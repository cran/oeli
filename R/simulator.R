#' Simulator R6 Object
#'
#' @description
#' Creates a simulation setup, where a function `f` is evaluated `runs` times,
#' optionally at each combination of input values.
#'
#' Provides some convenience (see below for more details):
#'
#' - Simulation results can be restored from a backup if the R session crashes.
#' - More simulation runs can be conducted after the initial simulation, failed
#'   simulation cases can be re-run.
#' - Parallel computation and progress updates are supported.
#'
#' @details
#' ## Backup
#' Simulation results can be saved to disk, allowing you to restore the results
#' if the R session is interrupted or crashes before the simulation completes.
#' To enable backup, set `backup = TRUE` in the `$go()` method, which will
#' create a backup directory at the location specified by `path`.
#' To restore, use `Simulator$initialize(use_backup = path)`.
#'
#' ## More runs and re-run
#' If additional simulation runs are needed, simply call the `$go()` method
#' again. Any cases that were not successfully completed in previous runs will
#' be attempted again.
#'
#' ## Parallel computation
#' By default, simulations run sequentially. But since they are independent,
#' they can be parallelized to decrease computation time. To enable parallel
#' computation, use the [`{future}` framework](https://future.futureverse.org/).
#' For example, run
#' \preformatted{future::plan(future::multisession, workers = 4)}
#' in advance for computation in 4 parallel R sessions.
#'
#' ## Progress updates
#' Use the [`{progressr}` framework](https://progressr.futureverse.org/) to
#' get progress updates. For example, run the following in advance:
#' \preformatted{progressr::handlers(global = TRUE)
#' progressr::handlers(
#'   progressr::handler_progress(format = ">> :percent, :eta to go :message")
#' )
#' }
#'
#' @keywords simulation
#' @family simulation helpers
#' @export
#'
#' @examples
#' # 1. Initialize a new simulation setup:
#' object <- Simulator$new(verbose = TRUE)
#'
#' # 2. Define function `f` and arguments (if any):
#' f <- function(x, y = 1) {
#'   Sys.sleep(runif(1)) # to see progress updates
#'   x + y
#' }
#' x_args <- list(1, 2)
#' object$define(f = f, x = x_args)
#' print(object)
#'
#' # 3. Define 'future' and 'progress' (optional):
#' \dontrun{
#' future::plan(future::sequential)
#' progressr::handlers(global = TRUE)}
#'
#' # 4. Evaluate `f` `runs` times at each parameter combination (backup is optional):
#' path <- file.path(tempdir(), paste0("backup_", format(Sys.time(), "%Y-%m-%d-%H-%M-%S")))
#' object$go(runs = 2, backup = TRUE, path = path)
#'
#' # 5. Access the results:
#' object$results
#'
#' # 6. Check if cases are pending or if an error occurred:
#' object$cases
#'
#' # 7. Restore simulation results from backup:
#' object_restored <- Simulator$new(use_backup = path)
#' print(object_restored)
#' \dontrun{all.equal(object, object_restored)}
#'
#' # 8. Run more simulations and pending simulations (if any):
#' object_restored$go(runs = 2)

Simulator <- R6::R6Class(

  classname = "Simulator",
  cloneable = FALSE,

  public = list(

    #' @description
    #' Initialize a `Simulator` object, either a new one or from backup.
    #'
    #' @param use_backup \[`NULL` | `character(1)`\]\cr
    #' Optionally a path to a backup folder previously used in `$go()`.
    #'
    #' @param verbose \[`logical(1)`\]\cr
    #' Provide info? Does not include progress updates. For that, see details.

    initialize = function(
      use_backup = NULL, verbose = getOption("verbose", default = FALSE)
    ) {

      private$.verbose <- isTRUE(verbose)

      if (is.null(use_backup)) {
        private$.status("Created {.cls Simulator}, call {.fun $define} next.")
      } else {
        input_check_response(
          check = checkmate::check_directory_exists(use_backup, access = "rw"),
          var_name = "use_backup"
        )
        input_check_response(
          check = checkmate::check_file_exists(
            file.path(use_backup, "Simulator_object.rds"), extension = ".rds",
            access = "r"
          )
        )
        self_old <- readRDS(file.path(use_backup, "Simulator_object.rds"))
        list2env(
          mget(
            c(".verbose", ".f", ".args", ".results", ".cases"),
            envir = self_old$.__enclos_env__$private
          ),
          envir = self$.__enclos_env__$private
        )
        case_files <- list.files(
          use_backup, pattern = "^case_.*\\.rds$", full.names = TRUE
        )
        cases <- lapply(case_files, readRDS)
        private$.results <- c(private$.results, cases)
        lapply(cases, function(case) {
          private$.update_case_pending(case = case$.case, error = case$.error)
        })
        private$.status(
          "Loaded {.cls Simulator} and {length(cases)} case{?s} from backup."
        )
      }
    },

    #' @description
    #' Print method.

    print = function() {
      cli::cli_bullets(c(
        "*"  = "Total cases: {nrow(private$.cases)}",
        ">"  = "Pending cases: {sum(private$.cases$.pending)}",
        "v"  = "Successful cases: {length(private$.results)}",
        "x"  = "Failed cases: {sum(private$.cases$.error)}"
      ))
      cli::cli_end()
      invisible(self)
    },

    #' @description
    #' Define function and arguments for a new `Simulator` object.
    #'
    #' @param f \[`function`\]\cr
    #' A `function` to evaluate.
    #'
    #' @param ...
    #' Arguments for `f`. Each value must be
    #'
    #' 1. named after an argument of `f`, and
    #' 2. a `list`, where each element is a variant of that argument for `f`.

    define = function(f, ...) {

      ### already defined?
      if (!is.null(private$.f)) {
        cli::cli_abort(
          "Definition already provided.",
          call = NULL
        )
      }

      ### input checks
      args <- list(...)
      arg_names <- names(args)
      input_check_response(
        check = list(
          checkmate::check_list(args, len = 0),
          checkmate::check_names(
            arg_names, type = "strict", disjunct.from = private$.reserved_vars
          )
        ),
        var_name = "..."
      )
      Map(function(arg, name) {
        input_check_response(
          check = checkmate::check_list(arg),
          var_name = name
        )
      }, args, arg_names)
      input_check_response(
        check = checkmate::check_function(f, args = arg_names),
        var_name = "f"
      )

      ### save simulation setting
      private$.f <- f
      private$.args <- args
      private$.status(
        "Simulation details defined, call {.fun $go} next to run simulations."
      )
      invisible(self)

    },

    #' @description
    #' Run simulations.
    #'
    #' @param runs \[`integer(1)`\]\cr
    #' The number of (additional) simulation runs.
    #'
    #' If `runs = 0`, only pending cases (if any) are solved.
    #'
    #' @param backup \[`logical(1)`\]\cr
    #' Create a backup under `path`?
    #'
    #' @param path \[`character(1)`\]\cr
    #' Only relevant, if `backup = TRUE`.
    #'
    #' In this case, a path for a new folder, which does not yet exist and
    #' allows reading and writing.

    go = function(
      runs = 0, backup = FALSE,
      path = paste0("backup_", format(Sys.time(), "%Y-%m-%d-%H-%M-%S"))
    ) {

      ### input checks
      input_check_response(
        check = check_missing(runs),
        var_name = "runs"
      )
      input_check_response(
        check = checkmate::check_count(runs, positive = FALSE),
        var_name = "runs"
      )
      input_check_response(
        check = checkmate::check_flag(backup),
        var_name = "backup"
      )

      ### prepare simulation
      private$.new_cases(runs = runs)
      cases <- self$cases |> dplyr::filter(.pending)
      if (backup) {
        input_check_response(
          check = checkmate::check_path_for_output(path, overwrite = FALSE),
          var_name = "path"
        )
        dir.create(path)
        saveRDS(self, file = sprintf("%s/Simulator_object.rds", path))
        private$.status("Saving backup to path {.path {normalizePath(path)}}.")
      }
      private$.status("Started simulation with {nrow(cases)} cases...")
      progress_step <- progressr::progressor(steps = nrow(cases))
      f <- private$.f # need to put f in environment

      ### run simulation
      results <- future.apply::future_lapply(cases$.case, function(case) {

        progress_step(glue::glue("[case {case}] started"), amount = 0)

        args <- lapply(
          cases[cases$.case == case, -(1:4), drop = FALSE],
          function(x) x[[1]]
        )

        start <- Sys.time()
        f_out <- try_silent(do.call(what = f, args = args))
        end <- Sys.time()
        error <- inherits(f_out, "fail")

        progress_step(glue::glue("[case {case}] finished"), class = "sticky")

        case_out <- list(
          ".case" = case,
          ".error" = error,
          ".seconds" = difftime(end, start, units = "secs"),
          ".input" = args,
          ".output" = f_out
        )

        if (backup && !error) {
          saveRDS(case_out, file = sprintf("%s/case_%03d.rds", path, case))
        }

        return(case_out)

      }, future.seed = TRUE)

      ### save results
      valid_cases <- Filter(function(case) !case$.error, results)
      ncases_failed <- nrow(cases) - length(valid_cases)
      private$.results <- c(private$.results, valid_cases)
      lapply(results, function(case) {
        private$.update_case_pending(case = case$.case, error = case$.error)
      })
      private$.status("Simulation complete, {ncases_failed} case{?s} failed.")
      invisible(self)

    }

  ),

  active = list(

    #' @field results \[`tibble`, read-only\]\cr
    #' The simulation results.

    results = function(value) {
      if (missing(value)) {
        if (length(private$.results) == 0) {
          tibble::tibble(
            .case = integer(),
            .seconds = difftime(numeric(), numeric(), units = "secs"),
            .input = list(),
            .output = list()
          )
        } else {
          private$.results |>
            lapply(function(x) tibble::tibble(
              .case = x$.case,
              .seconds = x$.seconds,
              .input = list(x$.input),
              .output = list(x$.output)
            )) |>
            dplyr::bind_rows() |>
            dplyr::arrange(.case)
        }
      } else {
        cli::cli_abort(
          "Field {.var $results} is read-only.",
          call = NULL
        )
      }
    },

    #' @field cases \[`tibble`, read-only\]\cr
    #' The simulation cases.

    cases = function(value) {
      if (missing(value)) {
        private$.cases |>
          dplyr::arrange(.case)
      } else {
        cli::cli_abort(
          "Field {.var $cases} is read-only.",
          call = NULL
        )
      }
    }

  ),

  private = list(

    .verbose = FALSE,
    .f = NULL,
    .args = list(),
    .results = list(),
    .cases = tibble::tibble(
      .case = integer(),
      .pending = logical(),
      .error = logical(),
      .run = integer()
    ),
    .reserved_vars = c(".case", ".pending", ".error", ".run"),

    .status = function(msg, verbose = private$.verbose) {
      checkmate::assert_string(msg)
      checkmate::assert_flag(verbose)
      if (verbose) cli::cli_inform(msg, .envir = parent.frame())
    },

    .new_cases = function(runs) {
      run_seq <- length(unique(private$.cases$.run)) + seq_len(runs)
      grid <- c(list(.run = run_seq), private$.args) |>
        expand.grid(stringsAsFactors = FALSE) |>
        tibble::as_tibble() |>
        dplyr::arrange(.run)
      new_cases <- cbind(
        tibble::tibble(
          .case = nrow(self$cases) + seq_len(nrow(grid)),
          .pending = TRUE,
          .error = FALSE
        ),
        grid
      )
      private$.cases <- dplyr::bind_rows(private$.cases, new_cases)
    },

    .update_case_pending = function(case, error) {
      private$.cases[private$.cases$.case == case, ".pending"] <- error
      private$.cases[private$.cases$.case == case, ".error"] <- error
    }
  )

)

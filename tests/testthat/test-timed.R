test_that("interruption of long evaluations works", {
  foo <- function(x) {
    for (i in 1:10) Sys.sleep(x / 10)
    return(x)
  }
  expect_error(
    timed(foo(0.5), "1"),
    "Assertion on 'seconds' failed: Must be of type 'number', not 'character'."
  )
  expect_equal(
    timed(foo(0.5), 5),
    0.5
  )
  expect_null(
    timed(foo(5), 1, "silent")
  )
  expect_warning(
    timed(foo(5), 1, "warning"),
    "time limit exceeded"
  )
  expect_error(
    timed(foo(5), 1, "error"),
    "time limit exceeded"
  )
})

test_that("initialization of Index works", {
  checkmate::expect_r6(Index$new(), "Index")
})

test_that("basic Index example works", {
  my_index <- Index$new()
  my_index$
    add(42, c("number", "rational"))$
    add(pi, c("number", "!rational"))$
    add("fear of black cats", c("text", "!rational"))$
    add("wearing a seatbelt", c("text", "rational"))$
    add(mean, "function")
  expect_equal(
    my_index$get("rational"),
    list(42, "wearing a seatbelt")
  )
  expect_length(
    my_index$get("!rational"),
    2
  )
  expect_equal(
    my_index$get(c("text", "!rational")),
    list("fear of black cats")
  )
  expect_length(
    my_index$get(ids = 4:5, id_names = TRUE),
    2
  )
  my_index$remove(ids = 4, shift_ids = FALSE)
})

test_that("lists can be merged", {
  expect_equal(
    merge_lists(list("a" = 1, "b" = 2)),
    list(a = 1, b = 2)
  )
  expect_equal(
    merge_lists(list("a" = 1, "b" = 2), list()),
    list(a = 1, b = 2)
  )
  expect_equal(
    merge_lists(list("a" = 1, "b" = 2), list("b" = 3, "c" = 4)),
    list(a = 1, b = 2, c = 4)
  )
  expect_equal(
    merge_lists(list("a" = 1, "b" = 2), list("b" = 3, "c" = 4), list("d" = 5)),
    list(a = 1, b = 2, c = 4, d = 5)
  )
})
test_that("highlights are data frame", {
  highlights <- logbook_highlights()
  expect_equal(class(highlights),
               class(data.frame("x" = c(1, 2, 3), 
                                "y" = c("a", "b", "c"))))
})

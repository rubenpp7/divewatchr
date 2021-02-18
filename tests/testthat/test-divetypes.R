test_that("divetypes are gg, ggplot object", {
  divetypes <- divetypes()
  expect_equal(class(divetypes),
               class(ggplot(data = data.frame("i" = c (1, 5, 7),
                                              "j" = c ("a", "b", "c")),
                            aes(x = j, y = i)) +
                     geom_col()))
})

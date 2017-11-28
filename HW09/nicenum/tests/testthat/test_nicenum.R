context("Formatting numbers")

test_that("At least numeric values work.", {
  expect_identical(signifDigit(5423.63875,2), "5424")
  expect_identical(signifDigit(0,2), "0")
  expect_identical(addPercent(.876589,2), "87.66%")
  expect_identical(addPercent(-123.4546,2), "-12345.46%")
})

test_that("String values return their equivalent.", {
  expect_identical(signifDigit("4563.346", 2), "4563.346")
})


test_that("Return value is string", {
  t <- signifDigit(4553.63,1)
  expect_type(t, "character")
})

test_that("Incorrect values are not returned and bad inputs throw errors.", {
  expect_false(signifDigit(5423.63875,2) == "542")
  expect_false(addPercent(0.4586,2) == "46%")
  expect_error(signifDigit(5423), "argument*")
  expect_error(addPercent("5423"), "non-numeric*")
})

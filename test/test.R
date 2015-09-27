x <- 1:9
dim(x) = c(3,3)
class(x)
ar <- array(c(1:4, 5:8, 9:12), dim = c(2, 2,3))
ar
lst <- list(
  first <- "shulin",
  last <- "chen"
)
lst[1]

rep(c(2, 4, 6), times = 2)
class(rep(1:3, times = c(3, 2, 1)))
rep(c(2, 4, 6), length.out = 5)
rep(c(2, 4, 6), each = 2)
2%%3
seq(0, 1, length.out = 10)
rep(c(1, 2, 3), times = c(1, 2, 3))



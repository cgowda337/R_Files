#linear programming practice
library(lpSolve)
objective.fn <-c(0.15, 0.40)

const.mat <- matrix(c(0.20, 0.70, 1, 1), ncol=2, byrow=TRUE)
const.dir <- c("<=", "<=")
const.rhs <- c(100,200)

lp.solution <- lp("max", objective.fn, const.mat, 
                  const.dir, const.rhs, compute.sens=TRUE)

lp.solution

lp.solution$solution

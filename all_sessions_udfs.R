# UDFs for Sample Size Calculator
library(pwr)

# Effect size h
h = function(p1, p2){
  result = 2*asin(sqrt(p1)) - 2*asin(sqrt(p2))
  return(result)
}

# Extract only required number of responses value from pwr.2p2n.test function. 
n2_2p2n <- function(p1, p2, n1, p_val, power, alternative){
  h_val <- h(p1, p2)
  result <- pwr.2p2n.test(h = h_val, n1 = n1, sig.level = p_val, power = power,
                          alternative = alternative)
  return(result$n2)
}

# Simulate required number of responses for every possible scenario of differences
# for every designated increment. 
power_sim <- function(p1, min_diff, max_diff, inc, n1, p_val, 
                      response_rate, power, alternative){
  # Setup required values and lists 
  p2 <- p1 + min_diff
  p2_list <- seq(p2, p1 + max_diff, inc)
  diff_list <- p2_list - p1
  n2_list <- c()

  for (i in 1:length(p2_list)){
    n2_list[i] <- n2_2p2n(p1 = p1, p2 = p2_list[i], n1 = n1, p_val = p_val, 
                          power = power, alternative = alternative) 
  }
  result <- data.frame(cbind(p2_list, diff_list, n2_list, n2_list/response_rate))
  colnames(result) <- c("P2", "DIFF", "N", "INVITEE")
  return(result)
}
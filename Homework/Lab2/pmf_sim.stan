
data {
  // Specify all of your data inputs in this block
  
  // For random draws:
  int n_draws;
  
  // For PMF:
  int n_seq;
  int y_pmf[n_seq];
  
}

transformed data {
  // Here, you specify the fixed parameters, as input data
  
  real theta;
  int n;
  
  theta = 0.25;
  n = 100;
}

generated quantities {
  // This block allows you to make external calculations in an efficient manner.
  
  real log_lik[n_seq];
  int rand_binomial[n_draws];
  
  // PMF: P(y | \Theta) on the natural log scale
  
  for(i in 1:n_seq){
    log_lik[i] = binomial_lpmf(y_pmf[i] | n,theta);
  }
  
  // Random draws:
  for(i in 1:n_draws){
    rand_binomial[i] = binomial_rng(n ,theta);
  }
  
}

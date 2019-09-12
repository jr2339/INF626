
data {
  // Specify all of your data inputs in this block
  
  // For random draws:
  int n_draws;
  
  // For PDF:
  int n_seq;
  real y_pdf[n_seq];
  
}

transformed data {
  // Here, you specify the fixed parameters, as input data
  
  real mu;
  real<lower = 0> sigma_sq;
  real<lower = 0> sigma;
  
  mu = 1.0;
  sigma_sq = 4.0;
  
  sigma = pow(sigma_sq, 0.5);
}

generated quantities {
  // This block allows you to make external calculations in an efficient manner.
  
  real log_lik[n_seq];
  real rand_norm[n_draws];
  
  // PDF: P(y | \Theta) on the natural log scale
  
  for(i in 1:n_seq){
    log_lik[i] = normal_lpdf(y_pdf[i] | mu, sigma);
  }
  
  // Random draws:
  for(i in 1:n_draws){
    rand_norm[i] = normal_rng(mu, sigma);
  }
  
}


data {
  
  int n_sample;
  int n_input;
  real y_vec[n_sample];
  matrix[n_sample, n_input] x_mat;
  
}


parameters {
  
  vector[n_input] beta;
  real alpha;
  real<lower = 0> sigma;
  
}

transformed parameters{
  
  vector[n_sample] mu;
  
  // This is using matrix algebra.
  // Think about how to write this out long-hand:
  mu = alpha + x_mat * beta; 
  
}

model {
  
  // PRIORS:
  alpha ~ normal(0, 50);
  
  for(i in 1:n_input){
    // Each slope has an independent prior
    beta[i] ~ normal(0, 50);
  }
  
  sigma ~ cauchy(0, 2.5);
  
  
  // DATA LIKELIHOOD
  // This is vectorized for efficiency
  y_vec ~ normal(mu, sigma);
  
}

generated quantities{
  
  real log_lik[n_sample];
  
  for(i in 1:n_sample){
    log_lik[i] = normal_lpdf(y_vec[i] | mu[i], sigma);
  }
  
}

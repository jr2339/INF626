
data {
  // Specify all of your data inputs in this block
  
  int n_sample;
  real y_vec[n_sample];
  real x_vec[n_sample];
  
}


parameters {
  // Here, you specify the parameters that will be estimated from your data
  real beta;
  real alpha;
  real<lower = 0> sigma_resid;
}

transformed parameters{
  // In this block, you can specify calculations that use only parameters or that 
  // use both parameters and data (e.g., a parameter multipled by a data vector).
  // Conducting such calculations in this block can make your model run faster. 
  
  real mu[n_sample];
  
  for(i in 1:n_sample){
    
    mu[i] = beta * x_vec[i] + alpha;
    
  }
  
}

model {
  // Here, you specify your parameter priors and your model likelihood
  
  // PRIORS:
  //alpha ~ normal(0, 50);
  target += normal_lpdf(alpha | 0, 50);
  //beta ~ normal(0, 50);
  target += normal_lpdf(beta | 0, 50);
  //sigma ~ cauchy(0, 2.5);
  target += cauchy_lpdf(sigma_resid | 0, 2.5);
  
  // DATA LIKELIHOOD
  
  for(i in 1:n_sample){
    //y_vec[i] ~ normal(mu[i], sigma);
    target += normal_lpdf(y_vec[i] | mu[i], sigma_resid);
  }
  
  // This code will do the same as above, but faster (vectorized)
  // y_vec ~ normal(mu, sigma);
}

generated quantities{
  
  real log_lik[n_sample];
  
  for(i in 1:n_sample){
    log_lik[i] = normal_lpdf(y_vec[i] | mu[i], sigma_resid);
  }
  
}

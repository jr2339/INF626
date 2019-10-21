
data {
  // Specify all of your data inputs in this block
  
  int n_sample;
  int n_group;
  real y_vec[n_sample];
  real x_vec[n_sample];
  int group_idx[n_sample];
  
}


parameters {
  // Here, you specify the parameters that will be estimated from your data
  real beta;
  real alpha_mean;
  real eta_alpha[n_group];
  
  real<lower = 0> alpha_sigma;
  real<lower = 0> sigma_resid;
}

transformed parameters{
  // In this block, you can specify calculations that use only parameters or that 
  // use both parameters and data (e.g., a parameter multipled by a data vector).
  // Conducting such calculations in this block can make your model run faster. 
  
  real mu[n_sample];
  
  for(i in 1:n_sample){
    
    mu[i] = (alpha_mean + eta_alpha[group_idx[i]]) + beta * x_vec[i];
    
  }
  
}

model {
  // Here, you specify your parameter priors and your model likelihood
  
  // PRIORS:
  alpha_mean ~ normal(0, 50);
  alpha_sigma ~ cauchy(0, 2.5);
  for(i in 1:n_group){
    eta_alpha[i] ~ normal(0, alpha_sigma);
  }
  
  beta ~ normal(0, 50);
  sigma_resid ~ cauchy(0, 2.5);

  // DATA LIKELIHOOD
  
  y_vec ~ normal(mu, sigma_resid);
}

generated quantities{
  
  real log_lik[n_sample];
  
  for(i in 1:n_sample){
    log_lik[i] = normal_lpdf(y_vec[i] | mu[i], sigma_resid);
  }
  
  
}


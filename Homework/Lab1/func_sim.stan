functions{
  
  // This block allows you to specify custom functions.
  
  real sum_func(real[] y){
    
    real temp_real;
    int N;
    
    N = size(y);
    temp_real = 0;
    
    for(i in 1:N){
      
      temp_real += y[i];
      
    }
    
    return temp_real;
  
  } // end sum_func specification
  
}

data {
  // Specify all of your data inputs in this block
  
  int N;
  real y[N];
  
}

transformed data {
  // In some cases, you may want to manually-code some data to be used in your model
  // In other cases, you may want to manipulate the data your provide
}

parameters {
  // Here, you specify the parameters that will be estimated from your data
}

transformed parameters{
  // In this block, you can specify calculations that use only parameters or that 
  // use both parameters and data (e.g., a parameter multipled by a data vector).
  // Conducting such calculations in this block can make your model run faster. 
}

model {
  // Here, you specify your parameter priors and your model likelihood
}

generated quantities {
  // This block allows you to make external calculations in an efficient manner.
  // For instance, you can run simulations.
  // You can also calulate model predictions for interpolation or forecasting.
  
  real summation;
  
  summation = sum_func(y);
}

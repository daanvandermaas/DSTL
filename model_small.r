model<-keras_model_sequential()



model %>%  
  layer_conv_2d(filter=32, kernel_size=c(5,5),padding="same",    input_shape=c(h,w,channels) ) %>%  
  layer_activation("relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  layer_conv_2d(filter=64 ,kernel_size=c(4,4), padding = 'same')  %>%  
  layer_activation("relu") %>%
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  layer_conv_2d(filter=64 , kernel_size=c(3,3),padding="same") %>%
  layer_activation("relu") %>%  
  layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same") %>%
  layer_activation("relu") %>%  
  layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same") %>%
  layer_activation("relu") %>%  
  layer_conv_2d(  filters = 512 , kernel_size=c(1,1) , padding="same") %>%
  layer_activation("relu") %>%  
  layer_conv_2d(  filters = 7 , kernel_size=c(1,1) , padding="same") %>%
  layer_activation("softmax") 

input_img = layer_input(shape = c(w, h, channels)) 


conv0 = layer_conv_2d(kernel_size = 2, filters = 32)(input_img)
conv0 = layer_activation_leaky_relu(alpha = 0.1)(conv0)
conv0= layer_batch_normalization(conv0)

max_pool_1 = layer_max_pooling_2d(pool_size = c(2L,2L))(conv0)


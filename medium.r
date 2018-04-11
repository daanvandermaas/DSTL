input_img = layer_input(shape = c(h, w, channels)) 

l1 =   layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(input_img) 
l1 =   layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l1) 
l1 = layer_batch_normalization()(l1)

l2 = layer_max_pooling_2d(pool_size = c(2,2))(l1)
l2 =   layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l2) 
l2 =   layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l2) 
l2 = layer_batch_normalization()(l2)

l3 = layer_max_pooling_2d(pool_size = c(2,2))(l2)
l3 =   layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l3) 
l3 =   layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l3) 
l3 = layer_batch_normalization()(l3)


l4 = layer_max_pooling_2d(pool_size = c(2,2))(l3)
l4 =   layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l4) 
l4 =   layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l4) 
l4 = layer_batch_normalization()(l4)

l5 = layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l4)
l5 = layer_concatenate( list(l3,l5))
l5 =   layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l5) 
l5 = layer_batch_normalization()(l5)


l6 = layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l5)
l6 = layer_concatenate( list(l2,l6))
l6 =   layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l6) 
l6 = layer_batch_normalization()(l6)


l7 = layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l6)
l7 = layer_concatenate( list(l1,l7))
l7 =   layer_conv_2d( filter=32, kernel_size=c(3,3),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l7) 
l7 = layer_batch_normalization()(l7)


l8 =   layer_conv_2d( filter=128, kernel_size=c(1,1),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l7) 
l8 =   layer_conv_2d( filter=7, kernel_size=c(1,1),padding="same",    input_shape=c(h,w,channels), activation = 'relu' )(l8) 

out = layer_activation_softmax(l8)

classes = k_argmax(out)

model = keras_model(inputs = input_img, outputs = out)


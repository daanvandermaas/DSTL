input_img = layer_input(shape = c(h, w, channels)) 


l0 = layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(input_img) 

l1 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l0) 
l1_pass = l1
l1 = layer_batch_normalization()(l1)
l1 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l1) 
l1 = layer_batch_normalization()(l1)
l1 = layer_max_pooling_2d(pool_size = c(2,2))(l1)


l =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l3) 
l = layer_batch_normalization()(l)
l =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l) 
l = layer_batch_normalization()(l)
l = layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l)
l = layer_batch_normalization()(l)



l3_up = layer_concatenate( list(l,l3_pass))
l3_up =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l3_up) 
l3_up = layer_batch_normalization()(l3_up)
l3_up =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l3_up) 
l3_up = layer_batch_normalization()(l3_up)
l3_up = layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l3_up)
l3_up = layer_batch_normalization()(l3_up)

l2_up = layer_concatenate( list(l3_up,l2_pass))
l2_up =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l2_up) 
l2_up = layer_batch_normalization()(l2_up)
l2_up =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l2_up) 
l2_up = layer_batch_normalization()(l2_up)
l2_up = layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l2_up)
l2_up = layer_batch_normalization()(l2_up)


l1_up = layer_concatenate( list(l2_up,l1_pass))
l1_up =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l1_up) 
l1_up = layer_batch_normalization()(l1_up)
l1_up =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l1_up) 
l1_up = layer_batch_normalization()(l1_up)

out =   layer_conv_2d( filter=class, kernel_size=c(1,1),padding="same",     activation = 'sigmoid' )(l1_up) 






model = keras_model(inputs = input_img, outputs = out)


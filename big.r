input_img = layer_input(shape = c(w, h, channels)) 


l0 = layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(input_img) 

l1 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l0) 
l1_pass = l1
l1 = layer_batch_normalization()(l1)
l1 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l1) 
l1 = layer_batch_normalization()(l1)
l1 = layer_max_pooling_2d(pool_size = c(2,2))(l1)



l2 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l1) 
l2 = layer_batch_normalization()(l2)
l2 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l2) 
l2 = layer_batch_normalization()(l2)
l2_pass = l2
l2 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l2) 
l2 = layer_batch_normalization()(l2)
l2 = layer_max_pooling_2d(pool_size = c(2,2))(l2)


l3 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l2) 
l3 = layer_batch_normalization()(l3)
l3 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l3) 
l3 = layer_batch_normalization()(l3)
l3_pass = l3
l3 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l3) 
l3 = layer_batch_normalization()(l3)
l3 = layer_max_pooling_2d(pool_size = c(2,2))(l3)

l4 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l3) 
l4 = layer_batch_normalization()(l4)
l4 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l4) 
l4 = layer_batch_normalization()(l4)
l4_pass = l4
l4 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l4) 
l4 = layer_batch_normalization()(l4)
l4 = layer_max_pooling_2d(pool_size = c(2,2))(l4)


l5 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l4) 
l5= layer_batch_normalization()(l5)
l5 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l5) 
l5 = layer_batch_normalization()(l5)
l5_pass = l5
l5 =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l5) 
l5 = layer_batch_normalization()(l5)
l5 = layer_max_pooling_2d(pool_size = c(2,2))(l5)



l =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l5) 
l = layer_batch_normalization()(l)
l =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l) 
l = layer_batch_normalization()(l)
l = layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l)
l = layer_batch_normalization()(l)


l5_up = layer_concatenate( list(l5_pass,l))
l5_up =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l5_up) 
l5_up = layer_batch_normalization()(l5_up)
l5_up =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l5_up) 
l5_up = layer_batch_normalization()(l5_up)
l5_up = layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l5_up)
l5_up = layer_batch_normalization()(l5_up)



l4_up = layer_concatenate( list(l5_up,l4_pass))
l4_up =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l4_up) 
l4_up = layer_batch_normalization()(l4_up)
l4_up =   layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l4_up) 
l4_up = layer_batch_normalization()(l4_up)
l4_up = layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l4_up)
l4_up = layer_batch_normalization()(l4_up)



l3_up = layer_concatenate( list(l4_up,l3_pass))
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


predictie = tf$argmax(out, axis = -1L)



model = keras_model(inputs = input_img, outputs = out)


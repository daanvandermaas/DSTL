evalueer = function(test, i, model, parts, w, h, sess){

cols <- c(
  '0' = "blue", #water
  '1' = "green", #forrest
  '2' = "gray", #rangeland
  '3' = "yellow", #agriculture
  '4' = "red", #urban
  '5' =  "brown", #barren
  '6' = "black" #undifined
)

dir.create( file.path(getwd(), 'db', 'result_all', i))

test = file.path( getwd(), 'db', 'landuse', 'land-valid' , test)




for(n in 1:length(test)){
 window = c(1:parts^2)
 batch_files = read_batch(files = test[n], format = 'jpg', channels = channels, windows = window, parts = parts, h=h, w=w)
  
 
 
   for(m  in 1:pred^2 ){
    
    
 a= array(batch_files[1,,,] , dim = c(1,w,h, channels))

    pred = sess$run( predictie, feed_dict = dict(input_img = a ))
    
    
    
    png(file.path(getwd(), 'db', 'result_all', i,  paste0(  n, '_', m, '_', 'prediction' , '.png')) )
    plot( as.raster(pred[1,,]) )
    dev.off()
    
    im = Image(batch_files[1,,,], colormode = 'Color' )
    im = EBImage::rotate(im, 90)
    im = im[dim(im)[1]:1,,]
    png(file.path(getwd(), 'db', 'result_all', i,  paste0(  n, '_', m, '_', 'image' , '.png')) )
    plot(im , all = TRUE)
    dev.off()
    
    
    
    
  }


}
}


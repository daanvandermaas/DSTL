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
  window = c(1:8)
    
    
    
    batch_files = read_batch(files = test[n], format = 'jpg', channels = channels, windows = window, parts = parts, h=h, w=w)
    pred = sess$run(predictie, feed_dict = dict(input_img = batch_files))
    
    
    for(m in 1:dim(pred[1])){
    
    png(file.path(getwd(), 'db', 'result_all', i,  paste0(  n, '_', window, '_', 'prediction' , '.png')) )
    plot( as.raster(pred[m,,]) )
    dev.off()
    
    im = Image(batch_files[m,,,], colormode = 'Color' )
    im = EBImage::rotate(im, 90)
    im = im[dim(im)[1]:1,,]
    png(file.path(getwd(), 'db', 'result_all', i,  paste0(  n, '_', window, '_', 'image' , '.png')) )
    plot(im , all = TRUE)
    dev.off()
    
    }
    
    
  }


}



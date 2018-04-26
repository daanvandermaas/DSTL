library(keras)
library(EBImage)
library(tensorflow)

parts = 4
h = as.integer(608) #heigth image dim image = 2448
w = as.integer(608) #width image
class = 2
test = list.files('db/landuse/land-valid')[1:20]

for(i in 1:length(test)){

evalueer(test = test, h = h, w = w, i=i, parts = 4)

}


evalueer = function(test, i, parts, w, h, class){

  
  model = load_model_hdf5(paste0('db/model_', i))
  
  
  
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

    pred = model$predict(x = a)
    
pred=     apply(pred, c(1,2,3), function(x){
      (which(x== max(x))[1] -1)/(class -1)
    })

    
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


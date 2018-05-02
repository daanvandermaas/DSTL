library(keras)
library(EBImage)
library(tensorflow)
library(jpeg)
source('read_batch.r')


cols = c('blue', 'green', 'brown', 'yellow', 'red', 'black', 'white')

parts = 4
h = as.integer(608) #heigth image dim image = 2448
w = as.integer(608) #width image
class = 2
channels = 3L

path = 'db/landuse/land-valid'


model = load_model_hdf5('db/model_68')



evalueer(path = path, h = h, w = w, model = model, parts = 4, channels = channels, cols = cols)




evalueer = function(path, model,  parts, w, h, class, channels, cols){

  


dir.create( file.path(getwd(), 'db', 'result_all'))

test = list.files(path, pattern = 'jpg')



for(n in 1:length(test)){
 window = c(1:parts^2)
 batch_files = read_batch(files = file.path(path, test[n]), format = 'jpg', channels = channels, windows = window, parts = parts, h=h, w=w)
  
 
 
   for(m  in 1:parts^2 ){
    
    
 a= array(batch_files[m,,,] , dim = c(1,w,h, channels))

    pred = model$predict(x = a)
    
pred= apply(pred, c(1,2,3), function(x){
      (which(x== max(x))[1] -1)/(class -1)
    })

    
    png(file.path(getwd(), 'db', 'result_all',   paste0(  n, '_', m, '_', 'prediction' , '.png')) )
    plot( as.raster(pred[1,,]) )
    dev.off()
    
    im = Image(batch_files[m,,,], colormode = 'Color' )
    im = EBImage::rotate(im, 90)
    im = im[dim(im)[1]:1,,]
    png(file.path(getwd(), 'db', 'result_all',   paste0(  n, '_', m, '_', 'image' , '.png')) )
    plot(im , all = TRUE)
    dev.off()
    
    
    
    
  }


}
}


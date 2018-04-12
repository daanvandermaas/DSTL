
library(EBImage)
library(raster)

cols <- c(
  '0' = "blue", #water
  '1' = "green", #forrest
  '2' = "gray", #rangeland
  '3' = "yellow", #agriculture
  '4' = "red", #urban
  '5' =  "brown", #barren
  '6' = "black" #undifined
)





for(i in 1:nrow(train)){
  for(window in 1:9){
    
    

batch_files = read_batch(files = train$images[i], format = 'jpg', channels = 3, windows = window, n = n, h=h, w=w)
batch_labels =  read_labels(files = train$labels[i], windows = window, class =class, n=n, w=w, h=h)
pred = model$predict(x = batch_files)


pred = apply(pred, c(2,3), function(x){
 cols[which(x == max(x))]
})
pred = as.raster(pred )

png(file.path('db', 'result_all', paste0( i, '_', window, '_', 'prediction' , '.png')) )
plot(pred)
dev.off()

im = Image(batch_files[1,,,], colormode = 'Color' )
im = rotate(im, 90)
im = im[dim(im)[1]:1,,]
png( file.path('db', 'result_all', paste0( i, '_', window, '_', 'image' , '.png'))  )
plot(im , all = TRUE)
dev.off()


batch_labels = apply(batch_labels, c(2,3), function(x){
  cols[which(x == max(x))]
})
batch_labels = as.raster(batch_labels)
png( file.path('db', 'result_all', paste0( i, '_', window, '_', 'label' , '.png')) )
plot(batch_labels)
dev.off()



}
}

































A = matrix(c( "black", "black","red","red"  ), nrow = 2)

A = matrix(c( "#555555", "#555555","#555555","#555555"  ), nrow = 2)
A = as.raster(A)
cols = c('red', 'blue', 'blue', 'red')



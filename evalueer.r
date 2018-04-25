library(EBImage)
library(raster)
library(keras)
library(jpeg)


source('read_batch.r')
source('read_labels_select.r')


model = load_model_hdf5('db/model')

cols <- c(
  '0' = "blue", #water
  '1' = "green", #forrest
  '2' = "gray", #rangeland
  '3' = "yellow", #agriculture
  '4' = "red", #urban
  '5' =  "brown", #barren
  '6' = "black" #undifined
)


path = file.path(getwd(), 'db', 'landuse')

#data loading
train = readRDS( file.path(path, 'train.rds'))
train$images = file.path(path, 'land-train', train$images)
train$labels = file.path(path, 'label-train', paste0(train$labels, '_mask.rds') )

test = readRDS( file.path(path, 'test.rds'))
test$images = file.path(path,  'land-train', test$images)
test$labels = file.path(path, 'label-train', paste0(test$labels, '_mask.rds') )

######Parameters
batch_size = 2
n = 4
h = as.integer(608) #heigth image dim image = 2448
w = as.integer(608) #width image
channels = 3L
class = 2
pick = 5
#####



for(i in 1:nrow(train)){
  print(paste('image: ', i))
window = c(1:16)    

batch_files = read_batch(files = train$images[i], format = 'jpg', channels = 3, windows = window, parts = parts, h=h, w=w)
batch_labels =  read_labels_select(files = train$labels[i], windows = window, class =class, parts=parts, w=w, h=h, pick = pick)
pred = model$predict(x = batch_files)


pred = apply(pred, c(2,3), function(x){
 unlist(as.character(cols[which(x == max(x))]) )[1]
})
pred = as.raster(pred )

png(file.path('db', 'result_all', paste0( i, '_', window, '_', 'prediction' , '.png')) )
plot(pred)
dev.off()

im = Image(batch_files[1,,,], colormode = 'Color' )
im = EBImage::rotate(im, 90)
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





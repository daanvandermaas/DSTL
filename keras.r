#a linear stack of layers
library(jpeg)
library(tensorflow)
library(keras)
source('read_batch.r')
source('read_labels.r')

path = file.path(getwd(), 'db', 'landuse')

#data loading
train = readRDS( file.path(path, 'train.rds'))
test = readRDS( file.path(path, 'test.rds'))

train$images = file.path(path, 'land-train', train$images)
train$labels = file.path(path, 'label-train', paste0(train$labels, '_mask.rds'))
test$images = file.path(path, 'land-train', test$images)
test$labels = file.path(path, 'label-train', paste0(test$labels, '_mask.rds'))


######Parameters
batch_size = 1
n = 4
  h = 608 #heigth image
w = 608 #width image
channels = 3L
class = 7
#####

# encoding layers


source('big.r')
#source('medium.r')

#source('model_small.r')

opt<-optimizer_adam( lr= 0.0001 , decay = 0 )

compile(model, loss="categorical_crossentropy", optimizer=opt, metrics = "accuracy")





#Train the network
for (i in 1:2000000) {
  #lees 50 random plaatjes in
  samp = sample(c(1:nrow(train)), batch_size)
  windows =sample(c(1:n), batch_size, replace = TRUE )
  
  batch_files = read_batch(files = train$images[samp], format = 'jpg', channels = 3, windows = windows, n=n, w= w, h=h)
  batch_labels =  read_labels(files = train$labels[samp], windows = windows, class = class, n=n, w=w, h=h)

  
  model$fit( x= batch_files, y= batch_labels, batch_size = dim(batch_files)[1], epochs = 1L  )
  
  if(i%%300 == 0 ){
    print('model saved')
    print(i)
    model$save( file.path(path,'model' ))
    
  }
  
  
}



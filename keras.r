#a linear stack of layers
library(jpeg)
library(tensorflow)
library(keras)
library(EBImage)
library(raster)


source('read_batch.r')
source('read_labels_select.r')
source('evalueer_op_test.r')


#data loading
train = readRDS( file.path(getwd(), 'db', 'landuse', 'train.rds'))
train$images = file.path(getwd(), 'db', 'landuse', 'land-train', train$images)
train$labels = file.path(getwd(), 'db', 'landuse', 'label-train', paste0(train$labels, '_mask.rds'))

test = list.files('db/landuse/land-valid')[1:20]


######Parameters
batch_size = 4
parts = 4
  h = as.integer(608) #heigth image dim image = 2448
w = as.integer(608) #width image
channels = 3L
class = 2
pick = 5
#####

# encoding layers


source('big.r')

opt<-optimizer_adam( lr= 0.001 , decay = 0,  clipnorm = 1 )

compile(model, loss="categorical_crossentropy", optimizer=opt, metrics = "accuracy")

sess = k_get_session()



#Train the network
for (i in 1:2000000) {
  print(i)
  #lees 50 random plaatjes in
  samp = sample(c(1:nrow(train)), 1)
  windows =sample(c(1:parts^2), batch_size, replace = TRUE )
  
  batch_files = read_batch(files = train$images[samp], format = 'jpg', channels = channels, windows = windows, parts=parts, w= w, h=h)
  batch_labels =  read_labels_select(files = train$labels[samp], windows = windows, class = class, parts=parts, w=w, h=h, pick = pick)

  
  model$fit( x= batch_files, y= batch_labels, batch_size = dim(batch_files)[1], epochs = 1L, class_weight = list(1,1)  )
  
  if(i%%4000 == 0 ){
    print(i)
    print('model saved')
    model$save( paste0('db/model_', i) )
    
  }
  
  
}


#model$evaluate(x = batch_files, y = batch_labels)


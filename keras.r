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
######Parameters
n = 4
  h = as.integer(600) #heigth image
w = as.integer(600) #width image
channels = 3L
max_pred = 0.8
class = 7
#####

# encoding layers



source('medium.r')

#source('model_small.r')

opt<-optimizer_adam( lr= 0.001 , decay = 1e-7 )

compile(model, loss="categorical_crossentropy", optimizer=opt, metrics = "accuracy")

model = load_model_hdf5('model')



#Train the network
for (i in 1:2000000) {
  print(i)
  #lees 50 random plaatjes in
  samp = sample(c(1:nrow(train)), 2)
  windows =sample(c(1:n), 2, replace = TRUE )
  
  batch_files = read_batch(files = train$images[samp], format = 'jpg', channels = 3, windows = windows, n=n, w= w, h=h)
  batch_labels =  read_labels(files = train$labels[samp], windows = windows, class = class, n=n, w=w, h=h)

  
  model$fit( x= batch_files, y= batch_labels, batch_size = dim(batch_files)[1], epochs = 1L  )
  
  if(i%%1000 == 0 ){
    print('model_saved')
    model$save( file.path(path,'model' ))
  }
  
  
}



# for (i in 1:20) {
#   
#   #lees 50 random plaatjes in
#   model$fit( x= batch_files, y= batch_labels, batch_size = dim(batch_files)[1], epochs = 1L  )
#   
#   
#   
# }



#pred = sess$run(classes, feed_dict = dict(input_img = batch_files))

#a linear stack of layers
library(jpeg)
library(keras)
source('read_batch.r')
source('read_labels.r')

path = file.path(getwd(), 'db', 'landuse')

#data loading
files = list.files( file.path(path, 'land-train'), full.names = FALSE, pattern = 'sat' )
images = file.path(path, 'land-train', files)

labels = unlist( lapply(files, function(x){
  strsplit(x, '[_.]')[[1]][1]
}))
labels = file.path(path, 'label-train', paste0(labels, '_mask.rds'))

data = data.frame('images' = images, 'labels' =  labels)
split = sample(x =  c(1:nrow(data)), size = round(0.8*nrow(data)) )
train = data[split,]
test = data[-split,]

######Parameters
n = 5
  h = as.integer(600) #heigth image
w = as.integer(600) #width image
channels = 3L
max_pred = 0.8
classes = 7
#####

# encoding layers



source('medium.r')

#source('model_small.r')

opt<-optimizer_adam( lr= 0.001 , decay = 1e-7 )

compile(model, loss="categorical_crossentropy", optimizer=opt, metrics = "accuracy")

sess = k_get_session()

#model = load_model_hdf5(file.path(path,'models/model_all2'))



#Train the network
for (i in 1:2000000) {
  
  #lees 50 random plaatjes in
  samp = sample(c(1:nrow(train)), 2)
  window = matrix( sample(c(0:3), 2*n, replace = TRUE) , ncol = 2 )
  
  batch_files = read_batch(files = train$images[samp], format = 'jpg', channels = 3, window = window)
  batch_labels =  read_labels(files = train$labels[samp], window = window)

  
  model$fit( x= batch_files, y= batch_labels, batch_size = dim(batch_files)[1], epochs = 1L  )
  
  
  
}



# for (i in 1:20) {
#   
#   #lees 50 random plaatjes in
#   model$fit( x= batch_files, y= batch_labels, batch_size = dim(batch_files)[1], epochs = 1L  )
#   
#   
#   
# }



pred = sess$run(classes, feed_dict = dict(input_img = batch_files))

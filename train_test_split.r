
path = file.path(getwd(), 'db', 'landuse')

files = list.files( file.path(path, 'land-train'), full.names = FALSE, pattern = 'sat' )
images = file.path(path, 'land-train', files)

labels = unlist( lapply(files, function(x){
  strsplit(x, '[_.]')[[1]][1]
}))
labels = file.path(path, 'label-train', paste0(labels, '_mask.rds'))

data = data.frame('images' = images, 'labels' =  labels)
split = sample(x =  c(1:nrow(data)), size = round(0.9*nrow(data)) )
train = data[split,]
test = data[-split,]


saveRDS(train, file.path(path, 'train.rds'))
saveRDS(test, file.path(path, 'test.rds'))


path = file.path(getwd(), 'db', 'landuse')

files = list.files( file.path(path, 'land-train'), full.names = FALSE, pattern = 'sat' )


labels = unlist( lapply(files, function(x){
  strsplit(x, '[_.]')[[1]][1]
}))


data = data.frame('images' = files, 'labels' =  labels)
split = sample(x =  c(1:nrow(data)), size = round(0.9*nrow(data)) )
train = data[split,]
test = data[-split,]


saveRDS(train, file.path(path, 'train.rds'))
saveRDS(test, file.path(path, 'test.rds'))






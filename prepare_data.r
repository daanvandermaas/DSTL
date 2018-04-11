data = read.csv('db/train_wkt_v4.csv')

images = unique(data$ImageId)

for(image in images){
  data_sub = data[data$ImageId == image, ]
  as.character(data_sub$data$MultipolygonWKT)
  data_sub = data_sub[data$MultipolygonWKT != 'MULTIPOLYGON EMPTY',]
  
}


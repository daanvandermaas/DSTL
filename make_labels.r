library(png)

labels = list.files('db/landuse/land-train', full.names = FALSE, pattern = 'mask' )


for(label in labels){
  print(label)
  im = readPNG(file.path('db/landuse/land-train',label))
  
  im_end = array(0, dim = c(2448,2448,7))
  
  im_end[,,1][ im[,,1] < 0.1  & im[,,2] < 0.1  &  im[,,3] > 0.1 ] = 1 #water
  im_end[,,2][ im[,,1] < 0.1  & im[,,2] > 0.1  &  im[,,3] < 0.1] = 1 #forest
  im_end[,,3][ im[,,1] > 0.1  & im[,,2] < 0.1  &  im[,,3] > 0.1 ]  = 1 #rangeland  
  im_end[,,4][ im[,,1] > 0.1  & im[,,2] > 0.1  &  im[,,3] < 0.1  ] = 1 #agriculture  
  im_end[,,5][ im[,,1] < 0.1  & im[,,2] > 0.1  &  im[,,3] > 0.1  ]   = 1 #urban
  im_end[,,6][ im[,,1] > 0.1  & im[,,2] > 0.1  &  im[,,3] > 0.1  ]  = 1 #barren
  im_end[,,7][ im[,,1] < 0.1  & im[,,2] < 0.1  &  im[,,3] < 0.1  ]  = 1 #undefined
  
  name = strsplit(label, '[.]')[[1]][1]
  saveRDS(im_end, paste0('db/landuse/label-train/', name, '.rds'))
  
}
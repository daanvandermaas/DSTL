read_batch = function(files, format, channels, window){
  
  
  batch = array(0, dim = c(length(files), w, h, channels))
  for(i  in 1:length(files)){
    file = files[i]
    if(format == 'jpg'){
    im = readJPEG( as.character(file) )
    batch[i,,,] = im[ (window[i,1]*w+1):((window[i,1]+1)*w) ,  (window[i,2]*h+1):((window[i,2]+1)*h),]
    }
    if(format == 'tif'){
      im = readTIFF(  as.character(file) )
      batch[i,,,] = im[ (window[i,1]*w+1):((window[i,1]+1)*w) ,  (window[i,2]*h+1):((window[i,2]+1)*h),]
    }
    if(format == 'png'){
      im = readPNG(  as.character(file) )
      batch[i,,,] = im[ (window[i,1]*w+1):((window[i,1]+1)*w) ,  (window[i,2]*h+1):((window[i,2]+1)*h),]
    }
    if(format == 'rds'){
      im = readRDS(  as.character(file) )
      batch[i,,,1] = im[ (window[i,1]*w+1):((window[i,1]+1)*w) ,  (window[i,2]*h+1):((window[i,2]+1)*h),]
    }
   
  }
  return(batch)
}
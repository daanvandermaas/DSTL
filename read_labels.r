read_labels = function(files, window){
  
  
  batch = array(0, dim = c(length(files), w, h,classes))
  
  for(i  in 1:length(files)){
    file = files[i]
      im = readRDS(  as.character(file) )
      
      
      batch[i,,,] = im[  (window[i,1]*w+1):((window[i,1]+1)*w) ,  (window[i,2]*h+1):((window[i,2]+1)*h) ,]
    
  }
  return(batch)
}
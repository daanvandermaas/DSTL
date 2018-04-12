read_batch = function(files, format, channels, windows, n, w , h){
  
  
  batch = array(0, dim = c(length(files), w, h, channels))
  
  
  for(window in windows){
  y=  floor( (window -1 )/n) +1
  x = window - (y-1)*n
  
  
  for(i in 1:length(files)){
    
    file = files[i]
    im = readJPEG(as.character(file))
    
    
    batch[i,,,] = im[ ((x-1)*w + 1)  :(x*w) , ((y-1)*h + 1)  :(y*h)  ,]
  }
  
  }
   
  return(batch)
}
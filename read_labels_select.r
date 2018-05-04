read_labels_select = function(files, windows, class, parts,w,h, pick, rot, aug){
  
  
  if(pick == 100){
    
    batch = array(0, dim = c(length(windows), w, h,class))
    
    
    for(i in 1:length(files)){
      
      file = files[i]
      im = readRDS(as.character(file))
      
      if(aug){
      im = augment_labels(im = im, flip = flip, rot = rot)
      }
      
      for(j in 1:length(windows)){
        window = windows[j]
        y=  floor( (window -1 )/parts) +1
        x = window - (y-1)*parts
        
        
        
        batch[j,,,] = im[ ((x-1)*w + 1)  :(x*w) , ((y-1)*h + 1)  :(y*h)  , ]
      }
      
    }
    
    return(batch)
    
    
  }else{
  
  batch = array(0, dim = c(length(windows), w, h,class))
  
  
  for(i in 1:length(files)){
    
    file = files[i]
    im = readRDS(as.character(file))
    
    
  
  for(j in 1:length(windows)){
    window = windows[j]
    y=  floor( (window -1 )/parts) +1
    x = window - (y-1)*parts
    
    

      batch[j,,,1] = im[ ((x-1)*w + 1)  :(x*w) , ((y-1)*h + 1)  :(y*h)  , pick]
      batch[j,,,2] = 1 - batch[i,,,1]
    }
    
  }
  
  return(batch)
  }
}

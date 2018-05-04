augment_labels = function(im, rot, flip){
  
  #rotate
  rotate <- function(im)  aperm(apply(im, c(2,3), rev), c(2,1,3) )
  
  while(rot >0){
  im = rotate(im)
  rot = rot - 1
  }
  
  #flip
  if(flip){
    im = im[ dim(im)[1]:1,,]
  }
  
 return(im) 
}
augment = function(im, rot, flip){
  
  #rotate
  rot = rot *90
  im =EBImage::rotate(im, rot)
  
  #add noise
 im = im + rnorm( im, mean = 0 , sd = 0.1)
    
 #resize
 w_old = dim(im)[1]
 h_old = dim(im)[2]
 w_new = sample(x = c( round(w_old/4):w_old), size = 1 )
 h_new = sample(x = c(round(h_old/4):h_old), size = 1)
 im = resize(im, w = w_new, h = h_new)
 im = resize(im, w = w_old, h = h_old)
 
 #flip
 if(flip){
   im = EBImage::flop(im)
 }
 
 return(im)
}
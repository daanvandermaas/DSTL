cols <- c(
  '0' = "blue", #water
  '1' = "green", #forrest
  '2' = "gray", #rangeland
  '3' = "yellow", #agriculture
  '4' = "red", #urban
  '5' =  "brown", #barren
  '6' = "black" #undifined
)

#colormap
colormap(x0 = 1, col0 = 'red')
colormap(c('red', 'green'))


#lees 50 random plaatjes in
samp = sample(c(1:nrow(train)), 2)
window = matrix( sample(c(0:3), 2*n, replace = TRUE) , ncol = 2 )
batch_files = read_batch(files = train$images[samp], format = 'jpg', channels = 3, window = window)
batch_labels =  read_labels(files = train$labels[samp], window = window, class)


pred = model$predict(x = batch_files)
pred = apply(pred, c(1,2,3), function(x){
 which(x == max(x))
})
png('prediction')
image( as.matrix(pred[1,,]) , col = rainbow(7))
dev.off()

png('image')
image(batch_files[1,,,1])
dev.off()

batch_labels = apply(batch_labels, c(1,2,3), function(x){
  which(x == max(x))
})

png('label')
image( as.matrix(batch_labels[1,,]), col = rainbow(7))
dev.off()










d<-read.table(text="
0  0  0  0
1  1  1  0
0  1  2  2
0  0  0  1")

cols <- c(
  '0' = "red",
  '1' = "green",
  '2' = "blue")
# the names aren't necessary here.

image( as.matrix(d), col=cols)




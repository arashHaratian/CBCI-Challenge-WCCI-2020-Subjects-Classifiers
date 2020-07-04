library(R.matlab)

reading_mat_file <- function(dir_filename, type = c('t', 'e'))
{
  mat_file <- readMat(dir_filename)
  mat_file_data <- mat_file[["RawEEGData"]]
  # if(type == 't')
    # mat_file_data <- add_labels(mat_file_data, mat_file[["Labels"]])
  
  return(mat_file_data)
}
#======================================================
get_labels <- function(dir_filename) {
  mat_file <- readMat(dir_filename)
  return(mat_file[["Labels"]])
}
#======================================================
make_2d <- function(data)
{
  trials <- dim(data)[1]
  twod_matrix <- t(data[1, , ])
  for(trial in 2:trials)
  {
    temp <- t(data[trial, , ])
    twod_matrix <- rbind(twod_matrix, temp)
  }
  return(twod_matrix)
}

#======================================================
add_labels <- function(data, labels)
{
  if(length(dim(data)) == 3)
    data <- make_2d(data)
  labeled_data <- cbind(data, rep(labels, each = 4096))
  colnames(labeled_data)[13] <- 'Labels'
  return(labeled_data)
}

#======================================================
merging_subjects <- function(dir, num, type = c('t', 'e')) {
  
  files <- list.files(dir)
  
  # files <- sample(files, num)
  
  file <- paste(dir , files[1], sep ='')
  final <- make_2d(reading_mat_file(file, 'e'))
  
  if(type == "t"){
    final <- make_2d(reading_mat_file(file, 't'))
    labels <- get_labels(file)
    final <- add_labels(final, labels = labels)
  }
  
  for (mat_file in files[-1] ){
    file <- paste(dir , mat_file, sep ='')
    
    if(type == "t"){
      temp <- make_2d(reading_mat_file(file, 't'))
      labels <- get_labels(file)
      temp <- add_labels(temp, labels = labels)
      final <- rbind(final, temp)

    }
    else{
    temp <- make_2d(reading_mat_file(file, 'e'))
    final <- rbind(final, temp)
    }
  }
  return(final)
}

#============================================================
save_as_csv <- function(data, dir = "./data.csv") {
  write.csv(file = dir, data, row.names = FALSE)
  print("data saved as csv")
  return(dir)
}

#==========================================================
save_as_mat <- function(data, dir = "./data.mat", matlab_variable_name = "extacted data from R") {
  writeMat(dir, matlab_variable_name = data)
  print("data saved as mat")
  return(dir)
}

#==========================================================
change_col_names <- function(data){
  colnames(data)[-13] <- c("F3", "FC3", "C3", "CP3", "P3", "FCz", "CPz", "F4", "FC4", "C4", "CP4", "P4")
  return(data)
}

#==========================================================
averaged_trials <- function(data){
  trials <- dim(data)[1]
  ave_matrix <- colMeans(t(data[1, , ]))
  for(trial in 2:trials)
  {
    temp <- colMeans(t(data[trial, , ]))
    ave_matrix <- rbind(ave_matrix, temp)
  }
  return(ave_matrix)
}

#===========================================================
averaged_squared_trials <- function(data){
  trials <- dim(data)[1]
  ave_matrix <- colMeans(t(data[1, , ]^2))
  for(trial in 2:trials)
  {
    temp <- colMeans(t(data[trial, , ]^2))
    ave_matrix <- rbind(ave_matrix, temp)
  }
  return(ave_matrix)
}

#===========================================================
merging_ave_trials_subject<- function(dir, num, squ = F, type = c('t', 'e')) {
  
  files <- list.files(dir)
  
  # files <- sample(files, num)
  
  file <- paste(dir , files[1], sep ='')
  
  if(squ == T)
    final <- averaged_squared_trials(reading_mat_file(file, 'e'))
  else
    final <- averaged_trials(reading_mat_file(file, 'e'))

  if(type == 't')
    final <- add_labels_ave_trials(final, get_labels(file))

    
  for (mat_file in files[-1] ){
    file <- paste(dir, mat_file, sep ='')
    
    if(squ == T)
      temp <- averaged_squared_trials(reading_mat_file(file, 'e'))
    else
      temp <- averaged_trials(reading_mat_file(file, 'e'))
    
    if(type == 't')
      temp <- add_labels_ave_trials(temp, get_labels(file))

    final <- rbind(final, temp)
  }
  return(final)
}

#============================================================
add_labels_ave_trials <- function(data, labels){
  data <- cbind(data, labels)
  colnames(data)[13] <- "Labels"
  return(data)
}

#============================================================
averaged_epochs <- function(data_3D_2D){
  trials <- dim(data_3D_2D)[1]
  
  ave_matrix <- colMeans(t(data_3D_2D[1, , ])[1:512, 1:12])
  for(sec in 2:8){
    ave_matrix <- rbind(ave_matrix, colMeans(t(data_3D_2D[1, , ]) [(((sec-1)*512)+1):(sec*512), 1:12] ))
}
  for(trial in 2:trials)
  {
    for(sec in 1:8)
      ave_matrix <- rbind(ave_matrix, colMeans(t(data_3D_2D[trial, , ]) [(((sec-1)*512)+1):(sec*512), 1:12] ))
  }
  return(ave_matrix)
}


#============================================================
averaged_squared_epochs <- function(data_3D_2D){
  trials <- dim(data_3D_2D)[1]
  
  ave_matrix <- colMeans((t(data_3D_2D[1, , ])[1:512, 1:12])^2)
  for(sec in 2:8){
    ave_matrix <- rbind(ave_matrix, colMeans(t(data_3D_2D[1, , ]) [(((sec-1)*512)+1):(sec*512), 1:12] ^ 2))
  }
  for(trial in 2:trials)
  {
    for(sec in 1:8)
      ave_matrix <- rbind(ave_matrix, colMeans(t(data_3D_2D[trial, , ]) [(((sec-1)*512)+1):(sec*512), 1:12] ^ 2))
  }
  return(ave_matrix)
}

#==========================================================
add_labels_ave_epochs <- function(data, labels){
  data <- cbind(data, rep(labels, each = 8))
  colnames(data)[13] <- "Labels"
  return(data)
}

#==========================================================
merging_ave_epochs_subject <- function(dir, num, squ = F, type = c('t', 'e')) {
  
  files <- list.files(dir)
  
  # files <- sample(files, num)
  
  file <- paste(dir , files[1], sep ='')
  
  if(squ == T)
    final <- averaged_squared_epochs(reading_mat_file(file, 'e'))
  else
    final <- averaged_epochs(reading_mat_file(file, 'e'))
  
  if(type == 't')
    final <- add_labels_ave_epochs(final, get_labels(file))
  
  
  for (mat_file in files[-1] ){
    file <- paste(dir , mat_file, sep ='')
    
    if(squ == T)
      temp <- averaged_squared_epochs(reading_mat_file(file, 'e'))
    else
      temp <- averaged_epochs(reading_mat_file(file, 'e'))
    
    if(type == 't')
      temp <- add_labels_ave_epochs(temp, get_labels(file))
    
    final <- rbind(final, temp)
  }
  return(final)
}

#==========================================================
var_trials <- function(data){
  library(matrixStats)
  trials <- dim(data)[1]
  var_matrix <- colVars(t(data[1, , ]))
  for(trial in 2:trials)
  {
    temp <- colVars(t(data[trial, , ]))
    var_matrix <- rbind(var_matrix, temp)
  }
  return(var_matrix)
}

#==========================================================
var_epochs <- function(data){
  library(matrixStats)
  trials <- dim(data)[1]
  var_matrix <- colVars((t(data[1, , ])[1:512, 1:12]))
  
  for(sec in 2:8)
    var_matrix <- rbind(var_matrix, colVars(t(data[1, , ]) [(((sec-1)*512)+1):(sec*512), 1:12]))

  for(trial in 2:trials)
  {
    for(sec in 1:8)
      var_matrix <- rbind(var_matrix, colVars(t(data[trial, , ]) [(((sec-1)*512)+1):(sec*512), 1:12]))
  }
  return(var_matrix)
}

#===========================================================
merging_var_epochs_subject <- function(dir, num, type = c('t', 'e')) {
  
  files <- list.files(dir)
  
  # files <- sample(files, num)
  
  file <- paste(dir , files[1], sep ='')
  
  final <- var_epochs(reading_mat_file(file, 'e'))
  
  if(type == 't')
    final <- add_labels_ave_epochs(final, get_labels(file))
  
  
  for (mat_file in files[-1] ){
    file <- paste(dir , mat_file, sep ='')
    
    temp <- var_epochs(reading_mat_file(file, 'e'))
    
    if(type == 't')
      temp <- add_labels_ave_epochs(temp, get_labels(file))
    
    final <- rbind(final, temp)
  }
  return(final)
}

#=========================================================================
merging_var_trials_subject<- function(dir, num, type = c('t', 'e')) {
  
  files <- list.files(dir)
  
  # files <- sample(files, num)
  
  file <- paste(dir , files[1], sep ='')
  
  final <- var_trials(reading_mat_file(file, 'e'))
  
  if(type == 't')
    final <- add_labels_ave_trials(final, get_labels(file))
  
  
  for (mat_file in files[-1] ){
    file <- paste(dir, mat_file, sep ='')
    
    temp <- var_trials(reading_mat_file(file, 'e'))
    
    if(type == 't')
      temp <- add_labels_ave_trials(temp, get_labels(file))
    
    final <- rbind(final, temp)
  }
  return(final)
}




# 
# merge_test <- merging_subjects('../competition dataset WCCI2020/Clinical-Brain-Computer-Interfaces-Challenge-WCCI-2020-Glasgow-master/', num = 5)
# 
# test <- reading_mat_file('../competition dataset WCCI2020/Clinical-Brain-Computer-Interfaces-Challenge-WCCI-2020-Glasgow-master/parsed_P01T.mat', 'e')
# test2d <- make_2d(test)
# labels <- get_labels('../competition dataset WCCI2020/Clinical-Brain-Computer-Interfaces-Challenge-WCCI-2020-Glasgow-master/parsed_P01T.mat')
# labeled_data <- add_labels(test2d, labels)
# 
# 
# a <- save_as_csv(dir = '../../../../../../Desktop/test2.csv', labeled_data)
# a <- save_as_mat(dir = '../../../../../../Desktop/test2.mat', labeled_data)

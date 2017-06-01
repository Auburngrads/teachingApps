library(shiny)
library(shinydashboard)
library(lattice)
library(matrixStats)
library(networkD3)
library(Matrix)
library(caret)
library(ggplot2)
library(gplots)
library(RColorBrewer)
library(tidyr)
library(dplyr)
library(plotly)
library(DT)
library(qdapTools)
library(magrittr)
library(MASS)

#Horn's Curve
Hornscurve <- function(N,p) {
  
  K=1000
  Eigvals_master = matrix(0,K,p)
  
  for (i in 1:K){
    
    M = matrix(rnorm(N*p),N,p)
    C = cov(M)
    Eigvals_C = eigen(C)$values
    tmp = sort(Eigvals_C,decreasing = TRUE)
    Eigvals_master[i,] = tmp
    next
  }
  curvepoints = colMeans(Eigvals_master)
  return(curvepoints)
}

IFS <- function(L) {
  
  N = nrow(L)
  M = ncol(L)
  t1 = matrix(0,N,1)
  t2 = matrix(0,N,1)
  sum1 = 0
  sum2 = 0
  
  for (i in 1:N) {
    for (j in 1:M){
      t1[i,1] = t1[i,1] + L[i,j]^4
      t2[i,1] = t2[i,1] + L[i,j]^2
    }
  }
  
  for (i in 1:M){
    sum1 = sum1 + (M*t1[i,1] - t2[i,1]^2)
    sum2 = sum2 + (M -1)* (t2[i,1]^2)
  }
  
  result = sqrt(sum1/sum2)
  return(result)
  
}

mahalanobis3 <- function(data) {
  
  N = nrow(data)
  M = ncol(data)
  md = as.vector(rep(0,N),mode = "numeric")
  bd = matrix(rep(0,N),nrow = N,ncol = M)
  C = cov(data)
  IC = ginv(C)
  CM = as.matrix(colMeans(data))
  
  
  for (i in 1:N){
    D = (data[i,] - t(CM))
    md[i] = D %*% IC %*% t(D)
    bd[i,] = abs(D /sqrt(diag(C)))
  }
  
  colnames(bd) = colnames(data)
  
  tmp = sort(md,decreasing = TRUE,index.return = TRUE)
  md_sort = tmp$x
  md_index = tmp$ix
  
  
  
  output = list(md = md,md_sort = md_sort, md_index = md_index,bd=bd)
  
  return(output)
  
}

bd_row <- function(data,r) {
  
  C = cov(data)
  CM = as.matrix(colMeans(data))
  D = (data[r,] - t(CM))
  bd = D /sqrt(diag(C))
  bd_abs = abs(bd)
  tmp = sort(bd_abs,decreasing = TRUE,index.return=TRUE)
  bd_sort = tmp$x
  bd_index = tmp$ix
  
  output = list(bd = bd,bd_abs = bd_abs,bd_sort = bd_sort, bd_index = bd_index)
  
  return(output)
  
}

#Found this on stackoverflow by Richie Cotton
get_all_factors <- function(n)
{
  prime_factor_tables <- lapply(
    setNames(n, n), 
    function(i)
    {
      if(i == 1) return(data.frame(x = 1L, freq = 1L))
      plyr::count(as.integer(gmp::factorize(i)))
    }
  )
  lapply(
    prime_factor_tables, 
    function(pft)
    {
      powers <- plyr::alply(pft, 1, function(row) row$x ^ seq.int(0L, row$freq))
      power_grid <- do.call(expand.grid, powers)
      sort(unique(apply(power_grid, 1, prod)))
    }
  )
}

PCA <- function(data) {
  data = as.matrix(data)
  N = nrow(data)
  M = ncol(data)
  R = cor(data)
  tmp = eigen(R)
  tmp2 = sort(tmp$values,decreasing = TRUE,index.return = TRUE)
  eigval = tmp2$x
  eigvec = tmp$vectors[,order(tmp2$ix)]
  
  #loadings matrix
  pca_loadings = matrix(0,M,M)
  for (i in 1:M) {
    pca_loadings[,i] = sqrt(eigval[i]) %*% eigvec[,i] 
    next
  }
  
  #component scores
  xbar = colMeans(data)
  Xd = data - matrix(1,N,1)%*%t(xbar)
  v = diag(M)*diag(1/sqrt(var(data)))
  Xs = Xd %*% v
  Y = Xs %*% eigvec
  pca_scores = Y
  
  output = list(eigval=eigval,eigvec=eigvec,pca_loadings=pca_loadings,pca_scores=pca_scores)
  
  return(output)
  
}

Factor_Analysis <- function(data,num_factors) {
  data = as.matrix(data)
  N = nrow(data)
  M = ncol(data)
  R = cor(data)
  tmp = eigen(R)
  tmp2 = sort(tmp$values,decreasing = TRUE,index.return = TRUE)
  eigval = tmp2$x
  eigvec = tmp$vectors[,order(tmp2$ix)]
  
  xbar = colMeans(data)
  Xd = data - matrix(1,N,1)%*%t(xbar)
  v = diag(M)*diag(1/sqrt(var(data)))
  Xs = Xd %*% v
  
  eigval2 = eigval[1:num_factors]
  eigvec2 = eigvec[,1:num_factors]
  lambda_mat = matrix(0,M,num_factors)
  for (i in 1:num_factors) {
    lambda_mat[,i] = sqrt(eigval2[i]) %*% eigvec2[,i]
    next
  }
  
  #generalized inverse is necessary to avoid matrix close to singularity
  fa_scores = Xs %*% ginv(R) %*% lambda_mat
  
  rotation = varimax(lambda_mat)
  B = lambda_mat %*% rotation$rotmat
  fa_scores_rotated = Xs %*% ginv(R) %*% B
  
  output = list(fa_loadings=lambda_mat,fa_scores=fa_scores,fa_loadings_rotated=B,fa_scores_rotated=fa_scores_rotated,num_factors=num_factors)
  
  return(output)
  
}

MC_Adjust <- function(data,delta1,delta2){
  col2rmv = which(colVars(data) < delta1)
  newdata = subset(data,select = -col2rmv)
  col2rmv = caret::findLinearCombos(newdata)$remove
  newdata = subset(newdata,select = -col2rmv)
  
  C = cor(newdata)
  samp = data.frame(which(apply(abs(C),MARGIN = 2,function(x) between(x,(1-delta2),1.0)),arr.ind = TRUE))
  mylist = data.frame(matrix(nrow = nrow(C),ncol=2))
  colnames(mylist) = c("num","name")
  mylist[,1] = 1:ncol(C)
  mylist[,2] = colnames(newdata)
  temp = lookup(samp,mylist)
  col2rmv = which(colnames(newdata) %in% temp[duplicated(temp)])
  newdata = subset(newdata,select = -col2rmv)
  return(newdata)
}

TVA2 <- function(data,block_length,level_limit=50,level_keep=10) {
  
  data = as.data.frame(data)
  #this is how many levels you want to keep
  level_keep = as.integer(level_keep)
  #find number of rows
  num_rows = nrow(data)
  num_blocks = as.numeric(floor(num_rows / block_length))
  
  #the next block of code is to determine the block width to dimensionalize the State Vector
  #find how many numeric variables there are 
  numeric_vars = as.numeric(sum(sapply(data,is.numeric)==TRUE))
  #find which columns are less than or equal to the level limit
  list1 = data %>% sapply(nlevels) %>% is_weakly_less_than(level_limit) %>% which(arr.ind=T)
  #find which columns are greater than the level limit
  list2 = data %>% sapply(nlevels) %>% is_greater_than(level_limit) %>% which(arr.ind=T)
  #if no columns above level limit, set level_keep to 0
  if (length(list2) == 0) level_keep=0
  #count the number of levels in all the columns found in list 1
  num_levels = data[,list1] %>% sapply(nlevels) %>% as.numeric %>% sum 
  #determines the width of the state vector
  block_width = num_levels + numeric_vars + length(list2)*level_keep
  State_Vector = matrix(nrow = num_blocks, ncol = block_width)
  
  i=1
  start = 1
  for (i in 1:num_blocks){
    stopp = block_length*i
    #create a temp variable to represent iterative block
    assign("temp",data[start:stopp,])
    #subset temp with only the columns that are of type factor
    temp_fac = temp %>% dplyr::select_if(is.factor)
    #find which columns in temp_fac are less than or equal to the level limit
    list1 = which(sapply(temp_fac,nlevels) <= level_limit,arr.ind = TRUE)
    #find which columns in temp_fac are greater than the level limit
    list2 = which(sapply(temp_fac,nlevels) > level_limit,arr.ind = TRUE)
    #for all columns in list 1, create a summary list
    vec1 = sapply(temp_fac[list1], summary)
    if (length(list2 != 0)) {
      j=1
      vec3 = vector("list", length = length(list2)*level_keep)
      for (j in 1:length(list2)){
        #finds the top most occurring factor levels for those that exceed the level limit
        temp1 = head(sapply(temp_fac[list2[j]],summary),n=level_keep)
        temp2 = as.vector(temp1)
        vec3[[j]] <- temp2
        next
      }
    }
    #subset the temp with only the columns that are of type numeric
    temp_num = temp %>% dplyr::select_if(is.numeric)
    #sum the entire column
    vec2 = sapply(temp_num, sum)
    vec0 = c(unlist(vec1),unlist(vec2))
    if (exists("vec3")) vec0 = c(vec0, unlist(vec3))
    State_Vector[i,] = vec0
    start = stopp + 1
    next
  }
  
  #the following set of code is to build the name list for the level_keep variables 
  list2names = NULL
  if (length(list2) != 0) {
    k=1
    for (k in 1:length(list2)){
      #takes the original name of the column and adds a number to it
      list2names = c(list2names,paste(names(data[list2[k]]),1:level_keep,sep="_"))
    }
  }
  namelist = c(unlist(sapply(temp_fac[list1],levels)),names(temp_num),list2names)
  colnames(State_Vector) = namelist
  return(State_Vector)
  
}

Block_Inspect <- function(data,block_length){
  num_rows = nrow(data)
  num_blocks = as.numeric(floor(num_rows / block_length))
  Blocks = vector("list",num_blocks)
  i=1
  start = 1
  for (i in 1:num_blocks){
    stopp = block_length*i
    Blocks[[i]] = data[start:stopp,]
    start = stopp + 1
    next
  }
  return(Blocks)
}

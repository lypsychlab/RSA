#behavioral_PCA.R:
# run principal components analysis on behavioral data
# make some nice biplots of PCA data, using ggplot/ggbiplot ((c) Vince Q. Vu, https://github.com/vqv/ggbiplot)
# run K-means clustering analysis on PCA data

setwd('~/Documents/data_analysis/dis_rsa/behavioral_variables')
# change this when running on a different system
source('~/Documents/code/R/ggbiplot.R')
source('~/Documents/code/R/ggscreeplot.R')
# note: I (Emily) use a slightly customized ggscreeplot, to show percent variance 
library('ggplot2')

d=read.csv('behavioral_vars.csv') #csv file of behavioral variables (1 measurement/item)

colnames(d)[1]='acc_wrongness'
colnames(d)[2]='int_wrongness'

pc=prcomp(d,scale.=TRUE,center=TRUE)

# make a crappy plot:
ggbiplot(pc)

# make a pretty plot with groups indicated:
colnames(d)[1:12]=c('WR (Acc)','WR (Int)','DIS','HTO','HTS','PA','SA','WRD','RAT','ENV','BEH','MIND')
vec=rep(1:4,12)
d$cond=as.factor(vec[order(vec)])
levels(d$cond)=c('Physical Harm','Psychological Harm','Incest','Purity')
colormaps=c('firebrick1','darkgoldenrod1','mediumpurple1','mediumseagreen')

ggbiplot(pc,groups=d$cond)+scale_color_manual(values=colormaps)

# write out the PCA loadings:
loadings=pc$x
write.csv(loadings,'behavioral_loadings.csv')

loadings=loadings[,1:5]
# Kmeans (2 centroids):
K=kmeans(loadings,2,iter.max=100L,nstart=10)
d$K2=as.factor(K$cluster)
ggbiplot(pc,groups=d$K2)

# for reporting clusters:
for (i in 1:4) {
	inds=(1+((i-1)*12)):(12+((i-1)*12))
	print(paste('1: ',length(which(as.numeric(K$cluster[inds])==1))),sep="")
	print(paste('2: ',length(which(as.numeric(K$cluster[inds])==2))),sep="")
}

# Kmeans (3 centroids):
K=kmeans(loadings,3,iter.max=100L,nstart=10)
d$K3=as.factor(K$cluster)
ggbiplot(pc,groups=d$K3)

for (i in 1:4) {
	inds=(1+((i-1)*12)):(12+((i-1)*12))
	print(paste('1: ',length(which(as.numeric(K$cluster[inds])==1))),sep="")
	print(paste('2: ',length(which(as.numeric(K$cluster[inds])==2))),sep="")
	print(paste('3: ',length(which(as.numeric(K$cluster[inds])==3))),sep="")

}

# Kmeans (4 centroids):
K=kmeans(loadings,4,iter.max=10L,nstart=10)
d$K4=as.factor(K$cluster)
ggbiplot(pc,groups=d$K4)

for (i in 1:4) {
	inds=(1+((i-1)*12)):(12+((i-1)*12))
	print(paste('1: ',length(which(as.numeric(K$cluster[inds])==1))),sep="")
	print(paste('2: ',length(which(as.numeric(K$cluster[inds])==2))),sep="")
	print(paste('3: ',length(which(as.numeric(K$cluster[inds])==3))),sep="")
	print(paste('4: ',length(which(as.numeric(K$cluster[inds])==4))),sep="")
}
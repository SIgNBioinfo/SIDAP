## cluster detection
if (ifCluster) {
    cluster_output <- kblm_cluster(transformed, exprs, para)
    
    train_data <- exprs[as.character(cluster_output[[3]]$ind), ]
    train_class <- cluster_output[[3]]$cluster
    svm.obj <- svm(train_data, train_class, type = "C-classification")
    pred <- predict(svm.obj, exprs)
    cluster <- data.frame(cluster = pred)
    if (sum(row.names(exprs) != row.names(cluster)) > 0) {
        print("Error.\n")
    }
    tsne_cluster <- data.frame(transformed, cluster)
    write.table(tsne_cluster, paste(baseName, "_tsne_cluster.txt", 
                                    sep = ""), sep = "\t", col.names = NA)
    
    add_col_to_fcs(analysisFile = paste(baseName, "_tsne_cluster.txt", 
                                        sep = ""), rawFCSdir = rawFCSdir, analyzedFCSdir = "analyzedFCS", 
                   transformed_col = c("ViSNE_dim1", "ViSNE_dim2"), cluster_col = c("cluster"))
} else {
    add_col_to_fcs(analysisFile = paste(baseName, "_tsne.txt", sep = ""), 
                   rawFCSdir = rawFCSdir, analyzedFCSdir = "analyzedFCS", transformed_col = c("ViSNE_dim1", 
                                                                                              "ViSNE_dim2"), cluster_col = NULL)
}

if (sum(row.names(exprs) != row.names(cluster)) > 0) {
    print("Error.\n")
}
exprs_cluster <- data.frame(exprs, cluster)
clust_mean <- aggregate(. ~ cluster, data = exprs_cluster, mean)

write.table(clust_mean, paste(baseName, "_clusterMean.txt", sep = ""), 
            sep = "\t", row.names = FALSE)
rownames(clust_mean) <- paste("cluster_", clust_mean$cluster, sep = "")
clust_mean <- clust_mean[, -which(colnames(clust_mean) == "cluster")]
if (nrow(clust_mean) > 1 & ncol(clust_mean) > 1) {
    pdf(paste(baseName, "clusterMeanHeatmap.pdf", sep = ""))
    heatmap.2(as.matrix(clust_mean), col = bluered, trace = "none", 
              scale = "none", margins = c(8, 8))
    dev.off()
}

##### calculate cluster percentage
cluster$sample <- sub("_[0-9]*$", "", row.names(cluster))
clust_cellCount <- as.data.frame(table(cluster[, c("sample", "cluster")]))
colnames(clust_cellCount)[3] <- "cellCount"
sample_cellCount <- as.data.frame(table(cluster$sample))
colnames(sample_cellCount) <- c("sample", "totalCellCount")
clust_cellCount <- merge(clust_cellCount, sample_cellCount, by = "sample")
clust_cellCount$percentage <- clust_cellCount$cellCount/clust_cellCount$totalCellCount * 
    100
write.table(clust_cellCount, paste(baseName, "_clusterCellCount.txt", 
                                   sep = ""), sep = "\t", row.names = FALSE)
clust_percentage <- cast(clust_cellCount, sample ~ cluster, value = "percentage")
write.table(clust_percentage, paste(baseName, "_clusterPerc.txt", 
                                    sep = ""), sep = "\t", row.names = FALSE)
clust_percentage_long <- melt(clust_percentage, id = "sample", variable_name = "cluster")
colnames(clust_percentage_long)[which(colnames(clust_percentage_long) == 
                                          "value")] <- "percentage"
write.table(clust_percentage_long, paste(baseName, "_clusterPerc_long.txt", 
                                         sep = ""), sep = "\t", row.names = FALSE)

row.names(clust_percentage) <- clust_percentage$sample
clust_percentage <- clust_percentage[, -which(colnames(clust_percentage) == 
                                                  "sample")]
colnames(clust_percentage) <- paste("cluster_", colnames(clust_percentage), 
                                    sep = "")
if(nrow(clust_percentage) > 1 && ncol(clust_percentage) > 1){
    pdf(paste(baseName,"clusterPercHeatmap.pdf",sep=""),width=nrow(clust_percentage)*0.8,height=ncol(clust_percentage)*0.8)
    par(mar = rep(2, 4))
    heatmap.2(t(as.matrix(clust_percentage)),col=bluered,trace="none",scale="none",margins = c(15,8),labRow=colnames(clust_percentage),labCol=rownames(clust_percentage),cexRow=1,cexCol=1)
    dev.off()
}
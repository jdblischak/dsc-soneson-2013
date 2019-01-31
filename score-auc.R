# Compute the Area Under the ROC Curve
#
# Input:
#   - pval_adj
#   - truth
#
# Output:
#   - auc

library(pROC)

roc_data <- roc(truth, 1 - pval_adj, direction = "<")
auc <- auc(roc_data)
auc <- as.numeric(auc)

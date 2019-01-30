# Compute the Area Under the ROC Curve
#
# Input:
#   - pval_adj
#   - truth
#
# Output:
#   - auc

library(pROC)

prediction <- pval_adj < 0.05
prediction <- as.numeric(prediction)

roc_data <- roc(truth, prediction)
auc <- auc(roc_data)
auc <- as.numeric(auc)

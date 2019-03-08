#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(ggplot2)
})
theme_set(theme_bw())

dir.create("figures/", showWarnings = FALSE)

df_auc <- read.delim("data/auc.txt")
p_auc <- ggplot(df_auc, aes(x = analyze, y = auc)) +
  geom_point() +
  facet_grid(samples_per_cond ~ de) +
  labs(x = "DE method", y = "AUC",
       title = "Area under the curve") +
  theme(axis.text.x = element_text(angle = 45, hjust = 0.75, vjust = 0.75))
ggsave("figures/auc.png", p_auc, width = 21, height = 9)

df_t1 <- read.delim("data/t1error.txt")
p_t1 <- ggplot(df_t1, aes(x = analyze, y = type_one_error)) +
  geom_point() +
  facet_grid(samples_per_cond ~ zeros) +
  labs(x = "DE method", y = "Type 1 Error",
       title = "Type I error rate") +
  theme(axis.text.x = element_text(angle = 45, hjust = 0.75, vjust = 0.75))
ggsave("figures/t1.png", p_t1, width = 12, height = 9)

df_fdr <- read.delim("data/fdr.txt")
p_fdr <- ggplot(df_fdr, aes(x = analyze, y = true_fdr)) +
  geom_point() +
  facet_grid(samples_per_cond ~ de) +
  labs(x = "DE method", y = "FDR",
       title = "False discovery rate") +
  theme(axis.text.x = element_text(angle = 45, hjust = 0.75, vjust = 0.75))
ggsave("figures/fdr.png", p_fdr, width = 21, height = 9)

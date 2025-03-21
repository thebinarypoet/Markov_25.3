# 指定要检查的列
columns_to_check <- c("wspeed1", "wspeed2", "bmi", "da051_3_", 
                      "qc003", "qc004", "qc005", "qc006", 
                      "dc012", "dc018")

# 确保数据集都有相同的 ID，并按照 ID 排序（可选）
Model_2011_filtered <- Model_2011_filtered[order(Model_2011_filtered$ID), ]
Model_2013_filtered <- Model_2013_filtered[order(Model_2013_filtered$ID), ]
Model_2015_filtered <- Model_2015_filtered[order(Model_2015_filtered$ID), ]

# 检查每个 ID 在三个数据集中，指定列是否完全无缺失值
complete_2011 <- complete.cases(Model_2011_filtered[, columns_to_check])
complete_2013 <- complete.cases(Model_2013_filtered[, columns_to_check])
complete_2015 <- complete.cases(Model_2015_filtered[, columns_to_check])

# 仅保留在 **三个数据集中所有列都无缺失值** 的 ID
valid_IDs <- Model_2011_filtered$ID[complete_2011 & complete_2013 & complete_2015]

# 过滤符合条件的 ID（删除不符合的）
Model_2011_filtered <- Model_2011_filtered[Model_2011_filtered$ID %in% valid_IDs, ]
Model_2013_filtered <- Model_2013_filtered[Model_2013_filtered$ID %in% valid_IDs, ]
Model_2015_filtered <- Model_2015_filtered[Model_2015_filtered$ID %in% valid_IDs, ]

# 查看删除后的数据集大小
dim(Model_2011_filtered)
dim(Model_2013_filtered)
dim(Model_2015_filtered)

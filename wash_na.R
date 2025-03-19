# 加载必要的包
library(dplyr)

# 假设三个数据集已经加载到环境中
# Model_2011_filtered, Model_2013_filtered, Model_2015_filtered

# 1. 合并三个数据集，并添加一个标识列
combined_data <- bind_rows(
  Model_2011_filtered %>% mutate(Source = "2011"),
  Model_2013_filtered %>% mutate(Source = "2013"),
  Model_2015_filtered %>% mutate(Source = "2015")
)

# 2. 检查每个ID的每一列是否在三个数据集中都为NA
# 对每个ID，检查除了ID列和Source列之外的所有列
ids_to_remove <- combined_data %>%
  group_by(ID) %>%
  summarise(across(-Source, ~ all(is.na(.x)))) %>%
  filter(if_any(-ID, ~ .x)) %>%
  pull(ID)

# 3. 删除符合条件的ID
filtered_data <- combined_data %>%
  filter(!ID %in% ids_to_remove)

# 4. 拆分回原始数据集
Model_2011_filtered_cleaned <- filtered_data %>%
  filter(Source == "2011") %>%
  select(-Source)

Model_2013_filtered_cleaned <- filtered_data %>%
  filter(Source == "2013") %>%
  select(-Source)

Model_2015_filtered_cleaned <- filtered_data %>%
  filter(Source == "2015") %>%
  select(-Source)

# 查看结果
print(head(Model_2011_filtered_cleaned))
print(head(Model_2013_filtered_cleaned))
print(head(Model_2015_filtered_cleaned))
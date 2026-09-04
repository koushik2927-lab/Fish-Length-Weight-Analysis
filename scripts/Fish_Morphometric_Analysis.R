# Fish Length-Weight Relationship Analysis
# Mekong River Fish Dataset
# Analysis using R

# ============================================================
# 1. Load dataset
# ============================================================

fish_raw <- read.csv(file.choose())

# ============================================================
# 2. Data cleaning
# ============================================================

colSums(is.na(fish_raw))

fish_clean <- na.omit(fish_raw)

dim(fish_clean)
colSums(is.na(fish_clean))

# ============================================================
# 3. Log10 transformation
# ============================================================

fish_clean$log_length <- log10(fish_clean$tl.cm)
fish_clean$log_weight <- log10(fish_clean$W.g)

# ============================================================
# 4. Overall length-weight regression
# ============================================================

log_model <- lm(log_weight ~ log_length, data = fish_clean)

summary(log_model)

# Extract parameters
a_value <- 10^(coef(log_model)[1])
b_est <- coef(log_model)[2]
r2_overall <- summary(log_model)$r.squared

a_value
b_est
r2_overall

# ============================================================
# 5. Species selection
# ============================================================

species_counts <- table(fish_clean$Genus_species)

selected_species <- names(
  species_counts[species_counts >= 100]
)

length(selected_species)

# ============================================================
# 6. Species-wise regression
# ============================================================

species_results <- data.frame()

for (sp in selected_species) {
  
  sp_data <- subset(
    fish_clean,
    Genus_species == sp
  )
  
  model <- lm(
    log_weight ~ log_length,
    data = sp_data
  )
  
  species_results <- rbind(
    species_results,
    data.frame(
      species = sp,
      b = coef(model)[2],
      R2 = summary(model)$r.squared
    )
  )
}

species_results

# ============================================================
# 7. 95% confidence intervals for b
# ============================================================

ci_table <- data.frame()

for (sp in selected_species) {
  
  sp_data <- subset(
    fish_clean,
    Genus_species == sp
  )
  
  model <- lm(
    log_weight ~ log_length,
    data = sp_data
  )
  
  ci <- confint(model, "log_length", level = 0.95)
  
  ci_table <- rbind(
    ci_table,
    data.frame(
      species = sp,
      b = coef(model)[2],
      lower = ci[1],
      upper = ci[2]
    )
  )
}

ci_table <- ci_table[order(ci_table$b), ]

ci_table

# ============================================================
# 8. Test whether b differs from 3
# H0: b = 3
# ============================================================

test_results <- data.frame()

for (sp in selected_species) {
  
  sp_data <- subset(
    fish_clean,
    Genus_species == sp
  )
  
  model <- lm(
    log_weight ~ log_length,
    data = sp_data
  )
  
  b <- coef(model)[2]
  se_b <- summary(model)$coefficients[2, 2]
  
  t_value <- (b - 3) / se_b
  df <- df.residual(model)
  
  p_value <- 2 * pt(
    -abs(t_value),
    df = df
  )
  
  test_results <- rbind(
    test_results,
    data.frame(
      species = sp,
      b = b,
      t = t_value,
      p = p_value
    )
  )
}

test_results

# ============================================================
# 9. Growth classification
# ============================================================

test_results$growth_final <- ifelse(
  test_results$p >= 0.05,
  "Isometric",
  ifelse(
    test_results$b > 3,
    "
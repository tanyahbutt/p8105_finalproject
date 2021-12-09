filtered_wt_avgs_df =
  read_csv("project_df.csv") %>%
  select(modzcta, dbn, n_testers, n_offers, year) %>%
  drop_na() %>% 
  filter(n_offers > 5) %>% 
  group_by(modzcta, year) %>% 
  summarize(
    avg_testers = mean(n_testers),
    avg_offers = mean(n_offers),
    wt_avg = weighted.mean(n_offers, n_testers)
  ) %>% 
  pivot_wider(names_from = year, values_from = avg_testers:wt_avg) %>%
  drop_na() %>% 
  mutate(
    `2015-19_avg_testers` = mean(avg_testers_2015:avg_testers_2019),
    `2015-19_avg_offers` = mean(avg_offers_2015:avg_testers_2019),
    `2015-19_wt_avg` = mean(wt_avg_2015:wt_avg_2019),
    all_years_avg_testers = mean(avg_testers_2015:avg_testers_2020),
    all_years_avg_offers = mean(avg_offers_2015:avg_testers_2020),
    all_years_wt_avg = mean(wt_avg_2015:wt_avg_2020)
  ) %>% 
  select(
    all_years_avg_testers, 
    all_years_avg_offers, 
    all_years_wt_avg, 
    `2015-19_avg_testers`,
    `2015-19_avg_offers`, 
    `2015-19_wt_avg`, 
    avg_testers_2020, 
    avg_offers_2020, 
    wt_avg_2020
  )

write.csv(wt_avgs_df, "filtered_weighted_avgs.csv")
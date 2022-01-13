library(RankAggreg)

RankAggreg(ranks, 10, weights, seed = 123)

data("geneLists")
RankAggreg(geneLists, 25, seed = 123, rho = 0.01)

geneLists


### 가장 기본
library("BayesMallows")
potato_visual
potato_true_ranking
bmm_test <- compute_mallows(potato_visual)
assess_convergence(bmm_test)
assess_convergence(bmm_test, parameter = "rho")


### Transitive closure and initial ranking

beach_preferences
beach_tc <- generate_transitive_closure(beach_preferences)

beach_init_rank <- generate_initial_ranking(beach_tc)
colnames(beach_init_rank) <- paste("beach", 1:ncol(beach_init_rank))

library("dplyr")
filter(beach_preferences, assessor == 1, bottom_item == 2 | top_item == 2)

filter(beach_tc, assessor == 1, bottom_item == 2 | top_item == 2)

bmm_test <- compute_mallows(rankings = beach_init_rank, preferences = beach_tc, save_aug = T)

assess_convergence(bmm_test, parameter = "Rtilde", items = c(2,6,15), assessors = 1)

assess_convergence(bmm_test, parameter = "Rtilde", items = c(2,6,15), assessors = 2)


bmm_beachs <- compute_mallows(rankings = beach_init_rank, preferences = beach_tc, nmc = 102000, save_aug = T)
bmm_beachs$burnin <- 2000
compute_posterior_intervals(bmm_beachs, parameter = "rho")
compute_consensus(bmm_beachs, type = "CP")
plot_top_k(bmm_beachs)


### Clustering with BayesMallows
library("parallel")
cl <- makeCluster(4)
bmm <- compute_mallows_mixtures(n_clusters = c(1,5,7,10), rankings = sushi_rankings, nmc = 5000, save_clus = F, include_wcd = F, cl = cl)

stopCluster(cl)

assess_convergence(bmm, parameter = "cluster_probs")

cl <- makeCluster(4)
bmm <- compute_mallows_mixtures(n_clusters = 1:10, rankings = sushi_rankings, nmc = 100000, rho_thinning = 10, save_clus = F, include_wcd = T, cl = cl) # 이게 오래걸림. within cluster sum of distance = T 라서 계산하는데 걸린다.
stopCluster(cl)

plot_elbow(bmm, burnin = 5000) 

bmm <- compute_mallows(rankings = sushi_rankings, n_clusters = 5, save_clus = T, clus_thin = 10, nmc = 100000, rho_thinning = 10)

bmm$burnin<- 5000

plot(bmm, parameter = "cluster_probs")
plot(bmm, parameter = "cluster_assignment")

library("tidyr")
compute_consensus(bmm) %>%
  select(-cumprob) %>%
  spread(key = cluster, value = item)

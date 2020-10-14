library(survival)
rm (CLUSTER)
     Rplink <- function(PHENO,GENO,CLUSTER,COVAR)
     {
      f1 <- function(s) 
      {
        m <- summary( coxph( Surv( PHENO , COVAR[,2]==5 ) ~ s + COVAR[,1] + COVAR[,3] + COVAR[,4] + COVAR[,5] + cluster(COVAR[,6]), control=coxph.control(iter.max = 100)    ) )
        r <- c( m$n, m$coefficients[1,2] , m$coefficients[1,3], m$coefficients[1,4], m$coefficients[1,5], m$coefficients[1,6] , m$conf.int [1,3], m$conf.int[1,4])
        c( length(r) , r )
      }
     apply( GENO , 2 , f1 )
     }

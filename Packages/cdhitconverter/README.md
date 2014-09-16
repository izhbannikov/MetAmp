##How to use:

~~~R
library(CDHITConverter)

fnames <- c(system.file("extdata", "test1.clstr", package="CDHITConverter"),system.file("extdata", "test2.clstr", package="CDHITConverter"),system.file("extdata", "test3.clstr", package="CDHITConverter"))

ans <- convert(fnames)

ans
~~~R 

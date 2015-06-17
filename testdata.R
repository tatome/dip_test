#
# Generate random samples of different sizes, compute dips for them, and
# store samples and dips in csv files as test data for the python
# implementation. 
#


library(diptest)

f <- function(num_samples) {
	function(blub) {
		d <- runif(num_samples)
		append(d, dip(d))
	}
}

out_data <- do.call(rbind, lapply(X=1:10000, FUN=f(5)))
write.table(out_data, row.names=FALSE, col.names=FALSE, sep=",", file="test-5.csv")

out_data <- do.call(rbind, lapply(X=1:10000, FUN=f(10)))
write.table(out_data, row.names=FALSE, col.names=FALSE, sep=",", file="test-10.csv")

out_data <- do.call(rbind, lapply(X=1:10000, FUN=f(100)))
write.table(out_data, row.names=FALSE, col.names=FALSE, sep=",", file="test-100.csv")

out_data <- do.call(rbind, lapply(X=1:10000, FUN=f(1000)))
write.table(out_data, row.names=FALSE, col.names=FALSE, sep=",", file="test-1000.csv")

# Test data with repeated values.
f <- function(num_samples) {
	function(blub) {
		d <- runif(num_samples)
		d <- c(d, sample(d, floor(num_samples / 2)))
		append(d, dip(d))
	}
}

out_data <- do.call(rbind, lapply(X=1:100, FUN=f(5)))
write.table(out_data, row.names=FALSE, col.names=FALSE, sep=",", file="test-repeated-5.csv")

out_data <- do.call(rbind, lapply(X=1:100, FUN=f(10)))
write.table(out_data, row.names=FALSE, col.names=FALSE, sep=",", file="test-repeated-10.csv")

out_data <- do.call(rbind, lapply(X=1:100, FUN=f(100)))
write.table(out_data, row.names=FALSE, col.names=FALSE, sep=",", file="test-repeated-100.csv")

out_data <- do.call(rbind, lapply(X=1:100, FUN=f(1000)))
write.table(out_data, row.names=FALSE, col.names=FALSE, sep=",", file="test-repeated-1000.csv")

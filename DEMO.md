### Chapter 1

Why do we use 3GB of memory after Concat instead of 2GB?

* data variable is 1GB
* csv variable is 1GB
* The extra 1GB are the intermediate results stored in memory in the row.join

Optimized version - re-write to not allocate that extra 1GB of intermediate data
Now, Ruby 1.9.3, Ruby 2.1.5 and Ruby 2.2.1 are all similar

#### Chapter 1

Why do we use 3GB of memory after Concat instead of 2GB?

* data variable is 1GB
* csv variable is 1GB
* The extra 1GB are the intermediate results stored in memory in the row.join

Optimized version - re-write to not allocate that extra 1GB of intermediate data

* Ruby 1.9.3, Ruby 2.1.5 and Ruby 2.2.1 are all similar with concat performance
* Notice differences in memory usage though with Ruby 1.9.3 vs 2.1.5/2.2.1 - has to do with generational GC

#### Chapter 2

Measure GC performance with wrapper

Measurements with and without GC will differ.

* With GC, we will get amount of memory allocated by the block that stays allocated after we are done - useful for finding memory leaks
* Without GC, we will get total memory consumption
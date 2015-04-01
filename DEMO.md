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

String manipulation

* bang! functions for in-place modification - good for memory usage (not 'functional' though)
* Free collections during iteration if possible (each_bang.rb)

#### Chapter 3

$ RAILS_ENV=production rake db:create && RAILS_ENV=production rake db:migrate

$ psql ch3_production

ch3_development=# select pg_size_pretty(pg_relation_size('things'));

This shows database size of 11 MB

Add lib/measure.rb and modify config/application to load files in lib

* config.autoload_paths << Rails.root.join('lib')

First example - load only attributes you need

$ RAILS_ENV=production bundle exec rails c

> Measure.run(gc: :disable) { Thing.all.load }

> Measure.run(gc: :disable) { Thing.all.select([:id, :col1, :col5]).load }

Second example - preload data

> Measure.run(gc: :disable) { Thing.all.each { |thing| thing.minions.load } }

> Measure.run(gc: :disable) { Thing.first(100).each { |thing| thing.minions.load } }

> Measure.run(gc: :disable) { Thing.all.includes(:minions).load }

> Measure.run(gc: :disable) { Thing.where('id <= 100').includes(:minions).load }

Third example - for certain cases, don't use ActiveRecord

> arr = ActiveRecord::Base.connection.execute("select * from things")

> Thing.all.pluck(:id, :col1)

> Thing.find(1).pluck(:id, :col1) # doesn't work - find(1) returns ActiveRecord, not ActiveRelation

> Thing.where('id=1').pluck(:id, :col1) # this works

> Thing.where('id < 10').update_all(col1: 'z' * 100)

#### Chapter 4

Profiling - just a taste

$ gem install ruby-prof

$ ruby ruby_prof_example_api.rb

$ ruby-prof -p flat -m 1 -f ruby_prof_example_command_profile.txt ruby_prof_example_command.rb
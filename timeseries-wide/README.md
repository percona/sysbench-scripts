Timeseries
================

* Prepare table
sysbench --test=insert.lua prepare

* Create files
* This will generate X sets of data (one per thread).  Consider each thread one customer.  
* Each thread generates six files:
* sensordata_X.txt - the actual values of the counters
* sensordata_cnt_X.txt - count of the values
* sensordata_sum_X.txt - sum of the values
* sensordata_min_X.txt - sum of the values
* sensordata_max_X.txt - sum of the values
* sensordata_pct_X.txt - sum of the values

* Generate 1 million samples of 1000 sensors per sample (1 sample = 6 rows, 19GB of generated data)
sysbench --mysql-user=root --mysql-port=5029 --mysql-host=127.0.0.1 --test=insert.lua --num-threads=10 --max-requests=1000 --max-time=0 --report-interval=10 run


* Querying
* Getting the average of a counter is possible even though it is not stored directly
select the_sum1 / the_cnt1 as avg1, the_sum300 / the_cnt300 as avg300
from ( select sum(sensor1) the_sum1, sum(sensor300) the_sum300 
        from sensordata_sum_1
       where ts >= now() - interval 30 minute 
         and mach_id = 100 ) sums
join ( select sum(sensor1) the_cnt1, sum(sensor300) the_cnt300 
        from sensordata_cnt_1
       where ts >= now() - interval 30 minute 
         and mach_id = 100 ) cnts 
      

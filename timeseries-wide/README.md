Timeseries
================

Data Generation
--
The insert.lua script will generate N sets of data (one per thread).  
Consider each thread one customer.
Each "request" is 1 sample each from 1000 machines.
Each sample contains aggregate readings from 1000 sensors.

Each thread generates six files:

* sensordata_N.txt - the actual values of the counters
* sensordata_cnt_N.txt - count of the values
* sensordata_sum_N.txt - sum of the values
* sensordata_min_N.txt - min of the values
* sensordata_max_N.txt - max of the values
* sensordata_pct_N.txt - percentile of the values

###To generate 1 million samples 

```
sysbench \
--mysql-user=root --mysql-port=5029 --mysql-host=127.0.0.1 \ 
--test=insert.lua --num-threads=10 \
--max-requests=1000 \
--max-time=0 --report-interval=10 run
```

Note that the timing information above is just data generator timing.  No data is actually being loaded into the database.  
I found that not passing the MySQL connection paramaters into the script failed, so I just passed the parameters to my running server, even though the insert.lua script won't actually connect.


Prepare table
--
sysbench --test=insert.lua prepare


Querying
--
###With SQL you can get the average of a counter:

```
    select 
    the_sum1 / the_cnt1 as the_avg1, 
    the_sum300 / the_cnt300 as the_avg300
    from ( select sum(sensor1) the_sum1, sum(sensor300) the_sum300
            from sensordata_sum_1
           where ts >= now() - interval 30 minute
             and mach_id = 100 ) sums
    join ( select sum(sensor1) the_cnt1, sum(sensor300) the_cnt300
            from sensordata_cnt_1
           where ts >= now() - interval 30 minute
             and mach_id = 100 ) cnts
```


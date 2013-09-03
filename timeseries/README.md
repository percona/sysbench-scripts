Timeseries
================

* Prepapre table
sysbench --test=insert.lua --mysql-db=sensor --mysql-user=root --mysql-table-engine=InnoDB prepare

* Run insert benchmark
sysbench --test=insert.lua --mysql-db=sensor --mysql-user=root --num-threads=16 --max-requests=1000000 --max-time=0 --report-interval=10 run 

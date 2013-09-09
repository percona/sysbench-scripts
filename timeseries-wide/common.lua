function prepare()
   local query
   local i
   local j

   db_connect()

   local columns = ""
   for i=1,1001 do
      columns = columns .. "\nsensor_" .. i .. " double,"
   end

   sql = "CREATE table sensordata\n";
   t_sql = "(ts int," .. columns .. "\nmachine_id int)\n";

   db_query(sql .. t_sql);
   sql = "CREATE table sensordata_sum\n";
   db_query(sql .. t_sql);
   sql = "CREATE table sensordata_cnt\n";
   db_query(sql .. t_sql);
   sql = "CREATE table sensordata_min\n";
   db_query(sql .. t_sql);
   sql = "CREATE table sensordata_max\n";
   db_query(sql .. t_sql);
   sql = "CREATE table sensordata_95\n";
   db_query(sql .. t_sql);

   return 0

end

function cleanup()
   local i

   set_vars()

   db_query("DROP TABLE sensordata" )
   db_query("DROP TABLE sensordata_sum" )
   db_query("DROP TABLE sensordata_cnt" )
   db_query("DROP TABLE sensordata_min" )
   db_query("DROP TABLE sensordata_max" )
   db_query("DROP TABLE sensordata_95" )

end

function set_vars()

end


pathtest = string.match(test, "(.*/)") or ""

dofile(pathtest .. "common.lua")

function thread_init(thread_id)
   set_vars()
   init_ts = os.time()
end

function event(thread_id)

   -- print("thread prepare"..thread_id..", num thr"..num_threads) 

   if thread_id < num_threads-1 then
   site_id = sb_rand_uniform(0, 159)
   -- 159 really should be variable
   
   sensor_id = sb_rand(1,sensors_per_thread)
   ts_range = sb_rand(1000, 10000)

   rs = db_query("SELECT data1,data2,data3,cnt FROM sensordata WHERE site_id=" .. site_id .. " AND sensor_id=" .. sensor_id .. " AND ts between ".. start_ts .. " AND " .. (start_ts + ts_range) )
   else
   
   for site_id = thread_id*10, (thread_id+1)*10-1 do

   db_bulk_insert_init("INSERT IGNORE INTO sensordata(ts, site_id, sensor_id, data1,data2,data3,data4,data5,cnt) VALUES")

   for j = 1, sensors_per_thread do
	 db_bulk_insert_next("("..init_ts.."," .. site_id .. "," .. j .. ",".. sb_rand(1,1000).."/10,".. sb_rand(1,1000).."/10,".. sb_rand(1,1000).."/10,".. sb_rand(1,1000).."/10,".. sb_rand(1,1000).."/10,"..sb_rand(40,60)..")")
   end

   db_bulk_insert_done()
  
   end

   init_ts = init_ts + 1
   end

end


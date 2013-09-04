pathtest = string.match(test, "(.*/)") or ""

dofile(pathtest .. "common.lua")

function thread_init(thread_id)
   set_vars()
   init_ts = os.time()
end

function event(thread_id)

   db_bulk_insert_init("INSERT INTO sensordata(ts, sensor_id, data1,data2,data3,data4,data5,cnt) VALUES")

   for j = sensors_per_thread*thread_id, sensors_per_thread*(thread_id+1)-1 do
	 db_bulk_insert_next("("..init_ts.."," .. j .. ",".. sb_rand(1,1000).."/10,".. sb_rand(1,1000).."/10,".. sb_rand(1,1000).."/10,".. sb_rand(1,1000).."/10,".. sb_rand(1,1000).."/10,"..sb_rand(40,60)..")")
   end

   init_ts = init_ts + 1
   db_bulk_insert_done()


end


dofile("common.lua")

function thread_init(thread_id)

   set_vars()
   init_ts = os.time()

end

function event(thread_id)

   f0 = assert(io.open("sensordata_" .. thread_id .. ".txt", "a"))
   f1 = assert(io.open("sensordata_max_" .. thread_id .. ".txt", "a"))
   f2 = assert(io.open("sensordata_min_" .. thread_id .. ".txt", "a"))
   f3 = assert(io.open("sensordata_sum_" .. thread_id .. ".txt", "a"))
   f4 = assert(io.open("sensordata_pct_" .. thread_id .. ".txt", "a"))
   f5 = assert(io.open("sensordata_cnt_" .. thread_id .. ".txt", "a"))

   -- 10K samples per batch
   for n=1,1000 do

      -- assign a random machine id to the row
      mach_id = sb_rand(1,1000);

      row = "" .. init_ts
      max_row = row
      min_row = row
      sum_row = row
      cnt_row = row
      pct_row = row

      for i=1, 1001 do

         cnt = sb_rand(40,60);

         max = sb_rand(1,1000);
         min = sb_rand(1,max);
         val = sb_rand(min,max);
         max = max / 10;
         min = min / 10;
         val = val / 10; 

         sum = max*cnt-min;
         pct = max-min;
         row = row .. val .. ","
         max_row = max_row .. max .. ","         
         min_row = min_row .. min .. ","         
         sum_row = sum_row .. sum .. ","         
         cnt_row = cnt_row .. cnt .. ","         
         pct_row = pct_row .. pct .. ","         

      end

      row = row .. mach_id .. "\n";
      max_row = max_row .. mach_id .. "\n";
      min_row = min_row .. mach_id .. "\n";
      cnt_row = cnt_row .. mach_id .. "\n";
      sum_row = sum_row .. mach_id .. "\n";
      pct_row = pct_row .. mach_id .. "\n";

      f0:write(row);
      f1:write(max_row)
      f2:write(min_row)
      f3:write(sum_row)
      f4:write(pct_row)
      f5:write(cnt_row)

      init_ts = init_ts + 1

   end

   f0:close()
   f1:close()
   f2:close()
   f3:close()
   f4:close()
   f5:close()

end


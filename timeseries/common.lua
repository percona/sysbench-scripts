-- Input parameters
-- oltp-tables-count - number of tables to create
-- oltp-secondary - use secondary key instead PRIMARY key for id column
--
--

function create_insert(table_id)

   local index_name
   local i
   local j
   local query

   i = table_id



   print("Creating table 'sensordata' ...")
   if (db_driver == "mysql") then
      query = [[
CREATE TABLE `sensordata` (
  `ts` int(10) unsigned NOT NULL DEFAULT '0',
  `site_id` int(10) unsigned NOT NULL,
  `sensor_id` int(10) unsigned NOT NULL,
  `data1` double NOT NULL,
  `data2` double NOT NULL,
  `data3` double NOT NULL,
  `data4` double NOT NULL,
  `data5` double NOT NULL,
  `cnt` int(10) unsigned NOT NULL,
  PRIMARY KEY (`site_id`,`sensor_id`,`ts`)
) /*! ENGINE = ]] .. mysql_table_engine ..
" ROW_FORMAT = " .. mysql_row_format .. " */"

   else

      print("Unknown database driver: " .. db_driver)
      return 1
   end

   db_query(query)

end



function prepare()
   local query
   local i
   local j

   set_vars()

   db_connect()


   --for i = 1,oltp_tables_count do
     create_insert(1)
   --end

   return 0
end

function cleanup()
   local i

   set_vars()

   -- for i = 1,oltp_tables_count do
   print("Dropping table 'sensordata'" )
   db_query("DROP TABLE sensordata" )
   -- end
end

function set_vars()
   oltp_tables_count = oltp_tables_count or 1
   sensors_per_thread = sensors_per_thread or 1000
   mysql_row_format = mysql_row_format or 'DEFAULT'
   start_ts = start_ts or 1300000000

   oltp_table_size = oltp_table_size or 10000
   oltp_range_size = oltp_range_size or 100
   oltp_point_selects = oltp_point_selects or 10
   oltp_simple_ranges = oltp_simple_ranges or 1
   oltp_sum_ranges = oltp_sum_ranges or 1
   oltp_order_ranges = oltp_order_ranges or 1
   oltp_distinct_ranges = oltp_distinct_ranges or 1
   oltp_index_updates = oltp_index_updates or 1
   oltp_non_index_updates = oltp_non_index_updates or 1


   if (oltp_read_only == 'on') then
      oltp_read_only = true
   else
      oltp_read_only = false
   end

   if (oltp_skip_trx == 'on') then
      oltp_skip_trx = true
   else
      oltp_skip_trx = false
   end

end

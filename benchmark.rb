require 'tty'
require_relative 'lib/lens/gzip_util'
require_relative 'lib/lens/compression'

data = <<LOG
Processing ProjectsController#index (for 127.0.0.1 at 2014-04-09 08:49:12) [GET]
I, [2014-04-09T08:49:12.102848 #71649]  INFO -- :   Parameters: {"controller"=>"projects", "action"=>"index"}
D, [2014-04-09T08:49:12.104303 #71649] DEBUG -- : User Load (0.2ms)  SELECT * FROM `users` WHERE (`users`.`id` = 1055964830) LIMIT 1
D, [2014-04-09T08:49:12.111569 #71649] DEBUG -- : Project Load (0.2ms)  SELECT * FROM `projects` ORDER BY id DESC
I, [2014-04-09T08:49:12.112001 #71649]  INFO -- : Rendering template within layouts/application
I, [2014-04-09T08:49:12.112073 #71649]  INFO -- : Rendering projects/index
D, [2014-04-09T08:49:12.119104 #71649] DEBUG -- : Project Columns (1.6ms)  SHOW FIELDS FROM `projects`
D, [2014-04-09T08:49:12.124703 #71649] DEBUG -- : Run Columns (2.7ms)  SHOW FIELDS FROM `runs`
D, [2014-04-09T08:49:12.126134 #71649] DEBUG -- : SQL (0.3ms)  SELECT count(*) AS count_all FROM `runs` INNER JOIN `projects_runs` ON `runs`.id = `projects_runs`.run_id WHERE ((file_present) AND (`projects_runs`.project_id = 4 ))
D, [2014-04-09T08:49:12.127778 #71649] DEBUG -- : projects_runs Columns (1.1ms)  SHOW FIELDS FROM `projects_runs`
D, [2014-04-09T08:49:12.128681 #71649] DEBUG -- : Run Load (0.3ms)  SELECT * FROM `runs` INNER JOIN `projects_runs` ON `runs`.id = `projects_runs`.run_id WHERE (`projects_runs`.project_id = 4 ) AND (file_present)
D, [2014-04-09T08:49:12.131352 #71649] DEBUG -- : Search Load (1.2ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881336) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.134110 #71649] DEBUG -- : Search Load (1.6ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881337) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.137107 #71649] DEBUG -- : Search Columns (2.3ms)  SHOW FIELDS FROM `searches`
D, [2014-04-09T08:49:12.143182 #71649] DEBUG -- : CACHE (0.0ms)  SELECT * FROM `runs` INNER JOIN `projects_runs` ON `runs`.id = `projects_runs`.run_id WHERE (`projects_runs`.project_id = 4 ) AND (file_present)
D, [2014-04-09T08:49:12.143857 #71649] DEBUG -- : CACHE (0.0ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881336) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.144332 #71649] DEBUG -- : CACHE (0.0ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881337) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.145795 #71649] DEBUG -- : ExperimentItemSearch Load (0.4ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 771)
D, [2014-04-09T08:49:12.146926 #71649] DEBUG -- : ExperimentItemSearch Load (0.3ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 772)
D, [2014-04-09T08:49:12.149330 #71649] DEBUG -- : Attachment Columns (1.3ms)  SHOW FIELDS FROM `attachments`
D, [2014-04-09T08:49:12.150200 #71649] DEBUG -- : SQL (0.2ms)  SELECT count(*) AS count_all FROM `attachments` WHERE (`attachments`.project_id = 4)
D, [2014-04-09T08:49:12.154392 #71649] DEBUG -- : User Load (0.3ms)  SELECT * FROM `users` WHERE (`users`.`id` = 1055964830)
D, [2014-04-09T08:49:12.177270 #71649] DEBUG -- : ProjectSharing Columns (22.1ms)  SHOW FIELDS FROM `project_sharings`
D, [2014-04-09T08:49:12.178144 #71649] DEBUG -- : SQL (0.3ms)  SELECT count(*) AS count_all FROM `project_sharings` WHERE (`project_sharings`.project_id = 4)
D, [2014-04-09T08:49:12.179150 #71649] DEBUG -- : User Load (0.3ms)  SELECT `users`.* FROM `users` INNER JOIN `project_sharings` ON `users`.id = `project_sharings`.user_id WHERE ((`project_sharings`.project_id = 4))
D, [2014-04-09T08:49:12.180727 #71649] DEBUG -- : SQL (0.2ms)  SELECT count(*) AS count_all FROM `runs` INNER JOIN `projects_runs` ON `runs`.id = `projects_runs`.run_id WHERE ((file_present) AND (`projects_runs`.project_id = 3 ))
D, [2014-04-09T08:49:12.181562 #71649] DEBUG -- : Run Load (0.2ms)  SELECT * FROM `runs` INNER JOIN `projects_runs` ON `runs`.id = `projects_runs`.run_id WHERE (`projects_runs`.project_id = 3 ) AND (file_present)
D, [2014-04-09T08:49:12.183575 #71649] DEBUG -- : Search Load (1.2ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881328) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.185259 #71649] DEBUG -- : Search Load (0.8ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881329) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.186178 #71649] DEBUG -- : CACHE (0.0ms)  SELECT * FROM `runs` INNER JOIN `projects_runs` ON `runs`.id = `projects_runs`.run_id WHERE (`projects_runs`.project_id = 3 ) AND (file_present)
D, [2014-04-09T08:49:12.186613 #71649] DEBUG -- : CACHE (0.0ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881328) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.187042 #71649] DEBUG -- : CACHE (0.0ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881329) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.187828 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 738)
D, [2014-04-09T08:49:12.188505 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 744)
D, [2014-04-09T08:49:12.189411 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 745)
D, [2014-04-09T08:49:12.190304 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 747)
D, [2014-04-09T08:49:12.191195 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 748)
D, [2014-04-09T08:49:12.191792 #71649] DEBUG -- : ExperimentItemSearch Load (0.1ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 749)
D, [2014-04-09T08:49:12.192310 #71649] DEBUG -- : ExperimentItemSearch Load (0.1ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 750)
D, [2014-04-09T08:49:12.192863 #71649] DEBUG -- : ExperimentItemSearch Load (0.1ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 751)
D, [2014-04-09T08:49:12.193712 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 752)
D, [2014-04-09T08:49:12.194491 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 757)
D, [2014-04-09T08:49:12.195384 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 739)
D, [2014-04-09T08:49:12.196153 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 740)
D, [2014-04-09T08:49:12.197008 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 742)
D, [2014-04-09T08:49:12.197811 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 743)
D, [2014-04-09T08:49:12.198541 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 756)
D, [2014-04-09T08:49:12.199528 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 760)
D, [2014-04-09T08:49:12.200834 #71649] DEBUG -- : ExperimentItemSearch Load (0.3ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 761)
D, [2014-04-09T08:49:12.202246 #71649] DEBUG -- : ExperimentItemSearch Columns (0.9ms)  SHOW FIELDS FROM `experiment_item_searches`
D, [2014-04-09T08:49:12.204827 #71649] DEBUG -- : ExperimentItem Columns (1.3ms)  SHOW FIELDS FROM `experiment_items`
D, [2014-04-09T08:49:12.205612 #71649] DEBUG -- : ExperimentItem Load (0.2ms)  SELECT * FROM `experiment_items` WHERE (`experiment_items`.`id` = 3)
D, [2014-04-09T08:49:12.207389 #71649] DEBUG -- : Experiment Columns (1.1ms)  SHOW FIELDS FROM `experiments`
D, [2014-04-09T08:49:12.208161 #71649] DEBUG -- : Experiment Load (0.2ms)  SELECT * FROM `experiments` WHERE (`experiments`.`id` = 2)
D, [2014-04-09T08:49:12.209862 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 767)
D, [2014-04-09T08:49:12.210558 #71649] DEBUG -- : SQL (0.1ms)  SELECT count(*) AS count_all FROM `attachments` WHERE (`attachments`.project_id = 3)
D, [2014-04-09T08:49:12.211615 #71649] DEBUG -- : User Load (0.2ms)  SELECT * FROM `users` WHERE (`users`.`id` = 1055964833)
D, [2014-04-09T08:49:12.212553 #71649] DEBUG -- : SQL (0.2ms)  SELECT count(*) AS count_all FROM `project_sharings` WHERE (`project_sharings`.project_id = 3)
D, [2014-04-09T08:49:12.213432 #71649] DEBUG -- : User Load (0.2ms)  SELECT `users`.* FROM `users` INNER JOIN `project_sharings` ON `users`.id = `project_sharings`.user_id WHERE ((`project_sharings`.project_id = 3))
D, [2014-04-09T08:49:12.215242 #71649] DEBUG -- : SQL (0.3ms)  SELECT count(*) AS count_all FROM `runs` INNER JOIN `projects_runs` ON `runs`.id = `projects_runs`.run_id WHERE ((file_present) AND (`projects_runs`.project_id = 2 ))
D, [2014-04-09T08:49:12.216248 #71649] DEBUG -- : Run Load (0.3ms)  SELECT * FROM `runs` INNER JOIN `projects_runs` ON `runs`.id = `projects_runs`.run_id WHERE (`projects_runs`.project_id = 2 ) AND (file_present)
D, [2014-04-09T08:49:12.217010 #71649] DEBUG -- : CACHE (0.0ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881336) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.217554 #71649] DEBUG -- : CACHE (0.0ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881337) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.219193 #71649] DEBUG -- : Search Load (1.0ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881338) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.220481 #71649] DEBUG -- : CACHE (0.0ms)  SELECT * FROM `runs` INNER JOIN `projects_runs` ON `runs`.id = `projects_runs`.run_id WHERE (`projects_runs`.project_id = 2 ) AND (file_present)
D, [2014-04-09T08:49:12.221046 #71649] DEBUG -- : CACHE (0.0ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881336) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.221567 #71649] DEBUG -- : CACHE (0.0ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881337) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.222069 #71649] DEBUG -- : CACHE (0.0ms)  SELECT `searches`.* FROM `searches` INNER JOIN `search_instances` ON `searches`.id = `search_instances`.search_id WHERE ((`search_instances`.run_id = 417881338) AND (finished_at AND (error_flag IS NULL OR error_flag = 0) AND progress != 'cancelled' and file_present))
D, [2014-04-09T08:49:12.222731 #71649] DEBUG -- : CACHE (0.0ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 771)
D, [2014-04-09T08:49:12.223212 #71649] DEBUG -- : CACHE (0.0ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 772)
D, [2014-04-09T08:49:12.224095 #71649] DEBUG -- : ExperimentItemSearch Load (0.3ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 773)
D, [2014-04-09T08:49:12.224795 #71649] DEBUG -- : ExperimentItem Load (0.2ms)  SELECT * FROM `experiment_items` WHERE (`experiment_items`.`id` = 1)
D, [2014-04-09T08:49:12.225546 #71649] DEBUG -- : Experiment Load (0.2ms)  SELECT * FROM `experiments` WHERE (`experiments`.`id` = 1)
D, [2014-04-09T08:49:12.226396 #71649] DEBUG -- : ExperimentItemSearch Load (0.2ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 778)
D, [2014-04-09T08:49:12.226765 #71649] DEBUG -- : CACHE (0.0ms)  SELECT * FROM `experiment_items` WHERE (`experiment_items`.`id` = 1)
D, [2014-04-09T08:49:12.227049 #71649] DEBUG -- : CACHE (0.0ms)  SELECT * FROM `experiments` WHERE (`experiments`.`id` = 1)
D, [2014-04-09T08:49:12.298992 #71649] DEBUG -- : ExperimentItemSearch Load (0.1ms)  SELECT * FROM `experiment_item_searches` WHERE (`experiment_item_searches`.search_id = 780)
D, [2014-04-09T08:49:12.299685 #71649] DEBUG -- : CACHE (0.0ms)  SELECT * FROM `experiment_items` WHERE (`experiment_items`.`id` = 1)
D, [2014-04-09T08:49:12.300170 #71649] DEBUG -- : CACHE (0.0ms)  SELECT * FROM `experiments` WHERE (`experiments`.`id` = 1)
D, [2014-04-09T08:49:12.301340 #71649] DEBUG -- : SQL (0.3ms)  SELECT count(*) AS count_all FROM `attachments` WHERE (`attachments`.project_id = 2)
D, [2014-04-09T08:49:12.302329 #71649] DEBUG -- : CACHE (0.0ms)  SELECT * FROM `users` WHERE (`users`.`id` = 1055964830)
D, [2014-04-09T08:49:12.303465 #71649] DEBUG -- : SQL (0.3ms)  SELECT count(*) AS count_all FROM `project_sharings` WHERE (`project_sharings`.project_id = 2)
D, [2014-04-09T08:49:12.304817 #71649] DEBUG -- : User Load (0.3ms)  SELECT `users`.* FROM `users` INNER JOIN `project_sharings` ON `users`.id = `project_sharings`.user_id WHERE ((`project_sharings`.project_id = 2))
D, [2014-04-09T08:49:12.352086 #71649] DEBUG -- : Rendered users/_user_bar (1.1ms)
I, [2014-04-09T08:49:12.353619 #71649]  INFO -- : Completed in 251ms (View: 192, DB: 51) | 200 OK [http://localhost/projects]
I, [2014-04-09T08:50:31.914692 #71649]  INFO -- :
LOG

compressors = [Lens::Compression::Gzip, Lens::Compression::Bson]

results = compressors.map do |compressor|
  compressed = compressor.compress(data)
  [compressor.to_s, data.size, compressed.size, "#{data.to_s[0..60]}..."]
end


puts TTY::Table.new header: ["Compressor", "Original", "Compressed", "Data"], rows: results


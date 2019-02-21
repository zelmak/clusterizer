truncate table debug_log;
truncate table auto_mode_summary;

exec auto_slope(0.1);
exec auto_extract('RF', 0.1, 0.5, 50);

select * from auto_mode_summary;

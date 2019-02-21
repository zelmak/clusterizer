REM INSERTING into DEBUG_LOG
SET DEFINE OFF;
Insert into DEBUG_LOG (EPOCH,MSG) values (to_timestamp('20-FEB-19 10.32.19.344060000 PM','DD-MON-RR HH.MI.SSXFF AM'),'thresh: 135');
Insert into DEBUG_LOG (EPOCH,MSG) values (to_timestamp('20-FEB-19 10.32.19.365744000 PM','DD-MON-RR HH.MI.SSXFF AM'),'auto-extract - post loop in_mode:   1');
Insert into DEBUG_LOG (EPOCH,MSG) values (to_timestamp('20-FEB-19 10.32.19.365905000 PM','DD-MON-RR HH.MI.SSXFF AM'),'auto-extract - post loop temp_stop: 200.9849');
Insert into DEBUG_LOG (EPOCH,MSG) values (to_timestamp('20-FEB-19 10.32.19.365988000 PM','DD-MON-RR HH.MI.SSXFF AM'),'auto-extract - post loop m_stop:    ');
Insert into DEBUG_LOG (EPOCH,MSG) values (to_timestamp('20-FEB-19 10.32.19.366944000 PM','DD-MON-RR HH.MI.SSXFF AM'),'post-x m_stop: 201');
commit;

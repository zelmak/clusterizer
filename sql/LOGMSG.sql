--------------------------------------------------------
--  DDL for Procedure LOGMSG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "LOGMSG" 
(
  MSG IN VARCHAR2 
) AS 
BEGIN
  INSERT INTO DEBUG_LOG (EPOCH, MSG) VALUES ( SYSTIMESTAMP, MSG);
END LOGMSG;

/

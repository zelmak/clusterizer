--------------------------------------------------------
--  DDL for Table DEBUG_LOG
--------------------------------------------------------

  CREATE TABLE "DEBUG_LOG" 
   (	"EPOCH" TIMESTAMP (6) DEFAULT SYSTIMESTAMP, 
	"MSG" VARCHAR2(256) DEFAULT 'EMPTY MSG'
   ) ;

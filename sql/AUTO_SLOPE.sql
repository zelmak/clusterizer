--------------------------------------------------------
--  DDL for Procedure AUTO_SLOPE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "AUTO_SLOPE" ( delta_x in number ) as
  start_value number;
  N integer := 0;
  X number;
  slope number;
  x_min number;
  x_max number;
  present_value number;
  cursor c_parm_value is select parm_value from brad.parm_input order by parm_value;
begin
  delete from parm_slope;
  select min(parm_value) into x_min from parm_input;
  x := x_min;
  start_value := x_min;
  open c_parm_value;
  loop
    fetch c_parm_value into present_value;
    if c_parm_value%NOTFOUND then
      if N > 0 then 
        slope := N/delta_x;
        insert into parm_slope(parm_value, slope) values (start_value, slope);
      end if;
      exit;
    end if;

    if present_value < start_value + delta_x then 
      N := N + 1;
    else 
      slope := N / delta_x;
      insert into parm_slope(parm_value, slope) values ( start_value, slope);
      start_value := start_value + delta_x;
      N := 1;
      while start_value < present_value - delta_x
      loop
        insert into parm_slope (parm_value, slope) values ( start_value, 0);
        start_value := start_value + delta_x;
      end loop;
    end if;
  end loop;

  close c_parm_value;

end auto_slope;

/

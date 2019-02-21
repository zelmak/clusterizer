--------------------------------------------------------
--  DDL for Procedure AUTO_EXTRACT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "AUTO_EXTRACT" (parm in VARCHAR2,
                                         delta_x in NUMBER,
                                         thresh_modifier in NUMBER,
                                         horizon in INTEGER,
                                         min_clstr_ints in INTEGER default 5)

AS
  
    x_max number;
    x_min number;
    y_max number;
    y_min number;
    mode_id integer := 0;
    i_max integer;
    in_mode integer := 0;
    k integer;
    m_start integer;
    m_stop integer;
    test_stat number;
    thresh number;
    elnot varchar2(5) := 'NODET';
    h_count integer;
    temp_stop number;
    parm_curr_val number;
    prev_parm_val number := 0;
    max_slope number;
    med_slope number;
    num_vals number;

    cursor slopes is select slope, parm_value from parm_slope order by parm_value;

begin
    select count(1) into i_max from parm_slope;
    -- TODO: join these?
    select max(parm_value) into x_max from parm_slope;
    select min(parm_value) into x_min from parm_slope;
    -- TODO: join to previous?
    select max(slope) into max_slope from parm_slope;
    select median(slope) into med_slope from parm_slope;
    
    if x_max - x_min <= 0 then
        logmsg('input data error: no parametric variation, x_max <= x_min ' || elnot || '; ' || parm);
        return;
    
    else
    
        thresh := thresh_modifier * max_slope;
        logmsg('thresh: ' || thresh);
        
        if max_slope < min_clstr_ints / delta_x then
            logmsg('no clusters found');
            return;
        end if;
        
        if max_slope = 0 then
            logmsg('max slope is 0');
            return;
        end if;
        
        if thresh < min_clstr_ints / delta_x then
            thresh := min_clstr_ints / delta_x;
            logmsg('using alternate minimum threshold: ' || thresh );
        end if;
    
    end if;
    
    k := 1;
    m_start := null;
    m_stop := null;
    
    open slopes;
    loop
        fetch slopes into test_stat, parm_curr_val;
            exit when slopes%NOTFOUND;

        h_count := h_count + 1;

        if test_stat >= thresh then
            h_count := 0;
            temp_stop := null;
        end if;

        if (( test_stat >= thresh ) AND ( in_mode = 0 )) then
            m_start := parm_curr_val;
            in_mode := 1;
        end if;

        if (( in_mode = 1 ) and ( test_stat < thresh )) then
            if h_count > horizon then
                m_stop := temp_stop;
                temp_stop := null;
                in_mode := 0;
            elsif temp_stop is null then
                temp_stop := prev_parm_val;
            end if;
        end if;

        if (( m_start is not null ) AND ( m_stop is not null )) then
            insert into auto_mode_summary(elnot, parm, mode_id, min, max)
                values(elnot, parm, k, m_start, m_stop + delta_x);
            k := k + 1;
            m_start := null;
            m_stop := null;
            in_mode := 0;
            mode_id := mode_id + 1;
        end if;

        prev_parm_val := parm_curr_val;
    end loop;
    
    logmsg('auto-extract - post loop in_mode:   ' || in_mode);
    logmsg('auto-extract - post loop temp_stop: ' || temp_stop);
    logmsg('auto-extract - post loop m_stop:    ' || m_stop);

    if in_mode = 1 then
        if temp_stop is null then
            m_stop := x_max;
        else 
            m_stop := temp_stop;
        end if;
        insert into auto_mode_summary (elnot, parm, mode_id, min, max) 
            values (elnot, parm, k, m_start, m_stop + delta_x);
    end if;

    logmsg('post-x m_stop: ' || m_stop);

    close slopes;

end auto_extract;

/

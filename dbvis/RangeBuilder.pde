class RangeBuilder {

  static final int DEFAULT_min_clstr_ints = 5; 

  final Map<Float, Integer> slopes;
  float threshold;

  public RangeBuilder(Map<Float, Integer> slopes) {
    this.slopes = slopes;
  }

  public List<Range> generateRanges(float step_size, float thresh_modifier, float horizon) {
    return generateRanges(step_size, thresh_modifier, horizon, DEFAULT_min_clstr_ints);
  }

  public List<Range> generateRanges(float step_size, float thresh_modifier, float horizon, int min_clstr_ints) {
    List<Range> ranges = new ArrayList();
    float x_min = minFloat(slopes.keySet());
    float x_max = maxFloat(slopes.keySet());
    float max_slope = maxInt(slopes.values());

    if ( x_max - x_min <= 0 ) {
      println("input data error: no parametric variation, x_max - x_min = 0");
      return ranges;
    }

     threshold= thresh_modifier * max_slope;
    println("thresh: " + threshold);

    if (max_slope < min_clstr_ints / step_size ) {
      println("no clusters found");
      return ranges;
    }

    if (max_slope == 0) {
      println("max_slope is 0");
      return ranges;
    }

    if (threshold < min_clstr_ints / step_size) {
      threshold = min_clstr_ints / step_size;
      println("using alternate minimum threshold: " + threshold);
    }

    Float m_start = null;
    Float m_stop = null;
    Float temp_stop = null;

    float prev_parm_value = 0;
    float curr_parm_value;
    float curr_slope;

    boolean gathering = false;
    int h_count = 0;

    for (Map.Entry<Float, Integer> e : slopes.entrySet()) {
      curr_parm_value = e.getKey();
      curr_slope = e.getValue();
      //println(curr_slope + ", " + curr_parm_value);

      h_count++;

      if (curr_slope >= threshold) {
        h_count = 0;
        temp_stop = null;
      }

      if (( curr_slope >= threshold ) && ( !gathering)) {
        m_start = curr_parm_value;
        gathering = true;
      }

      if (( gathering ) && ( curr_slope < threshold )) {
        if (h_count > horizon) {
          m_stop = temp_stop;
          temp_stop = null;
          gathering = false;
        } else if (temp_stop == null) {
          temp_stop = prev_parm_value;
        }
      }

      if (( m_start != null ) && ( m_stop != null )) {
        println("new range ( " + m_start + ", " + m_stop + " )");
        ranges.add(new Range(m_start, m_stop + step_size));
        m_start = null;
        m_stop = null;
        gathering = false;
      }

      prev_parm_value = curr_parm_value;
    }

    // if we fall off the end in the middle of processing
    if (gathering) {
      m_stop = nvl(temp_stop, x_max);
      ranges.add(new Range(m_start, m_stop + step_size));
    }

    return ranges;
  }  

  public float getCalculatedThreshold() {
    return this.threshold;
  }
}

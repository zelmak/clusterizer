class SlopeBuilder {

  final List<Float> input;

  SlopeBuilder(List<Float> input) {
    this.input = input;
  }

  Map<Float, Integer> generateSlopes(float step_size) {
    Map<Float, Integer> slopes = new TreeMap();

    float x_min = minFloat(input);

    float start_value = x_min;
    int N = 0;
    for (Float curr_parm_value : input) {
      if (curr_parm_value < start_value + step_size) {
        N = N + 1;
      } else {
        int slope = (int) (N / step_size);
        slopes.put(start_value, slope);
        start_value = start_value + step_size;
        N = 1;
        while (start_value < curr_parm_value - step_size ) {
          slopes.put(start_value, 0);
          start_value = start_value + step_size;
        }
      }
    }
    
    if (N > 0) {
      int slope = (int) (N / step_size);
      slopes.put(start_value, slope);
    }
    return slopes;
  }


}

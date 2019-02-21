
float minFloat(Collection<Float> data) {
  float min = Float.MAX_VALUE;
  for (Float f : data) {
    if (f.compareTo(min) < 0) {
      min = f;
    }
  }
  return min;
}

int minInt(Collection<Integer> data) {
  int min = Integer.MAX_VALUE;
  for (Integer f : data) {
    if (f.compareTo(min) < 0) {
      min = f;
    }
  }
  return min;
}

float maxFloat(Collection<Float> data) {
  float max = Float.MIN_VALUE;
  for (Float f : data) {
    if (f > max) {
      max = f;
    }
  }
  return max;
}

int maxInt(Collection<Integer> data) {
  int max = Integer.MIN_VALUE;
  for (Integer f : data) {
    if (f > max) {
      max = f;
    }
  }
  return max;
}

float nvl(Float value, Float altValue) {
  if (value == null) { 
    return altValue;
  } else {
    return value;
  }
}

float mapX(float x) {
  return map(x, minX, maxX, inset, width-inset);
}

float mapY(float y) {
  return map(y, minY, maxY, height-inset, inset);
}

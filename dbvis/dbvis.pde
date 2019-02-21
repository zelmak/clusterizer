import java.sql.*;
import java.util.*;

void settings() {
  size(2 * displayWidth /3, 2 * displayHeight /3);
}

void loadDriver() {
}

final List<Point> slopeData = new ArrayList();
final List<Point> inputData = new ArrayList();
final List<Range> ranges = new ArrayList();
final InputData input = new InputData();
float threshold;

static float roundTo(float values, int decimals) {
  return round(values * pow(10, decimals)) / pow(10, decimals);
}



int inset = 10;
float maxX = 0;
float maxY = 0;
float minX = Float.MAX_VALUE;
float minY = Float.MAX_VALUE;

void setup() {

  InputData input = new InputData();
  setInputPoints(input.data);

  SlopeBuilder slopeBuilder = new SlopeBuilder(input.data);
  Map<Float, Integer> slopes = slopeBuilder.generateSlopes(0.1);

  setSlopePoints(slopes);

  RangeBuilder rangeBuilder = new RangeBuilder(slopes);
  ranges.addAll(rangeBuilder.generateRanges(0.1, 0.5, 10));

  threshold = rangeBuilder.threshold;
  
  scaleScreenBasedOnData();
}

void setSlopePoints(Map<Float, Integer> slopes) {
  for (Map.Entry<Float, Integer> entry : slopes.entrySet()) {
    slopeData.add(new Point(entry.getKey(), entry.getValue()));
  }
}

void setInputPoints(List<Float> data) {
  Map<Float, Integer> freqMap = new TreeMap();
  for (Float f : data) {
    f = roundTo(f, 1);
    freqMap.putIfAbsent(f, 0);
    freqMap.put(f, freqMap.get(f)+1);
  }

  for (Map.Entry<Float, Integer> e : freqMap.entrySet()) {
    inputData.add(new Point(e.getKey(), e.getValue()));
  }
}

void draw() {

  background(255);
  noFill();

  // draw input data
  stroke(255, 0, 0);
  beginShape();
  for (Point p : inputData) {
    float x = mapX(p.x);
    float y = mapY(p.y);
    vertex(x, y);
  }
  endShape();

  // draw slope data
  stroke(0);
  beginShape();
  for (Point p : slopeData) {
    float x = mapX(p.x);
    float y = mapY(p.y);
    vertex(x, y);
  }
  endShape();

  // draw ranges
  for (Range r : ranges) {
    float x1 = mapX(r.min);
    float x2 = mapX(r.max);
    float y1 = mapY(minY);
    float y2 = mapY(maxY);
    stroke(0, 255, 0);
    line(x1, y1, x1, y2);
    stroke(0, 0, 255);
    line(x2, y1, x2, y2);
    //println("range: ( " + r.min + ", " + r.max + ")");
  }

  // draw threshold line
  float x1 = mapX(minX);
  float x2 = mapX(maxX);
  float y = mapY(threshold);
  stroke(255, 0, 255);
  line(x1, y, x2, y);

  noLoop();
}

void scaleScreenBasedOnData() {
  for (Point p : slopeData) {
    minX = min(minX, p.x);
    minY = min(minY, p.y);
    maxX = max(maxX, p.x);
    maxY = max(maxY, p.y);
  }
  for (Point p : inputData) {
    minX = min(minX, p.x);
    minY = min(minY, p.y);
    maxX = max(maxX, p.x);
    maxY = max(maxY, p.y);
  }
}

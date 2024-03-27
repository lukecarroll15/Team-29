// IMPORTS:
import java.util.HashMap;
import java.util.Collections;
import java.util.Map;
import processing.core.*;

// FINAL FIELDS:
final color MINCOL = color(255, 10, 10);
final color MAXCOL = color(10, 10, 255);
final int margin = 50; // Margin around the heatmap for texts to be entered.

ArrayList<PVector> data;
HashMap<String, Integer> table;



void settings() {
  size(800, 600);
}

void setup() {
  noLoop();
  textAlign(CENTER, CENTER);
  rectMode(RADIUS);
  noStroke();

 
  data = new ArrayList<PVector>();

  // Sample data generation random for now (Replace with flight data from the CSV file later)
  for (int i = 0; i < 100000; i++) {
    data.add(new PVector(floor(random(5, 55)), floor(random(0, 30))));
  }

  table = new HashMap<String, Integer>();

 
  for (PVector v : data) {
    addOrUpdate(v);
  }

  // Generate heatmap
  generateHeatmap();
}


void draw(){
}



void addOrUpdate(PVector p) {  
  int distance = (int) p.x;
  String originCity = (int) p.y + ""; // Convert float to string
  String key = distance + "_" + originCity;
  table.put(key, table.containsKey(key) ?  table.get(key) + 1 : 1);
}


void generateHeatmap() {
  float[] range = getRange(data);
  float minInt = Collections.min(table.values());
  float maxInt = Collections.max(table.values());

  background(0);
  for (Map.Entry<String, Integer> entry : table.entrySet()) {
    String[] values = entry.getKey().split("_");
    int distance = Integer.parseInt(values[0]);
    String originCity = values[1];
    int count = entry.getValue();

    float px = map(distance, range[0], range[1], margin, width - margin);
    float py = map(Integer.parseInt(originCity), range[2], range[3], height - margin, margin);
    color c = lerpColor(MINCOL, MAXCOL, map(count, minInt, maxInt, 0, 1));
    fill(c);
    rect(px, py, 5, 5); 
  }

  // Label axes
  fill(255);
  textSize(16);
  textAlign(CENTER);
  text("Flight Distance", width / 2, height - 10); // X-axis label (needs work)
  textAlign(CENTER);
  text("Origin City", margin / 2, height / 2); // Y-axis label (needs work)
}


float[] getRange(ArrayList<PVector> in) {
  float minx = PApplet.MAX_INT;
  float maxx = PApplet.MIN_INT;
  float miny = PApplet.MAX_INT;
  float maxy = PApplet.MIN_INT;
  
  for (PVector pp : in) {
    if (pp.x < minx) minx = pp.x;
    if (pp.y < miny) miny = pp.y;
    if (pp.x > maxx) maxx = pp.x;
    if (pp.y > maxy) maxy = pp.y;
  }

  return new float[]{minx, maxx, miny, maxy};
}

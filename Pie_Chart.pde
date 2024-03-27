//pieChart methods writen by Xinyi on 27/03/2024 at 20:22
import java.util.Arrays;
PieChart pieChart = new PieChart();
class PieChart{
 int[] flightsCituation;
 String[] labels;
 float[] angles;
 int diameter = 300;
 float total;
 int totalFlights;
 ArrayList<String> desCitys = new ArrayList<String>();
 int[] desFlights;
 int totalFlights2;
 
 void getFigures(Table flightsTable, int chartValue){
   totalFlights2 = 0; 
   totalFlights = getNumberOfFlightsByDepAirport("JFK");
   // println(topOrigins[b-1]);
   // println("T"+totalFlights);
    int divertedFlights = getNumberOfDivertedFlightsByAirport("JFK");
   // println("D"+divertedFlights);
    int delayedCounts = getNumberOfCancelledFlightsByAirport("JFK");
   // println("C"+delayedCounts);
    int operationalFlights = totalFlights - delayedCounts - divertedFlights;
    labels = new String[3];
    flightsCituation = new int[3];
    labels[0] = "Cancelled";
    labels[1] = "Diverted";
    labels[2] = "Operational";
    flightsCituation[0] = delayedCounts;
    flightsCituation[1] = divertedFlights;
    flightsCituation[2] = operationalFlights;
    
   for (TableRow row : flightsTable.rows()){
     if(desCitys.size()<6){
     String desCity = row.getString("Dest City"); 
     if(!desCitys.contains(desCity)){
      desCitys.add(desCity); 
     }
     }
    }
    desFlights = new int[desCitys.size()];
    
    for(int i = 0; i < desCitys.size(); i++){
     String desCity = desCitys.get(i);
     int desFlight = getNumberOfFlightsByDesCity(desCity);
     desFlights[i] = desFlight;
     totalFlights2 += desFlight;
    }
    
    
 }
  
 void calculateAngles(int chartValue){
  if(chartValue == 0){
    angles = new float[3];
    for (int i = 0; i < 3; i++) {
     angles[i] = radians(map(flightsCituation[i], 0, totalFlights, 0, 360));
    }
  }
  
  else if(chartValue == 1){
    angles = new float[desFlights.length];
    for(int i = 0; i < desFlights.length; i++) {
     angles[i] =  radians(map(desFlights[i], 0, totalFlights2, 0, 360)); 
    }
  }
 }
 
 
 void drawPieChart(int chartValue, int showingAreaX, int showingAreaY, int showingAreaWidth, int showingAreaHeight){
     color[] colors = {
  color(183, 234, 180), color(234, 222, 180), color(180,186,234), 
  color(103, 234, 180), color(247, 214, 47), color(130,186,234),
  color(53, 234, 180), color(255, 170, 41), color(80,186,234),
  color(183, 154, 180), color(234, 172, 180), color(180,136,234),
  color(183, 104, 180), color(234, 122, 180), color(180,86,234),
  color(183, 234, 130), color(234, 222, 130), color(70,136,184),
  color(100, 234, 80), color(200), color(180,186,0)
  };
  
  float lastAngle = 0;
  if(chartValue == 0){
    for (int i = 0; i < 3; i++) {
      fill(colors[i]);
      arc(showingAreaX+250, showingAreaY+275, diameter, diameter, lastAngle, lastAngle + angles[i]);
      lastAngle += angles[i];
    }
  }
  
  else if(chartValue == 1){
   for(int i = 0; i < desFlights.length; i++){
      fill(colors[i]);
      arc(showingAreaX+250, showingAreaY+275, diameter, diameter, lastAngle, lastAngle + angles[i]);
      lastAngle += angles[i];     
   }
  }
  float xLegend1 = showingAreaX + showingAreaWidth - 220;
  float yLegend1 = showingAreaY + 100;
  float labelPosition = xLegend1+30;
    textAlign(LEFT, CENTER);
  if(chartValue == 0){  
    for (int i = 0; i < 3; i++) {
      fill(colors[i]); 
      rect(xLegend1, yLegend1 + i * 30, 20, 20);
      fill(0); textSize(20);
      text(labels[i], labelPosition, yLegend1 + 12 + i * 30);
    }
    

    textSize(25);
    fill(0);
    
    text("Details in " + "JFK", showingAreaX + 150, showingAreaY + 60);
  }
  else if(chartValue == 1){
   for (int i = 0; i < desFlights.length; i++) {
      fill(colors[i]); 
      rect(xLegend1, yLegend1 + i * 30, 20, 20);
      fill(0); textSize(20);
      text(desCitys.get(i), labelPosition, yLegend1 + 12 + i * 30);
   }
    /*float xLegend2 = showingAreaX;
    for (int i = (int)0.5*desFlights.length + 1; i < desFlights.length; i++) {
      fill(255,255 - 10*(i-0.5*desFlights.length), 255); 
      rect(xLegend2, yLegend1 + i * 30, 20, 20);
      fill(0); textSize(20);
      text(desCitys.get(i), xLegend2 + 30, yLegend1 + 12 + i * 30);
   }*/
    
    textSize(25);
    fill(0);
    
    text("Part of Dest City From " + "HI", showingAreaX + 150, showingAreaY + 60);
  }
  
 }
} 

int getNumberOfDivertedFlightsByAirport(String airport) {  
  int count = 0;
  for (int i = 0; i < originalTable.getRowCount(); i++) {
    TableRow r = originalTable.getRow(i);
    if (r.getString("ORIGIN").equalsIgnoreCase(airport) 
      && r.getDouble("DIVERTED")==1) count++;
  }
  return count;
}

int getNumberOfFlightsByDesCity(String desCity){
  int count = 0;
  for(int i = 0; i < filteredTable.getRowCount(); i++){
   TableRow r = filteredTable.getRow(i);
   if(r.getString("Dest City").equalsIgnoreCase(desCity)) count++;
  }
  return count;
}

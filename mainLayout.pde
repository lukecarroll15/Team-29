//mainLayout created by Hubert on 20 March 7.40pm (with some of the blocks of code taken from the other files to the setup method), edited on 27 March 11.00pm
import controlP5.*;
import g4p_controls.*;
PImage errorImage;
boolean showError = false;
boolean submitPressed = false;
PFont barChartFont;


int tableVariable=0, chartVariable=0, showingAreaX=100, showingAreaY=250,
  showingAreaWidth=700, showingAreaHeight=500;
String[] customHeaders;
ArrayList<PVector> data;
HashMap<String, Integer> table;
boolean originSelectedOnly = false;
boolean destinationSelectedOnly = false;

void settings(){
  size(1000, 800);
}

ControlP5 control;
Controller controller;
Button switchGraph;
Button arrowUp;
Button arrowDown;
DropdownList dateSelector;
Slider flightDistanceSlider;
Textfield flightNumberField;
String[] airportsArray;
String[] originCityArray; // Array for Origin City
String[] destCityArray; // Array for Destination City
String [] destAirportsArray;
DropdownList destAirportDropdown;
DropdownList airportDropdown;
DropdownList originCityDropdown; // Dropdown for Origin City
DropdownList destCityDropdown; // Dropdown for Destination City

ArrayList<String> airportsList;
ArrayList<String> originCityList;
ArrayList<String> destCityList;
ArrayList<String> destAirportsList; 

String[] top5DestinationCities;
float[] top5DestinationFrequency;

String[] top5OriginCities;
float[] top5ArrivalsFrequency;

String[] top5DestinationsCancelled;
float[] top5CancelledFrequency;

String[] top5DestinationsDiverted;
float[] top5DivertedFrequency;

String[] top5LongestFlightsCity;
float[] top5LongestFlightsDistance;


void setup(){
  barChartFont = loadFont("Arial-Black.vlw");
  
  top5DestinationCities = new String[5];
  top5DestinationFrequency = new float[5];

  top5OriginCities = new String[5];
  top5ArrivalsFrequency = new float[5];

  top5DestinationsCancelled = new String[5];
  top5CancelledFrequency = new float[5];

  top5DestinationsDiverted = new String[5];
  top5DivertedFrequency = new float[5];

  top5LongestFlightsCity = new String[5];
  top5LongestFlightsDistance = new float[5];
  
  originalTable = loadTable("flights_full.csv", "header");
  customHeaders = new String[]{"Date", "Flight Number",/* "Origin Airport",*/ 
    "Origin City", /*"Dest Airport",*/ "Dest City", "Expected Dep", "Actual Dep", 
    "Expected Arr", "Actual Arr", "Cancelled", "Diverted", "Distance"};
  
  filteredTable = new Table();
  for (String header : customHeaders) {
    filteredTable.addColumn(header);
  }
 
  filterData(3000,22,"","","","","");
 

  
  control = new ControlP5(this);
  
  // Initialize ArrayLists to store unique airport names, origin cities, and destination cities
  airportsList = new ArrayList<String>();
  originCityList = new ArrayList<String>();
  destCityList = new ArrayList<String>();
  destAirportsList = new ArrayList<String>();   

  // Iterate through the table to extract unique airport names, origin cities, and destination cities
  for (TableRow row : originalTable.rows()) {
    String originAirport = row.getString("ORIGIN");
    String destAirport = row.getString("DEST");
    String originCity = row.getString("ORIGIN_CITY_NAME");
    String destCity = row.getString("DEST_CITY_NAME");

    if (!airportsList.contains(originAirport)) {
      airportsList.add(originAirport);
    }
    if (!originCityList.contains(originCity)) {
      originCityList.add(originCity);
    }
    if (!destCityList.contains(destCity)) {
      destCityList.add(destCity);
    }
    if (!destAirportsList.contains(destAirport)) {
      destAirportsList.add(destAirport);
    }
  }

 // Convert ArrayLists to String arrays and sort alphabetically
  airportsList.add(0, "'N/A'");
  airportsArray = airportsList.toArray(new String[0]);
  Arrays.sort(airportsArray);
  airportsList.remove(0);

  originCityList.add(0, "'N/A'");
  originCityArray = originCityList.toArray(new String[0]);
  Arrays.sort(originCityArray);
  originCityList.remove(0);

  destCityList.add(0, "'N/A'");
  destCityArray = destCityList.toArray(new String[0]);
  Arrays.sort(destCityArray);
  destCityList.remove(0);
  
  destAirportsList.add(0, "'N/A'");
  destAirportsArray = destAirportsList.toArray(new String[0]);
  Arrays.sort(destAirportsArray);
  destAirportsList.remove(0);
  
  
  // Add dropdown lists for Origin Airport, Dest Aiport, Origin City, and Destination City
  airportDropdown = control.addDropdownList("Origin Airport")
                          .setPosition(50, 175);
  customiseDropdownList(airportDropdown, airportsArray);

  originCityDropdown = control.addDropdownList("Origin City")
                          .setPosition(150, 175);
  customiseDropdownList(originCityDropdown, originCityArray);
  
  
  destAirportDropdown = control.addDropdownList("Destination Airport")
                          .setPosition(350, 175);
  customiseDropdownList(destAirportDropdown, destAirportsArray);

  destCityDropdown = control.addDropdownList("Destination City")
                          .setPosition(450, 175);
  customiseDropdownList(destCityDropdown, destCityArray);

  
  switchGraph = control.addButton("switchGraph").setValue(1)
    .setPosition(580, 175).setSize(100,40);
  arrowUp = control.addButton("arrowUp").setValue(2)
    .setPosition(700,175).setSize(70,40);
  arrowDown = control.addButton("arrowDown").setValue(3)
    .setPosition(800,175).setSize(70,40);

 dateSelector = control.addDropdownList("Select Date") // Created by Luke C on 25/03 at 4:00pm
        .setPosition(50,85)
        ;
        customise(dateSelector);
      
flightNumberField = control.addTextfield("Flight Number")  // Created by Luke C on 25/03 at 4:00pm
     .setValue(0)
     .setPosition(200, 85)
     .setSize(100,25)
     ;
     
flightDistanceSlider = control.addSlider("Flight Distance")  // Created by Luke C on 25/03 at 4:00pm
     .setPosition(350, 85)
     .setSize(200,25)
     .setRange(0,4000)
     .setValue(0)
     ;

control.addButton("Submit")  // Created by Luke C on 25/03 at 4:00pm
    .setPosition(800, 85)
      .setSize(80, 40)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
              scrollbarPosY = showingAreaY;
              scrollbarWidth = 20;
              scrollbarHeight = showingAreaHeight;
              
              sliderPosY = scrollbarPosY;
              sliderHeight = 50;   
              
errorImage = loadImage("Error.jpg");
}

void switchGraph(){
  tableVariable++;
  if(tableVariable==4)tableVariable=0;
}

void arrowUp(){
  chartVariable++;
  if(chartVariable==4)chartVariable=0;
}

void arrowDown(){
  chartVariable--;
  if(chartVariable==-1)chartVariable=3;
}
void customiseDropdownList(DropdownList dropdown, String[] itemsArray) {
  dropdown.setItemHeight(20);
  dropdown.setBarHeight(25);
  int index = 0; // Initialize index for values
  for (String item : itemsArray) {
    dropdown.addItem(item, index);
    index++; 
  }
}


void customise(DropdownList date) // Created by Luke C on 25/03 at 4:00pm
{
  date.setItemHeight(20);
  date.setBarHeight(25);
  for (int i = 1; i <= 31; i++) {
    if (i == 1) {
      date.addItem("N/A", i);
    }
    date.addItem("" + i, i);
  }
}

void Submit() {  // Created by Luke C on 25/03 at 4:00pm, modified by Hubert on 31 March 7.45pm

  double selectedDistance = control.get(Slider.class,"Flight Distance").getValue();
  String enteredFlightNumber  = control.get(Textfield.class,"Flight Number").getText();
  int selectedDate = (int)control.get(DropdownList.class,"Select Date").getValue();
  submitPressed = true;
  
  String selectedOriginAirport = "";
  if((int)control.get(DropdownList.class, "Origin Airport").getValue()!=0){ 
    if (!destinationSelectedOnly) {
      originSelectedOnly = true;
    }
    selectedOriginAirport = airportsArray[(int)control.get(DropdownList.class, "Origin Airport").getValue()];
    pieChart.originAirport = selectedOriginAirport;
    top5LongestFlightsFrom(selectedOriginAirport);
    top5DestinationsDivertedFrom(selectedOriginAirport);
    top5DestinationCancelledFrom(selectedOriginAirport);
    top5DestinationsFrom(selectedOriginAirport);
  }
    
  String selectedOriginCity = ""; 
  if((int)control.get(DropdownList.class, "Origin City").getValue()!=0) 
    selectedOriginCity = originCityArray[(int)control.get(DropdownList.class, "Origin City").getValue()];
    
  String selectedDestAirport = "";
  if((int)control.get(DropdownList.class, "Destination Airport").getValue()!=0){
    if (!originSelectedOnly) {
      destinationSelectedOnly = true;
    }
    selectedDestAirport = destAirportsArray[(int)control.get(DropdownList.class, "Destination Airport").getValue()];
    pieChart.destinationAirport = selectedDestAirport;
    top5ArrivalsTo(selectedDestAirport);
  }
  
  String selectedDestCity = "";
  if((int)control.get(DropdownList.class, "Destination City").getValue()!=0)
    selectedDestCity = destCityArray[(int)control.get(DropdownList.class, "Destination City").getValue()];

  if(tableVariable==0){
    filteredTable = new Table();
    for (String header : customHeaders) {
      filteredTable.addColumn(header);
    }
    filterData(selectedDistance, selectedDate, enteredFlightNumber, selectedOriginAirport, 
      selectedOriginCity, selectedDestAirport, selectedDestCity);
      drawHeaders(filteredTable, customHeaders);
      drawTableData(filteredTable, startRow, visibleRows, customHeaders);
      scrollbarPosX = showingAreaX + getTotallength(filteredTable, customHeaders);
    drawScrollbar();
  }
  
  boolean dataFound = checkForData(filteredTable);
  
  if(!dataFound){
   showError = true; 
  }else{
   showError = false; 
  }
}

void top5DestinationsFrom(String originAirport){ //method written by Hubert on 31 March at 8.30pm
  int[] frequencies = new int[destCityList.size()];
  for (TableRow row : originalTable.rows()) {
    if(originAirport.equals(row.getString("ORIGIN")))
    {
      for(int i=0; i<destCityList.size(); i++){
          if(destCityList.get(i).equals(row.getString("DEST_CITY_NAME"))){
            frequencies[i]++;
            break;
          }
      }
    }
  }
  String[] destCityArray = destCityList.toArray(new String[0]);
  String[][] top5Destinations = first5SelectionSort(destCityArray, frequencies);
  top5DestinationCities = new String[5];
  top5DestinationCities = top5Destinations[0];
  top5DestinationFrequency = new float[5];
  for(int i=0; i<5; i++){
    top5DestinationFrequency[i] = Integer.parseInt(top5Destinations[1][i]);
  }
}

void top5ArrivalsTo(String destAirport){ //method written by Hubert on 31 March at 8.40pm
  int[] frequencies = new int[originCityList.size()];
  for (TableRow row : originalTable.rows()) {
    if(destAirport.equals(row.getString("DEST")))
    {
      for(int i=0; i<originCityList.size(); i++){
          if(originCityList.get(i).equals(row.getString("ORIGIN_CITY_NAME"))){
            frequencies[i]++;
            break;
          }
      }
    }
  }
  String[] originCityArray = originCityList.toArray(new String[0]);
  String[][] top5Arrivals = first5SelectionSort(originCityArray, frequencies);
  top5OriginCities = new String[5];
  top5OriginCities = top5Arrivals[0];
  top5ArrivalsFrequency = new float[5];
  for(int i=0; i<5; i++){
    top5ArrivalsFrequency[i] = Integer.parseInt(top5Arrivals[1][i]);
  }
}

void top5DestinationCancelledFrom(String originAirport){ //method written by Hubert on 31 March 8.45pm
  int[] frequencies = new int[destCityList.size()];
  for (TableRow row : originalTable.rows()) {
    if(originAirport.equals(row.getString("ORIGIN")) && row.getDouble("CANCELLED")==1)
    {
      for(int i=0; i<destCityList.size(); i++){
          if(destCityList.get(i).equals(row.getString("DEST_CITY_NAME"))){
            frequencies[i]++;
            break;
          }
      }
    }
  }
  String[] destCityArray = destCityList.toArray(new String[0]);
  String[][] top5Cancelled = first5SelectionSort(destCityArray, frequencies);
  top5DestinationsCancelled = new String[5];
  top5DestinationsCancelled = top5Cancelled[0];
  top5CancelledFrequency = new float[5];
  for(int i=0; i<5; i++){
    top5CancelledFrequency[i] = Integer.parseInt(top5Cancelled[1][i]);
  }
}

void top5DestinationsDivertedFrom(String originAirport){ //method written by Hubert on 31 March at 8.50pm
  int[] frequencies = new int[destCityList.size()];
  for (TableRow row : originalTable.rows()) {
    if(originAirport.equals(row.getString("ORIGIN")) && row.getDouble("DIVERTED")==1)
    {
      for(int i=0; i<destCityList.size(); i++){
          if(destCityList.get(i).equals(row.getString("DEST_CITY_NAME"))){
            frequencies[i]++;
            break;
          }
      }
    }
  }
  String[] destCityArray = destCityList.toArray(new String[0]);
  String[][] top5Diverted = first5SelectionSort(destCityArray, frequencies);
  top5DestinationsDiverted = new String[5];
  top5DestinationsDiverted = top5Diverted[0];
  top5DivertedFrequency = new float[5];
  for(int i=0; i<5; i++){
    top5DivertedFrequency[i] = Integer.parseInt(top5Diverted[1][i]);
  }
}

void top5LongestFlightsFrom(String originAirport){ //method written by Hubert on 31 March at 9.15pm
  ArrayList<String> theLongestFlightsCity = new ArrayList<>();
  ArrayList<Integer> theLongestFlightsDistance = new ArrayList<>();
  for (TableRow row : originalTable.rows()) {
    if(originAirport.equals(row.getString("ORIGIN")))
    {
      if(!theLongestFlightsCity.contains(row.getString("DEST_CITY_NAME"))){
        theLongestFlightsDistance.add((int)row.getDouble("DISTANCE"));
        theLongestFlightsCity.add(row.getString("DEST_CITY_NAME"));
      }
    }
  }
  
  String[] theLongestFlights = theLongestFlightsCity.toArray(new String[0]);
  int[] theLongestDistance = theLongestFlightsDistance.stream().mapToInt(i -> i).toArray();
  String[][] top5Distances = first5SelectionSort(theLongestFlights, theLongestDistance);
  top5LongestFlightsCity = new String[5];
  top5LongestFlightsCity = top5Distances[0];
  top5LongestFlightsDistance = new float[5];
  for(int i=0; i<theLongestFlightsDistance.size() && i<5; i++){
    top5LongestFlightsDistance[i] = Integer.parseInt(top5Distances[1][i]);
  }
}

String[][] first5SelectionSort(String[] destinations, int[] frequencies){ //sorting algorithm written by Hubert on 31 March at 8.20pm
  String[][] result = new String[2][5];
  for(int i=0; i<5 && i<frequencies.length; i++){
    int index=i;
    for(int j=i; j<frequencies.length; j++){
      if(frequencies[j]>frequencies[index])index=j;
    }
    result[1][i] = String.valueOf(frequencies[index]);
    frequencies[index] = frequencies[i];
    result[0][i] = destinations[index];
    destinations[index] = destinations[i];
  }
  return result;
}

void draw(){
   
  background(0);
  
  switch(tableVariable){ // Control graphical display of data through arrow up / down feature
    case 0:
      if(!showError){
      drawHeaders(filteredTable, customHeaders);
      drawTableData(filteredTable, startRow, visibleRows, customHeaders);
      scrollbarPosX = showingAreaX + getTotallength(filteredTable, customHeaders);
      drawScrollbar();
      }
      else if (showError){
       image(errorImage, showingAreaX + showingAreaWidth/2 - errorImage.width/2, 
             showingAreaY + showingAreaHeight/2 - errorImage.height/2); 
      }
      break;
    case 1:
      collectData();
      if (submitPressed) {
      barChart.draw(showingAreaX, showingAreaY, showingAreaWidth, 
        showingAreaHeight);
      }
      break;
    case 2:
     pieChart.getFigures(filteredTable,chartVariable);
     //pieChart.calculateAngles(chartVariable);
     pieChart.drawPieChart(chartVariable, showingAreaX,
                             showingAreaY, showingAreaWidth, showingAreaHeight);  
    
  }

}
boolean checkForData(Table table) {

  return table.getRowCount() > 0; 
}

import org.gicentre.utils.stat.*;
//ArrayList<Flight> flights = new ArrayList<>();
BarChart barChart;

/*void setup(){ // readFromFile algorithm written by Hubert on 13 March 5.15pm, upgraded on 18 March, 2.40pm
  String[] lines = loadStrings("flights_full.csv");
  for(int i=1; i<lines.length; i++){
     String[] partsLines = lines[i].split("\"");
     String[] flightDetails1 = partsLines[0].split(",");
     String[] flightDetails2 = partsLines[2].split(",");
     String[] flightDetails3 = partsLines[4].split(",");
     if(flightDetails3[4].equals("")) flightDetails3[4] = "-1";
     if(flightDetails3[6].equals("")) flightDetails3[6] = "-1";
     Flight flight = new Flight(flightDetails1[0], flightDetails1[1], 
       Integer.parseInt(flightDetails1[2]), flightDetails1[3], partsLines[1], 
       flightDetails2[1], Integer.parseInt(flightDetails2[2]), flightDetails2[3], 
       partsLines[3], flightDetails3[1], Integer.parseInt(flightDetails3[2]), 
       Integer.parseInt(flightDetails3[3]), Integer.parseInt(flightDetails3[4]), 
       Integer.parseInt(flightDetails3[5]), Integer.parseInt(flightDetails3[6]), 
       (int)(flightDetails3[7].charAt(0)), (int)(flightDetails3[8].charAt(0)), 
       (int)Double.parseDouble(flightDetails3[9]));
     flights.add(flight);
  }

  int event=0;  // This variable controls which bar chart to display
  


  //for (int i = 0; i < flights.size(); i++) { // displayInfo method call written by Xinyi on 13 March 7.31pm
  //  Flight flight = flights.get(i);
  //  flight.displayInfo();
  //}
  print("done"); //print added to check how fast is loading from the file with all the flights
}*/

void collectData(){ // Function labelled by Hubert, written by Luke on 20/03/2024. Updated by Luke on 03/04 at 16:00 to show barcharts dependent on user queries.
  String[] categories;
  float[] data = new float[5];
  if (submitPressed) {
    
    if (originSelectedOnly) {
    switch (chartVariable) {
      case 0:
      categories = top5DestinationCities;
      data = top5DestinationFrequency;
      createBarChart("Frequency", "Destination Airport", categories, data, true);
      break;
      
      case 1:
      categories = top5DestinationsCancelled;
      data = top5CancelledFrequency;
      createBarChart("Frequency", "Destinations Cancelled", categories, data, true);
      break;
      
      case 2:
      categories = top5DestinationsDiverted;
      data = top5DivertedFrequency;
      createBarChart("Frequency", "Destinations Diverted", categories, data, true);
      break;
      
      case 3:
      categories = top5LongestFlightsCity;
      data = top5LongestFlightsDistance;
      createBarChart("Length (miles)", "Destination", categories, data, true);
      break;
    }
    }
    
    else if (destinationSelectedOnly) {
      switch (chartVariable) {
      case 0:
      categories = top5OriginCities;
      data = top5ArrivalsFrequency;
      createBarChart("Frequency", "Origin", categories, data, true);
      break;
      }
     
  }
  
  else { // Case where user hits submit without selecting destination || origin airport
    categories = new String[] {"JFK", "LAX", "DCA", "FLL", "SEA" };
    
    switch (chartVariable) {
      case 0:
      for (int i = 0; i < categories.length; i++) {
      data[i] = getNumberOfCancelledFlightsByAirport(categories[i]);
    }
    createBarChart("Number of Cancelled Flights", "Airport", categories, data, true);
    break;
    
    case 1:
    for (int i = 0; i < categories.length; i++) {
      data[i] = getNumberOfFlightsByDepAirport(categories[i]);
    }
    createBarChart("Number of Flights by Airport", "Airport", categories, data, true);
    break;
    
    case 2:
    categories = new String[] {"AA", "HA", "NK", "AS", "WN"};
    for (int i = 0; i < categories.length; i++) {
      data[i] = getNumberofFlightsByAirline(categories[i]);
    }
    createBarChart("Number of Flights by Airline", "Airline", categories, data, true);
    break;
    }
  }
}
}

double getFlightDistance(String depAirport, String arrAirport) {  // Method written by Luke on 17/03/2024 at 4:00pm to assist with graphical display of data, edited by Hubert (7.40pm 20 March) so it would by compatible with the new way of saving data 
  int distance = 0;
  for (int i = 0; i < originalTable.getRowCount(); i++) {
      TableRow r = originalTable.getRow(i);
    
    if (r.getString("ORIGIN").equalsIgnoreCase(depAirport) 
      && r.getString("DEST").equalsIgnoreCase(arrAirport)) {
      distance = r.getInt("DISTANCE");
    }
  }
  return distance;
}

int getNumberOfCancelledFlightsByAirport(String airport) {  // Method written by Luke on 16/03/2024 at 2:00pm, edited on 18/03/2024, edited by Hubert (7.40pm 20 March) so it would by compatible with the new way of saving data
  int count = 0;
  for (int i = 0; i < originalTable.getRowCount(); i++) {
    TableRow r = originalTable.getRow(i);
    if (r.getString("ORIGIN").equalsIgnoreCase(airport) 
      && r.getDouble("CANCELLED")==1) count++;
  }
  return count;
}

int getNumberOfFlightsByDepAirport(String airport) { // Method written by Luke on 17/03/2024 at 4:00pm to assist with graphical display of data, edited by Hubert (7.40pm 20 March) so it would by compatible with the new way of saving data
  int count = 0;
  for (int i = 0; i < originalTable.getRowCount(); i++) {
    TableRow r = originalTable.getRow(i);
    if (r.getString("ORIGIN").equalsIgnoreCase(airport)) count++;
  }
  return count;
}

int getNumberofFlightsByAirline(String MKTCarrier) { //method edited by Hubert (7.40pm 20 March) so it would by compatible with the new way of saving data
  int count = 0;
  for (int i = 0; i < originalTable.getRowCount(); i++) {
    TableRow r = originalTable.getRow(i);
    if (r.getString("MKT_CARRIER").equalsIgnoreCase(MKTCarrier)) count++;
  }
  return count;
}

void createBarChart(String valueAxisLabel, String categoryAxisLabel, String[] category,
float[] data, boolean transposeAxes) {  // Method written by Luke. C on 20/03/2024 at 2:00pm
  String[] categories = category;
  barChart = new BarChart(this);
  textFont(createFont("Arial Bold",10),10);
  barChart.setData(data);
  barChart.setMinValue(0);
  barChart.setMaxValue(max(data) + 1);
  barChart.showValueAxis(true);
  barChart.setBarLabels(categories);
  barChart.showCategoryAxis(true);
  barChart.setBarColour(color(235, 52, 52));
  barChart.setBarGap(9);
  barChart.transposeAxes(transposeAxes);
  barChart.setValueAxisLabel(valueAxisLabel);
  barChart.setCategoryAxisLabel(categoryAxisLabel);
}

boolean isDataEmpty(float[] data) { // method written by Luke on 03/04 to prevent empty barcharts
  int count = 0;
  for (int i = 0; i < data.length; i++) {
    if (data[i] == 0) count++;
  }
  
  if (count >= 3) return true;
  else return false;
}

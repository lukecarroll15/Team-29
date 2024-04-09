import org.gicentre.utils.stat.*;

BarChart barChart;

void collectData(){ // Function labelled by Hubert, written by Luke on 20/03/2024
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
  
  else {
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
  textFont(barChartFont, 15.0);
  fill(255, 255, 255);
  barChart.updateLayout();
  barChart.setData(data);
  barChart.setMinValue(0);
  barChart.setMaxValue(max(data) + 1);
  barChart.showValueAxis(true);
  barChart.setBarLabels(categories);
  barChart.showCategoryAxis(true);
  barChart.setBarColour(color(239, 214, 4));
  barChart.setBarGap(9);
  barChart.transposeAxes(transposeAxes);
  barChart.setAxisValuesColour(255);
  barChart.setAxisLabelColour(255);
  barChart.setValueAxisLabel(valueAxisLabel);
  barChart.setCategoryAxisLabel(categoryAxisLabel);
}

boolean isDataEmpty(float[] data) {
  int count = 0;
  for (int i = 0; i < data.length; i++) {
    if (data[i] == 0) count++;
  }
  
  if (count >= 3) return true;
  else return false;
}

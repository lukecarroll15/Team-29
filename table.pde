Table originalTable;
Table filteredTable;
int cellWidth = showingAreaWidth/9;
int cellHeight = showingAreaHeight/15;

float[] maxWidths;
int startRow = 0;
int visibleRows = 14; 

void filterData(double distance, int date, String flightNumber, String originAirport, 
  String originCity, String destAirport, String destCity) {
  //print(distance+" "+date+" "+flightNumber);
  for (TableRow row : originalTable.rows()) {
    //print(row.getString("FL_DATE"));
    if(distance<=row.getDouble("DISTANCE") 
      && (date==0 || ("1/"+date+"/2022 12:00:00 AM").equals(row.getString("FL_DATE")))                   
      && (flightNumber.equals("") || flightNumber.equals(row.getString("MKT_CARRIER") + row.getString("MKT_CARRIER_FL_NUM"))) 
      && (originAirport.equals("") || originAirport.equals(row.getString("ORIGIN"))) 
      && (originCity.equals("") || originCity.equals(row.getString("ORIGIN_CITY_NAME"))) 
      && (destAirport.equals("") || destAirport.equals(row.getString("DEST")))
      && (destCity.equals("") || destCity.equals(row.getString("DEST_CITY_NAME")))){ //if statement and combination with string written by Hubert on March 27 11.00pm, edited on March 31 7.00pm
      
      //println("distance: " + distance + ", date: " + date + ", flight number: " + flightNumber);
      TableRow newRow = filteredTable.addRow();                                                        
      String dateTable = row.getString("FL_DATE");
      dateTable = dateTable.replace(" 12:00:00AM", "");
      String[] dateParts = dateTable.split(" ");
      String insertDate = dateParts[0]; 
      //+ "\n" + dateParts[1] + dateParts[2];
      newRow.setString("Date", insertDate);
      
      newRow.setString("Flight Number", row.getString("MKT_CARRIER") + 
      row.getString("MKT_CARRIER_FL_NUM"));
      //newRow.setString("Origin Airport", originAirport);
      String origTable = row.getString("ORIGIN_CITY_NAME");
      String[] origParts = origTable.split(", ");
      String insertOrig = origParts[0] + ",\n" + origParts[1];
      newRow.setString("Origin City", insertOrig);
      
      //newRow.setString("Dest Airport", row.getString("DEST"));
      String destTable = row.getString("DEST_CITY_NAME");
      String[] destParts = destTable.split(", ");
      String insertDest = destParts[0] + ",\n" + destParts[1];
      newRow.setString("Dest City", insertDest);
      
  //newRow.setString("Expected Dep", row.getString("CRS_DEP_TIME"));
      String expectedDep = row.getString("CRS_DEP_TIME");
      if (expectedDep.length() == 4) {
          expectedDep = expectedDep.substring(0, 2) + ":" + expectedDep.substring(2);
      }
      newRow.setString("Expected Dep", expectedDep);      
      //newRow.setString("Actual Dep", row.getString("DEP_TIME"));
  String actualDep = row.getString("DEP_TIME");
      if (actualDep.length() == 4) {
          actualDep = actualDep.substring(0, 2) + ":" + actualDep.substring(2);
      }
      newRow.setString("Actual Dep", actualDep);      
      //newRow.setString("Expected Arr", row.getString("CRS_ARR_TIME"));
      String expectedArr = row.getString("CRS_ARR_TIME");
      if (expectedArr.length() == 4) {
          expectedArr = expectedArr.substring(0, 2) + ":" + expectedArr.substring(2);
      }
      newRow.setString("Expected Arr", expectedArr);
            
      //newRow.setString("Actual Arr", row.getString("ARR_TIME"));
      String actualArr = row.getString("ARR_TIME");
      if (actualArr.length() == 4) {
          actualArr = actualArr.substring(0, 2) + ":" + actualArr.substring(2);
      }
      newRow.setString("Actual Arr", actualArr); 
     
      int cancelled=row.getInt("CANCELLED");                    //change canclled and diverted to string for end user 21/03/2024 Conor Faulkner
      String cancelledStr = (cancelled == 1) ? "YES" : "NO";
      
      int diverted=row.getInt("DIVERTED");
      String divertedStr = (diverted == 1) ? "YES" : "NO";
      
      newRow.setString("Cancelled", cancelledStr);
      newRow.setString("Diverted", divertedStr);
      newRow.setInt("Distance", (int)row.getDouble("DISTANCE"));
      
    }
  }
  println(filteredTable.getRowCount() + " rows in filtered table");
}

void drawHeaders(Table data, String[] headers) {
    maxWidths = calculateColumnWidths(data);
  int totalLength = 0;
  for (int i = 0; i < maxWidths.length; i++){
    if(maxWidths[i] >= textWidth(headers[i])) totalLength += maxWidths[i]+10;
    else totalLength += textWidth(headers[i])+10;
    println("tColumn " + i + ": maxWidth = " + maxWidths[i] + ", headerWidth = " + textWidth(headers[i]) + ", totalLength = " + totalLength);
  }
  
  float x = showingAreaX;
  textAlign(CENTER, CENTER);
  fill(200);
 
  fill(135, 206, 250); 
  rect(showingAreaX, showingAreaY, totalLength, cellHeight); 

  fill(0);
  for (int i = 0; i < headers.length; i++) {
    float textWidth = textWidth(headers[i]);
    if(maxWidths[i] >= textWidth) cellWidth = (int)maxWidths[i]+10;
    else cellWidth = (int)textWidth+10;
    text(headers[i], x + cellWidth/2, 
      showingAreaY+cellHeight/2);
    line(x, showingAreaY, x, showingAreaY+showingAreaHeight);
    x+=cellWidth;
  }

 
  line(showingAreaX+totalLength, showingAreaY, 
    showingAreaX+totalLength, showingAreaY+showingAreaHeight);
}

void drawTableData(Table data, int startRow, int visibleRows, String[] headers) {
  maxWidths = calculateColumnWidths(data);
  int totalLength = 0;
  for (int i = 0; i < maxWidths.length; i++){
    if(maxWidths[i] >= textWidth(headers[i])) totalLength += maxWidths[i]+10;
    else totalLength += textWidth(headers[i])+10;
  }
  float x = showingAreaX;
  textAlign(CENTER, CENTER);
  textSize(10);
  fill(255); 
 // int rowIndex = 0;
  for (int i = 0; i < visibleRows; i++/*TableRow row : data.rows()*/) {
    x = showingAreaX;
    int rowIndex = startRow + i;
    if(rowIndex >= 0 && rowIndex < data.getRowCount()){
      for (int col = 0; col < data.getColumnCount(); col++) {
        TableRow row = data.getRow(rowIndex);
        String dataStr = row.getString(col);
        float textWidth = textWidth(headers[col]);
    if(maxWidths[col] >= textWidth) cellWidth = (int)maxWidths[col]+10;
    else cellWidth = (int)textWidth+10;
        text(dataStr, x + cellWidth/2, 
        showingAreaY+(i + 1) * cellHeight + cellHeight/2);
        line(x, showingAreaY+(i + 1) * cellHeight, 
          x += cellWidth, 
          showingAreaY+(i + 1) * cellHeight);
      }
      line(showingAreaX, showingAreaY+(i + 1) * cellHeight, 
                showingAreaX + totalLength, 
        showingAreaY+(i + 1) * cellHeight);
    //rowIndex++;
    }
  }
  line(showingAreaX, showingAreaY+15*cellHeight,
                showingAreaX + totalLength, 
        showingAreaY+15*cellHeight);
}


void keyPressed() {  //keyPressed method to scroll table method writen by Xinyi on 26/03/2024 at 22:50
  if (keyCode == UP) {
    startRow = max(0, startRow - 1); 

  } else if (keyCode == DOWN) {
    startRow = min(filteredTable.getRowCount() - visibleRows, startRow + 1);
  }
  
  sliderPosY = int(map(startRow, 0, filteredTable.getRowCount() - visibleRows, 
                    scrollbarPosY, scrollbarPosY + scrollbarHeight - sliderHeight));
}

float[] calculateColumnWidths(Table data){ //method to calculate max text longth to custom cell width written by Xinyi on 31/03/2024 AT 13:52
  
  textSize(10);
 
  float[] maxWidths = new float[data.getColumnCount()];
  
  for (int i = 0; i < maxWidths.length; i++) {
   maxWidths[i] = 0; 
  }
  
  for(TableRow row : data.rows()) {
    for(int col = 0; col < data.getColumnCount(); col++) {
     String dataStr = row.getString(col);
     float textWidth = textWidth(dataStr);
     if(textWidth > maxWidths[col]) {
      maxWidths[col] = textWidth; 
     }
    }
  }
  
 //   for (int i = 0; i < maxWidths.length; i++) {
 //   println("Column " + i + " max width: " + maxWidths[i]);
 // }
  
  return maxWidths;
}

int getTotallength(Table data, String[] headers){
    maxWidths = calculateColumnWidths(data);
  int totalLength = 0;
  for (int i = 0; i < maxWidths.length; i++){
    if(maxWidths[i] >= textWidth(headers[i])) totalLength += maxWidths[i]+10;
    else totalLength += textWidth(headers[i])+10;
  }
  return totalLength;
}

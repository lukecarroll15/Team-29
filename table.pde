Table originalTable;
Table filteredTable;
int cellWidth = showingAreaWidth/9;
int cellHeight = showingAreaHeight/15;

void filterData() {
  for (TableRow row : originalTable.rows()) {
    String originAirport = row.getString("ORIGIN");
    if (originAirport.equalsIgnoreCase("HNL")) {
      TableRow newRow = filteredTable.addRow();
      newRow.setString("Date", row.getString("FL_DATE"));
      //newRow.setString("Flight Number", row.getString("MKT_CARRIER") + 
      //  row.getString("MKT_CARRIER_FL_NUM"));
      //newRow.setString("Origin Airport", originAirport);
      newRow.setString("Origin City", row.getString("ORIGIN_CITY_NAME"));
      //newRow.setString("Dest Airport", row.getString("DEST"));
      newRow.setString("Dest City", row.getString("DEST_CITY_NAME"));
      newRow.setString("Expected Dep", row.getString("CRS_DEP_TIME"));
      newRow.setString("Actual Dep", row.getString("DEP_TIME"));
      newRow.setString("Expected Arr", row.getString("CRS_ARR_TIME"));
      newRow.setString("Actual Arr", row.getString("ARR_TIME"));
      newRow.setInt("Cancelled", row.getInt("CANCELLED"));
      newRow.setInt("Diverted", row.getInt("DIVERTED"));
      newRow.setInt("Distance", row.getInt("DISTANCE"));
    }
  }
  //println(filteredTable.getRowCount() + " rows in filtered table");
}

void drawHeaders(String[] headers) {
  textAlign(CENTER, CENTER);
  fill(200);
 
  fill(135, 206, 250); 
  rect(showingAreaX, showingAreaY, cellWidth*headers.length, cellHeight); 

  fill(0);
  for (int i = 0; i < headers.length; i++) {
    text(headers[i], showingAreaX+i * cellWidth + cellWidth/2, 
      showingAreaY+cellHeight/2);
    line(showingAreaX+i * cellWidth, showingAreaY, showingAreaX+i * cellWidth, 
      showingAreaY+showingAreaHeight);
  }

 
  line(showingAreaX+cellWidth*headers.length, showingAreaY, 
    showingAreaX+cellWidth*headers.length, showingAreaY+showingAreaHeight);
}

void drawTableData(Table data) {
  textAlign(CENTER, CENTER);
  textSize(10);
  fill(255); 
  int rowIndex = 0;
  for (TableRow row : data.rows()) {
    for (int col = 0; col < data.getColumnCount(); col++) {
      String dataStr = row.getString(col);
      text(dataStr, showingAreaX+col * cellWidth + cellWidth/2, 
        showingAreaY+(rowIndex + 1) * cellHeight + cellHeight/2);
      line(showingAreaX+col * cellWidth, showingAreaY+(rowIndex + 1) * cellHeight, 
        showingAreaX+(col + 1) * cellWidth, 
        showingAreaY+(rowIndex + 1) * cellHeight);
    }
    line(showingAreaX, showingAreaY+(rowIndex + 1) * cellHeight, 
      showingAreaX+cellWidth*customHeaders.length, 
      showingAreaY+(rowIndex + 1) * cellHeight);
    rowIndex++;
  }
}

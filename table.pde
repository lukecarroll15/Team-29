Table originalTable;
Table filteredTable;
int cellWidth = 100;
int cellHeight = 40;

void setup() {
  size(1300, 600);
  originalTable = loadTable("flights2k.csv", "header");
  String[] customHeaders = {"Date", "Flight Number", "Origin Airport", "Origin City", "Dest Airport", "Dest City", "Expected Dep", "Actual Dep", "Expected Arr", "Actual Arr", "Cancelled", "Diverted", "Distance"};
  println(originalTable.getRowCount() + " total rows in original table");


  filteredTable = new Table();
  for (String header : customHeaders) {
    filteredTable.addColumn(header);
  }

 
  filterData();

  drawHeaders(customHeaders);
  drawTableData(filteredTable);
}

void filterData() {
  for (TableRow row : originalTable.rows()) {
    String originAirport = row.getString("ORIGIN");
    if (originAirport.equalsIgnoreCase("HNL")) {
      TableRow newRow = filteredTable.addRow();
      newRow.setString("Date", row.getString("FL_DATE"));
      newRow.setString("Flight Number", row.getString("MKT_CARRIER") + row.getString("MKT_CARRIER_FL_NUM"));
      newRow.setString("Origin Airport", originAirport);
      newRow.setString("Origin City", row.getString("ORIGIN_CITY_NAME"));
      newRow.setString("Dest Airport", row.getString("DEST"));
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
  println(filteredTable.getRowCount() + " rows in filtered table");
}

void drawHeaders(String[] headers) {
  textAlign(CENTER, CENTER);
  fill(200);
 
  fill(135, 206, 250); 
  rect(0, 0, width, cellHeight); 


  fill(0);
  for (int i = 0; i < headers.length; i++) {
    text(headers[i], i * cellWidth + cellWidth/2, cellHeight/2);
    line(i * cellWidth, 0, i * cellWidth, height);
  }

 
  line(0, cellHeight, width, cellHeight);
}

void drawTableData(Table data) {
  textAlign(CENTER, CENTER);
  fill(255); 
  int rowIndex = 0;
  for (TableRow row : data.rows()) {
    for (int col = 0; col < data.getColumnCount(); col++) {
      String dataStr = row.getString(col);
      text(dataStr, col * cellWidth + cellWidth/2, (rowIndex + 1) * cellHeight + cellHeight/2);
      line(col * cellWidth, (rowIndex + 1) * cellHeight, (col + 1) * cellWidth, (rowIndex + 1) * cellHeight);
    }
    line(0, (rowIndex + 1) * cellHeight, width, (rowIndex + 1) * cellHeight);
    rowIndex++;
  }
}

void draw() {
  // Add any animation or dynamic updates here if needed
}

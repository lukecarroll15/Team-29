Table originalTable;
Table filteredTable;
int cellWidth = showingAreaWidth/9;
int cellHeight = showingAreaHeight/15;


int startRow = 0;
int visibleRows = 14; 



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
     
      int cancelled=row.getInt("CANCELLED");                    //change canclled and diverted to string for end user 21/03/2024 Conor Faulkner
      String cancelledStr = (cancelled == 1) ? "YES" : "NO";
      
      int diverted=row.getInt("DIVERTED");
      String divertedStr = (diverted == 1) ? "YES" : "NO";
      
      newRow.setString("Cancelled", cancelledStr);
      newRow.setString("Diverted", divertedStr);
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

void drawTableData(Table data, int startRow, int visibleRows) {
  textAlign(CENTER, CENTER);
  textSize(10);
  fill(255); 
 // int rowIndex = 0;
  for (int i = 0; i < visibleRows; i++/*TableRow row : data.rows()*/) {
    int rowIndex = startRow + i;
    if(rowIndex >= 0 && rowIndex < data.getRowCount()){
      for (int col = 0; col < data.getColumnCount(); col++) {
        TableRow row = data.getRow(rowIndex);
        String dataStr = row.getString(col);
        text(dataStr, showingAreaX+col * cellWidth + cellWidth/2, 
          showingAreaY+(i + 1) * cellHeight + cellHeight/2);
        line(showingAreaX+col * cellWidth, showingAreaY+(i + 1) * cellHeight, 
          showingAreaX+(col + 1) * cellWidth, 
          showingAreaY+(i + 1) * cellHeight);
      }
      line(showingAreaX, showingAreaY+(i + 1) * cellHeight, 
        showingAreaX+cellWidth*customHeaders.length, 
        showingAreaY+(i + 1) * cellHeight);
    //rowIndex++;
    }
  }
  line(showingAreaX, showingAreaY+15*cellHeight,
        showingAreaX+cellWidth*customHeaders.length,
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

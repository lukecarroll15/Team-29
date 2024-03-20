//mainLayout created by Hubert on 20 March 7.40pm (with some of the blocks of code taken from the other files to the setup method)
import controlP5.*;

int tableVariable=0, chartVariable=0, showingAreaX=150, showingAreaY=250,
  showingAreaWidth=700, showingAreaHeight=550;
String[] customHeaders;

void settings(){
  size(1000, 800);
}

ControlP5 control;
Controller controller;
Button switchGraph;
Button arrowUp;
Button arrowDown;

void setup(){
  originalTable = loadTable("flights_full.csv", "header");
  customHeaders = new String[]{"Date", /*"Flight Number", "Origin Airport",*/ 
    "Origin City", /*"Dest Airport",*/ "Dest City", "Expected Dep", "Actual Dep", 
    "Expected Arr", "Actual Arr", "Cancelled", "Diverted", "Distance"};
  
  filteredTable = new Table();
  for (String header : customHeaders) {
    filteredTable.addColumn(header);
  }

 
  filterData();
  
  control = new ControlP5(this);
  
  switchGraph = control.addButton("switchGraph").setValue(1)
    .setPosition(580, 200).setSize(100,40);
  arrowUp = control.addButton("arrowUp").setValue(2)
    .setPosition(700,200).setSize(70,40);
  arrowDown = control.addButton("arrowDown").setValue(3)
    .setPosition(800,200).setSize(70,40);
}

/*public void controlEvent(ControlEvent theEvent){ different way to make buttons work
  println(theEvent.getController().getName());
  
  //String name = theEvent.getController().getName();
}*/

void switchGraph(){
  tableVariable++;
  if(tableVariable==2)tableVariable=0;
}

void arrowUp(){
  chartVariable++;
  if(chartVariable==3)chartVariable=0;
}

void arrowDown(){
  chartVariable--;
  if(chartVariable==-1)chartVariable=2;
}

void draw(){
  background(200);
  switch(tableVariable){
    case 0:
      drawHeaders(customHeaders);
      drawTableData(filteredTable);
      break;
    case 1:
      collectData();
      barChart.draw(showingAreaX, showingAreaY, showingAreaWidth, 
        showingAreaHeight);
  }
}

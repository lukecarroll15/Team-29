ArrayList<Flight> flights = new ArrayList<>();

void setup(){ // readFromFile algorithm written by Hubert on 13 March 5.15pm
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

  //for (int i = 0; i < flights.size(); i++) { // displayInfo method call written by Xinyi on 13 March 7.31pm
  //  Flight flight = flights.get(i);
  //  flight.displayInfo();
  //}
  print("done");
}

int getFlightDistance(String depAirport, String arrAirport) {  // Method written by Luke on 17/03/2024 at 4:00pm to assist with graphical display of data
  int distance = 0;
  for (int i = 0; i < flights.size(); i++) {
    Flight flight = flights.get(i);
     
    if (flight.getOrigin().equalsIgnoreCase(depAirport) && flight.getDestination().equalsIgnoreCase(arrAirport)) {
      distance = flight.getDistance();
    }
  }
  return distance;
}

int getNumberOfCancelledFlightsByAirport(String airport) {  // Method written by Luke on 16/03/2024 at 2:00pm, edited on 18/03/2024
  int count = 0;
  for (int i = 0; i < flights.size(); i++) {
    Flight flight = flights.get(i);
    if (flight.getOrigin().equalsIgnoreCase(airport) && flight.isCancelled()) count++;
  }
  return count;
}

int getNumberOfFlightsByDepAirport(String airport) { // Method written by Luke on 17/03/2024 at 4:00pm to assist with graphical display of data
  int count = 0;
  for (int i = 0; i < flights.size(); i++) {
    Flight flight = flights.get(i);
    if (flight.getOrigin().equalsIgnoreCase(airport)) count++;
  }
  return count;
}

class Flight{ // attributes and constructor written By Hubert (13 March 5.15pm)
  String date, MKTCarrier, origin, originCity, originState;
  String destination, destinationCity, destinationState;
  int MKTCarrierFlNumber, originWac, destinationWac;
  int CRSDepTime, depTime, CRSArrTime, arrTime;
  int distance;
  boolean cancelled, diverted;
  
  Flight(String date, String MKTCarrier, int MKTCarrierFlNumber, 
   String origin, String originCity, String originState, int originWac,
   String destination, String destinationCity, String destinationState,
   int destinationWac, int CRSDepTime, int depTime, int CRSArrTime, 
   int arrTime, int cancelled, int diverted, int distance){
    this.date=date;
    this.MKTCarrier=MKTCarrier;
    this.origin=origin;
    this.originCity=originCity;
    this.originState=originState;
    this.destination=destination;
    this.destinationCity=destinationCity;
    this.destinationState=destinationState;
    this.MKTCarrierFlNumber=MKTCarrierFlNumber;
    this.originWac=originWac;
    this.destinationWac=destinationWac;
    this.CRSDepTime=CRSDepTime;
    this.depTime=depTime;
    this.CRSArrTime=CRSArrTime;
    this.arrTime=arrTime;
    this.distance=distance;
    if(cancelled==0)this.cancelled=false;
    else this.cancelled=true;
    if(diverted==0)this.diverted=false;
    else this.diverted=true;
  }
void setDate(String date) {                   // All set functions written by Luke @ 17:50 13/03/2024
    this.date = date;
  }
  
  void setMKTCarrier(String MKTCarrier) {
    this.MKTCarrier = MKTCarrier;
  }
  
  void setMKTCarrierFlNumber(int MKTCarrierFlNumber) {
    this.MKTCarrierFlNumber = MKTCarrierFlNumber;
  }
  
  void setOrigin(String origin) {
    this.origin = origin;
  }
  
  void setOriginCity(String originCity) {
    this.originCity = originCity;
  }
  
  void setOriginState(String originState) {
    this.originState = originState;
  }
  
  void setOriginWac(int originWac) {
    this.originWac = originWac;
  }
  
  void setDestination(String destination) {
    this.destination = destination;
  }
  
   void setDestinationCity(String destinationCity) {
    this.destinationCity = destinationCity;
  }
  
   void setDestinationState(String destinationState) {
    this.destinationState = destinationState;
  }
  
  void setDestinationWac(int destinationWac) {
    this.destinationWac = destinationWac;
  }
  
  void setCRSDepTime(int CRSDepTime)  {
    this.CRSDepTime = CRSDepTime;
  }
  
  void setDepTime(int depTime) {
    this.depTime = depTime;
  }
  
  void setCRSArrTime(int CRSArrTime) {
    this.CRSArrTime = CRSArrTime;
  }
  
  void setArrTime(int arrTime) {
    this.arrTime = arrTime;
  }
  
  void setCancelled(boolean cancelled) {
    this.cancelled = cancelled;
  }
  
  void setDiverted(boolean diverted) {
    this.diverted = diverted;
  }
  
  void setDistance(int distance) {
    this.distance = distance;
  }
}

ArrayList<Flight> flights = new ArrayList<>();

void setup(){ // readFromFile algorithm written by Hubert on 13 March 5.15pm
  String[] lines = loadStrings("flights2k.csv");
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
       Integer.parseInt(flightDetails3[7]), Integer.parseInt(flightDetails3[8]), 
       Integer.parseInt(flightDetails3[9]));
     flights.add(flight);
  }
}

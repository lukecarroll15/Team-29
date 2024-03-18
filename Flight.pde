class Flight{ // attributes and constructor written By Hubert (13 March 5.15pm), class separated by Hubert (18 March, 2.40pm)
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

   String getDate() {     // getters written by Raid @ 18:15 13/03/2024
        return date;
    }

    String getMKTCarrier() {
        return MKTCarrier;
    }

    int getMKTCarrierFlNumber() {
        return MKTCarrierFlNumber;
    }

    String getOrigin() {
        return origin;
    }

    String getOriginCity() {
        return originCity;
    }

    String getOriginState() {
        return originState;
    }

    int getOriginWac() {
        return originWac;
    }

    String getDestination() {
        return destination;
    }

    String getDestinationCity() {
        return destinationCity;
    }

    String getDestinationState() {
        return destinationState;
    }

    int getDestinationWac() {
        return destinationWac;
    }

    int getCRSDepTime() {
        return CRSDepTime;
    }

    int getDepTime() {
        return depTime;
    }

    int getCRSArrTime() {
        return CRSArrTime;
    }

    int getArrTime() {
        return arrTime;
    }

    int getDistance() {
        return distance;
    }

    boolean isCancelled() {
        return cancelled;
    }

    boolean isDiverted() {
        return diverted;
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
  
  void displayInfo() {  // displayInfo method written by Xinyi on 13 March 7.27pm
        println(date + ", " + MKTCarrier + ", " + MKTCarrierFlNumber + ", " + 
        origin + ", " + originCity + ", " + originState + ", " + originWac + ", " + 
        destination + ", " + destinationCity + ", " + destinationState + ", " + 
        destinationWac + ", " + CRSDepTime + ", " + depTime + ", " + CRSArrTime + ", " + 
        arrTime + ", " + cancelled + ", " + diverted + ", " + distance);
  }
}
abstract interface class Shipper {
  void displayInfo();
  int calculateShippingCost(int weightInKg);
  int calculateDeliveryTime(int distanceInKm);
}

class Airplane implements Shipper {
  String name;
  double speedInKmph;
  double maxLoadInKg;
  double costPerKg;
  String airline;

  Airplane(this.name, this.speedInKmph, this.maxLoadInKg, this.costPerKg, [this.airline = "Unknown"]);
  
  @override
  void displayInfo() {
    print("Airplane Name: $name, Speed: $speedInKmph km/h, Max load: $maxLoadInKg kg, Cost per Kg: $costPerKg");
  }
  
  @override
  int calculateShippingCost(int weight) {
    if (weight > maxLoadInKg) {
      throw Exception("Weight exceeds maximum load capacity of the airplane.");
    }
    return (weight * costPerKg).toInt();
  }

  @override
  int calculateDeliveryTime(int distance) {
    return (distance / speedInKmph).ceil();
  }

  String getAirline() => airline;
}

class Train implements Shipper {
  String name;
  double speedInKmph;
  double wagonMaxLoadInKg;
  double maxWagons;
  double costPerKg;

  Train(this.name, this.speedInKmph, this.wagonMaxLoadInKg, this.maxWagons, this.costPerKg);
  
  @override
  void displayInfo() {
    print("Train Name: $name, Speed: $speedInKmph km/h, Wagon max load: $wagonMaxLoadInKg kg, Max wagons: $maxWagons, Cost per Kg: $costPerKg");
  }
  
  @override
  int calculateShippingCost(int weight) {
    if (weight > wagonMaxLoadInKg * maxWagons) {
      throw Exception("Weight exceeds maximum load capacity of the train.");
    }
    return (weight * costPerKg).toInt();
  }

  @override
  int calculateDeliveryTime(int distance) {
    return (distance / speedInKmph).ceil();
  }

  int calculateWagonsNeeded(int weight) {
    return (weight / wagonMaxLoadInKg).ceil();
  }
}

class Truck implements Shipper {
  String name;
  double speedInKmph;
  double maxLoadInKg;
  double costPerKg;
  bool refrigerated;

  Truck(this.name, this.speedInKmph, this.maxLoadInKg, this.costPerKg, [this.refrigerated = false]);
  
  @override
  void displayInfo() {
    print("Truck Name: $name, Speed: $speedInKmph km/h, Max load: $maxLoadInKg kg, Cost per Kg: $costPerKg");
  }
  
  @override
  int calculateShippingCost(int weight) {
    if (weight > maxLoadInKg) {
      throw Exception("Weight exceeds maximum load capacity of the truck.");
    }
    return (weight * costPerKg).toInt();
  }

  @override
  int calculateDeliveryTime(int distance) {
    return (distance / speedInKmph).ceil();
  }

  bool isRefrigerated() => refrigerated;
}

void main() {
  Airplane airplane = Airplane("Boeing 747", 900, 100000, 5, "SkyCargo");
  Train train = Train("Freight Train", 80, 20000, 50, 2);
  Truck truck = Truck("Big Rig", 60, 20000, 3, true);

  List<Shipper> shippers = [airplane, train, truck];

  int weight = 15000;
  int distance = 1200;

  for (var shipper in shippers) {
    shipper.displayInfo();
    try {
      int cost = shipper.calculateShippingCost(weight);
      int time = shipper.calculateDeliveryTime(distance);
      
      print("Shipping Cost: \$${cost}, Delivery Time: ${time} hours");
      
      if (shipper is Train) {
        int wagonsNeeded = shipper.calculateWagonsNeeded(weight);
        print("Wagons Needed: $wagonsNeeded");
      }
      if (shipper is Airplane) {
        print("Airline: ${shipper.getAirline()}");
      }
      if (shipper is Truck) {
        print("Refrigerated: ${shipper.isRefrigerated() ? "Yes" : "No"}");
      }
    } catch (e) {
      print(e);
    }
    print("");
  }
}
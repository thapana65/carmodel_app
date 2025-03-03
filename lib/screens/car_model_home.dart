import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/car_model_provider.dart';
import 'package:car_model_app/screens/car_model_add.dart';
import 'package:car_model_app/screens/car_model_edit.dart';

class CarModelHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarModelProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Car Models',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey[100])),
        centerTitle: true,
        backgroundColor: Colors.lightGreen[600],
      ),
      body: carProvider.cars.isEmpty
          ? Center(
              child: Text(
                "No cars available. Add a new car!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: carProvider.cars.length,
              itemBuilder: (context, index) {
                final car = carProvider.cars[index];
                return Dismissible(
                  key: Key(car.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Confirm Delete"),
                        content: Text(
                            "Are you sure you want to delete ${car.brand} ${car.model}?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              carProvider.removeCar(index);
                              Navigator.of(context).pop(true);
                            },
                            child: Text("Delete",
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CarModelEdit(car: car, index: index),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                car.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.car_repair,
                                        size: 50, color: Colors.grey),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${car.brand} ${car.model}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Text(
                                      "Year: ${car.year}\nPrice: \$${car.price.toStringAsFixed(2)}"),
                                  Text("Color: ${car.color}"),
                                ],
                              ),
                            ),
                            Icon(Icons.edit,
                                color: Colors.orangeAccent),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CarModelAdd()),
        ),
        child: Icon(Icons.add, size: 30, color: Colors.white),
        backgroundColor: Colors.green,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Colors.lightGreen[600],
        child: Container(
          height: 50,
          child: Center(
            child: Text(
              "\nCar Management System",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

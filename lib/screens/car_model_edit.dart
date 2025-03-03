import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_model_app/providers/car_model_provider.dart';
import 'package:car_model_app/models/model.dart';

class CarModelEdit extends StatefulWidget {
  final CarModel car;
  final int index;

  CarModelEdit({required this.car, required this.index});

  @override
  _CarModelEditState createState() => _CarModelEditState();
}

class _CarModelEditState extends State<CarModelEdit> {
  final _formKey = GlobalKey<FormState>();
  late String _brand, _model, _category, _color, _imageUrl;
  late int _year;
  late double _price;

  @override
  void initState() {
    super.initState();
    _brand = widget.car.brand;
    _model = widget.car.model;
    _year = widget.car.year;
    _category = widget.car.category;
    _price = widget.car.price;
    _color = widget.car.color;
    _imageUrl = widget.car.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Car Model',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.lightGreen[600],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Edit Car Details",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 22, 22, 22)),
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildTextField("Brand Name", Icons.directions_car,
                          _brand, (value) => _brand = value),
                      _buildTextField("Model Name", Icons.drive_eta, _model,
                          (value) => _model = value),
                      _buildTextField("Year", Icons.calendar_today,
                          _year.toString(), (value) => _year = int.parse(value),
                          isNumber: true),
                      _buildTextField(
                          "Price",
                          Icons.attach_money,
                          _price.toString(),
                          (value) => _price = double.parse(value),
                          isNumber: true),
                      _buildTextField("Color", Icons.color_lens, _color,
                          (value) => _color = value),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          value: _category,
                          items: ['Sedan', 'SUV', 'Hatchback', 'Truck', 'Coupe']
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => _category = value!),
                        ),
                      ),

                      _buildTextField("Image URL", Icons.image, _imageUrl,
                          (value) => _imageUrl = value),

                      // แสดงตัวอย่างรูปภาพ
                      if (_imageUrl.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                _imageUrl,
                                height: 80,
                                width: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(
                                    Icons.image_not_supported,
                                    size: 80,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),

                      SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  Provider.of<CarModelProvider>(context,
                                          listen: false)
                                      .editCar(
                                    widget.index,
                                    CarModel(
                                      id: widget.car.id,
                                      brand: _brand,
                                      model: _model,
                                      year: _year,
                                      category: _category,
                                      price: _price,
                                      color: _color,
                                      launchDate: widget.car.launchDate,
                                      imageUrl: _imageUrl,
                                      createdAt: widget.car.createdAt,
                                    ),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("Save",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: Colors.green[600],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, String initialValue,
      Function(String) onSaved,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color.fromARGB(255, 32, 32, 32)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: const Color.fromARGB(255, 231, 231, 231),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
        onSaved: (value) => onSaved(value!),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_model_app/providers/car_model_provider.dart';
import 'package:car_model_app/models/model.dart';

class CarModelAdd extends StatefulWidget {
  @override
  _CarModelAddState createState() => _CarModelAddState();
}

class _CarModelAddState extends State<CarModelAdd> {
  final _formKey = GlobalKey<FormState>();
  String _brand = '';
  String _model = '';
  int _year = 2024;
  String _category = 'Sedan';
  double _price = 0.0;
  String _color = '';
  String _imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Car Model',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.lightGreen[600],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        _buildTextField("Brand Name", Icons.directions_car,
                            (value) => _brand = value),
                        _buildTextField("Model Name", Icons.drive_eta,
                            (value) => _model = value),
                        _buildTextField("Year", Icons.calendar_today,
                            (value) => _year = int.parse(value),
                            isNumber: true),
                        _buildTextField("Price", Icons.attach_money,
                            (value) => _price = double.parse(value),
                            isNumber: true),
                        _buildTextField("Color", Icons.color_lens,
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
                            items:
                                ['Sedan', 'SUV', 'Hatchback', 'Truck', 'Coupe']
                                    .map((category) => DropdownMenuItem(
                                          value: category,
                                          child: Text(category),
                                        ))
                                    .toList(),
                            onChanged: (value) =>
                                setState(() => _category = value!),
                          ),
                        ),

                        _buildTextField("Image URL", Icons.image, (value) {
                          setState(() {
                            _imageUrl = value;
                          });
                        }),

                        if (_imageUrl.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  _imageUrl,
                                  height: 70,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Icon(
                                      Icons.image_not_supported,
                                      size: 70,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ),

                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    Provider.of<CarModelProvider>(context,
                                            listen: false)
                                        .addCar(CarModel(
                                      id: DateTime.now().toString(),
                                      brand: _brand,
                                      model: _model,
                                      year: _year,
                                      category: _category,
                                      price: _price,
                                      color: _color,
                                      launchDate: DateTime.now(),
                                      imageUrl: _imageUrl,
                                      createdAt: DateTime.now(),
                                    ));
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
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, Function(String) onSaved,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
        onSaved: (value) => onSaved(value!),
      ),
    );
  }
}

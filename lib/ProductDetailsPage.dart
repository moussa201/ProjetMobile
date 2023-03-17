import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final Map<String, dynamic> productDetails;

  ProductDetailsPage({required this.product, required this.productDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.pink, Colors.purple],
            ),
          ),
        ),
        title: Text(product["titre"],
          style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product["image"],
              height: 200.0,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 16.0),
            Text(
              "${product["titre"]} - ${product["taille"]}",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "${product["description"]}",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              "${product["prix"]} €",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Détails",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            productDetails.isEmpty
                ? Text("Aucun détail disponible")
                : Expanded(
              child: ListView.builder(
                itemCount: productDetails.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = productDetails.keys.elementAt(index);
                  return ListTile(
                    title: Text(
                      key,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(productDetails[key]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

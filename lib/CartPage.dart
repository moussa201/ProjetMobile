import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    // Récupération des produits du panier depuis Firestore
    FirebaseFirestore.instance.collection("panier").get().then((querySnapshot) {
      setState(() {
        cartItems = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon panier'),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text('Votre panier est vide'),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(
                cartItems[index]['image'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(cartItems[index]['nom']),
              subtitle: Text(
                  'Taille: ${cartItems[index]['taille']}, Prix: ${cartItems[index]['prix']}'),
            ),
          );
        },
      ),
    );
  }
}

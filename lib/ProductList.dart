  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:projet_miage/user.dart';
  import 'CartPage.dart';
  import 'ProductDetailsPage.dart';
  import 'firebase_options.dart';

  class ProductList extends StatefulWidget {
    @override
    _ProductListState createState() => _ProductListState();
  }

  class _ProductListState extends State<ProductList> {
    List<Map<String, dynamic>> productList = [];
    List<Map<String, dynamic>> cart = [];
    List<String> categories = [];

    @override
    void initState() {
      super.initState();

      // Récupération de la collection "produits" de Firestore
      // Récupération des catégories distinctes de Firestore
      FirebaseFirestore.instance.collection("Liste produit").get().then((querySnapshot) {
        List<String> distinctCategories = querySnapshot.docs.map((doc) => doc["categorie"].toString()).toSet().toList();
        setState(() {
          categories = distinctCategories;
        });
      });


      // Récupération des produits de Firestore
      FirebaseFirestore.instance.collection("Liste produit").get().then((querySnapshot) {
        setState(() {
          productList = querySnapshot.docs.map((doc) => doc.data()).toList();
        });
      });
    }

    void addToCart(int index) {
      FirebaseFirestore.instance.collection("panier").add({
        "nom": productList[index]["titre"],
        "taille": productList[index]["taille"],
        "prix": productList[index]["prix"],
        "image": productList[index]["image"],
        "categorie": productList[index]["categorie"],
        // Ajouter d'autres champs selon les détails du produit
      }).then((value) {
        // Si l'ajout est réussi, afficher une notification
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Produit ajouté au panier")),
        );
      }).catchError((error) {
        // Si l'ajout échoue, afficher une erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : ${error.toString()}")),
        );
      });
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar:AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.pink, Colors.purple],
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              color: Colors.white,
            ),
          ),
          actions: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur Mode femme
                      FirebaseFirestore.instance.collection("Liste produit").where("categorie", isEqualTo: "femme").get().then((querySnapshot) {
                        setState(() {
                          productList = querySnapshot.docs.map((doc) => doc.data()).toList();
                        });
                      });

                    },
                    child: Text(
                      'Mode femme',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur Mode homme
                      FirebaseFirestore.instance.collection("Liste produit").where("categorie", isEqualTo: "homme").get().then((querySnapshot) {
                        setState(() {
                          productList = querySnapshot.docs.map((doc) => doc.data()).toList();
                        });
                      });
                    },
                    child: Text(
                      'Mode homme',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur Electronique
                      FirebaseFirestore.instance.collection("Liste produit").where("categorie", isEqualTo: "electronique").get().then((querySnapshot) {
                        setState(() {
                          productList = querySnapshot.docs.map((doc) => doc.data()).toList();
                        });
                      });
                    },
                    child: Text(
                      'Electronique',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur Bijoux et montre
                      FirebaseFirestore.instance.collection("Liste produit").where("categorie", isEqualTo: "bijoux").get().then((querySnapshot) {
                        setState(() {
                          productList = querySnapshot.docs.map((doc) => doc.data()).toList();
                        });
                      });
                    },
                    child: Text(
                      'Bijoux et montre',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur Jouets enfants
                      FirebaseFirestore.instance.collection("Liste produit").where("categorie", isEqualTo: "jouets").get().then((querySnapshot) {
                        setState(() {
                          productList = querySnapshot.docs.map((doc) => doc.data()).toList();
                        });
                      });
                    },
                    child: Text(
                      'Jouets enfants',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                final userSnapshot = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
                final userData = userSnapshot.data();
                final imageUrl = userData!['image'];
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(1000.0, 105.0, 1000.0, 1000.0),
                  items: [
                    PopupMenuItem(
                      child: Container(
                        width: 170, // set a custom width
                        height: 200, // set a custom height
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // center content vertically
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl),
                            ),
                            SizedBox(height: 10),
                            Text('${userData!['firstName']}  ${userData!['lastName']}', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text('Adresse: ${userData!['address']}'),
                            SizedBox(height: 5),
                            Text('Phone: ${userData!['phoneNumber']}'),
                            SizedBox(height: 5),

                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

          ],
        ),

        body: Center(
          child: productList.length == 0
              ? Text("Loading.")
              : ListView.builder(
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.all(8.0),
                      child: Image.network(
                        productList[index]["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 8.0),
                          Text(
                            productList[index]["titre"],
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "Taille : ${productList[index]["taille"]}\n${productList[index]["prix"]} €",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                    product: productList[index],
                                    productDetails: {},
                                  ),
                                ),
                              );
                            },
                            child: Text("Détails"),
                          ),
                          SizedBox(height: 8.0),
                          ElevatedButton(
                            onPressed: () => addToCart(index),
                            child: Text("Ajouter au panier"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
          child: Icon(Icons.shopping_cart),
        ),
      );
    }
  }

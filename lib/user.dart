import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Text('No user currently logged in.');
    }

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users')
          .doc(user.uid)
          .get(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return Text('Loading...');
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        if (data == null) {
          return Text('No user data found.');
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Prenom: ${data['firstName'] ?? "N/A"}'),
            Text('Nom: ${data['lastName'] ?? "N/A"}'),
            Text('Adresse: ${data['address'] ?? "N/A"}'),
            Text('Numéro téléphone: ${data['phoneNumber'] ?? "N/A"}'),
            Text('Email: ${user.email ?? "N/A"}'),
            Text('mot de passe: ${"*********"}'),
          ],
        );
      },
    );
  }
}
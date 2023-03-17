import 'package:flutter/material.dart';

class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon Application"),
        actions: <Widget>[
          TextButton(
            child: Text("S'inscrire", style: TextStyle(color: Colors.white)),
            onPressed: () {
              // Action pour le bouton "S'inscrire"
            },
          ),
          TextButton(
            child: Text("Se connecter", style: TextStyle(color: Colors.white)),
            onPressed: () {
              // Action pour le bouton "Se connecter"
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Image.asset('images/1.png'),
          Image.asset('images/2.png'),
          Image.asset('images/3.png'),
          Image.asset('images/3.png'),
        ],
      ),
    );
  }
}

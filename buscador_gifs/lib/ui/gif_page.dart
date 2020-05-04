import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  Map _gifData;

  GifPage(this._gifData); //Construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: (){
                Share.share(_gifData["images"]["fixed_height"]["url"]);
              },
            ),
          ],
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          bottom: PreferredSize(
            child: Container(
              color: Colors.white,
              height: 2.0,
            )
          ),
          title: Text(
              _gifData["title"],
              style: TextStyle(color: Colors.white)),

        ),
        body: Center(
          child: Image.network(_gifData["images"]["fixed_height"]["url"]),
        ));
  }
}

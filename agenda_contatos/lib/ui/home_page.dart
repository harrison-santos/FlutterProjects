import 'package:agendacontatos/helpers/contact_helper.dart';
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();


  @override
  void initState() {
    super.initState();

    Contact c = Contact();
    c.name = "Harrison Santos 3";
    c.email = "harrisonspeed1997@gmail.com";
    c.phone = "9 9859-0423";
    c.img = "imgtest";
    helper.saveContact(c);

    helper.getAllContact().then((list){
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

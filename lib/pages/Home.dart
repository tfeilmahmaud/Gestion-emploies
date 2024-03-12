import 'package:gemp/pages/profile/Profile.dart';
import 'package:gemp/pages/records/depdetails/GetDepartement.dart';
import 'package:gemp/pages/records/Emploie/Emploiesdetaille.dart';
import 'package:gemp/pages/registration/Signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'records/Emploie/GetEmploies.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Gestion Emploies')),
        body: GridView.count(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              grid(context, 'fill2', GetBasicDetails(), 'Departement'),
              grid(context, 'sheet', Getemps(), 'Emploies'),
              grid(context, 'profile', Profile(), 'My Profile'),
            ]));
  }
}

Widget grid(context, pic, page, label) {
  return InkWell(
    onTap: () => Get.to(
      page,
    ),
    child: Card(
      elevation: 5,
      child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: Image.asset('assets/images/$pic.png').image,
                    ),
                  ),
                ),
              ),
              Text("$label"),
            ],
          )),
    ),
  );
}

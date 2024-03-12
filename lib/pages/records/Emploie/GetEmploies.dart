import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gemp/api/API.dart';
import 'package:gemp/pages/records/depdetails/DepDetails.dart';

import 'Emploiesdetaille.dart'; // Assurez-vous d'importer le modèle Employee

class Getemps extends StatefulWidget {
  @override
  _GetempsState createState() => _GetempsState();
}

class _GetempsState extends State<Getemps> {
  late Future<List<Employee>> _empFuture;

  @override
  void initState() {
    super.initState();
    _empFuture = getEmployees(
        'employee'); // Appel de la méthode pour charger les employés
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employés'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddempPage()),
              ).then((result) {
                if (result != null && result) {
                  // Rafraîchir la liste des départements après l'ajout réussi
                  setState(() {
                    _empFuture = getEmployees('employee');
                  });
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Employee>>(
        future: _empFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Gestion des erreurs de FutureBuilder
            return Center(
              child: Text(
                'Une erreur s\'est produite: ${snapshot.error.toString()}. Veuillez réessayer.',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Aucune donnée disponible',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var employee = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person), // Ajout de l'icône de personne
                    title: Text(employee.employeeName),
                    onTap: () async {
                      var result = await Get.to(EmpDetails(employee: employee));
                      if (result != null && result) {
                        setState(() {
                          _empFuture = getEmployees('employee');
                        });
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class AddempPage extends StatefulWidget {
  @override
  _AddDepartmentPageState createState() => _AddDepartmentPageState();
}

class _AddDepartmentPageState extends State<AddempPage> {
  TextEditingController _emploieNameController = TextEditingController();
  TextEditingController _emploiedepController1 = TextEditingController();
  TextEditingController _emploiedateController2 = TextEditingController();
  TextEditingController _emploiephotoController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un employé'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emploieNameController,
              decoration: InputDecoration(labelText: 'Nom de l\'employé'),
            ),
            TextField(
              controller: _emploiedepController1,
              decoration: InputDecoration(labelText: 'Nom du département'),
            ),
            TextField(
              controller: _emploiedateController2,
              decoration: InputDecoration(labelText: 'Date de début'),
            ),
            TextField(
              controller: _emploiephotoController3,
              decoration: InputDecoration(labelText: 'Photo'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                bool added = await addEmployee({
                  'EmployeeName': _emploieNameController.text,
                  'Department': _emploiedepController1.text,
                  'DateOfJoining': _emploiedateController2.text,
                  'PhotoFileName': _emploiephotoController3.text
                });
                if (added) {
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Échec de l\'ajout de l\'employé'),
                    ),
                  );
                }
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}

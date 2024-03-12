import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gemp/api/API.dart';
import 'package:gemp/common/CWidget.dart';
import 'package:gemp/common/SnapConditions.dart';
import 'package:gemp/pages/records/depdetails/DepDetails.dart';

class GetBasicDetails extends StatefulWidget {
  @override
  _GetBasicDetailsState createState() => _GetBasicDetailsState();
}

class _GetBasicDetailsState extends State<GetBasicDetails> {
  Future<List<Department>>? _departmentsFuture;

  @override
  void initState() {
    super.initState();
    _departmentsFuture = getData('department');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Départements'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Naviguer vers la page d'ajout de département
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDepartmentPage()),
              ).then((result) {
                if (result != null && result) {
                  // Rafraîchir la liste des départements après l'ajout réussi
                  setState(() {
                    _departmentsFuture = getData('department');
                  });
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Department>>(
        future: _departmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return snapWaiting(context);
          } else if (snapshot.hasError) {
            return snapError();
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return snapNoData(context);
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var department = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading:
                        Icon(Icons.business), // Ajout de l'icône du département
                    title: Text(department.name),
                    onTap: () async {
                      // Naviguer vers la page DepDetails en passant le département sélectionné
                      var result =
                          await Get.to(DepDetails(department: department));
                      // Rafraîchir la liste des départements après avoir modifié un département
                      if (result != null && result) {
                        setState(() {
                          _departmentsFuture = getData('department');
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

// Nouvelle page pour ajouter un département
class AddDepartmentPage extends StatefulWidget {
  @override
  _AddDepartmentPageState createState() => _AddDepartmentPageState();
}

class _AddDepartmentPageState extends State<AddDepartmentPage> {
  TextEditingController _departmentNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un département'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _departmentNameController,
              decoration: InputDecoration(labelText: 'Nom du département'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // Appeler la méthode API pour ajouter le département
                bool added = await addDepartment(
                    {'DepartmentName': _departmentNameController.text});
                if (added) {
                  // Revenir à la page précédente en indiquant que l'ajout a été réussi
                  Navigator.pop(context, true);
                } else {
                  // Afficher un message d'erreur ou effectuer d'autres actions
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Échec de l\'ajout du département')));
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

import 'package:flutter/material.dart';
import 'package:gemp/api/API.dart';

class DepDetails extends StatefulWidget {
  final Department department;

  DepDetails({required this.department});

  @override
  _DepDetailsState createState() => _DepDetailsState();
}

class _DepDetailsState extends State<DepDetails> {
  TextEditingController _departmentNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialiser le contrôleur de texte avec le nom du département actuel
    _departmentNameController.text = widget.department.name;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Lorsque l'utilisateur appuie sur le bouton de retour physique ou logique
        _updateDepartment(); // Mettre à jour le département
        return true; // Retourner à la page précédente
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Détails du Département'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'ID: ${widget.department.id}',
              //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 10.0),
              TextField(
                controller: _departmentNameController,
                decoration: InputDecoration(labelText: 'Nom du département'),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _updateDepartment();
                    },
                    child: Text('Enregistrer'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _deleteDepartment();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text('Supprimer'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour mettre à jour le département
  void _updateDepartment() {
    String newName = _departmentNameController.text;
    if (newName.isNotEmpty) {
      // Utiliser la méthode patchDataForDepartmentName pour mettre à jour le nom du département
      patchDataForDepartmentName(widget.department.id, newName);
      Navigator.pop(context, true); // Retourner à la page précédente avec un indicateur de mise à jour
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez saisir un nom valide')));
    }
  }

  // Méthode pour supprimer le département
  void _deleteDepartment() {
    deleteDepartment(widget.department.id);
    Navigator.pop(context, true); // Retourner à la page précédente avec un indicateur de mise à jour
  }
}

import 'package:flutter/material.dart';
import 'package:gemp/api/API.dart';

class EmpDetails extends StatefulWidget {
  final Employee employee;

  EmpDetails({required this.employee});

  @override
  _EmpDetailsState createState() => _EmpDetailsState();
}

class _EmpDetailsState extends State<EmpDetails> {
  TextEditingController _employeeNameController = TextEditingController();
  TextEditingController _employeeNameController1 = TextEditingController();
  TextEditingController _employeeNameController2 = TextEditingController();
  TextEditingController _employeeNameController3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialiser le contrôleur de texte avec le nom de l'employé actuel
    _employeeNameController.text = widget.employee.employeeName;
    _employeeNameController1.text = widget.employee.department;
    _employeeNameController2.text = widget.employee.dateOfJoining;
    _employeeNameController3.text = widget.employee.photoFileName;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Lorsque l'utilisateur appuie sur le bouton de retour physique ou logique
        // _updateEmployee(); // Mettre à jour l'employé
        return true; // Retourner à la page précédente
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Détails de l\'employé'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'ID: ${widget.employee.id}',
              //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 10.0),
              TextField(
                controller: _employeeNameController,
                decoration: InputDecoration(labelText: 'Nom de l\'employé'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _employeeNameController1,
                decoration: InputDecoration(labelText: 'departement de l\'emploie'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _employeeNameController2,
                decoration: InputDecoration(labelText: 'date'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _employeeNameController3,
                decoration: InputDecoration(labelText: 'Photo'),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                       _updateEmployee();
                    },
                    child: Text('Enregistrer'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _deleteEmployee();
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

  // Méthode pour mettre à jour l'employé
  void _updateEmployee() {
   String newName = _employeeNameController.text;
   String dep = _employeeNameController1.text;
   String date = _employeeNameController2.text;
   String photo = _employeeNameController3.text;
    if (newName.isNotEmpty) {
      // Utiliser la méthode patchDataForDepartmentName pour mettre à jour le nom du département
      updateEmployee(widget.employee.employeeId, newName,dep,date,photo);
      Navigator.pop(context, true); // Retourner à la page précédente avec un indicateur de mise à jour
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez saisir un nom valide')));
    }
  }

  // Méthode pour supprimer l'employé
  void _deleteEmployee() {
    deleteemploie(widget.employee.employeeId);
    Navigator.pop(context, true); // Retourner à la page précédente avec un indicateur de mise à jour
  }
}

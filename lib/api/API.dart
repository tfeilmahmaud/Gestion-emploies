// https://flutter.dev/docs/cookbook#networking
import 'dart:convert';
import 'package:gemp/common/CWidget.dart';
import 'package:gemp/common/Controller.dart';
import 'package:gemp/pages/Home.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;


final controller = Get.put(ControllerPage());
final ControllerPage ctrl = Get.find();

class Department {
  final int id;
  final String name;

  Department({required this.id, required this.name});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['DepartmentId'],
      name: json['DepartmentName'],
    );
  }
}

class Employee {
  final int employeeId;
  final String employeeName;
  final String department;
  final String dateOfJoining;
  final String photoFileName;

  Employee({
    required this.employeeId,
    required this.employeeName,
    required this.department,
    required this.dateOfJoining,
    required this.photoFileName,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeId: json['EmployeeId'],
      employeeName: json['EmployeeName'],
      department: json['Department'],
      dateOfJoining: json['DateOfJoining'],
      photoFileName: json['PhotoFileName'],
    );
  }
}


Future<void> loginData(String url, Map<String, dynamic> data) async {
  try {
    // Effectuer une requête POST vers l'URL spécifiée avec les données de connexion
    final response = await http.post(
      Uri.parse(serversite + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    // Vérifier si la réponse du serveur a un code d'état HTTP 200 (OK)
    if (response.statusCode == 200) {
      // Parser la réponse JSON
      final responseJson = jsonDecode(response.body);
      
      // Vérifier si la clé 'jwt' existe dans la réponse JSON
      if (responseJson.containsKey('jwt')) {
        // Si le token existe, définir le token dans le contrôleur ou la méthode appropriée
        // Ici, on suppose que vous avez un contrôleur appelé 'controller' pour gérer le token
        controller.setToken(responseJson['jwt']);
        // Afficher un message de succès
        succesSnack('success', 'Signin successfully');
        // Naviguer vers la page Home
        Get.off(Home());
      } else {
        // Si la clé 'jwt' est absente, afficher un message d'erreur
        failedSnack('error', 'Access token is null');
      }
    } else {
      // Si le code d'état HTTP n'est pas 200, afficher un message d'erreur
      failedSnack('error', 'Failed to Signin');
    }
  } catch (e) {
    // Capturer les erreurs éventuelles et les afficher
    print('Error in loginData: $e');
    // Afficher un message d'erreur générique en cas d'erreur
    failedSnack('error', 'Failed to Signin');
  }
}



Future<bool> registerUser(String username, String email, String password) async {
  try {
    // Créez les données à envoyer au serveur
    Map<String, String> userData = {
      'username': username,
      'email': email,
      'password': password,
    };

    // Effectuez une requête POST vers l'URL d'enregistrement avec les données utilisateur
    final response = await http.post(
      Uri.parse(serversite +'register/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    // Vérifiez si la réponse du serveur est un succès (code 200)
    if (response.statusCode == 200) {
      // L'enregistrement a réussi
      return true;
    } else {
      // L'enregistrement a échoué
      return false;
    }
  } catch (e) {
    // Gérez les erreurs, par exemple, affichez un message d'erreur ou enregistrez les erreurs dans les journaux
    print('Error in registerUser: $e');
    return false;
  }
}
// final ControllerPage ctrl = Get.find();
// final String serversite = 'your_server_url_here'; // Assurez-vous de définir votre URL de serveur



Future<List<Department>> getData(String url) async {
  print('+--get--' * 5);
  final response = await http.get(
    Uri.parse(serversite + url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${ctrl.authtoken}',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    final List<Department> departments = data.map((dept) => Department.fromJson(dept)).toList();
    return departments;
  } else {
    print('Erreur ${response.statusCode}: ${response.body}');
    throw Exception('Erreur ${response.statusCode}: ${response.body}');
  }
}


Future<List<Employee>> getEmployees(String url) async {
  print('+--get--' * 5);
  // Effectuer une requête GET vers l'URL fournie
  final response = await http.get(
    Uri.parse(serversite + url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // Vous pouvez ajouter des en-têtes supplémentaires ici si nécessaire
    },
  );

  // Vérifier le code de statut de la réponse
  if (response.statusCode == 200) {
    // Si la réponse est OK (statut 200), analyser les données JSON
    // et les convertir en une liste d'objets Employee
    List<Employee> employees = parseEmployees(response.body);
    return employees;
  } else {
    // Si la réponse n'est pas OK, afficher un message d'erreur
    throw Exception('Échec de la récupération des employés: ${response.statusCode}');
  }
}

// Fonction pour convertir les données JSON en une liste d'objets Employee
List<Employee> parseEmployees(String responseBody) {
  
  // Analyser les données JSON
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  // Convertir les données JSON en une liste d'objets Employee
  return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
}




postData(url, data) async {
  print('--post--' * 5);
  final response = await http.post(
    Uri.parse(serversite + url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": ctrl.authtoken,
    },
    body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    succesSnack('success', 'Posted successfully');
    return null;
  } else {
    failedSnack('success', 'Failed to Post');
  }
}

//final String serversite = 'http://127.0.0.1:8000/'; // Assurez-vous de définir votre URL de serveur

Future<void> patchDataForDepartmentName(int departmentId, String newName) async {
  final url = 'department'; // Remplacez ceci par votre URL de mise à jour du nom de département
  final data = {
    'DepartmentId': departmentId,
    'DepartmentName': newName,
  };

  try {
    print('--patch--' * 5);
    final response = await http.put(
      Uri.parse(serversite + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": ctrl.authtoken,
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      succesSnack('success', 'Updated successfully');
    } else {
      failedSnack('error', 'Failed to Update');
    }
  } catch (e) {
    print('Error in patchDataForDepartmentName: $e');
    failedSnack('error', 'Failed to Update');
  }
}

Future<void> updateEmployee(int empId, String newName, String dep, String date, String photo) async {
 // Remplacez 'votre_url_de_l_api' par l'URL de votre API
 final url = 'employee'; // Remplacez ceci par votre URL de mise à jour du nom de département
  final data = {
    'EmployeeId': empId,
    'EmployeeName': newName,
    'Department': dep,
    'DateOfJoining': date,
    'PhotoFileName': photo,
  };

  try {
    print('--patch--' * 5);
    final response = await http.put(
      Uri.parse(serversite + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": ctrl.authtoken,
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      succesSnack('success', 'Updated successfully');
    } else {
      failedSnack('error', 'Failed to Update');
    }
  } catch (e) {
    print('Error in patchDataForDepartmentName: $e');
    failedSnack('error', 'Failed to Update');
  }
}


Future<void> deleteDepartment(int id) async {
  try {
    final response = await http.delete(
      Uri.parse(serversite + 'department/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': ctrl.authtoken,
      },
    );

    if (response.statusCode == 200) {
      succesSnack('success', 'Deleted successfully');
    } else {
      failedSnack('error', 'Failed to delete department');
    }
  } catch (e) {
    print('Error in deleteDepartment: $e');
    failedSnack('error', 'Failed to delete department');
  }
}


Future<void> deleteemploie(int id) async {
  try {
    final response = await http.delete(
      Uri.parse(serversite + 'employee/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': ctrl.authtoken,
      },
    );

    if (response.statusCode == 200) {
      succesSnack('success', 'Deleted successfully');
    } else {
      failedSnack('error', 'Failed to delete department');
    }
  } catch (e) {
    print('Error in deleteDepartment: $e');
    failedSnack('error', 'Failed to delete department');
  }
}

Future<bool> addDepartment(Map<String, dynamic> departmentData) async {
  try {
    final response = await http.post(
      Uri.parse(serversite +'department'), // Remplacez 'add_department' par votre endpoint approprié
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken', // Assurez-vous d'avoir un accessToken valide
      },
      body: jsonEncode(departmentData),
    );

    if (response.statusCode == 200) {
      // L'ajout du département a réussi
      return true;
    } else {
      // L'ajout du département a échoué
      return false;
    }
  } catch (e) {
    print('Error adding department: $e');
    // Gérer les erreurs, par exemple, afficher un message d'erreur ou enregistrer les erreurs dans les journaux
    return false;
  }
}
Future<bool> addEmployee(Map<String, dynamic> employeeData) async {
  try {
    final response = await http.post(
      Uri.parse(serversite +'employee'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken', // Assurez-vous d'avoir un accessToken valide
      },
      body: jsonEncode(employeeData),
    );

    if (response.statusCode == 200) {
      // L'ajout du département a réussi
      return true;
    } else {
      // L'ajout du département a échoué
      return false;
    }
  } catch (e) {
    print('Error adding department: $e');
    // Gérer les erreurs, par exemple, afficher un message d'erreur ou enregistrer les erreurs dans les journaux
    return false;
  }
}

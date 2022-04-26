import 'package:flutter/material.dart';
import 'package:mobile_app_open/models/user.dart';
import 'package:mobile_app_open/services/firestore_service.dart';

class UsuarioProvider with ChangeNotifier {
  final firestoreService = FireStoreService();

  String? _userId;
  String? _userEmail;
  String? _userFullName;
  String? _userCourse;
  DateTime? _userBirth;
  DateTime? _dateRegister;

  // Getters
  String? get userID => _userId;
  String? get userEmail => _userEmail;
  String? get userFullName => _userFullName;
  String? get userCourse => _userCourse;
  DateTime? get userBirth => _userBirth;
  DateTime? get dateRegister => _dateRegister;
  Stream<List<Usuario>> get usuarios => firestoreService.getUsers();

  //Setters
  set changeFullName(String fullname) {
    _userFullName = fullname;
    notifyListeners();
  }

  set changeCourse(String course) {
    _userCourse = course;
    notifyListeners();
  }

  set changeBirth(DateTime birth) {
    _userBirth = birth;
    notifyListeners();
  }

  //Functions
  loadAll(Usuario usuario) {
    if (usuario != null) {
      _userId = usuario.id;
      _userFullName = usuario.fullName;
      _userEmail = usuario.email;
      _userCourse = usuario.course;
      _userBirth = usuario.birthDate;
    } else {
      _userId = null;
      _userFullName = null;
      _userEmail = null;
      _userCourse = null;
      _userBirth = null;
    }
  }

  attUser(id) {
    var updateUser = Usuario(
        id: id,
        fullName: _userFullName,
        email: _userEmail,
        course: _userCourse,
        birthDate: _userBirth);
    firestoreService.setUser(id, updateUser);
  }

  addUser(id, email, fullname) {
    var updateUser = Usuario(
        id: id, fullName: fullname, email: email, course: '', birthDate: null, dateRegister: DateTime.now(), lastLogin: DateTime.now());
    firestoreService.setUser(id, updateUser);
  }

  lastLoginUser(id) {
    var updateLastLogin = Usuario(id: id, lastLogin: DateTime.now());
    firestoreService.updateLoginUser(id, updateLastLogin);
  }
}

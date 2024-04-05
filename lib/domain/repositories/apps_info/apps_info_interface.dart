import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IAppsInfoRepository {
  Future<DocumentSnapshot<Map<String, dynamic>>> termsAndConditions();
  Future<DocumentSnapshot<Map<String, dynamic>>> getContentHome();
  Future<DocumentSnapshot<Map<String, dynamic>>> getPromo();
  Future<DocumentSnapshot<Map<String, dynamic>>> getBrands();
  Future<DocumentSnapshot<Map<String, dynamic>>> getSpecialist();
}

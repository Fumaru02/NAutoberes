import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IAppsInfoRepository {
  Future<DocumentSnapshot<Map<String, dynamic>>> termsAndConditions();
}

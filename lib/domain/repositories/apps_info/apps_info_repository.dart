import 'package:cloud_firestore/cloud_firestore.dart';

import 'apps_info_interface.dart';

class AppsInfoRepository implements IAppsInfoRepository {
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> termsAndConditions() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await firestore.collection('auth').doc('newUser').get();

      // Memeriksa apakah dokumen ditemukan
      if (docSnapshot.exists) {
        return docSnapshot;
      } else {
        throw Exception("Dokumen doesn't exist.");
      }
    } catch (e) {
      // Tangani kesalahan
      throw Exception('Failed to get terms and conditions: $e');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import 'apps_info_interface.dart';

class AppsInfoRepository implements IAppsInfoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> termsAndConditions() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore.collection('auth').doc('newUser').get();
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

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getContentHome() async {
    final DocumentSnapshot<Map<String, dynamic>> data =
        await _firestore.collection('home').doc('data').get();
    if (data.exists) {
      return data;
    } else {
      throw Exception('Data doest Exist');
    }
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getPromo() async {
    final DocumentSnapshot<Map<String, dynamic>> data =
        await _firestore.collection('home').doc('promo').get();
    if (data.exists) {
      return data;
    } else {
      throw Exception('Data promo doest Exist');
    }
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getBrands() async {
    final DocumentSnapshot<Map<String, dynamic>> data =
        await _firestore.collection('data').doc('brands').get();
    if (data.exists) {
      return data;
    } else {
      throw Exception('Data brands doest Exist');
    }
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getSpecialist() async {
    final DocumentSnapshot<Map<String, dynamic>> data =
        await _firestore.collection('data').doc('specialist').get();
    if (data.exists) {
      return data;
    } else {
      throw Exception('Data specialist doest Exist');
    }
  }
}

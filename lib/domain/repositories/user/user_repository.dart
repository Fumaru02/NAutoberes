import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_interface.dart';

class UserRepository implements IUserRepository {
  User? user;

  @override
  Future<void> onSubmittedForm(String lat, String long, String homeServiceName,
      String homeServiceAddress, String homeServiceSkill) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update(<String, dynamic>{
      'mechanic': 1,
      'home_service': <String, dynamic>{
        'home_service_lat': lat,
        'home_service_long': long,
        'home_service_name': homeServiceName.trim(),
        'home_service_address': homeServiceAddress.trim(),
        'home_service_skill': homeServiceSkill.trim(),
      }
    });
    await FirebaseFirestore.instance
        .collection('mechanic')
        .doc('${user!.displayName}${user!.uid}')
        .update(<String, dynamic>{
      'id': '${DateTime.now()}+${user!.uid}',
      'name': user!.displayName,
      'user_rating': 0.0,
      'user_level': 'Beginner',
      'user_email': user!.email,
      'user_uid': user!.uid,
      'home_service_lat': lat,
      'home_service_long': long,
      'home_service_name': homeServiceName.trim(),
      'home_service_address': homeServiceAddress.trim(),
      'home_service_skill': homeServiceSkill.trim(),
    });
  }
}

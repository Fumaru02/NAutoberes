import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helpers/snackbar.dart';
import '../models/users/users_model.dart';
import '../services/shared_pref.dart';
import '../utils/enums.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  final SharedPref sharedPref = SharedPref();
  final RxBool isObscurePassword = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumbController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isTapped = false.obs;
  final RxBool isFront = true.obs;
  final RxBool isChecked = false.obs;
  final RxBool tapAnimation = false.obs;
  final RxDouble angle = RxDouble(0);
  final RxString termsOfUse = RxString('');
  Rx<UsersModel> userModel = UsersModel().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getAuthData();
  }

  Future<void> getAuthData() async {
    try {
      await _firestore
          .collection('auth')
          .doc('newUser')
          .get()
          .then((DocumentSnapshot<dynamic> docSnapshot) {
        final Map<String, dynamic> data =
            docSnapshot.data() as Map<String, dynamic>;
        termsOfUse.value = data['data']['termsOfUse'] as String;
        update();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void flipped() {
    angle.value = (angle + math.pi) % (2 * math.pi);
    update();
  }

  Future<void> getUserToken() async {
    final String? token = await _auth.currentUser?.getIdToken();
    sharedPref.writeAccessToken(token!);
  }

  Future<void> signInWithGoogle() async {
    Future<dynamic>.delayed(const Duration(milliseconds: 200));
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      final UserCredential userCreds =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCreds.user;
      if (userCreds.user != null) {
        isTapped.value = true;
        final CollectionReference<dynamic> users =
            _firestore.collection('users');
        if (userCreds.additionalUserInfo!.isNewUser) {
          await users.doc(user!.uid).set(<String, dynamic>{
            'user_uid': user.uid,
            'update_time': DateTime.now().toIso8601String(),
            'creation_time': user.metadata.creationTime!.toIso8601String(),
            'last_sign_in_time':
                user.metadata.lastSignInTime!.toIso8601String(),
            'email': user.email,
            'status': 'User',
            'key_name': user.displayName!.substring(0, 1).toUpperCase(),
            'username': user.displayName,
            'user_image': user.photoURL,
            'description': '',
            'gender': '',
            'profiency': '',
            'city': '',
            'subdistrict': '',
          });

          users.doc(user.uid).collection('chats');
        } else {
          await users.doc(user!.uid).update(<Object, Object?>{
            'last_sign_in_time':
                user.metadata.lastSignInTime!.toIso8601String(),
          });
        }

        final DocumentSnapshot<Object?> currUser =
            await users.doc(user.uid).get();
        final Map<String, dynamic> currUserData =
            currUser.data()! as Map<String, dynamic>;

        userModel(UsersModel.fromJson(currUserData));

        userModel.refresh();

        final QuerySnapshot<Map<String, dynamic>> listChats =
            await users.doc(user.uid).collection('chats').get();

        // ignore: prefer_is_empty
        if (listChats.docs.length != 0) {
          final List<ChatUser> dataListChat = <ChatUser>[];
          // ignore: avoid_function_literals_in_foreach_calls
          listChats.docs.forEach(
            (QueryDocumentSnapshot<Map<String, dynamic>> element) {
              final Map<String, dynamic> dataDocChat = element.data();
              final String dataDocChatId = element.id;
              dataListChat.add(ChatUser(
                  chatId: dataDocChatId,
                  connection: dataDocChat['connection'] as String?,
                  lastTime: dataDocChat['last_time'] as String?,
                  totalUnread: dataDocChat['total_unread'] as int?));
            },
          );
          userModel.update((UsersModel? user) {
            user!.chats = dataListChat;
          });
        } else {
          userModel.update((UsersModel? user) {
            user!.chats = <ChatUser>[];
          });
        }
        userModel.refresh();

        isTapped.value = false;
        Get.offAllNamed('/frame');
      } else {
        Snack.show(SnackbarType.error, 'invalid email',
            'Email tidak dapat ditemukan coba lagi');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Snack.show(SnackbarType.error, 'invalid email',
              'Email tidak dapat ditemukan coba lagi');
          break;
        case 'user-not-found':
          Snack.show(SnackbarType.error, 'Unknown email',
              'Akun tidak dapat ditemukan coba lagi/password salah');
          break;
        default:
          Snack.show(SnackbarType.error, 'Error',
              'Something error please try again later');
      }
      return false;
    }
  }

  dynamic signInWithEmailAndPassword() async {
    try {
      isTapped.value = true;
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (!credential.user!.emailVerified) {
        Snack.show(SnackbarType.error, 'Email Verification',
            'Email kamu belum terverifikasi mohon check inbox/spam');
        isTapped.value = false;
        return;
      }
      if (credential.user == null) {
        Snack.show(SnackbarType.error, 'Email Verification',
            'Email kamu belum terverifikasi mohon check inbox/spam');
        isTapped.value = false;
        return;
      }
      getUserToken();
      Get.offAllNamed('/frame');
      isTapped.value = false;

      return credential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Snack.show(SnackbarType.error, 'invalid email',
              'Email tidak dapat ditemukan coba lagi');
          isTapped.value = false;
          break;
        case 'invalid-credential':
          Snack.show(SnackbarType.error, 'wrong email/password',
              'Email/Password salah coba lagi');
          isTapped.value = false;
          break;
        case 'user-not-found':
          Snack.show(SnackbarType.error, 'Unknown email',
              'Akun tidak dapat ditemukan coba lagi/password salah');
          isTapped.value = false;
          break;
        case 'ERROR_USER_DISABLED':
          Snack.show(SnackbarType.error, 'Error User',
              'Akunmu dihentikan untuk sementara waktu');
          isTapped.value = false;
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          Snack.show(
              SnackbarType.error, 'Error', 'Too many request try again later');
          isTapped.value = false;
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          Snack.show(SnackbarType.error, 'Unknown user', 'Operasi dihentikan');
          isTapped.value = false;
          break;
        default:
          Snack.show(SnackbarType.error, 'Error',
              'Something error please try again later');
          isTapped.value = false;
          return null;
      }
    }
  }
}

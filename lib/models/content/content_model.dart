import 'package:cloud_firestore/cloud_firestore.dart';

class Content {
  Content({
    this.contentTitle,
    this.contentImg,
  });

  factory Content.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    // ignore: avoid_unused_constructor_parameters
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data = snapshot.data();
    return Content(
      contentImg: data?['content_img'] as String?,
      contentTitle: data?['content_title'] as String?,
    );
  }
  final String? contentTitle;
  final String? contentImg;

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      if (contentTitle != null) 'content_title': contentTitle,
      if (contentImg != null) 'content_img': contentImg,
    };
  }
}

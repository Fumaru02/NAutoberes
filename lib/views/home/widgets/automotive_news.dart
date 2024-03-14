import 'package:flutter/material.dart';

import '../../../controllers/home/home_controller.dart';
import 'about_automotive_list.dart';

class AutomotiveNews extends StatelessWidget {
  const AutomotiveNews({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      
        delegate: SliverChildBuilderDelegate(
          
            (BuildContext context, int index) => AboutAutomotiveList(
              
                  model: homeController.aboutAutomotiveList[index],
                ),
            childCount: homeController.aboutAutomotiveList.length));
  }
}

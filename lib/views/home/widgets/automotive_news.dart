import 'package:flutter/material.dart';

import '../../../controllers/home/home_controller.dart';
import '../../../utils/size_config.dart';
import 'about_automotive_list.dart';

class AutomotiveNews extends StatelessWidget {
  const AutomotiveNews({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: SizeConfig.horizontal(55),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeController.aboutAutomotiveList.length > 2
                ? 2
                : homeController.aboutAutomotiveList.length,
            itemBuilder: (BuildContext context, int index) =>
                AboutAutomotiveList(
                  model: homeController.aboutAutomotiveList[index],
                )),
      ),
    );
  }
}

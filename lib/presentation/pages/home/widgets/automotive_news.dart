import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/size_config.dart';
import '../../../blocs/bloc/home_bloc.dart';
import 'about_automotive_list.dart';

class AutomotiveNews extends StatelessWidget {
  const AutomotiveNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: SizeConfig.horizontal(55),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (_, HomeState state) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.aboutAutomotiveList.length,
                itemBuilder: (BuildContext context, int index) =>
                    AboutAutomotiveList(
                      model: state.aboutAutomotiveList[index],
                    ));
          },
        ),
      ),
    );
  }
}

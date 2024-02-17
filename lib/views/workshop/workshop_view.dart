import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/workshop_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/asset_list.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/text/inter_text_view.dart';

class WorkshopView extends StatelessWidget {
  const WorkshopView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkshopController>(
      init: WorkshopController(),
      builder: (WorkshopController workshopController) => ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: Obx(
            () => workshopController.isTapped.isFalse
                ? const SizedBox.shrink()
                : Container(
                    margin: EdgeInsets.only(top: SizeConfig.horizontal(2)),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                              color: AppColors.greyDisabled)
                        ],
                        border: Border.all(width: SizeConfig.horizontal(0.3)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    height: SizeConfig.horizontal(70),
                    width: SizeConfig.horizontal(92),
                    child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.COLUMN,
                      columnPadding: EdgeInsets.all(SizeConfig.horizontal(1)),
                      children: <ResponsiveRowColumnItem>[
                        ResponsiveRowColumnItem(
                            child: ResponsiveRowColumn(
                          layout: ResponsiveRowColumnType.ROW,
                          rowPadding:
                              EdgeInsets.only(left: SizeConfig.horizontal(8)),
                          rowMainAxisAlignment: MainAxisAlignment.center,
                          children: <ResponsiveRowColumnItem>[
                            ResponsiveRowColumnItem(
                              child: InterTextView(
                                value: 'Shop And Drive',
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ResponsiveRowColumnItem(
                                child: IconButton(
                              onPressed: () =>
                                  workshopController.hideWorkshop(),
                              icon: Icon(
                                Icons.close_sharp,
                                size: SizeConfig.horizontal(8),
                              ),
                            )),
                          ],
                        )),
                        ResponsiveRowColumnItem(
                            child: Container(
                                decoration:
                                    BoxDecoration(color: AppColors.black),
                                width: SizeConfig.horizontal(70),
                                height: SizeConfig.horizontal(30),
                                child: Image.asset(
                                  AssetList.autoberesLogo,
                                ))),
                        ResponsiveRowColumnItem(
                            child: ResponsiveRowColumn(
                          layout: ResponsiveRowColumnType.ROW,
                          rowSpacing: 4,
                          rowMainAxisAlignment: MainAxisAlignment.center,
                          children: <ResponsiveRowColumnItem>[
                            ResponsiveRowColumnItem(
                              child: InterTextView(
                                value: 'Shop And Drive Cikampek',
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ResponsiveRowColumnItem(
                                child: Icon(
                              Icons.check_circle_sharp,
                              color: AppColors.greenSuccess,
                            ))
                          ],
                        )),
                        ResponsiveRowColumnItem(
                            child: ResponsiveRowColumn(
                          layout: ResponsiveRowColumnType.ROW,
                          rowSpacing: 4,
                          rowMainAxisAlignment: MainAxisAlignment.center,
                          children: <ResponsiveRowColumnItem>[
                            const ResponsiveRowColumnItem(
                                child: Icon(Icons.call)),
                            ResponsiveRowColumnItem(
                              child: InterTextView(
                                value: 'Call Center 15-000-15',
                                color: AppColors.black,
                                fontWeight: FontWeight.normal,
                                size: SizeConfig.safeBlockHorizontal * 4,
                              ),
                            ),
                          ],
                        )),
                        const ResponsiveRowColumnItem(child: Icon(Icons.star)),
                        ResponsiveRowColumnItem(
                            child: InterTextView(
                          value: '5.0',
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                          color: AppColors.black,
                        ))
                      ],
                    ),
                  ),
          )),
          ResponsiveRowColumnItem(
            child: Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) =>
                    CustomRippleButton(
                  onTap: () => workshopController.showWorkshop(),
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.horizontal(4)),
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.horizontal(6),
                        vertical: SizeConfig.horizontal(3)),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                              color: AppColors.greyDisabled)
                        ],
                        borderRadius: BorderRadius.all(
                            Radius.circular(SizeConfig.horizontal(4)))),
                    child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.ROW,
                      children: <ResponsiveRowColumnItem>[
                        ResponsiveRowColumnItem(
                          child: SizedBox(
                            height: SizeConfig.horizontal(16),
                            child: const CircleAvatar(
                              minRadius: 30,
                            ),
                          ),
                        ),
                        ResponsiveRowColumnItem(
                          child: ResponsiveRowColumn(
                            columnMainAxisSize: MainAxisSize.min,
                            layout: ResponsiveRowColumnType.COLUMN,
                            columnPadding:
                                EdgeInsets.only(left: SizeConfig.horizontal(2)),
                            columnCrossAxisAlignment: CrossAxisAlignment.start,
                            children: <ResponsiveRowColumnItem>[
                              ResponsiveRowColumnItem(
                                  child: InterTextView(
                                value: 'Shop and Drive',
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              )),
                              ResponsiveRowColumnItem(
                                  child: InterTextView(
                                value: 'Jl. Buahbatu no 38',
                                color: AppColors.greyButton,
                                size: SizeConfig.safeBlockHorizontal * 3.5,
                              )),
                              ResponsiveRowColumnItem(
                                  child: ResponsiveRowColumn(
                                layout: ResponsiveRowColumnType.ROW,
                                rowSpacing: 4,
                                children: <ResponsiveRowColumnItem>[
                                  ResponsiveRowColumnItem(
                                    child: InterTextView(
                                      value: 'Original Certified',
                                      color: AppColors.black,
                                      size: SizeConfig.safeBlockHorizontal * 4,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ResponsiveRowColumnItem(
                                      child: Icon(
                                    Icons.check_circle_sharp,
                                    color: AppColors.greenSuccess,
                                  ))
                                ],
                              ))
                            ],
                          ),
                        ),
                        const ResponsiveRowColumnItem(child: Spacer()),
                        const ResponsiveRowColumnItem(child: Icon(Icons.star)),
                        ResponsiveRowColumnItem(
                            child: InterTextView(
                          value: '4.7',
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                          color: AppColors.black,
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

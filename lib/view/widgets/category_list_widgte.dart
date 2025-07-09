import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:map_pro/model/category_model.dart';
import 'package:map_pro/utility/common_extension.dart';
import 'package:map_pro/utility/config/static_text.dart';
import 'package:map_pro/utility/theme/app_color.dart';
import 'package:map_pro/utility/theme/text_styles.dart';

class CategorySection extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategorySection({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.currentLocale;
    return Padding(
      padding: EdgeInsets.only(left: 12,right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(StaticText.menuList.tr(), style: TextStyles.boldText),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            children: categories.map((cat)
            {
              return Column(
                children: [
                  InkWell(
                    onTap:()
                       {
                         print("hjhjhhj:  ${cat.route}");
                         Navigator.pushNamed(context, "/${cat.route}");
                       },
                    child: Container(
                      width: 80,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary),
                        color: AppColors.boxShade
                      ),
                      child: Icon(cat.icon,size: 30,),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(cat.title.tr(), style: TextStyles.smallText),
                  const SizedBox(height: 12),

                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

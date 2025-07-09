import 'package:flutter/material.dart';
import 'package:map_pro/utility/theme/app_color.dart';
import 'package:map_pro/utility/theme/text_styles.dart';
import 'package:map_pro/view/widgets/image_network_widget.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String country;
  final String imageUrl;

  const ProfileCard({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.country,
    required this.imageUrl, // Default image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(15),
       border: Border.all(
         color: AppColors.primary.withOpacity(0.2)
       )
     ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            ImageNetworkWidget(
              width: double.infinity,
              height: 200,
              image: imageUrl,
            ),
            Container(
              width: double.infinity,
              height: 200,
              color: AppColors.grey.withOpacity(0.1),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyles.heading
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color:AppColors.black),
                      const SizedBox(width: 4),
                      Text(
                        phoneNumber,
                        style: TextStyle(color:AppColors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color:AppColors.black),
                      const SizedBox(width: 4),
                      Text(
                        country,
                        style: TextStyle(color:AppColors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

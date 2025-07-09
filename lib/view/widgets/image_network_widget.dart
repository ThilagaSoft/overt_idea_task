import 'package:flutter/material.dart';
import 'package:map_pro/utility/theme/app_color.dart';

class ImageNetworkWidget extends StatelessWidget
{
  final String image;
  final double height;
 final double width;
 const  ImageNetworkWidget({super.key, required this.image, required this.height, required this.width});

  @override
  Widget build(BuildContext context)
  {
    return Image.network(
      image,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
      Icon(Icons.image,color: AppColors.boxShade,size: height,),
      loadingBuilder: (context, child, loadingProgress)
      {
        if (loadingProgress == null) return child;
        return  Icon(Icons.image,color: AppColors.boxShade,size: height,);
      },
    );
  }
}

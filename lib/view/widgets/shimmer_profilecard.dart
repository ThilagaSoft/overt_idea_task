import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:map_pro/utility/theme/app_color.dart';

class ShimmerProfileCard extends StatelessWidget {
  const ShimmerProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Background shimmer
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey.shade300,
              ),
            ),

            // Overlay content shimmer
            Positioned(
              bottom: 10,
              left: 10,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Container(
                      width: 150,
                      height: 20,
                      color: Colors.grey,
                      margin: const EdgeInsets.only(bottom: 8),
                    ),
                    // Phone row
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: Colors.grey.shade400),
                        const SizedBox(width: 4),
                        Container(width: 100, height: 14, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Country row
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey.shade400),
                        const SizedBox(width: 4),
                        Container(width: 80, height: 14, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

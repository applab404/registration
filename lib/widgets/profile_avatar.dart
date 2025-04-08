import 'dart:io';
import 'package:flutter/material.dart';
import 'package:registration/theme/colors.dart';

class ProfileAvatar extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;
  final double radius;

  const ProfileAvatar({
    super.key,
    required this.imageFile,
    required this.onTap,
    this.radius = 60,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageFile != null;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.lightGrey,
            backgroundImage: hasImage ? FileImage(imageFile!) : null,
            child:
                !hasImage
                    ? const Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.textPrimary,
                    )
                    : null,
          ),
          _buildActionIcon(hasImage),
        ],
      ),
    );
  }

  Widget _buildActionIcon(bool hasImage) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.primary,
      child: Icon(
        hasImage ? Icons.edit : Icons.add,
        size: 20,
        color: AppColors.surface,
      ),
    );
  }
}

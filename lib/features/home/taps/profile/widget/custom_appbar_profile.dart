import 'package:evently/core/consts/app_image.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:evently/provider/auth_provider.dart';
import 'package:evently/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBarProfile extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    String userName = authProvider.user?.displayName ?? 
                     authProvider.user?.email?.split('@')[0] ?? 
                     'Guest User';
    
    String userEmail = authProvider.user?.email ?? 'No email';
    String? userPhotoUrl = authProvider.user?.photoURL;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.only(top: 50, right: 15, left: 15),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode
              ? AppColors.darkPurple
              : AppColors.purple,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.navyBlue,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                    child: userPhotoUrl != null
                        ? Image.network(
                            userPhotoUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                AppImage.creative,
                                fit: BoxFit.cover,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: AppColors.offWhite,
                                ),
                              );
                            },
                          )
                        : Image.asset(
                            AppImage.creative,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStylesHelper.font20WhiteBold,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 4),
                      Text(
                        userEmail,
                        style: TextStylesHelper.font16semiBoldWhite,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(140);
}
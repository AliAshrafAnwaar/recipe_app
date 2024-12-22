import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/features/profile/widgets/edit_bio_dialog.dart';
import 'package:recipe_app/features/profile/widgets/edit_info_dialog.dart';
import 'package:recipe_app/features/profile/widgets/info_display.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget buildBioHeader(String title, {required VoidCallback onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'Edit',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryText,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryText,
        elevation: 0,
        title: Text(
          'Profile',
          style: AppTextStyles.primaryTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EditInfoDialog(),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(),
          Flexible(child: buildProfileScreen(context)),
        ],
      ),
    );
  }

  Widget buildProfileScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          const SizedBox(height: 16),
          Center(
              child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey.shade200,
                child: const ClipOval(
                  child: Icon(Icons.person),
                ),
              ),
              Positioned(
                right: 7,
                child: Container(
                  width: 35,
                  height: 35,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, color: Colors.white),
                    padding: EdgeInsets
                        .zero, // Reduce padding inside IconButton to minimize size
                    constraints:
                        const BoxConstraints(), // Remove minimum size constraints
                  ),
                ),
              ),
            ],
          )),
          const SizedBox(height: 8),
          Center(
            child: Column(
              children: [
                Text(
                  'Author Name',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Job Title' ?? 'No job title',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.verified,
                      color: AppColors.primaryColor,
                      size: 16,
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    InkWell(
                      child: Text(
                        '1',
                        style: AppTextStyles.secondaryTextStyle,
                      ),
                      onTap: () {
                        GoRouter.of(context).pushNamed('/applicationsScreen');
                      },
                    ), // Show the count once data is available,
                    InkWell(
                        child: const Text('Recips'),
                        onTap: () {
                          GoRouter.of(context).pushNamed('/applicationsScreen');
                        }),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Status' ?? 'No status',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                    const Text(
                      'Status',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Contacts ',
            style: AppTextStyles.secondaryTextStyle,
          ),
          const SizedBox(height: 10),
          const InfoDisplay(
              text: 'aliashrafanwaar@gmail.com', icon: Icons.email),
          const SizedBox(
              width: 10), // Adjust spacing based on your layout width
          const InfoDisplay(
              text: '01025591901' ?? 'No phone number',
              icon: Icons.phone_android),
          const SizedBox(height: 24),
          buildBioHeader('Bio', onPressed: () {
            showDialog(
              context: context,
              builder: (context) => EditBioDialog(),
            );
          }),
          const SizedBox(height: 10),
          const CustomBioDisplay(
              text:
                  'This is a tes stample for the bio of the osumn ali ashraf' ??
                      'No bio'),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

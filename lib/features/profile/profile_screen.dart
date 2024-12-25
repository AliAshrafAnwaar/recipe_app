import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/features/profile/widgets/edit_bio_dialog.dart';
import 'package:recipe_app/features/profile/widgets/edit_info_dialog.dart';
import 'package:recipe_app/features/profile/widgets/info_display.dart';
import 'package:recipe_app/providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProviderProvider);
    final userNotifier = ref.read(userProviderProvider.notifier);
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
                builder: (context) => EditInfoDialog(user: user!),
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
          const Divider(
            color: AppColors.mainColor,
            thickness: 1,
          ),
          Flexible(child: buildProfileScreen(context, user, userNotifier)),
        ],
      ),
    );
  }

  Widget buildProfileScreen(
      BuildContext context, UserModel? user, UserProvider userNotifier) {
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
                backgroundColor: AppColors.mainColor.withOpacity(0.1),
                radius: 100,
                backgroundImage: (user!.image.isEmpty)
                    ? null
                    : Image.network(user.image).image,
                child: (user.image.isEmpty)
                    ? const Icon(
                        Icons.person,
                        size: 100,
                        color: AppColors.primaryText,
                      )
                    : null,
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
                    onPressed: () async {
                      await userNotifier
                          .profileImageUpload(user ?? user!.copyWith());
                    },
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
                  (user != null) ? user.username : '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
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
                        (user != null) ? user.recipes.length.toString() : '0',
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
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Contacts ',
            style: AppTextStyles.secondaryTextStyle,
          ),
          const SizedBox(height: 10),
          InfoDisplay(
              text: (user != null) ? user.email : '', icon: Icons.email),
          const SizedBox(
              width: 10), // Adjust spacing based on your layout width
          InfoDisplay(
              text: (user != null)
                  ? user.phoneNumber.isEmpty
                      ? 'No phone number'
                      : user.phoneNumber
                  : 'No phone number',
              icon: Icons.phone_android),
          const SizedBox(height: 24),
          buildBioHeader('Bio', onPressed: () {
            showDialog(
              context: context,
              builder: (context) => EditBioDialog(
                user: user!,
              ),
            );
          }),
          const SizedBox(height: 10),
          CustomBioDisplay(
              text: (user != null)
                  ? user.bio.isEmpty
                      ? 'No bio'
                      : user.bio
                  : 'No Bio'),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

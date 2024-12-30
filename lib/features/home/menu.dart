import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/app_router.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/providers/user_provider.dart';

class Menu extends ConsumerWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProviderProvider);
    return Scaffold(
      backgroundColor: AppColors.secondaryText,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryText,
        title: Text(
          'Menu',
          style: AppTextStyles.primaryTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              color: AppColors.mainColor,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  userContainer(context, user!),
                  Row(
                    children: [
                      Flexible(
                        child: menuItem(
                          title: 'Favorites',
                          icon: const Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          ),
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.favouriteList);
                          },
                        ),
                      ),
                      Flexible(
                        child: menuItem(
                          title: 'My listings',
                          icon: const Icon(
                            Icons.list,
                            color: AppColors.mainColor,
                          ),
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.userListings);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: menuItem(
                          title: 'Edit Profile',
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.mainColor,
                          ),
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.profileScreen);
                          },
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // settingsItem(
                  //   icon: const Icon(
                  //     Icons.settings,
                  //     color: AppColors.mainColor,
                  //   ),
                  //   title: 'Settings & privacy',
                  //   onTap: () {},
                  // ),
                  // settingsItem(
                  //   icon: Icon(Icons.help, color: AppColors.mainColor),
                  //   title: 'Help and support',
                  //   onTap: () {},
                  // ),
                  settingsItem(
                    icon: const Icon(Icons.logout, color: AppColors.mainColor),
                    title: 'Logout',
                    onTap: () {
                      GoRouter.of(context).go(AppRouter.signIn);
                      ref.read(userProviderProvider.notifier).signOut(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userContainer(BuildContext context, UserModel user) {
    return Card(
      shadowColor: Colors.black.withOpacity(0.5),
      elevation: 1,
      child: InkWell(
        onTap: () {
          GoRouter.of(context).push(AppRouter.profileScreen);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.mainColor.withOpacity(0.1),
                radius: 20,
                backgroundImage: (user.image.isEmpty)
                    ? null
                    : Image.network(user.image).image,
                child: (user.image.isEmpty)
                    ? const Icon(
                        Icons.person,
                        color: AppColors.primaryText,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Text(user.username),
              const Expanded(child: SizedBox()),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem(
      {required String title,
      required Widget icon,
      required Function() onTap}) {
    return Card(
        shadowColor: Colors.black.withOpacity(0.5),
        elevation: 1,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                icon,
                const SizedBox(height: 8),
                Text(title),
              ],
            ),
          ),
        ));
  }

  Widget settingsItem(
      {required String title,
      required Widget icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 8),
                Text(title),
                const Expanded(child: SizedBox()),
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onPressed: onTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

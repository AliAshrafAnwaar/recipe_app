import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            userContainer(),
            Row(
              children: [
                Flexible(
                  child: menuItem(
                    title: 'Favorites',
                    icon: Icons.favorite,
                    onTap: () {},
                  ),
                ),
                Flexible(
                  child: menuItem(
                    title: 'My listings',
                    icon: Icons.list,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: menuItem(
                    title: 'Edit Profile',
                    icon: Icons.edit,
                    onTap: () {},
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            SizedBox(height: 8),
            settingsItem(
              icon: Icons.settings,
              title: 'Settings & privacy',
              onTap: () {},
            ),
            settingsItem(
              icon: Icons.help,
              title: 'Help and support',
              onTap: () {},
            ),
            settingsItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget userContainer() {
    return Card(
      shadowColor: Colors.black.withOpacity(0.5),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: Image.asset('assets/images/profile.jpg').image,
            ),
            const SizedBox(width: 16),
            const Text('Ali Ashraf'),
            const Expanded(child: SizedBox()),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return Card(
        shadowColor: Colors.black.withOpacity(0.5),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Icon(icon),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ));
  }

  Widget settingsItem(
      {required String title,
      required IconData icon,
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
                Icon(icon),
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

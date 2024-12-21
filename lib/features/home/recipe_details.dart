import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/utils/app_router.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/features/home/widgets/user_action_button.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Author Names Recipe',
            style: AppTextStyles.secondaryTextStyle,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Divider(),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundImage:
                                  Image.asset('assets/images/profile.jpg')
                                      .image),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recipe Author',
                                style: AppTextStyles.secondaryTextStyle,
                              ),
                              Text(
                                'Date',
                                style: AppTextStyles.subTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Recipe Name',
                            style: TextStyle(),
                          ),
                          Text(
                            'Recipe Discription',
                            style: TextStyle(),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/profile.jpg',
                    ),
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UserActionButton(
                              icon: Icons.thumb_up_alt_outlined, text: '1'),
                          UserActionButton(icon: Icons.comment, text: '3'),
                          UserActionButton(
                              icon: Icons.favorite_border_outlined, text: ''),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

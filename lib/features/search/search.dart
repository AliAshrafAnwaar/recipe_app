import 'package:flutter/material.dart';
import 'package:recipe_app/features/shared_widgets/styled_textField.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledTextField(
          hint: 'Search for recipe',
          icon: Icons.food_bank,
        ),
      ),
      body: Center(
        child: Text('data'),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/features/shared_widgets/styled_button.dart';
import 'package:recipe_app/features/shared_widgets/styled_textField.dart';
import 'package:recipe_app/providers/user_provider.dart';

class CreateRecipe extends ConsumerStatefulWidget {
  const CreateRecipe({super.key});

  @override
  ConsumerState<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends ConsumerState<CreateRecipe> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? _image;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Perform the recipe creation logic here
      // For example, upload the image and save the recipe details to Firestore
      final recipeNotifier = ref.read(userProviderProvider.notifier);
      await recipeNotifier.addRecipe(
          _titleController.text, _descriptionController.text, _image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryText,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryText,
        title: Text('Create Recipe', style: AppTextStyles.primaryTextStyle),
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StyledTextField(
                      controller: _titleController,
                      hint: 'Title',
                      icon: Icons.title,
                    ),
                    const SizedBox(height: 10),
                    StyledTextField(
                      controller: _descriptionController,
                      hint: 'Description',
                      icon: Icons.description,
                      maxLines: 10,
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        final XFile? pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (pickedFile != null) {
                          setState(() {
                            _image = File(pickedFile.path);
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.image,
                              color:
                                  _image != null ? Colors.green : Colors.grey,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _image != null
                                  ? 'Image Selected'
                                  : 'Select Image',
                              style: TextStyle(
                                color:
                                    _image != null ? Colors.green : Colors.grey,
                              ),
                            ),
                            Expanded(child: const SizedBox()),
                            (_image == null)
                                ? SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                                    icon: Icon(Icons.remove_circle_outline),
                                    color: Colors.green,
                                  )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    StyledButton(
                      onPressed: _submitForm,
                      text: 'Create Recipe',
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

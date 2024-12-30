import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  bool _isLoading = false; // Loading state

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Start loading
      });

      try {
        // Simulate the recipe creation logic
        await ref.read(userProviderProvider.notifier).addRecipe(
            _titleController.text, _descriptionController.text, _image);

        // Clear the form after submission
        _titleController.clear();
        _descriptionController.clear();
        setState(() {
          _image = null;
        });
        GoRouter.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recipe created successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Stop loading
        });
      }
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
                            const Expanded(child: SizedBox()),
                            (_image == null)
                                ? const SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                                    icon:
                                        const Icon(Icons.remove_circle_outline),
                                    color: Colors.green,
                                  )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isLoading // Show loading indicator
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                          ))
                        : StyledButton(
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

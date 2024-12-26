import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';

class UserActionButton extends StatefulWidget {
  const UserActionButton({
    super.key,
    required this.icon,
    required this.filledIcon,
    required this.text,
    required this.onSelected,
    required this.onUnSelected,
    required this.isSelected,
  });

  final IconData icon;
  final IconData filledIcon;
  final String text;
  final Function() onSelected;
  final Function() onUnSelected;
  final bool isSelected;

  @override
  _UserActionButtonState createState() => _UserActionButtonState();
}

class _UserActionButtonState extends State<UserActionButton> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
    if (_isSelected) {
      widget.onSelected();
    } else {
      widget.onUnSelected();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: _toggleSelection,
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isSelected ? widget.filledIcon : widget.icon,
                color: AppColors.mainColor.withOpacity(0.5),
              ),
              Text(widget.text),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WarrantyElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isEnabled;
  const WarrantyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
          ),
          onPressed: isEnabled ? onPressed : null,
          child: Center(
            child: Text(
              text,
            ),
          ),
        ),
      ),
    );
  }
}

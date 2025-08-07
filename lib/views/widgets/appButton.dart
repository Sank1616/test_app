import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onClick;
  final bool enabled;
  final Color? disabledColor;
  final Color? disabledTextColor;

  const AppButton({
    super.key,
    required this.label,
    required this.onClick,
    this.enabled = true,
    this.disabledColor,
    this.disabledTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && onClick != null;
    final backgroundColor = isEnabled
        ? appDefaultColor
        : (disabledColor ?? appDefaultColor.withOpacity(0.5));
    final textColor = isEnabled
        ? Colors.white
        : (disabledTextColor ?? Colors.white.withOpacity(0.7));

    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
        onPressed: isEnabled ? onClick : null,
        style: ElevatedButton.styleFrom(
          overlayColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
        ),
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 15,
            letterSpacing: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
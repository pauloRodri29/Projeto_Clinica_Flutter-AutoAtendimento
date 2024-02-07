import 'package:clinica/clinica.dart';
import 'package:flutter/material.dart';

class IconPopupMenu extends StatelessWidget {
  const IconPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 64),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ClinicaThemes.orangeColor, width: 2),
        ),
        child: const Icon(
          Icons.more_horiz_rounded,
          color: ClinicaThemes.orangeColor,
        ),
      ),
    );
  }
}

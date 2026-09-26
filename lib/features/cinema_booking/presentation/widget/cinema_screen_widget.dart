import 'package:flutter/material.dart';

class CinemaScreenWidget extends StatelessWidget {
  const CinemaScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 12),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'SCREEN',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
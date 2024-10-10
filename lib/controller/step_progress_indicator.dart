import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;

  StepProgressIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(value: currentStep / 7),
        SizedBox(height: 10),
        Text('Question $currentStep of 7'),
      ],
    );
  }
}
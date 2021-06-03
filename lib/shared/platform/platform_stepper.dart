import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PlatformStepper extends PlatformWidgetBase<CupertinoStepper, Stepper> {
  final List<Step> steps;
  final int? currentStep;
  final StepperType? type;
  final controlsBuilder;
  final onStepContinue;
  final onStepCancel;

  const PlatformStepper({
    Key? key,
    required this.steps,
    this.currentStep,
    this.type,
    this.controlsBuilder,
    this.onStepContinue,
    this.onStepCancel,
  });

  @override
  CupertinoStepper createCupertinoWidget(BuildContext context) {
    return CupertinoStepper(
      steps: steps,
      type: type!,
      currentStep: currentStep!,
      controlsBuilder: controlsBuilder,
      onStepContinue: onStepContinue,
      onStepCancel: onStepCancel,
    );
  }

  @override
  Stepper createMaterialWidget(BuildContext context) {
    return Stepper(
      currentStep: currentStep!,
      type: type!,
      steps: steps,
      controlsBuilder: controlsBuilder,
      onStepContinue: onStepContinue,
      onStepCancel: onStepCancel,
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String NoteValueKey = 'note';

final Map<String, TextEditingController>
    _BookAppointmentViewTextEditingControllers = {};

final Map<String, FocusNode> _BookAppointmentViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _BookAppointmentViewTextValidations = {
  NoteValueKey: null,
};

mixin $BookAppointmentView {
  TextEditingController get noteController =>
      _getFormTextEditingController(NoteValueKey);
  FocusNode get noteFocusNode => _getFormFocusNode(NoteValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_BookAppointmentViewTextEditingControllers.containsKey(key)) {
      return _BookAppointmentViewTextEditingControllers[key]!;
    }

    _BookAppointmentViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _BookAppointmentViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_BookAppointmentViewFocusNodes.containsKey(key)) {
      return _BookAppointmentViewFocusNodes[key]!;
    }
    _BookAppointmentViewFocusNodes[key] = FocusNode();
    return _BookAppointmentViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    noteController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    noteController.addListener(() => _updateFormData(model));
  }

  static const bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NoteValueKey: noteController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _BookAppointmentViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _BookAppointmentViewFocusNodes.values) {
      focusNode.dispose();
    }

    _BookAppointmentViewTextEditingControllers.clear();
    _BookAppointmentViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get noteValue => this.formValueMap[NoteValueKey] as String?;

  set noteValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          NoteValueKey: value,
        }),
    );

    if (_BookAppointmentViewTextEditingControllers.containsKey(NoteValueKey)) {
      _BookAppointmentViewTextEditingControllers[NoteValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasNote =>
      this.formValueMap.containsKey(NoteValueKey) &&
      (noteValue?.isNotEmpty ?? false);

  bool get hasNoteValidationMessage =>
      this.fieldsValidationMessages[NoteValueKey]?.isNotEmpty ?? false;

  String? get noteValidationMessage =>
      this.fieldsValidationMessages[NoteValueKey];
}

extension Methods on FormViewModel {
  setNoteValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NoteValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    noteValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NoteValueKey: getValidationMessage(NoteValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _BookAppointmentViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _BookAppointmentViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormViewModel model) => model.setValidationMessages({
      NoteValueKey: getValidationMessage(NoteValueKey),
    });

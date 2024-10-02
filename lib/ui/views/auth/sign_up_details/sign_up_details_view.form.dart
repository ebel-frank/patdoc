// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String FirstNameValueKey = 'firstName';
const String LastNameValueKey = 'lastName';
const String PhoneNumberValueKey = 'phoneNumber';
const String YearValueKey = 'year';
const String DayValueKey = 'day';
const String TokenValueKey = 'token';

final Map<String, TextEditingController>
    _SignUpDetailsViewTextEditingControllers = {};

final Map<String, FocusNode> _SignUpDetailsViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _SignUpDetailsViewTextValidations = {
  FirstNameValueKey: null,
  LastNameValueKey: null,
  PhoneNumberValueKey: null,
  YearValueKey: null,
  DayValueKey: null,
  TokenValueKey: null,
};

mixin $SignUpDetailsView {
  TextEditingController get firstNameController =>
      _getFormTextEditingController(FirstNameValueKey);
  TextEditingController get lastNameController =>
      _getFormTextEditingController(LastNameValueKey);
  TextEditingController get phoneNumberController =>
      _getFormTextEditingController(PhoneNumberValueKey);
  TextEditingController get yearController =>
      _getFormTextEditingController(YearValueKey);
  TextEditingController get dayController =>
      _getFormTextEditingController(DayValueKey);
  TextEditingController get tokenController =>
      _getFormTextEditingController(TokenValueKey);
  FocusNode get firstNameFocusNode => _getFormFocusNode(FirstNameValueKey);
  FocusNode get lastNameFocusNode => _getFormFocusNode(LastNameValueKey);
  FocusNode get phoneNumberFocusNode => _getFormFocusNode(PhoneNumberValueKey);
  FocusNode get yearFocusNode => _getFormFocusNode(YearValueKey);
  FocusNode get dayFocusNode => _getFormFocusNode(DayValueKey);
  FocusNode get tokenFocusNode => _getFormFocusNode(TokenValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_SignUpDetailsViewTextEditingControllers.containsKey(key)) {
      return _SignUpDetailsViewTextEditingControllers[key]!;
    }

    _SignUpDetailsViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _SignUpDetailsViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_SignUpDetailsViewFocusNodes.containsKey(key)) {
      return _SignUpDetailsViewFocusNodes[key]!;
    }
    _SignUpDetailsViewFocusNodes[key] = FocusNode();
    return _SignUpDetailsViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    firstNameController.addListener(() => _updateFormData(model));
    lastNameController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));
    yearController.addListener(() => _updateFormData(model));
    dayController.addListener(() => _updateFormData(model));
    tokenController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    firstNameController.addListener(() => _updateFormData(model));
    lastNameController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));
    yearController.addListener(() => _updateFormData(model));
    dayController.addListener(() => _updateFormData(model));
    tokenController.addListener(() => _updateFormData(model));
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
          FirstNameValueKey: firstNameController.text,
          LastNameValueKey: lastNameController.text,
          PhoneNumberValueKey: phoneNumberController.text,
          YearValueKey: yearController.text,
          DayValueKey: dayController.text,
          TokenValueKey: tokenController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _SignUpDetailsViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _SignUpDetailsViewFocusNodes.values) {
      focusNode.dispose();
    }

    _SignUpDetailsViewTextEditingControllers.clear();
    _SignUpDetailsViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get firstNameValue => this.formValueMap[FirstNameValueKey] as String?;
  String? get lastNameValue => this.formValueMap[LastNameValueKey] as String?;
  String? get phoneNumberValue =>
      this.formValueMap[PhoneNumberValueKey] as String?;
  String? get yearValue => this.formValueMap[YearValueKey] as String?;
  String? get dayValue => this.formValueMap[DayValueKey] as String?;
  String? get tokenValue => this.formValueMap[TokenValueKey] as String?;

  set firstNameValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          FirstNameValueKey: value,
        }),
    );

    if (_SignUpDetailsViewTextEditingControllers.containsKey(
        FirstNameValueKey)) {
      _SignUpDetailsViewTextEditingControllers[FirstNameValueKey]?.text =
          value ?? '';
    }
  }

  set lastNameValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          LastNameValueKey: value,
        }),
    );

    if (_SignUpDetailsViewTextEditingControllers.containsKey(
        LastNameValueKey)) {
      _SignUpDetailsViewTextEditingControllers[LastNameValueKey]?.text =
          value ?? '';
    }
  }

  set phoneNumberValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          PhoneNumberValueKey: value,
        }),
    );

    if (_SignUpDetailsViewTextEditingControllers.containsKey(
        PhoneNumberValueKey)) {
      _SignUpDetailsViewTextEditingControllers[PhoneNumberValueKey]?.text =
          value ?? '';
    }
  }

  set yearValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          YearValueKey: value,
        }),
    );

    if (_SignUpDetailsViewTextEditingControllers.containsKey(YearValueKey)) {
      _SignUpDetailsViewTextEditingControllers[YearValueKey]?.text =
          value ?? '';
    }
  }

  set dayValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          DayValueKey: value,
        }),
    );

    if (_SignUpDetailsViewTextEditingControllers.containsKey(DayValueKey)) {
      _SignUpDetailsViewTextEditingControllers[DayValueKey]?.text = value ?? '';
    }
  }

  set tokenValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          TokenValueKey: value,
        }),
    );

    if (_SignUpDetailsViewTextEditingControllers.containsKey(TokenValueKey)) {
      _SignUpDetailsViewTextEditingControllers[TokenValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasFirstName =>
      this.formValueMap.containsKey(FirstNameValueKey) &&
      (firstNameValue?.isNotEmpty ?? false);
  bool get hasLastName =>
      this.formValueMap.containsKey(LastNameValueKey) &&
      (lastNameValue?.isNotEmpty ?? false);
  bool get hasPhoneNumber =>
      this.formValueMap.containsKey(PhoneNumberValueKey) &&
      (phoneNumberValue?.isNotEmpty ?? false);
  bool get hasYear =>
      this.formValueMap.containsKey(YearValueKey) &&
      (yearValue?.isNotEmpty ?? false);
  bool get hasDay =>
      this.formValueMap.containsKey(DayValueKey) &&
      (dayValue?.isNotEmpty ?? false);
  bool get hasToken =>
      this.formValueMap.containsKey(TokenValueKey) &&
      (tokenValue?.isNotEmpty ?? false);

  bool get hasFirstNameValidationMessage =>
      this.fieldsValidationMessages[FirstNameValueKey]?.isNotEmpty ?? false;
  bool get hasLastNameValidationMessage =>
      this.fieldsValidationMessages[LastNameValueKey]?.isNotEmpty ?? false;
  bool get hasPhoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey]?.isNotEmpty ?? false;
  bool get hasYearValidationMessage =>
      this.fieldsValidationMessages[YearValueKey]?.isNotEmpty ?? false;
  bool get hasDayValidationMessage =>
      this.fieldsValidationMessages[DayValueKey]?.isNotEmpty ?? false;
  bool get hasTokenValidationMessage =>
      this.fieldsValidationMessages[TokenValueKey]?.isNotEmpty ?? false;

  String? get firstNameValidationMessage =>
      this.fieldsValidationMessages[FirstNameValueKey];
  String? get lastNameValidationMessage =>
      this.fieldsValidationMessages[LastNameValueKey];
  String? get phoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey];
  String? get yearValidationMessage =>
      this.fieldsValidationMessages[YearValueKey];
  String? get dayValidationMessage =>
      this.fieldsValidationMessages[DayValueKey];
  String? get tokenValidationMessage =>
      this.fieldsValidationMessages[TokenValueKey];
}

extension Methods on FormViewModel {
  setFirstNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FirstNameValueKey] = validationMessage;
  setLastNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[LastNameValueKey] = validationMessage;
  setPhoneNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneNumberValueKey] = validationMessage;
  setYearValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[YearValueKey] = validationMessage;
  setDayValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DayValueKey] = validationMessage;
  setTokenValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TokenValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    firstNameValue = '';
    lastNameValue = '';
    phoneNumberValue = '';
    yearValue = '';
    dayValue = '';
    tokenValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      FirstNameValueKey: getValidationMessage(FirstNameValueKey),
      LastNameValueKey: getValidationMessage(LastNameValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
      YearValueKey: getValidationMessage(YearValueKey),
      DayValueKey: getValidationMessage(DayValueKey),
      TokenValueKey: getValidationMessage(TokenValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _SignUpDetailsViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _SignUpDetailsViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormViewModel model) => model.setValidationMessages({
      FirstNameValueKey: getValidationMessage(FirstNameValueKey),
      LastNameValueKey: getValidationMessage(LastNameValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
      YearValueKey: getValidationMessage(YearValueKey),
      DayValueKey: getValidationMessage(DayValueKey),
      TokenValueKey: getValidationMessage(TokenValueKey),
    });

import 'package:flutter/widgets.dart';
import 'package:patdoc/ui/shared/dialogs/appointment_success_dialog.dart';
import 'package:patdoc/utils/enums.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialog() {
  final builders = {
    DialogType.appointmentSuccess: (BuildContext context, DialogRequest request,
            Function(DialogResponse) completer) =>
        AppointmentSuccessDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

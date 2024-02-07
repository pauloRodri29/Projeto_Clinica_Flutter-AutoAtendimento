import 'dart:async';
import 'dart:developer';

import 'package:clinica/clinica.dart';
import 'package:fe_lab_clinica_self_service/src/binding/clinica_application_binding.dart';
import 'package:fe_lab_clinica_self_service/src/modules/auth/auth_module.dart';
import 'package:fe_lab_clinica_self_service/src/modules/home/home_module.dart';
import 'package:fe_lab_clinica_self_service/src/modules/self_service/self_service_module.dart';
import 'package:fe_lab_clinica_self_service/src/pages/splash_pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

//terminal1@gmail.com
void main() {
  runZonedGuarded(() => {runApp(const LabClinicaSelfService())},
      (error, stack) {
    log('Erro não tratado: ', error: error, stackTrace: stack);
    throw error;
  });
}

class LabClinicaSelfService extends StatelessWidget {
  const LabClinicaSelfService({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicaCoreConfig(
      binding: ClinicaApplicationBinding(),
      title: 'Clinica Auto Atendimento',
      pagesBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/') 
      ],
      modules: [AuthModule(), HomeModule(), SelfServiceModule()],
    );
  }
}

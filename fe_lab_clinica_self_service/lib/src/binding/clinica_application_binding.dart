import 'package:clinica/clinica.dart';
import 'package:fe_lab_clinica_self_service/src/core/env.dart';
import 'package:flutter_getit/flutter_getit.dart';

class ClinicaApplicationBinding extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton<RestClient>(
          (i) => RestClient(
            Env.backendBaseUrl,
          ),
        ),
      ];
}

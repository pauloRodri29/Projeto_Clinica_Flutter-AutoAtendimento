import 'package:brasil_fields/brasil_fields.dart';
import 'package:clinica/clinica.dart';
import 'package:fe_lab_clinica_self_service/src/modules/self_service/find_patient/find_patient_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class FindPatientPage extends StatefulWidget {
  const FindPatientPage({super.key});

  @override
  State<FindPatientPage> createState() => _FindPatientPageState();
}

class _FindPatientPageState extends State<FindPatientPage>
    with MessagesViewMixin {
  final formKey = GlobalKey<FormState>();
  final cpfController = TextEditingController();
  final controller = Injector.get<FindPatientController>();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      final FindPatientController(:patient, :patientNotFound) = controller;

      if (patient != null || patientNotFound != null) {
        print("Paciente: ${patient != null}");
        print("Paciente não encontrado: ${patientNotFound != null}");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ClinicaAppBar(
          actions: [
            PopupMenuButton(
              child: const IconPopupMenu(),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Reiniciar Processo'),
                  ),
                ];
              },
              onSelected: (value) async {
                if (value == 1) {}
              },
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (_, constrains) {
            var sizeOf = MediaQuery.sizeOf(context);
            return SingleChildScrollView(
              child: Container(
                  constraints: BoxConstraints(
                    minHeight: constrains.maxHeight,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background_login.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      width: sizeOf.width * .8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Image.asset('assets/images/logo_vertical.png'),
                            const SizedBox(
                              height: 48,
                            ),
                            TextFormField(
                              controller: cpfController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter()
                              ],
                              validator:
                                  Validatorless.required("CPF é obrigatório"),
                              decoration: const InputDecoration(
                                label: Text('Digite o CPF do paciente'),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Não sabe o CPF do paciente',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ClinicaThemes.blueColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Clique aqui',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ClinicaThemes.orangeColor),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            SizedBox(
                              width: sizeOf.width * .8,
                              height: 48,
                              child: ElevatedButton(
                                  onPressed: () {
                                    final valid =
                                        formKey.currentState?.validate() ??
                                            false;

                                    if (valid) {
                                      controller.findPatientByDocument(
                                          cpfController.text);
                                    }
                                  },
                                  child: const Text('CONTINUAR')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          },
        ));
  }
}

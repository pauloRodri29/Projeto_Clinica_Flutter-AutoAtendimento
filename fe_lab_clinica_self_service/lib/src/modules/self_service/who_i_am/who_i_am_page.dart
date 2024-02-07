import 'package:clinica/clinica.dart';
import 'package:fe_lab_clinica_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class WhoIAmPage extends StatefulWidget {
  const WhoIAmPage({super.key});

  @override
  State<WhoIAmPage> createState() => _WhoIAmPageState();
}

class _WhoIAmPageState extends State<WhoIAmPage> {
  final selfServiceController = Injector.get<SelfServiceController>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        nameController.text = '';
        lastNameController.text = '';
        selfServiceController.clearForm();
      },
      child: Scaffold(
          appBar: ClinicaAppBar(
            actions: [
              PopupMenuButton(
                child: const IconPopupMenu(),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Finalizar Terminal'),
                    ),
                  ];
                },
                onSelected: (value) async {
                  if (value == 1) {
                    final nav = Navigator.of(context);
                    await SharedPreferences.getInstance()
                        .then((value) => value.clear());
                    nav.pushNamedAndRemoveUntil('/', (route) => false);
                  }
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
                          image:
                              AssetImage('assets/images/background_login.png'),
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
                              const Text(
                                'Bem Vindo!',
                                style: ClinicaThemes.titleStyle,
                              ),
                              const SizedBox(
                                height: 48,
                              ),
                              TextFormField(
                                controller: nameController,
                                validator: Validatorless.required(
                                    "Nome é obrigatório"),
                                decoration: const InputDecoration(
                                  label: Text('Digite seu nome'),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: lastNameController,
                                validator: Validatorless.required(
                                    "Sobrenome é obrigatório"),
                                decoration: const InputDecoration(
                                  label: Text('Digite seu Sobrenome'),
                                ),
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
                                        selfServiceController
                                            .setWhoIAmDataStepAndNext(
                                                nameController.text,
                                                lastNameController.text);
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
          )),
    );
  }
}

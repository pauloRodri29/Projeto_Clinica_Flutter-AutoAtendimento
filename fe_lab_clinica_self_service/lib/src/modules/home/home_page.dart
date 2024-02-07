import 'package:clinica/clinica.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: ClinicaAppBar(
          actions: [
            PopupMenuButton<int>(
                child: const IconPopupMenu(),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text('Inicicar terminal'),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text('Finalizar terminal'),
                    ),
                  ];
                }),
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 112),
            padding: const EdgeInsets.all(40),
            width: sizeOf.width * .8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ClinicaThemes.orangeColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Bem Vindo!",
                  style: ClinicaThemes.titleStyle,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: sizeOf.width * .8,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/self-service');
                      },
                      child: const Text("INICIAR TERMINAL")),
                )
              ],
            ),
          ),
        ));
  }
}

import 'package:asyncstate/asyncstate.dart';
import 'package:clinica/src/loader/clinica_loader.dart';
import 'package:clinica/src/themes/clinica_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class ClinicaCoreConfig extends StatelessWidget {
  const ClinicaCoreConfig(
      {super.key,
      this.binding,
      this.pages,
      this.pagesBuilders,
      this.modules,
      required this.title});

  final ApplicationBindings? binding;
  final List<FlutterGetItPageRouter>? pages;
  final List<FlutterGetItPageBuilder>? pagesBuilders;
  final List<FlutterGetItModule>? modules;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
        debugMode: true,
        bindings: binding,
        modules: modules,
        pages: [...pages ?? [], ...pagesBuilders ?? []],
        builder: ((
          context,
          routes,
          flutterGetItNavObserver,
        ) {
          return AsyncStateBuilder(
              loader: ClinicaLoader(),
              builder: (navigatorObserver) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ClinicaThemes.lightTheme,
                  darkTheme: ClinicaThemes.darkTheme,
                  navigatorObservers: [
                    navigatorObserver,
                    flutterGetItNavObserver
                  ],
                  routes: routes,
                  title: title,
                );
              });
        }));
  }
}

import 'package:clinica/clinica.dart';
import 'package:fe_lab_clinica_self_service/src/model/patient_model.dart';
import 'package:fe_lab_clinica_self_service/src/repositories/patients/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FindPatientController with MessageStateMixin {
  FindPatientController({required PatientRepository patientRepository})
      : _patientRepository = patientRepository;
  final PatientRepository _patientRepository;

  final _patientNotFound = ValueSignal<bool?>(null);
  final _patient = ValueSignal<PatientModel?>(null);

  bool? get patientNotFound => _patientNotFound.value;
  PatientModel? get patient => _patient.value;

  Future<void> findPatientByDocument(String document) async {
    final patientResult =
        await _patientRepository.findPatientByDocument(document);

    bool patientNotFound;
    PatientModel? patient;

    switch (patientResult) {
      case Right(value: PatientModel model?):
        patientNotFound = false;
        patient = model;
      case Right(value: _):
        patientNotFound = true;
        patient = null;
      case Left():
        showError('Error ao buscar paciente');
        return;
    }

    batch(() {
      _patient.forceUpdate(patient);
      _patientNotFound.forceUpdate(patientNotFound);
    });
  }
}

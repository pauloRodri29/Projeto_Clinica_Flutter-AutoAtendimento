import 'package:clinica/clinica.dart';
import 'package:fe_lab_clinica_self_service/src/model/patient_model.dart';

abstract interface class PatientRepository {
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(
      String document);
}

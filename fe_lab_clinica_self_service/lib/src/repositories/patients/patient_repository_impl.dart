import 'dart:developer';

import 'package:clinica/clinica.dart';
import 'package:dio/dio.dart';
import 'package:fe_lab_clinica_self_service/src/model/patient_model.dart';
import './patient_repository.dart';

class PatientRepositoryImpl implements PatientRepository {
  PatientRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(
      String document) async {
    try {
      final Response(:List data) = await restClient.auth
          .get('/patients', queryParameters: {'document': document});

      if (data.isEmpty) {
        return Right(null);
      }

      return Right(PatientModel.fromJson(data.first));
      
    } on DioException catch (e, s) {
      log('Erro ao buscar cliente pelo CPF', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}

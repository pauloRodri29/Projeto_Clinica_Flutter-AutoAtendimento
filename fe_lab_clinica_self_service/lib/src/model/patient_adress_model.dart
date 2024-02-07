import 'package:json_annotation/json_annotation.dart';

part 'patient_adress_model.g.dart';

@JsonSerializable()
class PatientAdressModel {
  PatientAdressModel({
    required this.cep,
    required this.streetAddress,
    required this.state,
    required this.city,
    required this.district,
  });

  final String cep;
  @JsonKey(name: 'street_address')
  final String streetAddress;
  final String state;
  final String city;
  final String district;

  factory PatientAdressModel.fromJson(Map<String, dynamic> json) =>
      _$PatientAdressModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAdressModelToJson(this);
}

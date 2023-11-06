
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CuentaModelo {
  CuentaModelo({
    required this.id,
    required this.nombre,
    required this.cajas,
  });

  CuentaModelo.unlaunched();

  late  int id=0;
  late final String nombre;
  late List<CajaRModelo> cajas;

  CuentaModelo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nombre = json['nombre'];
    if (json['cajas'] != null) {
      cajas = (json['cajas'] as List).map((e) =>
          CajaRModelo.fromJson(e as Map<String, dynamic>)).toList();
    }else{ cajas=[]; }
  }

  factory CuentaModelo.fromJsonModelo(Map<String, dynamic> json){
   return CuentaModelo(
       id : json['id'],
       nombre : json['nombre'],
       cajas: []
   );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombre'] = nombre;
    if (this.cajas != null) {
      _data['cajas'] = this.cajas.map((v) => v.toJson()).toList();
    }
    return _data;
  }
}

class CajaRModelo {
  late int id=0;
  late final String nombre;

  CajaRModelo({
    required this.id,
    required this.nombre,
  });

  factory CajaRModelo.fromJson(Map<String, dynamic> json){
    return CajaRModelo(
      id: json["id"],
      nombre: json["nombre"],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    //final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    return data;
  }


}
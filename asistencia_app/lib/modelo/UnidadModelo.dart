
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UnidadModelo {
  UnidadModelo({
    required this.id,
    required this.unidad,
    required this.cajas,
  });

  UnidadModelo.unlaunched();

  late  int id=0;
  late final String unidad;
  late List<CajaRModelo> cajas;

  UnidadModelo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    unidad = json['unidad'];
    if (json['cajas'] != null) {
      cajas = (json['cajas'] as List).map((e) =>
          CajaRModelo.fromJson(e as Map<String, dynamic>)).toList();
    }else{ cajas=[]; }
  }

  factory UnidadModelo.fromJsonModelo(Map<String, dynamic> json){
   return UnidadModelo(
       id : json['id'],
       unidad : json['unidad'],
       cajas: []
   );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['unidad'] = unidad;
    if (this.cajas != null) {
      _data['cajas'] = this.cajas.map((v) => v.toJson()).toList();
    }
    return _data;
  }
}

class CajaRModelo {
  late int id=0;
  late final String unidad;

  CajaRModelo({
    required this.id,
    required this.unidad,
  });

  factory CajaRModelo.fromJson(Map<String, dynamic> json){
    return CajaRModelo(
      id: json["id"],
      unidad: json["unidad"],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    //final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unidad'] = this.unidad;
    return data;
  }


}
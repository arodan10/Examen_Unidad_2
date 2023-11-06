
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MovimientoModelo {
  MovimientoModelo({
    required this.id,
    required this.movimiento,
    required this.cajas,
  });

  MovimientoModelo.unlaunched();

  late  int id=0;
  late final String movimiento;
  late List<CajaRModelo> cajas;

  MovimientoModelo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    movimiento = json['movimiento'];
    if (json['cajas'] != null) {
      cajas = (json['cajas'] as List).map((e) =>
          CajaRModelo.fromJson(e as Map<String, dynamic>)).toList();
    }else{ cajas=[]; }
  }

  factory MovimientoModelo.fromJsonModelo(Map<String, dynamic> json){
   return MovimientoModelo(
       id : json['id'],
       movimiento : json['movimiento'],
       cajas: []
   );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['movimiento'] = movimiento;
    if (this.cajas != null) {
      _data['cajas'] = this.cajas.map((v) => v.toJson()).toList();
    }
    return _data;
  }
}

class CajaRModelo {
  late int id=0;
  late final String movimiento;

  CajaRModelo({
    required this.id,
    required this.movimiento,
  });

  factory CajaRModelo.fromJson(Map<String, dynamic> json){
    return CajaRModelo(
      id: json["id"],
      movimiento: json["movimiento"],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    //final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['movimiento'] = this.movimiento;
    return data;
  }


}
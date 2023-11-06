import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CajaModelo {
  CajaModelo({
    required this.id,
    required this.fecha,
    required this.glosa,
    required this.cantidad,
    required this.precio,
    required this.subtotal,
    required this.unidad,
    required this.movimiento,
    required this.cuenta,
  });

  CajaModelo.unlaunched();  

  late int id = 0;
  late final String fecha;
  late final String glosa;
  late final String cantidad;
  late final String precio;
  late final String subtotal;
  late final String unidad;
  late final String movimiento;
  late final String cuenta;

  CajaModelo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fecha = json['fecha'];
    glosa = json['glosa'];
    cantidad = json['cantidad'];
    precio = json['precio'];
    subtotal = json['subtotal'];
    unidad = json['unidad'];
    movimiento = json['movimiento'];
    cuenta = json['cuenta'];
    
  }

  factory CajaModelo.fromJsonModelo(Map<String, dynamic> json) {
    return CajaModelo(
      id: json['id'],
      fecha: json['fecha'],
      glosa: json['glosa'],
      cantidad: json['cantidad'],
      precio: json['precio'],
      subtotal: json['subtotal'],
      unidad: json['unidad'],
      movimiento: json['movimiento'],
      cuenta: json['cuenta'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fecha'] = fecha;
    _data['glosa'] = glosa;
    _data['cantidad'] = cantidad;
    _data['precio'] = precio;
    _data['subtotal'] = subtotal;
    _data['unidad'] = unidad;
    _data['movimiento'] = movimiento;
    _data['cuenta'] = cuenta;
    return _data;
  }
}
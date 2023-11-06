part of 'caja_bloc.dart';

@immutable
abstract class CajaEvent {}
class ListarCajaEvent extends CajaEvent{
  ListarCajaEvent(){print("Evento si");}
//ListarActividadEvent({required ActividadModelo actividad}):super(actividad:actividad);
}
class DeleteCajaEvent extends CajaEvent{
  CajaModelo caja;
  DeleteCajaEvent(this.caja);
//DeleteActividadEvent({required ActividadModelo actividad}):super(actividad:actividad);
}
class UpdateCajaEvent extends CajaEvent{
  CajaModelo caja;
  UpdateCajaEvent(this.caja);
//UpdateActividadEvent({required ActividadModelo actividad}):super(actividad:actividad);
}
class CreateCajaEvent extends CajaEvent{
  CajaModelo caja;
  CreateCajaEvent(this.caja);
//CreateActividadEvent({required ActividadModelo actividad}):super(actividad:actividad);
}

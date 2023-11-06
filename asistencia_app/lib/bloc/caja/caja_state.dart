part of 'caja_bloc.dart';

@immutable
abstract class CajaState {}

class CajaInitialState extends CajaState {}
class CajaLoadingState extends CajaState{}
class CajaLoadedState extends CajaState{
  List<CajaModelo> CajaList;
  CajaLoadedState(this.CajaList);
}
class CajaError extends CajaState{
  Error e;
  CajaError(this.e);
}

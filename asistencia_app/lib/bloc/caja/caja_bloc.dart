import 'dart:async';

import 'package:asistencia_app/modelo/CajaModelo.dart';
import 'package:asistencia_app/repository/CajaRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'caja_event.dart';
part 'caja_state.dart';

class CajaBloc extends Bloc<CajaEvent, CajaState> {
  late final CajaRepository _cajaRepository;
  CajaBloc(this._cajaRepository) : super(CajaInitialState()) {
    on<CajaEvent>((event, emit) async{
      // TODO: implement event handler
      print("Bloc x");
      if(event is ListarCajaEvent){
        emit(CajaLoadingState());
        try{
          print("pasox!!");
          List<CajaModelo> CajaList= await _cajaRepository.getCaja();
          emit(CajaLoadedState(CajaList));
        } catch(e){
          emit(CajaError(e as Error)) ;
        }
      }else if(event is DeleteCajaEvent){
        try{
          await _cajaRepository.deleteCaja(event.caja!.id);
          emit(CajaLoadingState());
          List<CajaModelo> CajaList= await _cajaRepository.getCaja();
          emit(CajaLoadedState(CajaList));
        }catch(e){
          emit(CajaError(e as Error));
        }
      }else if(event is CreateCajaEvent){
        try{
          await _cajaRepository.createCaja(event.caja!);
          emit(CajaLoadingState());
          List<CajaModelo> CajaList= await _cajaRepository.getCaja();
          emit(CajaLoadedState(CajaList));
        }catch(e){
          emit(CajaError(e as Error));
        }
      }else if(event is UpdateCajaEvent){
        try{
          await _cajaRepository.updateCaja(event.caja!.id, event.caja!);
          emit(CajaLoadingState());
          List<CajaModelo> CajaList= await _cajaRepository.getCaja();
          emit(CajaLoadedState(CajaList));
        }catch(e){
          emit(CajaError(e as Error));
        }
      }
    });
  }
}


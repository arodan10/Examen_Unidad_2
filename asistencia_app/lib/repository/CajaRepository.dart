import 'package:asistencia_app/apis/caja_api.dart';
import 'package:asistencia_app/modelo/CajaModelo.dart';
import 'package:asistencia_app/modelo/GenericModelo.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:dio/dio.dart';
class CajaRepository {
  CajaApi? cajaApi;

  CajaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    cajaApi = CajaApi(_dio);
  }

  Future<List<CajaModelo>> getCaja() async {
    var dato = await cajaApi!.getCaja(TokenUtil.TOKEN).then((
        value) => value);
    return await dato;
  }

  Future<GenericModelo> deleteCaja(int id) async {
    return await cajaApi!.deleteCaja(TokenUtil.TOKEN, id);
  }

  Future<CajaModelo> updateCaja(int id,
      CajaModelo caja) async {
    return await cajaApi!.updateCaja(TokenUtil.TOKEN, id, caja);
  }

  Future<CajaModelo> createCaja(CajaModelo caja) async {
    return await cajaApi!.crearCaja(TokenUtil.TOKEN, caja);
  }
}
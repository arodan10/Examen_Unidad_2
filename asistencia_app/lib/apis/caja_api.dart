
import 'package:asistencia_app/modelo/CajaModelo.dart';
import 'package:asistencia_app/modelo/GenericModelo.dart';
import 'package:asistencia_app/util/UrlApi.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

part 'caja_api.g.dart';
@RestApi(baseUrl: UrlApi.urlApix)
abstract class CajaApi {
  factory CajaApi(Dio dio, {String baseUrl}) = _CajaApi;

  static CajaApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return CajaApi(dio);
  }

  @GET("/asis/caja/list")
  Future<List<CajaModelo>> getCaja(@Header("Authorization") String token);

  @POST("/asis/caja/crear")
  Future<CajaModelo> crearCaja(@Header("Authorization") String token, @Body() CajaModelo caja);

  @GET("/asis/caja/buscar/{id}")
  Future<CajaModelo> findCaja(@Header("Authorization") String token, @Path("id") int id);

  @DELETE("/asis/caja/eliminar/{id}")
  Future<GenericModelo> deleteCaja(@Header("Authorization") String token, @Path("id") int id);

  @PUT("/asis/caja/editar/{id}")
  Future<CajaModelo> updateCaja(@Header("Authorization") String token, @Path("id") int id , @Body() CajaModelo caja);
}
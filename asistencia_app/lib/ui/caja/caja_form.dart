import 'package:asistencia_app/apis/caja_api.dart';
import 'package:asistencia_app/bloc/caja/caja_bloc.dart';
import 'package:asistencia_app/comp/DropDownFormField.dart';
import 'package:asistencia_app/modelo/CajaModelo.dart';
import 'package:asistencia_app/theme/AppTheme.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CajaForm extends StatefulWidget {
  @override
  _CajaFormState createState() => _CajaFormState();
}

class _CajaFormState extends State<CajaForm> {
  TextEditingController _fecha = new TextEditingController();
  DateTime? selectedDate;

  late String _glosa = "";
  late String _cantidad = "";
  late String _precio = "";
  late String _subtotal = "";
  late String _unidad = "L";
  late String _movimiento = "I";
  late String _cuenta = "C";
  var _data = [];

  List<Map<String, String>> listaTipo = [
    {'value': 'I', 'display': 'Ingreso'},
    {'value': 'E', 'display': 'Egreso'}
  ];

  List<Map<String, String>> listaCuenta = [
    {'value': 'E', 'display': 'Efectivo'},
    {'value': 'T', 'display': 'Tarjeta'}
  ];

  List<Map<String, String>> listaEva = [
    {'value': 'L', 'display': 'Litro'},
    {'value': 'K', 'display': 'Kilo'},
    {'value': 'U', 'display': 'Unidad'},
  ];

  @override
  void initState() {
    super.initState();
    print("ver: ${listaTipo.map((item) => item['value']).toList()}");
    print("verv: ${listaTipo.map((item) => item['display']).toList()}");
  }

  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );

  void capturaGlosa(valor) {
    this._glosa = valor;
  }

  void capturaCantidad(valor) {
    this._cantidad = valor;
  }

  void capturaPrecio(valor) {
    this._precio = valor;
  }

  void capturaSubTotal(valor) {
    this._subtotal = valor;
  }

  void capturaFecha(valor) {
    this._fecha.text = valor;
  }

  void capturaMovimiento(valor) {
    this._movimiento = valor;
  }

  void capturaUnidad(valor) {
    this._unidad = valor;
  }

  void capturaCuenta(valor) {
    this._cuenta = valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Caja B"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              //color: AppTheme.nearlyWhite,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildDatoLista(capturaMovimiento, _movimiento,
                        "Tipo Mov.:", listaTipo),
                    _buildDatoFecha(capturaFecha, "Fecha"),
                    _buildDatoCadena(capturaGlosa, "Glosa:"),
                    _buildDatoCadena(capturaCantidad, "Cantidad:"),
                    _buildDatoCadena(capturaPrecio, "Precio:"),
                    _buildDatoCadena(capturaSubTotal, "Subtotal:"),
                    _buildDatoLista(
                        capturaCuenta, _cuenta, "Cuenta:", listaCuenta),
                    _buildDatoLista(
                        capturaUnidad, _unidad, "Unidad:", listaEva),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Cancelar')),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                                _formKey.currentState!.save();
                                CajaModelo mp = new CajaModelo.unlaunched();
                                mp.movimiento = _movimiento;
                                mp.fecha = DateFormat('yyyy-MM-dd')
                                    .format(DateTime.parse(_fecha.value.text));
                                mp.glosa = _glosa;
                                mp.cantidad = _cantidad;
                                mp.precio = _precio;
                                mp.subtotal = _subtotal;
                                mp.cuenta = _cuenta;
                                mp.unidad = _unidad;

                                print(
                                    "M:${_movimiento}, F:${_fecha.value.text}, G:${_glosa}, "
                                    "CA:${_cantidad} P:${_precio} ST:${_subtotal} "
                                    "F:${_cuenta} HI:${_unidad}");

                                var api = await Provider.of<CajaApi>(
                                        context,
                                        listen: false)
                                    .crearCaja(TokenUtil.TOKEN, mp);
                                print("ver: ${api.toJson()}");
                                if (api.toJson() != null) {
                                  Navigator.pop(context, () {
                                    setState(() {});
                                  });
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No estan bien los datos de los campos!'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }

  Widget _buildDatoEntero(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Id es campo Requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(int.parse(value!));
      },
    );
  }

  Widget _buildDatoCadena(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }

  Widget _buildDatoLista(
      Function obtValor, _dato, String label, List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: _dato,
      onSaved: (value) {
        setState(() {
          obtValor(value);
        });
      },
      onChanged: (value) {
        setState(() {
          obtValor(value);
        });
      },
      dataSource: listaDato,
      textField: 'display',
      valueField: 'value',
    );
  }

  Future<void> _selectDate(BuildContext context, Function obtValor) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        obtValor(selectedDate.toString());
      });
    }
  }

  Widget _buildDatoFecha(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: _fecha,
      keyboardType: TextInputType.datetime,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onTap: () {
        _selectDate(context, obtValor);
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }
}

import 'dart:io';

import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:asistencia_app/bloc/caja/caja_bloc.dart';
import 'package:asistencia_app/repository/CajaRepository.dart';
import 'package:asistencia_app/ui/caja/MyAppState.dart';
import 'package:asistencia_app/apis/caja_api.dart';
//import 'package:asistencia_app/apis/asistencia_api.dart';
import 'package:asistencia_app/comp/TabItem.dart';
//import 'package:asistencia_app/modelo/AsistenciapaxModelo.dart';
import 'package:asistencia_app/ui/caja/caja_edit.dart';
import 'package:asistencia_app/ui/caja/caja_form.dart';
import 'package:flutter/material.dart';
import 'package:asistencia_app/modelo/CajaModelo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:asistencia_app/theme/AppTheme.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import '../help_screen.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class MainCaja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CajaBloc(CajaRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
        theme: AppTheme.themeDataLight,
        darkTheme: AppTheme.themeDataDark,
        home: CajaUI(),
      ),
    );
  }
}

class CajaUI extends StatefulWidget {
  @override
  _CajaUIState createState() => _CajaUIState();
}

class _CajaUIState extends State<CajaUI> {
  //ApiCovid apiService;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var api;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CajaBloc>(context).add(ListarCajaEvent());
    print("entro aqui");
  }

  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();

  String text = 'Caja';
  String subject = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];

  Future onGoBack(dynamic value) async {
    setState(() {
      print(value);
    });
  }

  void accion() {
    setState(() {});
  }

  void accion2() {
    setState(() {
      print("Holaas");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeDataLight,
      darkTheme: AppTheme.themeDataDark,
      home: Scaffold(
        appBar: new AppBar(
          title: Text(
            'Lista de Cajas Bloc',
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("Si funciona");
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  //final producto=new ModeloProductos();
                  //formDialog(context, producto);
                  print("Si funciona 2");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CajaForm()),
                  ).then(onGoBack);
                },
                child: Icon(Icons.add_box_sharp),
              ),
            )
          ],
        ),
        backgroundColor: AppTheme.nearlyWhite,
        body: BlocBuilder<CajaBloc, CajaState>(
          builder: (context, state) {
            if (state is CajaLoadedState) {
              return _buildListView(context, state.CajaList);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        bottomNavigationBar: _buildBottomTab(),
        floatingActionButton: AnimatedFloatingActionButton(
          key: key,
          fabButtons: <Widget>[
            add(),
            image(),
            inbox(),
          ],
          colorStartAnimation: AppTheme.themeData.colorScheme.inversePrimary,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close,
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, List<CajaModelo> caja) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          CajaModelo cajax = caja[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                        title: Row(
                          children: [
                            Container(
                              child: Text(cajax.fecha,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            )
                          ],
                        ),
                        subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppTheme.themeData.colorScheme
                                        .primaryContainer),
                                child: Text(
                                  cajax.movimiento == "I"
                                      ? "Ingreso"
                                      : "Egreso",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppTheme.themeData.colorScheme
                                        .primaryContainer),
                                child: Text(
                                  //personax.asistenciaxs.isEmpty? personax.evaluar:personax.asistenciaxs.first.horaReg,
                                  cajax.subtotal,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ]),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/imagen/man-icon.png"),
                        ),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                        child: IconButton(
                                            icon: Icon(Icons.edit),
                                            iconSize: 24,
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CajaFormEdit(
                                                            modelA: cajax)),
                                              ).then(onGoBack);
                                            })),
                                    Expanded(
                                        child: IconButton(
                                            icon: Icon(Icons.delete),
                                            iconSize: 24,
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            //color: AppTheme.themeData.colorScheme.inversePrimary,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Mensaje de confirmacion"),
                                                      content: Text(
                                                          "Desea Eliminar?"),
                                                      actions: [
                                                        FloatingActionButton(
                                                          child: const Text(
                                                              'CANCEL'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop('Failure');
                                                          },
                                                        ),
                                                        FloatingActionButton(
                                                            child: const Text(
                                                                'ACCEPT'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      'Success');
                                                            })
                                                      ],
                                                    );
                                                  }).then((value) {
                                                if (value.toString() ==
                                                    "Success") {
                                                  print(cajax.id);
                                                  BlocProvider.of<CajaBloc>(
                                                          context)
                                                      .add(DeleteCajaEvent(
                                                          cajax));
                                                }
                                              });
                                            }))
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      child: IconButton(
                                        icon: Icon(Icons.qr_code),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MyAppQR(
                                                      modelA: cajax,
                                                    )),
                                          ).then(onGoBack);
                                        },
                                      ),
                                    ),
                                    Expanded(child: Builder(
                                      builder: (BuildContext context) {
                                        return IconButton(
                                          icon: Icon(
                                              Icons.send_and_archive_sharp),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () async {
                                          },
                                        );
                                      },
                                    ))
                                  ],
                                ),
                              )
                            ])),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: caja.length,
      ),
    );
  }

  int selectedPosition = 0;
  final tabs = ['Home', 'Profile', 'Help', 'Settings'];

  _buildBottomTab() {
    return BottomAppBar(
      //color: AppTheme.themeData.colorScheme.primaryContainer,

      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem(
            icon: Icons.menu,
            text: tabs[0],
            isSelected: selectedPosition == 0,
            onTap: () {
              setState(() {
                selectedPosition = 0;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HelpScreen();
              }));
            },
          ),
          TabItem(
            icon: Icons.person,
            text: tabs[1],
            isSelected: selectedPosition == 1,
            onTap: () {
              setState(() {
                selectedPosition = 1;
              });
            },
          ),
          TabItem(
            text: tabs[2],
            icon: Icons.help,
            isSelected: selectedPosition == 2,
            onTap: () {
              setState(() {
                selectedPosition = 2;
              });
            },
          ),
          TabItem(
            text: tabs[3],
            icon: Icons.settings,
            isSelected: selectedPosition == 3,
            onTap: () {
              setState(() {
                selectedPosition = 3;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          key.currentState?.closeFABs();
        },
        heroTag: Text("Image"),
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget image() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        heroTag: Text("Image"),
        tooltip: 'Image',
        child: Icon(Icons.image),
      ),
    );
  }

  Widget inbox() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        heroTag: Text("Inbox"),
        tooltip: 'Inbox',
        child: Icon(Icons.inbox),
      ),
    );
  }
}

import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_checkbox_group.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAlarmWidget extends StatefulWidget {
  const AddAlarmWidget({Key? key}) : super(key: key);

  @override
  _AddAlarmWidgetState createState() => _AddAlarmWidgetState();
}

class _AddAlarmWidgetState extends State<AddAlarmWidget> {
  ApiCallResponse? apiResultkvx;
  TextEditingController? phoneNumberController;
  TextEditingController? messageController;
  DateTime? datePicked1;
  DateTime? datePicked2;
  List<String>? daysOptionsValues;
  DateTime? datePicked3;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    messageController?.dispose();
    phoneNumberController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          FFLocalizations.of(context).getText(
            '78lmpjjy' /* Adicionar novo alarme */,
          ),
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Lexend Exa',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 5,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        controller: phoneNumberController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: FFLocalizations.of(context).getText(
                            'h8evsuap' /* Phone number */,
                          ),
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          hintStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDBE2E7),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDBE2E7),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                          prefixIcon: Icon(
                            Icons.phone_iphone_outlined,
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                        textAlign: TextAlign.start,
                        maxLines: null,
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  var _shouldSetState = false;
                  apiResultkvx =
                      await WhatsRememberAPIGroup.verifiqueNumberCall.call(
                    number: phoneNumberController!.text,
                  );
                  _shouldSetState = true;
                  if ((apiResultkvx?.succeeded ?? true)) {
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('Sucesso'),
                          content: Text('Sucesso'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext),
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                    if (_shouldSetState) setState(() {});
                    return;
                  } else {
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('Fail'),
                          content: Text('Fail :/'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext),
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                    if (_shouldSetState) setState(() {});
                    return;
                  }

                  if (_shouldSetState) setState(() {});
                },
                text: FFLocalizations.of(context).getText(
                  '7wndjb1l' /* Verificar Numero */,
                ),
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Lexend Exa',
                        color: Colors.white,
                      ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(),
                  child: TextFormField(
                    controller: messageController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: FFLocalizations.of(context).getText(
                        'n242zr9o' /* Message send */,
                      ),
                      labelStyle: FlutterFlowTheme.of(context).bodyText2,
                      hintStyle:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFDBE2E7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFDBE2E7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                      prefixIcon: Icon(
                        Icons.message_rounded,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF1D2429),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                    maxLines: null,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: InkWell(
                        onTap: () async {
                          await DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              setState(() => datePicked1 = date);
                            },
                            currentTime: getCurrentTimestamp,
                            minTime: getCurrentTimestamp,
                            locale: LocaleType.values.firstWhere(
                              (l) =>
                                  l.name ==
                                  FFLocalizations.of(context).languageCode,
                              orElse: () => LocaleType.en,
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.44,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFCFD4DB),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  valueOrDefault<String>(
                                    dateTimeFormat(
                                      'yMMMd',
                                      datePicked1,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    'Start Date',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF57636C),
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                Icon(
                                  Icons.date_range_outlined,
                                  color: Color(0xFF57636C),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          onConfirm: (date) {
                            setState(() => datePicked2 = date);
                          },
                          currentTime: getCurrentTimestamp,
                          minTime: getCurrentTimestamp,
                          locale: LocaleType.values.firstWhere(
                            (l) =>
                                l.name ==
                                FFLocalizations.of(context).languageCode,
                            orElse: () => LocaleType.en,
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFCFD4DB),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                valueOrDefault<String>(
                                  dateTimeFormat(
                                    'yMMMd',
                                    datePicked2,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  'End Date',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Icon(
                                Icons.date_range_outlined,
                                color: Color(0xFF57636C),
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Container(
                  width: 280,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: FlutterFlowCheckboxGroup(
                    options: FFAppState().daysOptions.toList(),
                    onChanged: (val) => setState(() => daysOptionsValues = val),
                    activeColor: FlutterFlowTheme.of(context).primaryColor,
                    checkColor: Colors.white,
                    checkboxBorderColor: Color(0xFF95A1AC),
                    textStyle: FlutterFlowTheme.of(context).bodyText1,
                    initialized: daysOptionsValues != null,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        icon: Icon(
                          Icons.timer_outlined,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 30,
                        ),
                        onPressed: () async {
                          await DatePicker.showTimePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              setState(() => datePicked3 = date);
                            },
                            currentTime: getCurrentTimestamp,
                            locale: LocaleType.values.firstWhere(
                              (l) =>
                                  l.name ==
                                  FFLocalizations.of(context).languageCode,
                              orElse: () => LocaleType.en,
                            ),
                          );
                        },
                      ),
                      Text(
                        valueOrDefault<String>(
                          dateTimeFormat(
                            'Hm',
                            datePicked3,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          'Selecionar horario',
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(75, 0, 75, 0),
                child: InkWell(
                  onTap: () async {
                    final alarmesCreateData = {
                      ...createAlarmesRecordData(
                        number: phoneNumberController!.text,
                        message: messageController!.text,
                        startDate: datePicked1,
                        endDate: datePicked2,
                        hour: datePicked3,
                        mail: currentUserEmail,
                      ),
                      'days': daysOptionsValues,
                    };
                    await AlarmesRecord.collection.doc().set(alarmesCreateData);
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('Sucesso.'),
                          content: Text('Seu alarme foi salvo com sucesso.'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext),
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            '66rd6yzs' /* Salvar */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Lexend Exa',
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                              ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              borderWidth: 1,
                              buttonSize: 60,
                              icon: FaIcon(
                                FontAwesomeIcons.gavel,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 30,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

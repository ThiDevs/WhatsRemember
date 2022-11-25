import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'alarmes_record.g.dart';

abstract class AlarmesRecord
    implements Built<AlarmesRecord, AlarmesRecordBuilder> {
  static Serializer<AlarmesRecord> get serializer => _$alarmesRecordSerializer;

  String? get number;

  String? get message;

  DateTime? get data;

  DateTime? get hora;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(AlarmesRecordBuilder builder) => builder
    ..number = ''
    ..message = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('alarmes');

  static Stream<AlarmesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<AlarmesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  AlarmesRecord._();
  factory AlarmesRecord([void Function(AlarmesRecordBuilder) updates]) =
      _$AlarmesRecord;

  static AlarmesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createAlarmesRecordData({
  String? number,
  String? message,
  DateTime? data,
  DateTime? hora,
}) {
  final firestoreData = serializers.toFirestore(
    AlarmesRecord.serializer,
    AlarmesRecord(
      (a) => a
        ..number = number
        ..message = message
        ..data = data
        ..hora = hora,
    ),
  );

  return firestoreData;
}

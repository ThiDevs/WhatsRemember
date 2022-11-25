// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarmes_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AlarmesRecord> _$alarmesRecordSerializer =
    new _$AlarmesRecordSerializer();

class _$AlarmesRecordSerializer implements StructuredSerializer<AlarmesRecord> {
  @override
  final Iterable<Type> types = const [AlarmesRecord, _$AlarmesRecord];
  @override
  final String wireName = 'AlarmesRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, AlarmesRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.number;
    if (value != null) {
      result
        ..add('number')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.data;
    if (value != null) {
      result
        ..add('data')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.hora;
    if (value != null) {
      result
        ..add('hora')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  AlarmesRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AlarmesRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'data':
          result.data = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'hora':
          result.hora = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$AlarmesRecord extends AlarmesRecord {
  @override
  final String? number;
  @override
  final String? message;
  @override
  final DateTime? data;
  @override
  final DateTime? hora;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$AlarmesRecord([void Function(AlarmesRecordBuilder)? updates]) =>
      (new AlarmesRecordBuilder()..update(updates))._build();

  _$AlarmesRecord._(
      {this.number, this.message, this.data, this.hora, this.ffRef})
      : super._();

  @override
  AlarmesRecord rebuild(void Function(AlarmesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AlarmesRecordBuilder toBuilder() => new AlarmesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AlarmesRecord &&
        number == other.number &&
        message == other.message &&
        data == other.data &&
        hora == other.hora &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, number.hashCode), message.hashCode), data.hashCode),
            hora.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AlarmesRecord')
          ..add('number', number)
          ..add('message', message)
          ..add('data', data)
          ..add('hora', hora)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class AlarmesRecordBuilder
    implements Builder<AlarmesRecord, AlarmesRecordBuilder> {
  _$AlarmesRecord? _$v;

  String? _number;
  String? get number => _$this._number;
  set number(String? number) => _$this._number = number;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DateTime? _data;
  DateTime? get data => _$this._data;
  set data(DateTime? data) => _$this._data = data;

  DateTime? _hora;
  DateTime? get hora => _$this._hora;
  set hora(DateTime? hora) => _$this._hora = hora;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  AlarmesRecordBuilder() {
    AlarmesRecord._initializeBuilder(this);
  }

  AlarmesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _number = $v.number;
      _message = $v.message;
      _data = $v.data;
      _hora = $v.hora;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AlarmesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AlarmesRecord;
  }

  @override
  void update(void Function(AlarmesRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AlarmesRecord build() => _build();

  _$AlarmesRecord _build() {
    final _$result = _$v ??
        new _$AlarmesRecord._(
            number: number,
            message: message,
            data: data,
            hora: hora,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

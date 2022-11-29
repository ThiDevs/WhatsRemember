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
    value = object.startDate;
    if (value != null) {
      result
        ..add('start_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.endDate;
    if (value != null) {
      result
        ..add('end_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.hour;
    if (value != null) {
      result
        ..add('hour')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.days;
    if (value != null) {
      result
        ..add('days')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.mail;
    if (value != null) {
      result
        ..add('mail')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
        case 'start_date':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'end_date':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'hour':
          result.hour = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'days':
          result.days.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'mail':
          result.mail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final DateTime? hour;
  @override
  final BuiltList<String>? days;
  @override
  final String? mail;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$AlarmesRecord([void Function(AlarmesRecordBuilder)? updates]) =>
      (new AlarmesRecordBuilder()..update(updates))._build();

  _$AlarmesRecord._(
      {this.number,
      this.message,
      this.startDate,
      this.endDate,
      this.hour,
      this.days,
      this.mail,
      this.ffRef})
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
        startDate == other.startDate &&
        endDate == other.endDate &&
        hour == other.hour &&
        days == other.days &&
        mail == other.mail &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, number.hashCode), message.hashCode),
                            startDate.hashCode),
                        endDate.hashCode),
                    hour.hashCode),
                days.hashCode),
            mail.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AlarmesRecord')
          ..add('number', number)
          ..add('message', message)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('hour', hour)
          ..add('days', days)
          ..add('mail', mail)
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

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  DateTime? _hour;
  DateTime? get hour => _$this._hour;
  set hour(DateTime? hour) => _$this._hour = hour;

  ListBuilder<String>? _days;
  ListBuilder<String> get days => _$this._days ??= new ListBuilder<String>();
  set days(ListBuilder<String>? days) => _$this._days = days;

  String? _mail;
  String? get mail => _$this._mail;
  set mail(String? mail) => _$this._mail = mail;

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
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _hour = $v.hour;
      _days = $v.days?.toBuilder();
      _mail = $v.mail;
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
    _$AlarmesRecord _$result;
    try {
      _$result = _$v ??
          new _$AlarmesRecord._(
              number: number,
              message: message,
              startDate: startDate,
              endDate: endDate,
              hour: hour,
              days: _days?.build(),
              mail: mail,
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'days';
        _days?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AlarmesRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'Models/User.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 7956162915796090214),
      name: 'User',
      lastPropertyId: const IdUid(10, 4662988826656721794),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7669362955978532350),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7437242169782829849),
            name: 'email',
            type: 9,
            flags: 2080,
            indexId: const IdUid(1, 207139226926130311)),
        ModelProperty(
            id: const IdUid(3, 3128806733621539172),
            name: 'firstname',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 282964711990895585),
            name: 'lastname',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4170759854998259062),
            name: 'isloggedin',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 4432387898993741670),
            name: 'passwordhash',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 4577725164010207432),
            name: 'createddatetimeutc',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 1050871947858951574),
            name: 'modifieddatetimeutc',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 8787952933112411801),
            name: 'expireson',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 4662988826656721794),
            name: 'plan',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 7956162915796090214),
      lastIndexId: const IdUid(1, 207139226926130311),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    User: EntityDefinition<User>(
        model: _entities[0],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {},
        getId: (User object) => object.id,
        setId: (User object, int id) {
          object.id = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final emailOffset = fbb.writeString(object.email);
          final firstnameOffset = fbb.writeString(object.firstname);
          final lastnameOffset = fbb.writeString(object.lastname);
          final passwordhashOffset = object.passwordhash == null
              ? null
              : fbb.writeString(object.passwordhash!);
          final expiresonOffset = object.expireson == null
              ? null
              : fbb.writeString(object.expireson!);
          final planOffset =
              object.plan == null ? null : fbb.writeString(object.plan!);
          fbb.startTable(11);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, emailOffset);
          fbb.addOffset(2, firstnameOffset);
          fbb.addOffset(3, lastnameOffset);
          fbb.addBool(4, object.isloggedin);
          fbb.addOffset(5, passwordhashOffset);
          fbb.addInt64(6, object.createddatetimeutc?.millisecondsSinceEpoch);
          fbb.addInt64(7, object.modifieddatetimeutc?.millisecondsSinceEpoch);
          fbb.addOffset(8, expiresonOffset);
          fbb.addOffset(9, planOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final createddatetimeutcValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 16);
          final modifieddatetimeutcValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 18);
          final object = User(
              email:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              firstname:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              lastname:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              isloggedin: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 12, false),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0))
            ..passwordhash = const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 14)
            ..createddatetimeutc = createddatetimeutcValue == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(createddatetimeutcValue)
            ..modifieddatetimeutc = modifieddatetimeutcValue == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(modifieddatetimeutcValue)
            ..expireson = const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 20)
            ..plan = const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 22);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.id]
  static final id = QueryIntegerProperty<User>(_entities[0].properties[0]);

  /// see [User.email]
  static final email = QueryStringProperty<User>(_entities[0].properties[1]);

  /// see [User.firstname]
  static final firstname =
      QueryStringProperty<User>(_entities[0].properties[2]);

  /// see [User.lastname]
  static final lastname = QueryStringProperty<User>(_entities[0].properties[3]);

  /// see [User.isloggedin]
  static final isloggedin =
      QueryBooleanProperty<User>(_entities[0].properties[4]);

  /// see [User.passwordhash]
  static final passwordhash =
      QueryStringProperty<User>(_entities[0].properties[5]);

  /// see [User.createddatetimeutc]
  static final createddatetimeutc =
      QueryIntegerProperty<User>(_entities[0].properties[6]);

  /// see [User.modifieddatetimeutc]
  static final modifieddatetimeutc =
      QueryIntegerProperty<User>(_entities[0].properties[7]);

  /// see [User.expireson]
  static final expireson =
      QueryStringProperty<User>(_entities[0].properties[8]);

  /// see [User.plan]
  static final plan = QueryStringProperty<User>(_entities[0].properties[9]);
}

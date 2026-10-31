// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('pending'),
      ).withConverter<SyncStatus>($CategoriesTable.$convertersyncStatus);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CategoryType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CategoryType>($CategoriesTable.$convertertype);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    version,
    id,
    name,
    type,
    icon,
    color,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: $CategoriesTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: $CategoriesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
  static TypeConverter<CategoryType, String> $convertertype =
      const CategoryTypeConverter();
}

class Category extends DataClass implements Insertable<Category> {
  /// UTC epoch milliseconds when the entity was created locally.
  final int createdAt;

  /// UTC epoch milliseconds when the entity was last modified locally.
  final int updatedAt;

  /// Soft-delete tombstone (UTC epoch ms). Null if active/archived; timestamp if deleted.
  final int? deletedAt;

  /// Synchronization state with Cloud Firestore ('pending', 'synced', 'conflict').
  final SyncStatus syncStatus;

  /// Local mutation counter incremented on every write.
  final int version;

  /// Unique client-generated UUIDv4 identifier.
  final String id;

  /// User-defined category name.
  final String name;

  /// Category type ('INCOME' or 'EXPENSE').
  final CategoryType type;

  /// Optional Material icon identifier.
  final String? icon;

  /// Optional hex color string (e.g. '#RRGGBB').
  final String? color;

  /// User-facing archive toggle. Archiving hides from pickers while preserving historical transactions.
  final bool active;
  const Category({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.version,
    required this.id,
    required this.name,
    required this.type,
    this.icon,
    this.color,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    {
      map['sync_status'] = Variable<String>(
        $CategoriesTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['type'] = Variable<String>(
        $CategoriesTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['active'] = Variable<bool>(active);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      version: Value(version),
      id: Value(id),
      name: Value(name),
      type: Value(type),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      active: Value(active),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<CategoryType>(json['type']),
      icon: serializer.fromJson<String?>(json['icon']),
      color: serializer.fromJson<String?>(json['color']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<CategoryType>(type),
      'icon': serializer.toJson<String?>(icon),
      'color': serializer.toJson<String?>(color),
      'active': serializer.toJson<bool>(active),
    };
  }

  Category copyWith({
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
    SyncStatus? syncStatus,
    int? version,
    String? id,
    String? name,
    CategoryType? type,
    Value<String?> icon = const Value.absent(),
    Value<String?> color = const Value.absent(),
    bool? active,
  }) => Category(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    version: version ?? this.version,
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    icon: icon.present ? icon.value : this.icon,
    color: color.present ? color.value : this.color,
    active: active ?? this.active,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    version,
    id,
    name,
    type,
    icon,
    color,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.version == this.version &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.active == this.active);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> version;
  final Value<String> id;
  final Value<String> name;
  final Value<CategoryType> type;
  final Value<String?> icon;
  final Value<String?> color;
  final Value<bool> active;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String name,
    required CategoryType type,
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name),
       type = Value(type);
  static Insertable<Category> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? icon,
    Expression<String>? color,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? version,
    Value<String>? id,
    Value<String>? name,
    Value<CategoryType>? type,
    Value<String?>? icon,
    Value<String?>? color,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      version: version ?? this.version,
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $CategoriesTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $CategoriesTable.$convertertype.toSql(type.value),
      );
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CreditCardsTable extends CreditCards
    with TableInfo<$CreditCardsTable, CreditCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('pending'),
      ).withConverter<SyncStatus>($CreditCardsTable.$convertersyncStatus);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _issuerMeta = const VerificationMeta('issuer');
  @override
  late final GeneratedColumn<String> issuer = GeneratedColumn<String>(
    'issuer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastFourDigitsMeta = const VerificationMeta(
    'lastFourDigits',
  );
  @override
  late final GeneratedColumn<String> lastFourDigits = GeneratedColumn<String>(
    'last_four_digits',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (last_four_digits IS NULL OR last_four_digits GLOB \'[0-9][0-9][0-9][0-9]\')',
  );
  static const VerificationMeta _creditLimitMinorUnitsMeta =
      const VerificationMeta('creditLimitMinorUnits');
  @override
  late final GeneratedColumn<int> creditLimitMinorUnits = GeneratedColumn<int>(
    'credit_limit_minor_units',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (credit_limit_minor_units IS NULL OR credit_limit_minor_units >= 0)',
  );
  static const VerificationMeta _statementDayMeta = const VerificationMeta(
    'statementDay',
  );
  @override
  late final GeneratedColumn<int> statementDay = GeneratedColumn<int>(
    'statement_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (statement_day BETWEEN 1 AND 31)',
  );
  static const VerificationMeta _dueDayMeta = const VerificationMeta('dueDay');
  @override
  late final GeneratedColumn<int> dueDay = GeneratedColumn<int>(
    'due_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (due_day BETWEEN 1 AND 31)',
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    version,
    id,
    name,
    issuer,
    lastFourDigits,
    creditLimitMinorUnits,
    statementDay,
    dueDay,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditCard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('issuer')) {
      context.handle(
        _issuerMeta,
        issuer.isAcceptableOrUnknown(data['issuer']!, _issuerMeta),
      );
    } else if (isInserting) {
      context.missing(_issuerMeta);
    }
    if (data.containsKey('last_four_digits')) {
      context.handle(
        _lastFourDigitsMeta,
        lastFourDigits.isAcceptableOrUnknown(
          data['last_four_digits']!,
          _lastFourDigitsMeta,
        ),
      );
    }
    if (data.containsKey('credit_limit_minor_units')) {
      context.handle(
        _creditLimitMinorUnitsMeta,
        creditLimitMinorUnits.isAcceptableOrUnknown(
          data['credit_limit_minor_units']!,
          _creditLimitMinorUnitsMeta,
        ),
      );
    }
    if (data.containsKey('statement_day')) {
      context.handle(
        _statementDayMeta,
        statementDay.isAcceptableOrUnknown(
          data['statement_day']!,
          _statementDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statementDayMeta);
    }
    if (data.containsKey('due_day')) {
      context.handle(
        _dueDayMeta,
        dueDay.isAcceptableOrUnknown(data['due_day']!, _dueDayMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDayMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCard(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: $CreditCardsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      issuer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issuer'],
      )!,
      lastFourDigits: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_four_digits'],
      ),
      creditLimitMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_limit_minor_units'],
      ),
      statementDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}statement_day'],
      )!,
      dueDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_day'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $CreditCardsTable createAlias(String alias) {
    return $CreditCardsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class CreditCard extends DataClass implements Insertable<CreditCard> {
  /// UTC epoch milliseconds when the entity was created locally.
  final int createdAt;

  /// UTC epoch milliseconds when the entity was last modified locally.
  final int updatedAt;

  /// Soft-delete tombstone (UTC epoch ms). Null if active/archived; timestamp if deleted.
  final int? deletedAt;

  /// Synchronization state with Cloud Firestore ('pending', 'synced', 'conflict').
  final SyncStatus syncStatus;

  /// Local mutation counter incremented on every write.
  final int version;

  /// Unique client-generated UUIDv4 identifier.
  final String id;

  /// User-defined card nickname (e.g. "Millennia", "Amazon Pay ICICI").
  final String name;

  /// Card issuing bank or institution (e.g. "HDFC Bank", "ICICI").
  final String issuer;

  /// Optional display label for distinguishing cards. When provided, must be exactly 4 numeric digits.
  final String? lastFourDigits;

  /// Optional credit limit in minor currency units (signed 64-bit int).
  final int? creditLimitMinorUnits;

  /// Day of the month the statement is generated / cycle closes (1–31).
  final int statementDay;

  /// Day of the month payment is due (1–31).
  final int dueDay;

  /// User-facing archive toggle.
  final bool active;
  const CreditCard({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.version,
    required this.id,
    required this.name,
    required this.issuer,
    this.lastFourDigits,
    this.creditLimitMinorUnits,
    required this.statementDay,
    required this.dueDay,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    {
      map['sync_status'] = Variable<String>(
        $CreditCardsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['issuer'] = Variable<String>(issuer);
    if (!nullToAbsent || lastFourDigits != null) {
      map['last_four_digits'] = Variable<String>(lastFourDigits);
    }
    if (!nullToAbsent || creditLimitMinorUnits != null) {
      map['credit_limit_minor_units'] = Variable<int>(creditLimitMinorUnits);
    }
    map['statement_day'] = Variable<int>(statementDay);
    map['due_day'] = Variable<int>(dueDay);
    map['active'] = Variable<bool>(active);
    return map;
  }

  CreditCardsCompanion toCompanion(bool nullToAbsent) {
    return CreditCardsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      version: Value(version),
      id: Value(id),
      name: Value(name),
      issuer: Value(issuer),
      lastFourDigits: lastFourDigits == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFourDigits),
      creditLimitMinorUnits: creditLimitMinorUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(creditLimitMinorUnits),
      statementDay: Value(statementDay),
      dueDay: Value(dueDay),
      active: Value(active),
    );
  }

  factory CreditCard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCard(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      issuer: serializer.fromJson<String>(json['issuer']),
      lastFourDigits: serializer.fromJson<String?>(json['lastFourDigits']),
      creditLimitMinorUnits: serializer.fromJson<int?>(
        json['creditLimitMinorUnits'],
      ),
      statementDay: serializer.fromJson<int>(json['statementDay']),
      dueDay: serializer.fromJson<int>(json['dueDay']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'issuer': serializer.toJson<String>(issuer),
      'lastFourDigits': serializer.toJson<String?>(lastFourDigits),
      'creditLimitMinorUnits': serializer.toJson<int?>(creditLimitMinorUnits),
      'statementDay': serializer.toJson<int>(statementDay),
      'dueDay': serializer.toJson<int>(dueDay),
      'active': serializer.toJson<bool>(active),
    };
  }

  CreditCard copyWith({
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
    SyncStatus? syncStatus,
    int? version,
    String? id,
    String? name,
    String? issuer,
    Value<String?> lastFourDigits = const Value.absent(),
    Value<int?> creditLimitMinorUnits = const Value.absent(),
    int? statementDay,
    int? dueDay,
    bool? active,
  }) => CreditCard(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    version: version ?? this.version,
    id: id ?? this.id,
    name: name ?? this.name,
    issuer: issuer ?? this.issuer,
    lastFourDigits: lastFourDigits.present
        ? lastFourDigits.value
        : this.lastFourDigits,
    creditLimitMinorUnits: creditLimitMinorUnits.present
        ? creditLimitMinorUnits.value
        : this.creditLimitMinorUnits,
    statementDay: statementDay ?? this.statementDay,
    dueDay: dueDay ?? this.dueDay,
    active: active ?? this.active,
  );
  CreditCard copyWithCompanion(CreditCardsCompanion data) {
    return CreditCard(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      issuer: data.issuer.present ? data.issuer.value : this.issuer,
      lastFourDigits: data.lastFourDigits.present
          ? data.lastFourDigits.value
          : this.lastFourDigits,
      creditLimitMinorUnits: data.creditLimitMinorUnits.present
          ? data.creditLimitMinorUnits.value
          : this.creditLimitMinorUnits,
      statementDay: data.statementDay.present
          ? data.statementDay.value
          : this.statementDay,
      dueDay: data.dueDay.present ? data.dueDay.value : this.dueDay,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditCard(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('issuer: $issuer, ')
          ..write('lastFourDigits: $lastFourDigits, ')
          ..write('creditLimitMinorUnits: $creditLimitMinorUnits, ')
          ..write('statementDay: $statementDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    version,
    id,
    name,
    issuer,
    lastFourDigits,
    creditLimitMinorUnits,
    statementDay,
    dueDay,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditCard &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.version == this.version &&
          other.id == this.id &&
          other.name == this.name &&
          other.issuer == this.issuer &&
          other.lastFourDigits == this.lastFourDigits &&
          other.creditLimitMinorUnits == this.creditLimitMinorUnits &&
          other.statementDay == this.statementDay &&
          other.dueDay == this.dueDay &&
          other.active == this.active);
}

class CreditCardsCompanion extends UpdateCompanion<CreditCard> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> version;
  final Value<String> id;
  final Value<String> name;
  final Value<String> issuer;
  final Value<String?> lastFourDigits;
  final Value<int?> creditLimitMinorUnits;
  final Value<int> statementDay;
  final Value<int> dueDay;
  final Value<bool> active;
  final Value<int> rowid;
  const CreditCardsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.issuer = const Value.absent(),
    this.lastFourDigits = const Value.absent(),
    this.creditLimitMinorUnits = const Value.absent(),
    this.statementDay = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CreditCardsCompanion.insert({
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String name,
    required String issuer,
    this.lastFourDigits = const Value.absent(),
    this.creditLimitMinorUnits = const Value.absent(),
    required int statementDay,
    required int dueDay,
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name),
       issuer = Value(issuer),
       statementDay = Value(statementDay),
       dueDay = Value(dueDay);
  static Insertable<CreditCard> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? issuer,
    Expression<String>? lastFourDigits,
    Expression<int>? creditLimitMinorUnits,
    Expression<int>? statementDay,
    Expression<int>? dueDay,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (issuer != null) 'issuer': issuer,
      if (lastFourDigits != null) 'last_four_digits': lastFourDigits,
      if (creditLimitMinorUnits != null)
        'credit_limit_minor_units': creditLimitMinorUnits,
      if (statementDay != null) 'statement_day': statementDay,
      if (dueDay != null) 'due_day': dueDay,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CreditCardsCompanion copyWith({
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? version,
    Value<String>? id,
    Value<String>? name,
    Value<String>? issuer,
    Value<String?>? lastFourDigits,
    Value<int?>? creditLimitMinorUnits,
    Value<int>? statementDay,
    Value<int>? dueDay,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return CreditCardsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      version: version ?? this.version,
      id: id ?? this.id,
      name: name ?? this.name,
      issuer: issuer ?? this.issuer,
      lastFourDigits: lastFourDigits ?? this.lastFourDigits,
      creditLimitMinorUnits:
          creditLimitMinorUnits ?? this.creditLimitMinorUnits,
      statementDay: statementDay ?? this.statementDay,
      dueDay: dueDay ?? this.dueDay,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $CreditCardsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (issuer.present) {
      map['issuer'] = Variable<String>(issuer.value);
    }
    if (lastFourDigits.present) {
      map['last_four_digits'] = Variable<String>(lastFourDigits.value);
    }
    if (creditLimitMinorUnits.present) {
      map['credit_limit_minor_units'] = Variable<int>(
        creditLimitMinorUnits.value,
      );
    }
    if (statementDay.present) {
      map['statement_day'] = Variable<int>(statementDay.value);
    }
    if (dueDay.present) {
      map['due_day'] = Variable<int>(dueDay.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('issuer: $issuer, ')
          ..write('lastFourDigits: $lastFourDigits, ')
          ..write('creditLimitMinorUnits: $creditLimitMinorUnits, ')
          ..write('statementDay: $statementDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentMethodsTable extends PaymentMethods
    with TableInfo<$PaymentMethodsTable, PaymentMethod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentMethodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('pending'),
      ).withConverter<SyncStatus>($PaymentMethodsTable.$convertersyncStatus);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethodKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PaymentMethodKind>($PaymentMethodsTable.$converterkind);
  static const VerificationMeta _linkedCreditCardIdMeta =
      const VerificationMeta('linkedCreditCardId');
  @override
  late final GeneratedColumn<String> linkedCreditCardId =
      GeneratedColumn<String>(
        'linked_credit_card_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES credit_cards (id) ON DELETE SET NULL',
        ),
      );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    version,
    id,
    name,
    kind,
    linkedCreditCardId,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_methods';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentMethod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('linked_credit_card_id')) {
      context.handle(
        _linkedCreditCardIdMeta,
        linkedCreditCardId.isAcceptableOrUnknown(
          data['linked_credit_card_id']!,
          _linkedCreditCardIdMeta,
        ),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentMethod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentMethod(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: $PaymentMethodsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: $PaymentMethodsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      linkedCreditCardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_credit_card_id'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $PaymentMethodsTable createAlias(String alias) {
    return $PaymentMethodsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
  static TypeConverter<PaymentMethodKind, String> $converterkind =
      const PaymentMethodKindConverter();
}

class PaymentMethod extends DataClass implements Insertable<PaymentMethod> {
  /// UTC epoch milliseconds when the entity was created locally.
  final int createdAt;

  /// UTC epoch milliseconds when the entity was last modified locally.
  final int updatedAt;

  /// Soft-delete tombstone (UTC epoch ms). Null if active/archived; timestamp if deleted.
  final int? deletedAt;

  /// Synchronization state with Cloud Firestore ('pending', 'synced', 'conflict').
  final SyncStatus syncStatus;

  /// Local mutation counter incremented on every write.
  final int version;

  /// Unique client-generated UUIDv4 identifier.
  final String id;

  /// Label name (e.g. "HDFC Savings", "Cash", "Amazon Pay ICICI").
  final String name;

  /// Kind of payment method ('CASH', 'BANK', 'CREDIT_CARD', 'WALLET', 'OTHER').
  final PaymentMethodKind kind;

  /// Set only when kind = 'CREDIT_CARD'; references CreditCards.id.
  final String? linkedCreditCardId;

  /// User-facing archive toggle.
  final bool active;
  const PaymentMethod({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.version,
    required this.id,
    required this.name,
    required this.kind,
    this.linkedCreditCardId,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    {
      map['sync_status'] = Variable<String>(
        $PaymentMethodsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['kind'] = Variable<String>(
        $PaymentMethodsTable.$converterkind.toSql(kind),
      );
    }
    if (!nullToAbsent || linkedCreditCardId != null) {
      map['linked_credit_card_id'] = Variable<String>(linkedCreditCardId);
    }
    map['active'] = Variable<bool>(active);
    return map;
  }

  PaymentMethodsCompanion toCompanion(bool nullToAbsent) {
    return PaymentMethodsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      version: Value(version),
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      linkedCreditCardId: linkedCreditCardId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedCreditCardId),
      active: Value(active),
    );
  }

  factory PaymentMethod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentMethod(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<PaymentMethodKind>(json['kind']),
      linkedCreditCardId: serializer.fromJson<String?>(
        json['linkedCreditCardId'],
      ),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<PaymentMethodKind>(kind),
      'linkedCreditCardId': serializer.toJson<String?>(linkedCreditCardId),
      'active': serializer.toJson<bool>(active),
    };
  }

  PaymentMethod copyWith({
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
    SyncStatus? syncStatus,
    int? version,
    String? id,
    String? name,
    PaymentMethodKind? kind,
    Value<String?> linkedCreditCardId = const Value.absent(),
    bool? active,
  }) => PaymentMethod(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    version: version ?? this.version,
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    linkedCreditCardId: linkedCreditCardId.present
        ? linkedCreditCardId.value
        : this.linkedCreditCardId,
    active: active ?? this.active,
  );
  PaymentMethod copyWithCompanion(PaymentMethodsCompanion data) {
    return PaymentMethod(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      linkedCreditCardId: data.linkedCreditCardId.present
          ? data.linkedCreditCardId.value
          : this.linkedCreditCardId,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentMethod(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('linkedCreditCardId: $linkedCreditCardId, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    version,
    id,
    name,
    kind,
    linkedCreditCardId,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentMethod &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.version == this.version &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.linkedCreditCardId == this.linkedCreditCardId &&
          other.active == this.active);
}

class PaymentMethodsCompanion extends UpdateCompanion<PaymentMethod> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> version;
  final Value<String> id;
  final Value<String> name;
  final Value<PaymentMethodKind> kind;
  final Value<String?> linkedCreditCardId;
  final Value<bool> active;
  final Value<int> rowid;
  const PaymentMethodsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.linkedCreditCardId = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentMethodsCompanion.insert({
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String name,
    required PaymentMethodKind kind,
    this.linkedCreditCardId = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name),
       kind = Value(kind);
  static Insertable<PaymentMethod> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? linkedCreditCardId,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (linkedCreditCardId != null)
        'linked_credit_card_id': linkedCreditCardId,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentMethodsCompanion copyWith({
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? version,
    Value<String>? id,
    Value<String>? name,
    Value<PaymentMethodKind>? kind,
    Value<String?>? linkedCreditCardId,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return PaymentMethodsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      version: version ?? this.version,
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      linkedCreditCardId: linkedCreditCardId ?? this.linkedCreditCardId,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $PaymentMethodsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $PaymentMethodsTable.$converterkind.toSql(kind.value),
      );
    }
    if (linkedCreditCardId.present) {
      map['linked_credit_card_id'] = Variable<String>(linkedCreditCardId.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentMethodsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('linkedCreditCardId: $linkedCreditCardId, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('pending'),
      ).withConverter<SyncStatus>($TransactionsTable.$convertersyncStatus);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TransactionType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TransactionType>($TransactionsTable.$convertertype);
  static const VerificationMeta _amountMinorUnitsMeta = const VerificationMeta(
    'amountMinorUnits',
  );
  @override
  late final GeneratedColumn<int> amountMinorUnits = GeneratedColumn<int>(
    'amount_minor_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (amount_minor_units > 0)',
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (currency GLOB \'[A-Z][A-Z][A-Z]\')',
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<int> transactionDate = GeneratedColumn<int>(
    'transaction_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _paymentMethodIdMeta = const VerificationMeta(
    'paymentMethodId',
  );
  @override
  late final GeneratedColumn<String> paymentMethodId = GeneratedColumn<String>(
    'payment_method_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payment_methods (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _counterPaymentMethodIdMeta =
      const VerificationMeta('counterPaymentMethodId');
  @override
  late final GeneratedColumn<String> counterPaymentMethodId =
      GeneratedColumn<String>(
        'counter_payment_method_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES payment_methods (id) ON DELETE RESTRICT',
        ),
      );
  static const VerificationMeta _merchantMeta = const VerificationMeta(
    'merchant',
  );
  @override
  late final GeneratedColumn<String> merchant = GeneratedColumn<String>(
    'merchant',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCreditCardBillPaymentMeta =
      const VerificationMeta('isCreditCardBillPayment');
  @override
  late final GeneratedColumn<bool> isCreditCardBillPayment =
      GeneratedColumn<bool>(
        'is_credit_card_bill_payment',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_credit_card_bill_payment" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  late final GeneratedColumnWithTypeConverter<TransactionSource, String>
  source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('MANUAL'),
  ).withConverter<TransactionSource>($TransactionsTable.$convertersource);
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    version,
    id,
    type,
    amountMinorUnits,
    currency,
    transactionDate,
    categoryId,
    paymentMethodId,
    counterPaymentMethodId,
    merchant,
    description,
    notes,
    isCreditCardBillPayment,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount_minor_units')) {
      context.handle(
        _amountMinorUnitsMeta,
        amountMinorUnits.isAcceptableOrUnknown(
          data['amount_minor_units']!,
          _amountMinorUnitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorUnitsMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('payment_method_id')) {
      context.handle(
        _paymentMethodIdMeta,
        paymentMethodId.isAcceptableOrUnknown(
          data['payment_method_id']!,
          _paymentMethodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodIdMeta);
    }
    if (data.containsKey('counter_payment_method_id')) {
      context.handle(
        _counterPaymentMethodIdMeta,
        counterPaymentMethodId.isAcceptableOrUnknown(
          data['counter_payment_method_id']!,
          _counterPaymentMethodIdMeta,
        ),
      );
    }
    if (data.containsKey('merchant')) {
      context.handle(
        _merchantMeta,
        merchant.isAcceptableOrUnknown(data['merchant']!, _merchantMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_credit_card_bill_payment')) {
      context.handle(
        _isCreditCardBillPaymentMeta,
        isCreditCardBillPayment.isAcceptableOrUnknown(
          data['is_credit_card_bill_payment']!,
          _isCreditCardBillPaymentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: $TransactionsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: $TransactionsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      amountMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor_units'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_date'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      paymentMethodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method_id'],
      )!,
      counterPaymentMethodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}counter_payment_method_id'],
      ),
      merchant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isCreditCardBillPayment: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_credit_card_bill_payment'],
      )!,
      source: $TransactionsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
  static TypeConverter<TransactionType, String> $convertertype =
      const TransactionTypeConverter();
  static TypeConverter<TransactionSource, String> $convertersource =
      const TransactionSourceConverter();
}

class Transaction extends DataClass implements Insertable<Transaction> {
  /// UTC epoch milliseconds when the entity was created locally.
  final int createdAt;

  /// UTC epoch milliseconds when the entity was last modified locally.
  final int updatedAt;

  /// Soft-delete tombstone (UTC epoch ms). Null if active/archived; timestamp if deleted.
  final int? deletedAt;

  /// Synchronization state with Cloud Firestore ('pending', 'synced', 'conflict').
  final SyncStatus syncStatus;

  /// Local mutation counter incremented on every write.
  final int version;

  /// Unique client-generated UUIDv4 identifier.
  final String id;

  /// Direction driver ('INCOME', 'EXPENSE', 'TRANSFER').
  final TransactionType type;

  /// Strictly positive signed 64-bit integer minor currency units (ADR-009).
  final int amountMinorUnits;

  /// Exactly three uppercase ASCII letters representing ISO 4217 code shape (e.g. 'INR', 'USD').
  final String currency;

  /// When the spend or receipt happened (user-meaningful UTC epoch ms).
  final int transactionDate;

  /// Category reference. Required for INCOME/EXPENSE; null for TRANSFER.
  final String? categoryId;

  /// The 'from' side for EXPENSE/TRANSFER, the 'into' side for INCOME.
  final String paymentMethodId;

  /// The 'to' side for TRANSFER.
  final String? counterPaymentMethodId;

  /// Optional merchant or payee name.
  final String? merchant;

  /// Optional description.
  final String? description;

  /// Optional user notes.
  final String? notes;

  /// True only for a TRANSFER representing paying down a credit card (ADR-006).
  final bool isCreditCardBillPayment;

  /// Audit/entry source ('MANUAL', 'AI_RECEIPT', 'AI_NATURAL_LANGUAGE', 'CSV_IMPORT').
  final TransactionSource source;
  const Transaction({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.version,
    required this.id,
    required this.type,
    required this.amountMinorUnits,
    required this.currency,
    required this.transactionDate,
    this.categoryId,
    required this.paymentMethodId,
    this.counterPaymentMethodId,
    this.merchant,
    this.description,
    this.notes,
    required this.isCreditCardBillPayment,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    {
      map['sync_status'] = Variable<String>(
        $TransactionsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    {
      map['type'] = Variable<String>(
        $TransactionsTable.$convertertype.toSql(type),
      );
    }
    map['amount_minor_units'] = Variable<int>(amountMinorUnits);
    map['currency'] = Variable<String>(currency);
    map['transaction_date'] = Variable<int>(transactionDate);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['payment_method_id'] = Variable<String>(paymentMethodId);
    if (!nullToAbsent || counterPaymentMethodId != null) {
      map['counter_payment_method_id'] = Variable<String>(
        counterPaymentMethodId,
      );
    }
    if (!nullToAbsent || merchant != null) {
      map['merchant'] = Variable<String>(merchant);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_credit_card_bill_payment'] = Variable<bool>(
      isCreditCardBillPayment,
    );
    {
      map['source'] = Variable<String>(
        $TransactionsTable.$convertersource.toSql(source),
      );
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      version: Value(version),
      id: Value(id),
      type: Value(type),
      amountMinorUnits: Value(amountMinorUnits),
      currency: Value(currency),
      transactionDate: Value(transactionDate),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      paymentMethodId: Value(paymentMethodId),
      counterPaymentMethodId: counterPaymentMethodId == null && nullToAbsent
          ? const Value.absent()
          : Value(counterPaymentMethodId),
      merchant: merchant == null && nullToAbsent
          ? const Value.absent()
          : Value(merchant),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isCreditCardBillPayment: Value(isCreditCardBillPayment),
      source: Value(source),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<TransactionType>(json['type']),
      amountMinorUnits: serializer.fromJson<int>(json['amountMinorUnits']),
      currency: serializer.fromJson<String>(json['currency']),
      transactionDate: serializer.fromJson<int>(json['transactionDate']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      paymentMethodId: serializer.fromJson<String>(json['paymentMethodId']),
      counterPaymentMethodId: serializer.fromJson<String?>(
        json['counterPaymentMethodId'],
      ),
      merchant: serializer.fromJson<String?>(json['merchant']),
      description: serializer.fromJson<String?>(json['description']),
      notes: serializer.fromJson<String?>(json['notes']),
      isCreditCardBillPayment: serializer.fromJson<bool>(
        json['isCreditCardBillPayment'],
      ),
      source: serializer.fromJson<TransactionSource>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<TransactionType>(type),
      'amountMinorUnits': serializer.toJson<int>(amountMinorUnits),
      'currency': serializer.toJson<String>(currency),
      'transactionDate': serializer.toJson<int>(transactionDate),
      'categoryId': serializer.toJson<String?>(categoryId),
      'paymentMethodId': serializer.toJson<String>(paymentMethodId),
      'counterPaymentMethodId': serializer.toJson<String?>(
        counterPaymentMethodId,
      ),
      'merchant': serializer.toJson<String?>(merchant),
      'description': serializer.toJson<String?>(description),
      'notes': serializer.toJson<String?>(notes),
      'isCreditCardBillPayment': serializer.toJson<bool>(
        isCreditCardBillPayment,
      ),
      'source': serializer.toJson<TransactionSource>(source),
    };
  }

  Transaction copyWith({
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
    SyncStatus? syncStatus,
    int? version,
    String? id,
    TransactionType? type,
    int? amountMinorUnits,
    String? currency,
    int? transactionDate,
    Value<String?> categoryId = const Value.absent(),
    String? paymentMethodId,
    Value<String?> counterPaymentMethodId = const Value.absent(),
    Value<String?> merchant = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isCreditCardBillPayment,
    TransactionSource? source,
  }) => Transaction(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    version: version ?? this.version,
    id: id ?? this.id,
    type: type ?? this.type,
    amountMinorUnits: amountMinorUnits ?? this.amountMinorUnits,
    currency: currency ?? this.currency,
    transactionDate: transactionDate ?? this.transactionDate,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    counterPaymentMethodId: counterPaymentMethodId.present
        ? counterPaymentMethodId.value
        : this.counterPaymentMethodId,
    merchant: merchant.present ? merchant.value : this.merchant,
    description: description.present ? description.value : this.description,
    notes: notes.present ? notes.value : this.notes,
    isCreditCardBillPayment:
        isCreditCardBillPayment ?? this.isCreditCardBillPayment,
    source: source ?? this.source,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      amountMinorUnits: data.amountMinorUnits.present
          ? data.amountMinorUnits.value
          : this.amountMinorUnits,
      currency: data.currency.present ? data.currency.value : this.currency,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      paymentMethodId: data.paymentMethodId.present
          ? data.paymentMethodId.value
          : this.paymentMethodId,
      counterPaymentMethodId: data.counterPaymentMethodId.present
          ? data.counterPaymentMethodId.value
          : this.counterPaymentMethodId,
      merchant: data.merchant.present ? data.merchant.value : this.merchant,
      description: data.description.present
          ? data.description.value
          : this.description,
      notes: data.notes.present ? data.notes.value : this.notes,
      isCreditCardBillPayment: data.isCreditCardBillPayment.present
          ? data.isCreditCardBillPayment.value
          : this.isCreditCardBillPayment,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amountMinorUnits: $amountMinorUnits, ')
          ..write('currency: $currency, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('counterPaymentMethodId: $counterPaymentMethodId, ')
          ..write('merchant: $merchant, ')
          ..write('description: $description, ')
          ..write('notes: $notes, ')
          ..write('isCreditCardBillPayment: $isCreditCardBillPayment, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    version,
    id,
    type,
    amountMinorUnits,
    currency,
    transactionDate,
    categoryId,
    paymentMethodId,
    counterPaymentMethodId,
    merchant,
    description,
    notes,
    isCreditCardBillPayment,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.version == this.version &&
          other.id == this.id &&
          other.type == this.type &&
          other.amountMinorUnits == this.amountMinorUnits &&
          other.currency == this.currency &&
          other.transactionDate == this.transactionDate &&
          other.categoryId == this.categoryId &&
          other.paymentMethodId == this.paymentMethodId &&
          other.counterPaymentMethodId == this.counterPaymentMethodId &&
          other.merchant == this.merchant &&
          other.description == this.description &&
          other.notes == this.notes &&
          other.isCreditCardBillPayment == this.isCreditCardBillPayment &&
          other.source == this.source);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> version;
  final Value<String> id;
  final Value<TransactionType> type;
  final Value<int> amountMinorUnits;
  final Value<String> currency;
  final Value<int> transactionDate;
  final Value<String?> categoryId;
  final Value<String> paymentMethodId;
  final Value<String?> counterPaymentMethodId;
  final Value<String?> merchant;
  final Value<String?> description;
  final Value<String?> notes;
  final Value<bool> isCreditCardBillPayment;
  final Value<TransactionSource> source;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.amountMinorUnits = const Value.absent(),
    this.currency = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.paymentMethodId = const Value.absent(),
    this.counterPaymentMethodId = const Value.absent(),
    this.merchant = const Value.absent(),
    this.description = const Value.absent(),
    this.notes = const Value.absent(),
    this.isCreditCardBillPayment = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required TransactionType type,
    required int amountMinorUnits,
    required String currency,
    required int transactionDate,
    this.categoryId = const Value.absent(),
    required String paymentMethodId,
    this.counterPaymentMethodId = const Value.absent(),
    this.merchant = const Value.absent(),
    this.description = const Value.absent(),
    this.notes = const Value.absent(),
    this.isCreditCardBillPayment = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       type = Value(type),
       amountMinorUnits = Value(amountMinorUnits),
       currency = Value(currency),
       transactionDate = Value(transactionDate),
       paymentMethodId = Value(paymentMethodId);
  static Insertable<Transaction> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? type,
    Expression<int>? amountMinorUnits,
    Expression<String>? currency,
    Expression<int>? transactionDate,
    Expression<String>? categoryId,
    Expression<String>? paymentMethodId,
    Expression<String>? counterPaymentMethodId,
    Expression<String>? merchant,
    Expression<String>? description,
    Expression<String>? notes,
    Expression<bool>? isCreditCardBillPayment,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (amountMinorUnits != null) 'amount_minor_units': amountMinorUnits,
      if (currency != null) 'currency': currency,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (categoryId != null) 'category_id': categoryId,
      if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
      if (counterPaymentMethodId != null)
        'counter_payment_method_id': counterPaymentMethodId,
      if (merchant != null) 'merchant': merchant,
      if (description != null) 'description': description,
      if (notes != null) 'notes': notes,
      if (isCreditCardBillPayment != null)
        'is_credit_card_bill_payment': isCreditCardBillPayment,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? version,
    Value<String>? id,
    Value<TransactionType>? type,
    Value<int>? amountMinorUnits,
    Value<String>? currency,
    Value<int>? transactionDate,
    Value<String?>? categoryId,
    Value<String>? paymentMethodId,
    Value<String?>? counterPaymentMethodId,
    Value<String?>? merchant,
    Value<String?>? description,
    Value<String?>? notes,
    Value<bool>? isCreditCardBillPayment,
    Value<TransactionSource>? source,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      version: version ?? this.version,
      id: id ?? this.id,
      type: type ?? this.type,
      amountMinorUnits: amountMinorUnits ?? this.amountMinorUnits,
      currency: currency ?? this.currency,
      transactionDate: transactionDate ?? this.transactionDate,
      categoryId: categoryId ?? this.categoryId,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      counterPaymentMethodId:
          counterPaymentMethodId ?? this.counterPaymentMethodId,
      merchant: merchant ?? this.merchant,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      isCreditCardBillPayment:
          isCreditCardBillPayment ?? this.isCreditCardBillPayment,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $TransactionsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $TransactionsTable.$convertertype.toSql(type.value),
      );
    }
    if (amountMinorUnits.present) {
      map['amount_minor_units'] = Variable<int>(amountMinorUnits.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<int>(transactionDate.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (paymentMethodId.present) {
      map['payment_method_id'] = Variable<String>(paymentMethodId.value);
    }
    if (counterPaymentMethodId.present) {
      map['counter_payment_method_id'] = Variable<String>(
        counterPaymentMethodId.value,
      );
    }
    if (merchant.present) {
      map['merchant'] = Variable<String>(merchant.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isCreditCardBillPayment.present) {
      map['is_credit_card_bill_payment'] = Variable<bool>(
        isCreditCardBillPayment.value,
      );
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $TransactionsTable.$convertersource.toSql(source.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amountMinorUnits: $amountMinorUnits, ')
          ..write('currency: $currency, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('counterPaymentMethodId: $counterPaymentMethodId, ')
          ..write('merchant: $merchant, ')
          ..write('description: $description, ')
          ..write('notes: $notes, ')
          ..write('isCreditCardBillPayment: $isCreditCardBillPayment, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, Attachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('pending'),
      ).withConverter<SyncStatus>($AttachmentsTable.$convertersyncStatus);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transactions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _storagePathMeta = const VerificationMeta(
    'storagePath',
  );
  @override
  late final GeneratedColumn<String> storagePath = GeneratedColumn<String>(
    'storage_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AiProcessingStatus?, String>
  aiProcessingStatus =
      GeneratedColumn<String>(
        'ai_processing_status',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<AiProcessingStatus?>(
        $AttachmentsTable.$converteraiProcessingStatusn,
      );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    version,
    id,
    transactionId,
    storagePath,
    fileName,
    mimeType,
    sizeBytes,
    aiProcessingStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Attachment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('storage_path')) {
      context.handle(
        _storagePathMeta,
        storagePath.isAcceptableOrUnknown(
          data['storage_path']!,
          _storagePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_storagePathMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Attachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attachment(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: $AttachmentsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      )!,
      storagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}storage_path'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      aiProcessingStatus: $AttachmentsTable.$converteraiProcessingStatusn
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}ai_processing_status'],
            ),
          ),
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
  static TypeConverter<AiProcessingStatus, String>
  $converteraiProcessingStatus = const AiProcessingStatusConverter();
  static TypeConverter<AiProcessingStatus?, String?>
  $converteraiProcessingStatusn = NullAwareTypeConverter.wrap(
    $converteraiProcessingStatus,
  );
}

class Attachment extends DataClass implements Insertable<Attachment> {
  /// UTC epoch milliseconds when the entity was created locally.
  final int createdAt;

  /// UTC epoch milliseconds when the entity was last modified locally.
  final int updatedAt;

  /// Soft-delete tombstone (UTC epoch ms). Null if active/archived; timestamp if deleted.
  final int? deletedAt;

  /// Synchronization state with Cloud Firestore ('pending', 'synced', 'conflict').
  final SyncStatus syncStatus;

  /// Local mutation counter incremented on every write.
  final int version;

  /// Unique client-generated UUIDv4 identifier.
  final String id;

  /// Foreign key referencing Transactions.id. Physical deletion cascades; soft-deletion is domain-handled.
  final String transactionId;

  /// Cloud Storage path.
  final String storagePath;

  /// Original file name.
  final String fileName;

  /// MIME type (e.g. 'image/jpeg', 'application/pdf').
  final String mimeType;

  /// File size in bytes.
  final int sizeBytes;

  /// AI receipt extraction status ('NOT_PROCESSED', 'PENDING', 'DONE', 'FAILED').
  final AiProcessingStatus? aiProcessingStatus;
  const Attachment({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.version,
    required this.id,
    required this.transactionId,
    required this.storagePath,
    required this.fileName,
    required this.mimeType,
    required this.sizeBytes,
    this.aiProcessingStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    {
      map['sync_status'] = Variable<String>(
        $AttachmentsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['version'] = Variable<int>(version);
    map['id'] = Variable<String>(id);
    map['transaction_id'] = Variable<String>(transactionId);
    map['storage_path'] = Variable<String>(storagePath);
    map['file_name'] = Variable<String>(fileName);
    map['mime_type'] = Variable<String>(mimeType);
    map['size_bytes'] = Variable<int>(sizeBytes);
    if (!nullToAbsent || aiProcessingStatus != null) {
      map['ai_processing_status'] = Variable<String>(
        $AttachmentsTable.$converteraiProcessingStatusn.toSql(
          aiProcessingStatus,
        ),
      );
    }
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      version: Value(version),
      id: Value(id),
      transactionId: Value(transactionId),
      storagePath: Value(storagePath),
      fileName: Value(fileName),
      mimeType: Value(mimeType),
      sizeBytes: Value(sizeBytes),
      aiProcessingStatus: aiProcessingStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(aiProcessingStatus),
    );
  }

  factory Attachment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attachment(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
      version: serializer.fromJson<int>(json['version']),
      id: serializer.fromJson<String>(json['id']),
      transactionId: serializer.fromJson<String>(json['transactionId']),
      storagePath: serializer.fromJson<String>(json['storagePath']),
      fileName: serializer.fromJson<String>(json['fileName']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      aiProcessingStatus: serializer.fromJson<AiProcessingStatus?>(
        json['aiProcessingStatus'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
      'version': serializer.toJson<int>(version),
      'id': serializer.toJson<String>(id),
      'transactionId': serializer.toJson<String>(transactionId),
      'storagePath': serializer.toJson<String>(storagePath),
      'fileName': serializer.toJson<String>(fileName),
      'mimeType': serializer.toJson<String>(mimeType),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'aiProcessingStatus': serializer.toJson<AiProcessingStatus?>(
        aiProcessingStatus,
      ),
    };
  }

  Attachment copyWith({
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
    SyncStatus? syncStatus,
    int? version,
    String? id,
    String? transactionId,
    String? storagePath,
    String? fileName,
    String? mimeType,
    int? sizeBytes,
    Value<AiProcessingStatus?> aiProcessingStatus = const Value.absent(),
  }) => Attachment(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    version: version ?? this.version,
    id: id ?? this.id,
    transactionId: transactionId ?? this.transactionId,
    storagePath: storagePath ?? this.storagePath,
    fileName: fileName ?? this.fileName,
    mimeType: mimeType ?? this.mimeType,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    aiProcessingStatus: aiProcessingStatus.present
        ? aiProcessingStatus.value
        : this.aiProcessingStatus,
  );
  Attachment copyWithCompanion(AttachmentsCompanion data) {
    return Attachment(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      version: data.version.present ? data.version.value : this.version,
      id: data.id.present ? data.id.value : this.id,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      storagePath: data.storagePath.present
          ? data.storagePath.value
          : this.storagePath,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      aiProcessingStatus: data.aiProcessingStatus.present
          ? data.aiProcessingStatus.value
          : this.aiProcessingStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attachment(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('storagePath: $storagePath, ')
          ..write('fileName: $fileName, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('aiProcessingStatus: $aiProcessingStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    version,
    id,
    transactionId,
    storagePath,
    fileName,
    mimeType,
    sizeBytes,
    aiProcessingStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attachment &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.version == this.version &&
          other.id == this.id &&
          other.transactionId == this.transactionId &&
          other.storagePath == this.storagePath &&
          other.fileName == this.fileName &&
          other.mimeType == this.mimeType &&
          other.sizeBytes == this.sizeBytes &&
          other.aiProcessingStatus == this.aiProcessingStatus);
}

class AttachmentsCompanion extends UpdateCompanion<Attachment> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> version;
  final Value<String> id;
  final Value<String> transactionId;
  final Value<String> storagePath;
  final Value<String> fileName;
  final Value<String> mimeType;
  final Value<int> sizeBytes;
  final Value<AiProcessingStatus?> aiProcessingStatus;
  final Value<int> rowid;
  const AttachmentsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.version = const Value.absent(),
    this.id = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.storagePath = const Value.absent(),
    this.fileName = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.aiProcessingStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.version = const Value.absent(),
    required String id,
    required String transactionId,
    required String storagePath,
    required String fileName,
    required String mimeType,
    required int sizeBytes,
    this.aiProcessingStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       id = Value(id),
       transactionId = Value(transactionId),
       storagePath = Value(storagePath),
       fileName = Value(fileName),
       mimeType = Value(mimeType),
       sizeBytes = Value(sizeBytes);
  static Insertable<Attachment> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? version,
    Expression<String>? id,
    Expression<String>? transactionId,
    Expression<String>? storagePath,
    Expression<String>? fileName,
    Expression<String>? mimeType,
    Expression<int>? sizeBytes,
    Expression<String>? aiProcessingStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (version != null) 'version': version,
      if (id != null) 'id': id,
      if (transactionId != null) 'transaction_id': transactionId,
      if (storagePath != null) 'storage_path': storagePath,
      if (fileName != null) 'file_name': fileName,
      if (mimeType != null) 'mime_type': mimeType,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (aiProcessingStatus != null)
        'ai_processing_status': aiProcessingStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttachmentsCompanion copyWith({
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? version,
    Value<String>? id,
    Value<String>? transactionId,
    Value<String>? storagePath,
    Value<String>? fileName,
    Value<String>? mimeType,
    Value<int>? sizeBytes,
    Value<AiProcessingStatus?>? aiProcessingStatus,
    Value<int>? rowid,
  }) {
    return AttachmentsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      version: version ?? this.version,
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      storagePath: storagePath ?? this.storagePath,
      fileName: fileName ?? this.fileName,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      aiProcessingStatus: aiProcessingStatus ?? this.aiProcessingStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $AttachmentsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (storagePath.present) {
      map['storage_path'] = Variable<String>(storagePath.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (aiProcessingStatus.present) {
      map['ai_processing_status'] = Variable<String>(
        $AttachmentsTable.$converteraiProcessingStatusn.toSql(
          aiProcessingStatus.value,
        ),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('version: $version, ')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('storagePath: $storagePath, ')
          ..write('fileName: $fileName, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('aiProcessingStatus: $aiProcessingStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $CreditCardsTable creditCards = $CreditCardsTable(this);
  late final $PaymentMethodsTable paymentMethods = $PaymentMethodsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    creditCards,
    paymentMethods,
    transactions,
    attachments,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'credit_cards',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('payment_methods', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'transactions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('attachments', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required int createdAt,
  required int updatedAt,
  Value<int?> deletedAt,
  Value<SyncStatus> syncStatus,
  Value<int> version,
  required String id,
  required String name,
  required CategoryType type,
  Value<String?> icon,
  Value<String?> color,
  Value<bool> active,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int?> deletedAt,
  Value<SyncStatus> syncStatus,
  Value<int> version,
  Value<String> id,
  Value<String> name,
  Value<CategoryType> type,
  Value<String?> icon,
  Value<String?> color,
  Value<bool> active,
  Value<int> rowid,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'categories__id__transactions__category_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CategoryType, CategoryType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CategoryType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<CategoryType> type = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                version: version,
                id: id,
                name: name,
                type: type,
                icon: icon,
                color: color,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String name,
                required CategoryType type,
                Value<String?> icon = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                version: version,
                id: id,
                name: name,
                type: type,
                icon: icon,
                color: color,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, Category>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedDataByColumns<
                      Category,
                      $CategoriesTable,
                      Transaction,
                      $TransactionsTable
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'category_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$CreditCardsTableCreateCompanionBuilder =
    CreditCardsCompanion Function({
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<int> version,
      required String id,
      required String name,
      required String issuer,
      Value<String?> lastFourDigits,
      Value<int?> creditLimitMinorUnits,
      required int statementDay,
      required int dueDay,
      Value<bool> active,
      Value<int> rowid,
    });
typedef $$CreditCardsTableUpdateCompanionBuilder =
    CreditCardsCompanion Function({
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<int> version,
      Value<String> id,
      Value<String> name,
      Value<String> issuer,
      Value<String?> lastFourDigits,
      Value<int?> creditLimitMinorUnits,
      Value<int> statementDay,
      Value<int> dueDay,
      Value<bool> active,
      Value<int> rowid,
    });

final class $$CreditCardsTableReferences
    extends BaseReferences<_$AppDatabase, $CreditCardsTable, CreditCard> {
  $$CreditCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PaymentMethodsTable, List<PaymentMethod>>
  _paymentMethodsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.paymentMethods,
    aliasName: 'credit_cards__id__payment_methods__linked_credit_card_id',
  );

  $$PaymentMethodsTableProcessedTableManager get paymentMethodsRefs {
    final manager = $$PaymentMethodsTableTableManager($_db, $_db.paymentMethods)
        .filter(
          (f) => f.linkedCreditCardId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_paymentMethodsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CreditCardsTableFilterComposer
    extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issuer => $composableBuilder(
    column: $table.issuer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastFourDigits => $composableBuilder(
    column: $table.lastFourDigits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get creditLimitMinorUnits => $composableBuilder(
    column: $table.creditLimitMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get statementDay => $composableBuilder(
    column: $table.statementDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> paymentMethodsRefs(
    Expression<bool> Function($$PaymentMethodsTableFilterComposer f) f,
  ) {
    final $$PaymentMethodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.linkedCreditCardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableFilterComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issuer => $composableBuilder(
    column: $table.issuer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastFourDigits => $composableBuilder(
    column: $table.lastFourDigits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get creditLimitMinorUnits => $composableBuilder(
    column: $table.creditLimitMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get statementDay => $composableBuilder(
    column: $table.statementDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CreditCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get issuer =>
      $composableBuilder(column: $table.issuer, builder: (column) => column);

  GeneratedColumn<String> get lastFourDigits => $composableBuilder(
    column: $table.lastFourDigits,
    builder: (column) => column,
  );

  GeneratedColumn<int> get creditLimitMinorUnits => $composableBuilder(
    column: $table.creditLimitMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<int> get statementDay => $composableBuilder(
    column: $table.statementDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueDay =>
      $composableBuilder(column: $table.dueDay, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  Expression<T> paymentMethodsRefs<T extends Object>(
    Expression<T> Function($$PaymentMethodsTableAnnotationComposer a) f,
  ) {
    final $$PaymentMethodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.linkedCreditCardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditCardsTable,
          CreditCard,
          $$CreditCardsTableFilterComposer,
          $$CreditCardsTableOrderingComposer,
          $$CreditCardsTableAnnotationComposer,
          $$CreditCardsTableCreateCompanionBuilder,
          $$CreditCardsTableUpdateCompanionBuilder,
          (CreditCard, $$CreditCardsTableReferences),
          CreditCard,
          PrefetchHooks Function({bool paymentMethodsRefs})
        > {
  $$CreditCardsTableTableManager(_$AppDatabase db, $CreditCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> issuer = const Value.absent(),
                Value<String?> lastFourDigits = const Value.absent(),
                Value<int?> creditLimitMinorUnits = const Value.absent(),
                Value<int> statementDay = const Value.absent(),
                Value<int> dueDay = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CreditCardsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                version: version,
                id: id,
                name: name,
                issuer: issuer,
                lastFourDigits: lastFourDigits,
                creditLimitMinorUnits: creditLimitMinorUnits,
                statementDay: statementDay,
                dueDay: dueDay,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String name,
                required String issuer,
                Value<String?> lastFourDigits = const Value.absent(),
                Value<int?> creditLimitMinorUnits = const Value.absent(),
                required int statementDay,
                required int dueDay,
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CreditCardsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                version: version,
                id: id,
                name: name,
                issuer: issuer,
                lastFourDigits: lastFourDigits,
                creditLimitMinorUnits: creditLimitMinorUnits,
                statementDay: statementDay,
                dueDay: dueDay,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CreditCardsTable, CreditCard>(table),
                  $$CreditCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({paymentMethodsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (paymentMethodsRefs) db.paymentMethods,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (paymentMethodsRefs)
                    await $_getPrefetchedDataByColumns<
                      CreditCard,
                      $CreditCardsTable,
                      PaymentMethod,
                      $PaymentMethodsTable
                    >(
                      currentTable: table,
                      referencedTable: $$CreditCardsTableReferences
                          ._paymentMethodsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CreditCardsTableReferences(
                            db,
                            table,
                            p0,
                          ).paymentMethodsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'linked_credit_card_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CreditCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditCardsTable,
      CreditCard,
      $$CreditCardsTableFilterComposer,
      $$CreditCardsTableOrderingComposer,
      $$CreditCardsTableAnnotationComposer,
      $$CreditCardsTableCreateCompanionBuilder,
      $$CreditCardsTableUpdateCompanionBuilder,
      (CreditCard, $$CreditCardsTableReferences),
      CreditCard,
      PrefetchHooks Function({bool paymentMethodsRefs})
    >;
typedef $$PaymentMethodsTableCreateCompanionBuilder =
    PaymentMethodsCompanion Function({
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<int> version,
      required String id,
      required String name,
      required PaymentMethodKind kind,
      Value<String?> linkedCreditCardId,
      Value<bool> active,
      Value<int> rowid,
    });
typedef $$PaymentMethodsTableUpdateCompanionBuilder =
    PaymentMethodsCompanion Function({
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<int> version,
      Value<String> id,
      Value<String> name,
      Value<PaymentMethodKind> kind,
      Value<String?> linkedCreditCardId,
      Value<bool> active,
      Value<int> rowid,
    });

final class $$PaymentMethodsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentMethodsTable, PaymentMethod> {
  $$PaymentMethodsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CreditCardsTable _linkedCreditCardIdTable(_$AppDatabase db) => db
      .creditCards
      .createAlias('payment_methods__linked_credit_card_id__credit_cards__id');

  $$CreditCardsTableProcessedTableManager? get linkedCreditCardId {
    final $_column = $_itemColumn<String>('linked_credit_card_id');
    if ($_column == null) return null;
    final manager = $$CreditCardsTableTableManager(
      $_db,
      $_db.creditCards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_linkedCreditCardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsAsPaymentMethodTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactions,
        aliasName: 'payment_methods__id__transactions__payment_method_id',
      );

  $$TransactionsTableProcessedTableManager get transactionsAsPaymentMethod {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter(
          (f) => f.paymentMethodId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _transactionsAsPaymentMethodTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsAsCounterPaymentMethodTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactions,
        aliasName:
            'payment_methods__id__transactions__counter_payment_method_id',
      );

  $$TransactionsTableProcessedTableManager
  get transactionsAsCounterPaymentMethod {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter(
          (f) => f.counterPaymentMethodId.id.sqlEquals(
            $_itemColumn<String>('id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _transactionsAsCounterPaymentMethodTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PaymentMethodsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PaymentMethodKind, PaymentMethodKind, String>
  get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  $$CreditCardsTableFilterComposer get linkedCreditCardId {
    final $$CreditCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedCreditCardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardsTableFilterComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transactionsAsPaymentMethod(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.paymentMethodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transactionsAsCounterPaymentMethod(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.counterPaymentMethodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaymentMethodsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  $$CreditCardsTableOrderingComposer get linkedCreditCardId {
    final $$CreditCardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedCreditCardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardsTableOrderingComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentMethodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethodKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  $$CreditCardsTableAnnotationComposer get linkedCreditCardId {
    final $$CreditCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedCreditCardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transactionsAsPaymentMethod<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.paymentMethodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transactionsAsCounterPaymentMethod<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.counterPaymentMethodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaymentMethodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentMethodsTable,
          PaymentMethod,
          $$PaymentMethodsTableFilterComposer,
          $$PaymentMethodsTableOrderingComposer,
          $$PaymentMethodsTableAnnotationComposer,
          $$PaymentMethodsTableCreateCompanionBuilder,
          $$PaymentMethodsTableUpdateCompanionBuilder,
          (PaymentMethod, $$PaymentMethodsTableReferences),
          PaymentMethod,
          PrefetchHooks Function({
            bool linkedCreditCardId,
            bool transactionsAsPaymentMethod,
            bool transactionsAsCounterPaymentMethod,
          })
        > {
  $$PaymentMethodsTableTableManager(
    _$AppDatabase db,
    $PaymentMethodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentMethodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentMethodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentMethodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<PaymentMethodKind> kind = const Value.absent(),
                Value<String?> linkedCreditCardId = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentMethodsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                version: version,
                id: id,
                name: name,
                kind: kind,
                linkedCreditCardId: linkedCreditCardId,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String name,
                required PaymentMethodKind kind,
                Value<String?> linkedCreditCardId = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentMethodsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                version: version,
                id: id,
                name: name,
                kind: kind,
                linkedCreditCardId: linkedCreditCardId,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaymentMethodsTable, PaymentMethod>(table),
                  $$PaymentMethodsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                linkedCreditCardId = false,
                transactionsAsPaymentMethod = false,
                transactionsAsCounterPaymentMethod = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionsAsPaymentMethod) db.transactions,
                    if (transactionsAsCounterPaymentMethod) db.transactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (linkedCreditCardId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.linkedCreditCardId,
                            referencedTable: $$PaymentMethodsTableReferences
                                ._linkedCreditCardIdTable(db),
                            referencedColumn: $$PaymentMethodsTableReferences
                                ._linkedCreditCardIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionsAsPaymentMethod)
                        await $_getPrefetchedDataByColumns<
                          PaymentMethod,
                          $PaymentMethodsTable,
                          Transaction,
                          $TransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PaymentMethodsTableReferences
                              ._transactionsAsPaymentMethodTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PaymentMethodsTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsAsPaymentMethod,
                          currentColumn: 'id',
                          referencedColumn: 'payment_method_id',
                          typedResults: items,
                        ),
                      if (transactionsAsCounterPaymentMethod)
                        await $_getPrefetchedDataByColumns<
                          PaymentMethod,
                          $PaymentMethodsTable,
                          Transaction,
                          $TransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PaymentMethodsTableReferences
                              ._transactionsAsCounterPaymentMethodTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PaymentMethodsTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsAsCounterPaymentMethod,
                          currentColumn: 'id',
                          referencedColumn: 'counter_payment_method_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PaymentMethodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentMethodsTable,
      PaymentMethod,
      $$PaymentMethodsTableFilterComposer,
      $$PaymentMethodsTableOrderingComposer,
      $$PaymentMethodsTableAnnotationComposer,
      $$PaymentMethodsTableCreateCompanionBuilder,
      $$PaymentMethodsTableUpdateCompanionBuilder,
      (PaymentMethod, $$PaymentMethodsTableReferences),
      PaymentMethod,
      PrefetchHooks Function({
        bool linkedCreditCardId,
        bool transactionsAsPaymentMethod,
        bool transactionsAsCounterPaymentMethod,
      })
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<int> version,
      required String id,
      required TransactionType type,
      required int amountMinorUnits,
      required String currency,
      required int transactionDate,
      Value<String?> categoryId,
      required String paymentMethodId,
      Value<String?> counterPaymentMethodId,
      Value<String?> merchant,
      Value<String?> description,
      Value<String?> notes,
      Value<bool> isCreditCardBillPayment,
      Value<TransactionSource> source,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<int> version,
      Value<String> id,
      Value<TransactionType> type,
      Value<int> amountMinorUnits,
      Value<String> currency,
      Value<int> transactionDate,
      Value<String?> categoryId,
      Value<String> paymentMethodId,
      Value<String?> counterPaymentMethodId,
      Value<String?> merchant,
      Value<String?> description,
      Value<String?> notes,
      Value<bool> isCreditCardBillPayment,
      Value<TransactionSource> source,
      Value<int> rowid,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('transactions__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PaymentMethodsTable _paymentMethodIdTable(_$AppDatabase db) => db
      .paymentMethods
      .createAlias('transactions__payment_method_id__payment_methods__id');

  $$PaymentMethodsTableProcessedTableManager get paymentMethodId {
    final $_column = $_itemColumn<String>('payment_method_id')!;

    final manager = $$PaymentMethodsTableTableManager(
      $_db,
      $_db.paymentMethods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paymentMethodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PaymentMethodsTable _counterPaymentMethodIdTable(_$AppDatabase db) =>
      db.paymentMethods.createAlias(
        'transactions__counter_payment_method_id__payment_methods__id',
      );

  $$PaymentMethodsTableProcessedTableManager? get counterPaymentMethodId {
    final $_column = $_itemColumn<String>('counter_payment_method_id');
    if ($_column == null) return null;
    final manager = $$PaymentMethodsTableTableManager(
      $_db,
      $_db.paymentMethods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _counterPaymentMethodIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AttachmentsTable, List<Attachment>>
  _attachmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.attachments,
    aliasName: 'transactions__id__attachments__transaction_id',
  );

  $$AttachmentsTableProcessedTableManager get attachmentsRefs {
    final manager = $$AttachmentsTableTableManager(
      $_db,
      $_db.attachments,
    ).filter((f) => f.transactionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_attachmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TransactionType, TransactionType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get amountMinorUnits => $composableBuilder(
    column: $table.amountMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCreditCardBillPayment => $composableBuilder(
    column: $table.isCreditCardBillPayment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TransactionSource, TransactionSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentMethodsTableFilterComposer get paymentMethodId {
    final $$PaymentMethodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentMethodId,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableFilterComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentMethodsTableFilterComposer get counterPaymentMethodId {
    final $$PaymentMethodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.counterPaymentMethodId,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableFilterComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> attachmentsRefs(
    Expression<bool> Function($$AttachmentsTableFilterComposer f) f,
  ) {
    final $$AttachmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attachments,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttachmentsTableFilterComposer(
            $db: $db,
            $table: $db.attachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinorUnits => $composableBuilder(
    column: $table.amountMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCreditCardBillPayment => $composableBuilder(
    column: $table.isCreditCardBillPayment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentMethodsTableOrderingComposer get paymentMethodId {
    final $$PaymentMethodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentMethodId,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableOrderingComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentMethodsTableOrderingComposer get counterPaymentMethodId {
    final $$PaymentMethodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.counterPaymentMethodId,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableOrderingComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TransactionType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountMinorUnits => $composableBuilder(
    column: $table.amountMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchant =>
      $composableBuilder(column: $table.merchant, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isCreditCardBillPayment => $composableBuilder(
    column: $table.isCreditCardBillPayment,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TransactionSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentMethodsTableAnnotationComposer get paymentMethodId {
    final $$PaymentMethodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentMethodId,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentMethodsTableAnnotationComposer get counterPaymentMethodId {
    final $$PaymentMethodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.counterPaymentMethodId,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> attachmentsRefs<T extends Object>(
    Expression<T> Function($$AttachmentsTableAnnotationComposer a) f,
  ) {
    final $$AttachmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attachments,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttachmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.attachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (Transaction, $$TransactionsTableReferences),
          Transaction,
          PrefetchHooks Function({
            bool categoryId,
            bool paymentMethodId,
            bool counterPaymentMethodId,
            bool attachmentsRefs,
          })
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<TransactionType> type = const Value.absent(),
                Value<int> amountMinorUnits = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> transactionDate = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String> paymentMethodId = const Value.absent(),
                Value<String?> counterPaymentMethodId = const Value.absent(),
                Value<String?> merchant = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isCreditCardBillPayment = const Value.absent(),
                Value<TransactionSource> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                version: version,
                id: id,
                type: type,
                amountMinorUnits: amountMinorUnits,
                currency: currency,
                transactionDate: transactionDate,
                categoryId: categoryId,
                paymentMethodId: paymentMethodId,
                counterPaymentMethodId: counterPaymentMethodId,
                merchant: merchant,
                description: description,
                notes: notes,
                isCreditCardBillPayment: isCreditCardBillPayment,
                source: source,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required TransactionType type,
                required int amountMinorUnits,
                required String currency,
                required int transactionDate,
                Value<String?> categoryId = const Value.absent(),
                required String paymentMethodId,
                Value<String?> counterPaymentMethodId = const Value.absent(),
                Value<String?> merchant = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isCreditCardBillPayment = const Value.absent(),
                Value<TransactionSource> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                version: version,
                id: id,
                type: type,
                amountMinorUnits: amountMinorUnits,
                currency: currency,
                transactionDate: transactionDate,
                categoryId: categoryId,
                paymentMethodId: paymentMethodId,
                counterPaymentMethodId: counterPaymentMethodId,
                merchant: merchant,
                description: description,
                notes: notes,
                isCreditCardBillPayment: isCreditCardBillPayment,
                source: source,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTable, Transaction>(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                paymentMethodId = false,
                counterPaymentMethodId = false,
                attachmentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (attachmentsRefs) db.attachments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$TransactionsTableReferences
                                ._categoryIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._categoryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (paymentMethodId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.paymentMethodId,
                            referencedTable: $$TransactionsTableReferences
                                ._paymentMethodIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._paymentMethodIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (counterPaymentMethodId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.counterPaymentMethodId,
                            referencedTable: $$TransactionsTableReferences
                                ._counterPaymentMethodIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._counterPaymentMethodIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (attachmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Transaction,
                          $TransactionsTable,
                          Attachment,
                          $AttachmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$TransactionsTableReferences
                              ._attachmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransactionsTableReferences(
                                db,
                                table,
                                p0,
                              ).attachmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'transaction_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (Transaction, $$TransactionsTableReferences),
      Transaction,
      PrefetchHooks Function({
        bool categoryId,
        bool paymentMethodId,
        bool counterPaymentMethodId,
        bool attachmentsRefs,
      })
    >;
typedef $$AttachmentsTableCreateCompanionBuilder =
    AttachmentsCompanion Function({
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<int> version,
      required String id,
      required String transactionId,
      required String storagePath,
      required String fileName,
      required String mimeType,
      required int sizeBytes,
      Value<AiProcessingStatus?> aiProcessingStatus,
      Value<int> rowid,
    });
typedef $$AttachmentsTableUpdateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<SyncStatus> syncStatus,
      Value<int> version,
      Value<String> id,
      Value<String> transactionId,
      Value<String> storagePath,
      Value<String> fileName,
      Value<String> mimeType,
      Value<int> sizeBytes,
      Value<AiProcessingStatus?> aiProcessingStatus,
      Value<int> rowid,
    });

final class $$AttachmentsTableReferences
    extends BaseReferences<_$AppDatabase, $AttachmentsTable, Attachment> {
  $$AttachmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TransactionsTable _transactionIdTable(_$AppDatabase db) => db
      .transactions
      .createAlias('attachments__transaction_id__transactions__id');

  $$TransactionsTableProcessedTableManager get transactionId {
    final $_column = $_itemColumn<String>('transaction_id')!;

    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storagePath => $composableBuilder(
    column: $table.storagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    AiProcessingStatus?,
    AiProcessingStatus,
    String
  >
  get aiProcessingStatus => $composableBuilder(
    column: $table.aiProcessingStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$TransactionsTableFilterComposer get transactionId {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storagePath => $composableBuilder(
    column: $table.storagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiProcessingStatus => $composableBuilder(
    column: $table.aiProcessingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$TransactionsTableOrderingComposer get transactionId {
    final $$TransactionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableOrderingComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storagePath => $composableBuilder(
    column: $table.storagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AiProcessingStatus?, String>
  get aiProcessingStatus => $composableBuilder(
    column: $table.aiProcessingStatus,
    builder: (column) => column,
  );

  $$TransactionsTableAnnotationComposer get transactionId {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttachmentsTable,
          Attachment,
          $$AttachmentsTableFilterComposer,
          $$AttachmentsTableOrderingComposer,
          $$AttachmentsTableAnnotationComposer,
          $$AttachmentsTableCreateCompanionBuilder,
          $$AttachmentsTableUpdateCompanionBuilder,
          (Attachment, $$AttachmentsTableReferences),
          Attachment,
          PrefetchHooks Function({bool transactionId})
        > {
  $$AttachmentsTableTableManager(_$AppDatabase db, $AttachmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> transactionId = const Value.absent(),
                Value<String> storagePath = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<AiProcessingStatus?> aiProcessingStatus =
                    const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                version: version,
                id: id,
                transactionId: transactionId,
                storagePath: storagePath,
                fileName: fileName,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                aiProcessingStatus: aiProcessingStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String id,
                required String transactionId,
                required String storagePath,
                required String fileName,
                required String mimeType,
                required int sizeBytes,
                Value<AiProcessingStatus?> aiProcessingStatus =
                    const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                version: version,
                id: id,
                transactionId: transactionId,
                storagePath: storagePath,
                fileName: fileName,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                aiProcessingStatus: aiProcessingStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AttachmentsTable, Attachment>(table),
                  $$AttachmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (transactionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.transactionId,
                        referencedTable: $$AttachmentsTableReferences
                            ._transactionIdTable(db),
                        referencedColumn: $$AttachmentsTableReferences
                            ._transactionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttachmentsTable,
      Attachment,
      $$AttachmentsTableFilterComposer,
      $$AttachmentsTableOrderingComposer,
      $$AttachmentsTableAnnotationComposer,
      $$AttachmentsTableCreateCompanionBuilder,
      $$AttachmentsTableUpdateCompanionBuilder,
      (Attachment, $$AttachmentsTableReferences),
      Attachment,
      PrefetchHooks Function({bool transactionId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$CreditCardsTableTableManager get creditCards =>
      $$CreditCardsTableTableManager(_db, _db.creditCards);
  $$PaymentMethodsTableTableManager get paymentMethods =>
      $$PaymentMethodsTableTableManager(_db, _db.paymentMethods);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db, _db.attachments);
}

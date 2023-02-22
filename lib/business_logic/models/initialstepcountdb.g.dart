// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialstepcountdb.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetInitialStepCountDBCollection on Isar {
  IsarCollection<InitialStepCountDB> get initialStepCountDBs =>
      this.collection();
}

const InitialStepCountDBSchema = CollectionSchema(
  name: r'InitialStepCountDB',
  id: 4882441610184079669,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'steps': PropertySchema(
      id: 1,
      name: r'steps',
      type: IsarType.long,
    )
  },
  estimateSize: _initialStepCountDBEstimateSize,
  serialize: _initialStepCountDBSerialize,
  deserialize: _initialStepCountDBDeserialize,
  deserializeProp: _initialStepCountDBDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _initialStepCountDBGetId,
  getLinks: _initialStepCountDBGetLinks,
  attach: _initialStepCountDBAttach,
  version: '3.0.5',
);

int _initialStepCountDBEstimateSize(
  InitialStepCountDB object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _initialStepCountDBSerialize(
  InitialStepCountDB object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeLong(offsets[1], object.steps);
}

InitialStepCountDB _initialStepCountDBDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InitialStepCountDB();
  object.date = reader.readDateTime(offsets[0]);
  object.id = id;
  object.steps = reader.readLong(offsets[1]);
  return object;
}

P _initialStepCountDBDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _initialStepCountDBGetId(InitialStepCountDB object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _initialStepCountDBGetLinks(
    InitialStepCountDB object) {
  return [];
}

void _initialStepCountDBAttach(
    IsarCollection<dynamic> col, Id id, InitialStepCountDB object) {
  object.id = id;
}

extension InitialStepCountDBQueryWhereSort
    on QueryBuilder<InitialStepCountDB, InitialStepCountDB, QWhere> {
  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InitialStepCountDBQueryWhere
    on QueryBuilder<InitialStepCountDB, InitialStepCountDB, QWhereClause> {
  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InitialStepCountDBQueryFilter
    on QueryBuilder<InitialStepCountDB, InitialStepCountDB, QFilterCondition> {
  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      stepsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'steps',
        value: value,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      stepsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'steps',
        value: value,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      stepsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'steps',
        value: value,
      ));
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterFilterCondition>
      stepsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'steps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InitialStepCountDBQueryObject
    on QueryBuilder<InitialStepCountDB, InitialStepCountDB, QFilterCondition> {}

extension InitialStepCountDBQueryLinks
    on QueryBuilder<InitialStepCountDB, InitialStepCountDB, QFilterCondition> {}

extension InitialStepCountDBQuerySortBy
    on QueryBuilder<InitialStepCountDB, InitialStepCountDB, QSortBy> {
  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterSortBy>
      sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterSortBy>
      sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }
}

extension InitialStepCountDBQuerySortThenBy
    on QueryBuilder<InitialStepCountDB, InitialStepCountDB, QSortThenBy> {
  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterSortBy>
      thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QAfterSortBy>
      thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }
}

extension InitialStepCountDBQueryWhereDistinct
    on QueryBuilder<InitialStepCountDB, InitialStepCountDB, QDistinct> {
  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QDistinct>
      distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<InitialStepCountDB, InitialStepCountDB, QDistinct>
      distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }
}

extension InitialStepCountDBQueryProperty
    on QueryBuilder<InitialStepCountDB, InitialStepCountDB, QQueryProperty> {
  QueryBuilder<InitialStepCountDB, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InitialStepCountDB, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<InitialStepCountDB, int, QQueryOperations> stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }
}

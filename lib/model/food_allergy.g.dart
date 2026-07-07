// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_allergy.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFoodAllergyCollection on Isar {
  IsarCollection<FoodAllergy> get foodAllergys => this.collection();
}

const FoodAllergySchema = CollectionSchema(
  name: r'FoodAllergy',
  id: -5457830115329773755,
  properties: {
    r'allergyCategory': PropertySchema(
      id: 0,
      name: r'allergyCategory',
      type: IsarType.byte,
      enumMap: _FoodAllergyallergyCategoryEnumValueMap,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _foodAllergyEstimateSize,
  serialize: _foodAllergySerialize,
  deserialize: _foodAllergyDeserialize,
  deserializeProp: _foodAllergyDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _foodAllergyGetId,
  getLinks: _foodAllergyGetLinks,
  attach: _foodAllergyAttach,
  version: '3.1.0+1',
);

int _foodAllergyEstimateSize(
  FoodAllergy object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _foodAllergySerialize(
  FoodAllergy object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.allergyCategory.index);
  writer.writeString(offsets[1], object.name);
}

FoodAllergy _foodAllergyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FoodAllergy(
    allergyCategory: _FoodAllergyallergyCategoryValueEnumMap[
            reader.readByteOrNull(offsets[0])] ??
        FoodAllergyCategory.cowmilk,
    id: id,
    name: reader.readString(offsets[1]),
  );
  return object;
}

P _foodAllergyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_FoodAllergyallergyCategoryValueEnumMap[
              reader.readByteOrNull(offset)] ??
          FoodAllergyCategory.cowmilk) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FoodAllergyallergyCategoryEnumValueMap = {
  'cowmilk': 0,
  'eggs': 1,
  'peanuts': 2,
  'treenuts': 3,
  'soy': 4,
  'wheat': 5,
  'fish': 6,
  'shellfish': 7,
  'sesame': 8,
  'garlic': 9,
  'onion': 10,
};
const _FoodAllergyallergyCategoryValueEnumMap = {
  0: FoodAllergyCategory.cowmilk,
  1: FoodAllergyCategory.eggs,
  2: FoodAllergyCategory.peanuts,
  3: FoodAllergyCategory.treenuts,
  4: FoodAllergyCategory.soy,
  5: FoodAllergyCategory.wheat,
  6: FoodAllergyCategory.fish,
  7: FoodAllergyCategory.shellfish,
  8: FoodAllergyCategory.sesame,
  9: FoodAllergyCategory.garlic,
  10: FoodAllergyCategory.onion,
};

Id _foodAllergyGetId(FoodAllergy object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _foodAllergyGetLinks(FoodAllergy object) {
  return [];
}

void _foodAllergyAttach(
    IsarCollection<dynamic> col, Id id, FoodAllergy object) {
  object.id = id;
}

extension FoodAllergyQueryWhereSort
    on QueryBuilder<FoodAllergy, FoodAllergy, QWhere> {
  QueryBuilder<FoodAllergy, FoodAllergy, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FoodAllergyQueryWhere
    on QueryBuilder<FoodAllergy, FoodAllergy, QWhereClause> {
  QueryBuilder<FoodAllergy, FoodAllergy, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterWhereClause> idBetween(
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

extension FoodAllergyQueryFilter
    on QueryBuilder<FoodAllergy, FoodAllergy, QFilterCondition> {
  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition>
      allergyCategoryEqualTo(FoodAllergyCategory value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allergyCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition>
      allergyCategoryGreaterThan(
    FoodAllergyCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allergyCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition>
      allergyCategoryLessThan(
    FoodAllergyCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allergyCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition>
      allergyCategoryBetween(
    FoodAllergyCategory lower,
    FoodAllergyCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allergyCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension FoodAllergyQueryObject
    on QueryBuilder<FoodAllergy, FoodAllergy, QFilterCondition> {}

extension FoodAllergyQueryLinks
    on QueryBuilder<FoodAllergy, FoodAllergy, QFilterCondition> {}

extension FoodAllergyQuerySortBy
    on QueryBuilder<FoodAllergy, FoodAllergy, QSortBy> {
  QueryBuilder<FoodAllergy, FoodAllergy, QAfterSortBy> sortByAllergyCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergyCategory', Sort.asc);
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterSortBy>
      sortByAllergyCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergyCategory', Sort.desc);
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension FoodAllergyQuerySortThenBy
    on QueryBuilder<FoodAllergy, FoodAllergy, QSortThenBy> {
  QueryBuilder<FoodAllergy, FoodAllergy, QAfterSortBy> thenByAllergyCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergyCategory', Sort.asc);
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterSortBy>
      thenByAllergyCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergyCategory', Sort.desc);
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension FoodAllergyQueryWhereDistinct
    on QueryBuilder<FoodAllergy, FoodAllergy, QDistinct> {
  QueryBuilder<FoodAllergy, FoodAllergy, QDistinct>
      distinctByAllergyCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allergyCategory');
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergy, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension FoodAllergyQueryProperty
    on QueryBuilder<FoodAllergy, FoodAllergy, QQueryProperty> {
  QueryBuilder<FoodAllergy, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FoodAllergy, FoodAllergyCategory, QQueryOperations>
      allergyCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allergyCategory');
    });
  }

  QueryBuilder<FoodAllergy, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

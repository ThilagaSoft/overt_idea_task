class Country {
  final Flag flag;
  final CountryName name;
  final String cca2;

  Country({
    required this.flag,
    required this.name,
    required this.cca2,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      flag: Flag.fromJson(json['flags']),
      name: CountryName.fromJson(json['name']),
      cca2: json['cca2'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'flags': flag.toJson(),
    'name': name.toJson(),
    'cca2': cca2,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Country && runtimeType == other.runtimeType && cca2 == other.cca2;

  @override
  int get hashCode => cca2.hashCode;
}
class Flag {
  final String png;
  final String svg;
  final String? alt;

  Flag({required this.png, required this.svg, this.alt});

  factory Flag.fromJson(Map<String, dynamic> json) => Flag(
    png: json['png'] ?? '',
    svg: json['svg'] ?? '',
    alt: json['alt'],
  );

  Map<String, dynamic> toJson() => {
    'png': png,
    'svg': svg,
    'alt': alt,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Flag &&
              runtimeType == other.runtimeType &&
              png == other.png &&
              svg == other.svg &&
              alt == other.alt;

  @override
  int get hashCode => png.hashCode ^ svg.hashCode ^ alt.hashCode;
}
class CountryName {
  final String common;
  final String official;
  final Map<String, NativeName> nativeName;

  CountryName({
    required this.common,
    required this.official,
    required this.nativeName,
  });

  factory CountryName.fromJson(Map<String, dynamic> json) {
    final native = (json['nativeName'] as Map<String, dynamic>?) ?? {};
    final parsedNative = {
      for (var key in native.keys)
        key: NativeName.fromJson(native[key])
    };

    return CountryName(
      common: json['common'] ?? '',
      official: json['official'] ?? '',
      nativeName: parsedNative,
    );
  }

  Map<String, dynamic> toJson() => {
    'common': common,
    'official': official,
    'nativeName': {
      for (var key in nativeName.keys) key: nativeName[key]!.toJson(),
    },
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CountryName &&
              runtimeType == other.runtimeType &&
              common == other.common &&
              official == other.official &&
              _mapEquals(nativeName, other.nativeName);

  @override
  int get hashCode =>
      common.hashCode ^ official.hashCode ^ nativeName.hashCode;

  // Helper method for deep map comparison
  bool _mapEquals(Map<String, NativeName> a, Map<String, NativeName> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || a[key] != b[key]) return false;
    }
    return true;
  }
}
class NativeName {
  final String common;
  final String official;

  NativeName({
    required this.common,
    required this.official,
  });

  factory NativeName.fromJson(Map<String, dynamic> json) => NativeName(
    common: json['common'] ?? '',
    official: json['official'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'common': common,
    'official': official,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NativeName &&
              runtimeType == other.runtimeType &&
              common == other.common &&
              official == other.official;

  @override
  int get hashCode => common.hashCode ^ official.hashCode;
}

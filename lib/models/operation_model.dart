class Operation {
  // final int? id;
  final String machine;
  final String nameCode;
  final String code;
  final String name;
  final String notes;
  final String images;

  Operation({
    // required this.id,
    required this.machine,
    required this.nameCode,
    required this.code,
    required this.name,
    required this.notes,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'machine': machine,
      'nameCode': nameCode,
      'code': code,
      'name': name,
      'notes': notes,
      'images': images,
    };
  }

    factory Operation.fromMap(Map<String, dynamic> map) {
    return Operation(
      machine: map['machine']?.toString() ?? '',
      nameCode: map['nameCode']?.toString() ?? '',
      code: map['code']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      notes: map['notes']?.toString() ?? '',
      images: map['images']?.toString() ?? '',
    );
  }

    factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
      machine: json['machine']?.toString() ?? '',
      nameCode: json['nameCode']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      notes: json['notes']?.toString() ?? '',
      images: json['images']?.toString() ?? '',
    );
  }
  @override
  String toString() {
    return 'Operation{code: $code, name: $name, notes: $notes, images: $images}';
  }

  Operation copyWith({
    // int? id,
    String? machine,
    String? nameCode,
    String? code,
    String? name,
    String? notes,
    String? images,
  }) {
    return Operation(
      code: code ?? this.code,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      // id: null,
      machine: machine ?? this.machine,
      nameCode: nameCode ?? this.nameCode,
      images: images ?? this.images,
    );
  }
}

class Record {
  late int id;
  late DateTime dateTime;
  late double weight;
  late String? photoUrl;
  late String? note;

  Record({required this.dateTime, required this.weight, this.photoUrl, this.note});

  Record.fromMap(Map<String, dynamic> data) {
    assert(data['id'] != null);
    assert(data['dateTime'] != null);
    assert(data['weight'] != null);
    id = data['id'];
    dateTime = DateTime.parse(data['dateTime']);
    weight = data['weight'].toDouble();
    photoUrl = data['photoUrl'];
    note = data['note'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime' : dateTime.toIso8601String(),
      'weight' : weight,
      'photoUrl' : photoUrl,
      'note' : note,
    };
  }
}
class Word {
  int id;
  List<String> keys;
  List<String> means;
  String note;

  Word({
    required this.id,
    required this.keys,
    required this.means,
    required this.note
  });

  factory Word.fromMap(Map<String, dynamic> json) => Word (
    id: json["id"],
    keys: json["keys"],
    means: json["means"],
    note: json["note"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "keys": keys,
    "means": means,
    "note": note
  };
}
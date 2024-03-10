class GrammarItem {
  int id;
  String form;
  String structure;

  GrammarItem({
    required this.id,
    required this.form,
    required this.structure
  });

  factory GrammarItem.fromMap(Map<String, dynamic> json) => GrammarItem (
    id: json["id"],
    form: json["form"],
    structure: json["structure"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "form": form,
    "structure": structure
  };
}
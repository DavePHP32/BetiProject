class Interprete {
  int id;
  String nom;

  Interprete({
    required this.id,
    required this.nom,
  });

  factory Interprete.fromJson(Map<String, dynamic> json) {
    return Interprete(
      id: json['id'],
      nom: json['nom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
    };
  }
}

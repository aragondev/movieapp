class Actor {
  final int id;
  final String name;
  final int birthYear;
  final String nationality;
  final List<String> knownFor;
  final List<String> awards;
  final String biography;
  final String image;

  Actor({
    required this.id,
    required this.name,
    required this.birthYear,
    required this.nationality,
    required this.knownFor,
    required this.awards,
    required this.biography,
    required this.image,
  });
}

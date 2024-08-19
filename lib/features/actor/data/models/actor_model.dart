import 'package:movie_app/features/actor/domain/entities/actor.dart';

class ActorModel extends Actor {
  ActorModel({
    required int id,
    required String name,
    required int birthYear,
    required String nationality,
    required List<String> knownFor,
    required List<String> awards,
    required String biography,
    required String image,
  }) : super(
          id: id,
          name: name,
          birthYear: birthYear,
          nationality: nationality,
          knownFor: knownFor,
          awards: awards,
          biography: biography,
          image: image,
        );

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
      id: json['id'],
      name: json['name'],
      birthYear: json['birth_year'],
      nationality: json['nationality'],
      knownFor: List<String>.from(json['known_for']),
      awards: List<String>.from(json['awards']),
      biography: json['biography'],
      image: json['image'],
    );
  }
}

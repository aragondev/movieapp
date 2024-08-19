import 'package:movie_app/features/actor/domain/entities/actor.dart';
import 'package:movie_app/features/actor/domain/repositores/actor_repository.dart';

class GetActorByName {
  final ActorRepository repository;

  GetActorByName({required this.repository});

  Future<Actor> call(String name) async {
    return await repository.getActorByName(name);
  }
}

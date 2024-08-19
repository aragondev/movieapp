import 'package:movie_app/features/actor/domain/entities/actor.dart';
import 'package:movie_app/features/actor/domain/repositores/actor_repository.dart';

class GetAllActors {
  final ActorRepository repository;

  GetAllActors(this.repository);

  Future<List<Actor>> call() async {
    return await repository.getAllActors();
  }
}

import 'package:movie_app/features/actor/domain/entities/actor.dart';

abstract class ActorRepository {
  Future<List<Actor>> getAllActors();
  Future<Actor> getActorByName(String name);
}

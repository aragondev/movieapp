import 'package:movie_app/features/actor/domain/entities/actor.dart';

abstract class ActorRepository {
  Future<List<Actor>> getAllActors();
  Future<Actor> getActorById(int id);
  Future<List<Actor>> searchActors(String query);
  Future<List<Actor>> getActorsWithLimit(int limit);
  Future<List<Actor>> sortActors(String sortBy, String order);
}

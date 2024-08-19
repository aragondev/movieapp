import 'package:movie_app/features/actor/data/datasources/actor_remote_data_source.dart';
import 'package:movie_app/features/actor/domain/entities/actor.dart';
import 'package:movie_app/features/actor/domain/repositores/actor_repository.dart';

class ActorRepositoryImpl implements ActorRepository {
  final ActorRemoteDataSource remoteDataSource;

  ActorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Actor>> getAllActors() async {
    return remoteDataSource.getAllActors();
  }

  @override
  Future<Actor> getActorById(int id) async {
    return remoteDataSource.getActorById(id);
  }

  @override
  Future<List<Actor>> searchActors(String query) async {
    return remoteDataSource.searchActors(query);
  }

  @override
  Future<List<Actor>> getActorsWithLimit(int limit) async {
    return remoteDataSource.getActorsWithLimit(limit);
  }

  @override
  Future<List<Actor>> sortActors(String sortBy, String order) async {
    return remoteDataSource.sortActors(sortBy, order);
  }
}

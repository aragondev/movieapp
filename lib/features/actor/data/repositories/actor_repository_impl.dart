import 'package:movie_app/features/actor/data/datasources/actor_remote_data_source.dart';
import 'package:movie_app/features/actor/domain/entities/actor.dart';
import 'package:movie_app/features/actor/domain/repositores/actor_repository.dart';

class ActorRepositoryImpl implements ActorRepository {
  final ActorRemoteDataSource remoteDataSource;

  ActorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Actor>> getAllActors() async {
    return await remoteDataSource.getAllActors();
  }

  @override
  Future<Actor> getActorByName(String name) async {
    return await remoteDataSource.getActorByName(name);
  }
}

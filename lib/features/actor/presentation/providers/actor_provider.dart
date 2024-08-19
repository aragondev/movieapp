import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/actor/data/datasources/actor_remote_data_source.dart';
import 'package:movie_app/features/actor/data/repositories/actor_repository_impl.dart';
import 'package:movie_app/features/actor/domain/entities/actor.dart';
import 'package:movie_app/features/actor/domain/usecases/get_all_actors.dart';

final actorsProvider = FutureProvider<List<Actor>>((ref) async {
  final getAllActors = ref.watch(getAllActorsProvider);
  return await getAllActors();
});

final getAllActorsProvider = Provider<GetAllActors>((ref) {
  final repository = ref.watch(actorRepositoryProvider);
  return GetAllActors(repository);
});

final actorRepositoryProvider = Provider<ActorRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(actorRemoteDataSourceProvider);
  return ActorRepositoryImpl(remoteDataSource: remoteDataSource);
});

final actorRemoteDataSourceProvider =
    Provider<ActorRemoteDataSourceImpl>((ref) {
  final dio = Dio();
  return ActorRemoteDataSourceImpl(dio: dio);
});

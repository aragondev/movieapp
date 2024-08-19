import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/actor/data/datasources/actor_remote_data_source.dart';
import 'package:movie_app/features/actor/data/repositories/actor_repository_impl.dart';
import 'package:movie_app/features/actor/domain/entities/actor.dart';
import 'package:movie_app/features/actor/domain/repositores/actor_repository.dart';
import 'package:movie_app/features/actor/domain/usecases/get_actor_by_name.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';

// Proveedor para la fuente de datos remota de actores
final actorRemoteDataSourceProvider = Provider<ActorRemoteDataSource>(
  (ref) => ActorRemoteDataSourceImpl(dioClient: ref.watch(dioProvider)),
);

// Proveedor para el repositorio de actores
final actorRepositoryProvider = Provider<ActorRepository>(
  (ref) => ActorRepositoryImpl(
      remoteDataSource: ref.watch(actorRemoteDataSourceProvider)),
);

// Proveedor para el caso de uso de obtener un actor por nombre
final getActorByNameProvider = Provider<GetActorByName>(
  (ref) => GetActorByName(repository: ref.watch(actorRepositoryProvider)),
);

// Proveedor para obtener detalles de un actor por nombre
final actorProvider =
    FutureProvider.family<Actor, String>((ref, actorName) async {
  return await ref.watch(getActorByNameProvider).call(actorName);
});

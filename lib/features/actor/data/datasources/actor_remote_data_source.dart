import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/features/actor/data/models/actor_model.dart';

abstract class ActorRemoteDataSource {
  Future<List<ActorModel>> getAllActors();
  Future<ActorModel> getActorByName(String name);
}

class ActorRemoteDataSourceImpl implements ActorRemoteDataSource {
  final DioClient dioClient;

  ActorRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<ActorModel>> getAllActors() async {
    final response = await dioClient.get('actors');
    return (response.data as List)
        .map((actor) => ActorModel.fromJson(actor))
        .toList();
  }

  @override
  Future<ActorModel> getActorByName(String name) async {
    final response =
        await dioClient.get('actors', queryParameters: {'search': name});
    final List<dynamic> data = response.data;

    if (data.isNotEmpty) {
      return ActorModel.fromJson(
          data[0]); // Tomar el primer elemento de la lista
    } else {
      throw Exception('Actor not found');
    }
  }
}

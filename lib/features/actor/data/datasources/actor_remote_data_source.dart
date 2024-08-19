import 'package:dio/dio.dart';
import 'package:movie_app/features/actor/data/models/actor_model.dart';

abstract class ActorRemoteDataSource {
  Future<List<ActorModel>> getAllActors();
  Future<ActorModel> getActorById(int id);
  Future<List<ActorModel>> searchActors(String query);
  Future<List<ActorModel>> getActorsWithLimit(int limit);
  Future<List<ActorModel>> sortActors(String sortBy, String order);
}

class ActorRemoteDataSourceImpl implements ActorRemoteDataSource {
  final Dio dio;

  ActorRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ActorModel>> getAllActors() async {
    final response = await dio.get('https://freetestapi.com/api/v1/actors');
    return (response.data as List)
        .map((actor) => ActorModel.fromJson(actor))
        .toList();
  }

  @override
  Future<ActorModel> getActorById(int id) async {
    final response = await dio.get('https://freetestapi.com/api/v1/actors/$id');
    return ActorModel.fromJson(response.data);
  }

  @override
  Future<List<ActorModel>> searchActors(String query) async {
    final response =
        await dio.get('https://freetestapi.com/api/v1/actors?search=$query');
    return (response.data as List)
        .map((actor) => ActorModel.fromJson(actor))
        .toList();
  }

  @override
  Future<List<ActorModel>> getActorsWithLimit(int limit) async {
    final response =
        await dio.get('https://freetestapi.com/api/v1/actors?limit=$limit');
    return (response.data as List)
        .map((actor) => ActorModel.fromJson(actor))
        .toList();
  }

  @override
  Future<List<ActorModel>> sortActors(String sortBy, String order) async {
    final response = await dio
        .get('https://freetestapi.com/api/v1/actors?sort=$sortBy&order=$order');
    return (response.data as List)
        .map((actor) => ActorModel.fromJson(actor))
        .toList();
  }
}

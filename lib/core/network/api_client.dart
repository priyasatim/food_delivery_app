import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../features/data/model/food_model.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/users")
  Future<List<FoodModel>> getUsers();

  @POST("/users")
  Future<FoodModel> createUser(@Body() Map<String, dynamic> body);
}
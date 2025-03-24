import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:task_management/core/api/app_api.dart';
import 'package:task_management/core/error/custom_error.dart';
import 'package:task_management/core/response/typedef.dart';

abstract interface class RemoteDatasource {
  const RemoteDatasource();

  Future<List<DataMap>> get fetchTask;

  Future<DataMap> addOrUpdateTask(DataMap value);

  static void inject(GetIt di) => di.registerLazySingleton<RemoteDatasource>(
    () => RemoteDatasourceImpl(di<Client>()),
  );
}

class RemoteDatasourceImpl extends RemoteDatasource {
  const RemoteDatasourceImpl(Client client) : _client = client;
  final Client _client;

  @override
  Future<DataMap> addOrUpdateTask(DataMap value) async {
    var response = await _client.post(
      Uri.parse(TaskApi.addTaskUrl),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      DataMap jsonResponse = json.decode(response.body);
      DataMap result = jsonResponse["task"];
      return result;
    }
    throw ServerError();
  }

  @override
  Future<List<DataMap>> get fetchTask async {
    var response = await _client.get(Uri.parse(TaskApi.fetchTaskUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<DataMap> list = List<DataMap>.from(jsonResponse);
      return list;
    }
    throw ServerError();
  }
}

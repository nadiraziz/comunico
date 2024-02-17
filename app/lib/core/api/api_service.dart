// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, non_constant_identifier_names
import 'dart:developer';
import 'package:app/controller/sharedpreference/sharedpreference_controller.dart';
import 'package:app/helper/constant/api_urls.dart';
import 'package:dio/dio.dart';

// ApiService class for making HTTP requests and handling errors

class APIService {
  final Dio _dio = Dio();

  APIService() {
    _setupInterceptors();
  }

  // Setup Dio interceptors for handling authentication
  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.validateStatus = (int? status) {
          // Return true if the status code is considered a success, false otherwise.
          // You can define custom logic here.
          if (status! > 500) {
            log("Server down!, Please check with backend");
          }
          return true;
        };
        // Add authentication token to headers if available
        final token = SharedPreferenceController().getAccessToken();

        if (token != null) {
          options.headers['Authorization'] = "JWT $token";
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle responses, e.g., token refresh if needed
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        if (e.response?.statusCode == 502) {
          log("Server Down!");
        } else {
          return handler.next(e);
        }
      },
    ));
  }

  // Perform a GET request and return a result wrapped in Either
  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final response =
          await _dio.get(APIUrl.baseUrl + path, queryParameters: params);

      return response;
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception(e);
    }
  }

  // Perform a POST request and return a result wrapped in Either
  Future<Response<dynamic>> post({
    required String path,
    required dynamic data,
    Map<String, dynamic>? params,
  }) async {
    return await _dio.post(APIUrl.baseUrl + path,
        data: data, queryParameters: params);
  }

  // Perform a PUT request and return a result wrapped in Either
  Future<Response> put(String path, dynamic data,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.put(APIUrl.baseUrl + path,
          data: data, queryParameters: params);
      return response;
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception(e);
    }
  }

  // Perform a DELETE request and return a result wrapped in Either
  Future<Response> delete(String path, dynamic data,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.delete(APIUrl.baseUrl + path,
          data: data, queryParameters: params);

      return response;
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception(e);
    }
  }
}

enum APIRequestMethodType { post, get, delete, put }

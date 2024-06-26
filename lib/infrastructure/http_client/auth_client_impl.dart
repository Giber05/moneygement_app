import 'dart:convert';

import 'package:moneygement_app/infrastructure/http_client/api_client.dart';
import 'package:moneygement_app/infrastructure/env/network_constants.dart';
import 'package:moneygement_app/infrastructure/ext/map_ext.dart';
import 'package:moneygement_app/infrastructure/types/exceptions/base_exception.dart';
import 'package:moneygement_app/infrastructure/types/exceptions/form_exception.dart';
import 'package:moneygement_app/infrastructure/types/exceptions/session_exception.dart';
import 'package:moneygement_app/infrastructure/types/json.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@Named("AuthClient")
@LazySingleton(as: APIClient)
class AuthClient implements APIClient {
  @override
  String get baseURL => NetworkConstants.apiAuthUrl;

  @override
  String buildFullUrl(
    String extraPath,
  ) =>
      "$baseURL$extraPath";

  @override
  Future<APIResult<T>> delete<T>(
      {required String path,
      required MapFromJSON<T> mapper,
      Map<String, String>? headers,
      body,
      String? token,
      Map<String, dynamic>? query,
      bool shouldPrint = false,
      bool useBaseUrl = true,
      MockedResult? mockResult}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<APIResult<T>> get<T>(
      {required String path,
      Map<String, String>? headers,
      required MapFromJSON<T> mapper,
      Map<String, dynamic>? query,
      bool shouldPrint = false,
      String? token,
      bool useBaseUrl = true,
      MockedResult? mockResult}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<APIResult<T>> post<T>(
      {required String path,
      required MapFromJSON<T> mapper,
      Map<String, String>? headers,
      body,
      String? token,
      Map<String, dynamic>? query,
      bool shouldPrint = false,
      bool useBaseUrl = true,
      MockedResult? mockResult}) async {
    try {
      final uri = Uri.parse(buildFullUrl(path)).replace(queryParameters: _buildQuery(query, token));
      final finalHeader = _buildHeader(headers);
      final response = mockResult != null
          ? _mockResult(mockResult)
          : await http.post(
              uri,
              headers: finalHeader,
              body: jsonEncode(body),
            );
      final result = _handleResponse(response, mapper, shouldPrint, path,
          headers: finalHeader, body: body, query: query, token: token);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<APIResult<T>> put<T>(
      {required String path,
      required MapFromJSON<T> mapper,
      Map<String, String>? headers,
      body,
      String? token,
      Map<String, dynamic>? query,
      bool useBaseUrl = true,
      bool shouldPrint = false,
      MockedResult? mockResult}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  Map<String, String> _buildHeader(Map<String, dynamic>? headers) {
    return {
      "Content-Type": "application/json",
      if (headers != null) ...headers,
    };
  }

  Map<String, dynamic>? _buildQuery(Map<String, dynamic>? query, String? token) {
    if (query == null && token == null) return null;
    return {if (query != null) ...query, if (token != null) "token": token};
  }

  APIResult<T> _handleResponse<T>(http.Response response, MapFromJSON<T> mapper, bool shouldPrint, String url,
      {Map<String, String>? headers, JSON? body, Map<String, dynamic>? query, String? token}) {
    if (shouldPrint) {
      _printResponse(response, url, headers: headers, requestBody: body, query: query, token: token);
    }

    final result = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final mappedData = mapper(result);
      return APIResult<T>(status: "OK", data: mappedData, message: "", code: response.statusCode);
    }
    if (response.statusCode == 401) {
      throw const SessionException("UnAuthorized");
    }
    final resultBody = jsonDecode(response.body);
    if (resultBody is Map<String, dynamic>) {
      final message = resultBody.getOrNull("error");
      if (message != null) throw BaseException(message);
      final title = resultBody.getOrNull("title");
      if (title != null) {
        final Map<String, List<dynamic>> plainError = Map.from(resultBody["errors"]);
        throw FormException(title,
            errors: plainError.map((key, value) => MapEntry(key, value.map((e) => e.toString()).toList())));
      }
    }
    throw BaseException.unknownError();
  }

  void _printResponse(http.Response response, String url,
      {dynamic requestBody, Map<String, String>? headers, Map<String, dynamic>? query, String? token}) {
    if (kReleaseMode) return;
    debugPrint("====^^^^^^^^^^^^^^^===");
    debugPrint("URL : ${buildFullUrl(url)}");
    debugPrint("Method : ${response.request?.method}");
    if (headers != null) {
      debugPrint("====== Headers =====");
      _printJSONSafely(jsonEncode(headers));
    }

    final finalQuery = _buildQuery(query, token);
    if (finalQuery != null) {
      debugPrint("==== Queries ====");
      _printJSONSafely(jsonEncode(finalQuery));
    }

    if (requestBody != null) {
      debugPrint("====== Request Body =====");
      if (requestBody is List || requestBody is Map<String, dynamic>) {
        _printJSONSafely(jsonEncode(requestBody));
      } else if (requestBody is String) {
        debugPrint("Body String : $requestBody");
      }
    }
    debugPrint("Status Code : ${response.statusCode}");
    debugPrint("====== Response Body =====");
    final responseBody = response.body;
    _printJSONSafely(responseBody);
    debugPrint("===vvvvvvvvvvvvvvvvv==");
  }

  dynamic tryDecode(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      return null;
    }
  }

  void _printJSONSafely(String body) {
    try {
      if (body.isEmpty) {
        debugPrint("Empty Body");
      } else {
        JsonDecoder decoder = const JsonDecoder();
        final object = decoder.convert(body);
        JsonEncoder encoder = const JsonEncoder.withIndent('  ');
        String prettyprint = encoder.convert(object);
        prettyprint.split('\n').forEach((element) => debugPrint(element));
      }
    } catch (e) {
      debugPrint("UnFormatted");
      debugPrint(body);
    }
  }

  http.Response _mockResult(MockedResult mockedResult) {
    return http.Response(jsonEncode(mockedResult.result), mockedResult.statusCode, headers: mockedResult.headers);
  }
}

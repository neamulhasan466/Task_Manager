import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  /// GET request
  static Future<ApiResponse> getRequest({required String url}) async {
    Uri uri = Uri.parse(url);
    _logRequest(url);

    try {
      final http.Response response = await http
          .get(uri)
          .timeout(const Duration(seconds: 10));
      _logResponse(url, response);

      final int statusCode = response.statusCode;
      final decodedData = _tryDecode(response.body);

      if (statusCode == 200) {
        return ApiResponse(
          isSuccess: true,
          responseCode: statusCode,
          responseData: decodedData,
        );
      } else {
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedData,
          errorMessage: 'Request failed with status: $statusCode',
        );
      }
    } on SocketException {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: 'No Internet connection',
      );
    } on Exception catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  /// POST request
  static Future<ApiResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    Uri uri = Uri.parse(url);
    _logRequest(url, body: body);

    try {
      final http.Response response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      _logResponse(url, response);

      final int statusCode = response.statusCode;
      final decodedData = _tryDecode(response.body);

      if (statusCode == 200 || statusCode == 201) {
        return ApiResponse(
          isSuccess: true,
          responseCode: statusCode,
          responseData: decodedData,
        );
      } else {
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedData,
          errorMessage: 'Request failed with status: $statusCode',
        );
      }
    } on SocketException {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: 'No Internet connection',
      );
    } on Exception catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  /// Helper to safely decode JSON
  static dynamic _tryDecode(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return body;
    }
  }

  /// Logging
  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i(
      'REQUEST → $url\nBODY → ${body != null ? jsonEncode(body) : 'N/A'}',
    );
  }

  static void _logResponse(String url, http.Response response) {
    _logger.i(
      'RESPONSE ← $url\nSTATUS: ${response.statusCode}\nBODY: ${response.body}',
    );
  }
}

class ApiResponse {
  final bool isSuccess;
  final dynamic responseData;
  final int responseCode;
  final String? errorMessage;

  ApiResponse({
    required this.isSuccess,
    required this.responseCode,
    required this.responseData,
    this.errorMessage,
  });
}

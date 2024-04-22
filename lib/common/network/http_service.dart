import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:challenge_disruptive/common/network/models/http_services_response.dart';
import 'package:challenge_disruptive/common/user_preferences.dart';
import 'package:challenge_disruptive/tools/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpService {
  String url = constants.domain;
  String timeoutMessage =
      'We couldn\'t connect to our servers. Try again in a moment.';

  Future<String?>? token() async {
    return prefs.jwt;
  }

  Future<HttpServiceResponse> get(
      {required String endpoint, http.Client? client}) async {
    http.Client? httpClient = client ?? http.Client();

    try {
      Response response =
          await httpClient.get(Uri.parse("$url$endpoint"), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        // if (await token() != null)
        //   HttpHeaders.authorizationHeader: "Bearer ${await token()}",
      }).timeout(
        const Duration(seconds: 10),
        onTimeout: (() => throw TimeoutException("{'error': 'Timeout'}")),
      );
      return validateResponse(response);
    } on TimeoutException catch (_) {
      return HttpServiceResponse(success: false, message: timeoutMessage);
    } catch (e) {
      return HttpServiceResponse(success: false, message: "$e");
    }
  }

  Future<HttpServiceResponse> post({
    required String endpoint,
    required Map<String, dynamic> body,
    bool? needAuth = true,
    http.Client? client,
  }) async {
    log('[http-service] [post]'
        '\nbody: ${json.encode(body)}');
    http.Client? httpClient = client ?? http.Client();
    try {
      Response response = await httpClient
          .post(Uri.parse("$url$endpoint"), body: json.encode(body), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        if (needAuth!)
          if (await token() != null)
            HttpHeaders.authorizationHeader: "Bearer ${await token()}",
      }).timeout(
        const Duration(seconds: 250),
        onTimeout: (() => throw TimeoutException("{'error': 'Timeout'}")),
      );
      return await validateResponse(response);
    } on SocketException catch (_) {
      return HttpServiceResponse(
          success: false,
          errorCode: 250,
          message:
              "Parece que no tienes internet. Revisa tu conexión e inténtalo de nuevo.");
    } on TimeoutException catch (_) {
      return HttpServiceResponse(success: false, message: timeoutMessage);
    } catch (e) {
      return HttpServiceResponse(
        success: false,
        body: "$e",
        message:
            "En este momento nuestro servicio está experimentando una falla técnica. Por favor vuelve a intentarlo.",
      );
    }
  }

  Future<HttpServiceResponse> validateResponse(Response response) async {
    bool success = false;
    String message = "";
    String res =
        response.request?.method != "GET" ? '[response]: ${response.body}' : "";
    log('[http-service] [validateResponse]');
    log(res);
    log('\n StatusCode: ${response.statusCode}');
    log('\nURL: ${response.request}');

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        success = true;
        break;
      case 401:
        success = false;
        message = "El tiempo de sesión ha  expirado, inténtalo de nuevo.";
        return HttpServiceResponse(
            success: false, errorCode: response.statusCode, message: message);
      case 404:
      case 408:
      case 500:
      case 503:
        success = false;
        message =
            "Nuestro servicio está experimentando una falla técnica. Inténtalo más tarde.";
        return HttpServiceResponse(
            success: false, errorCode: response.statusCode, message: message);

      default:
        return HttpServiceResponse(
            success: false,
            errorCode: 100,
            message:
                "Parece que no tienes internet. Revisa tu conexión e inténtalo de nuevo.");
    }

    Map<String, dynamic> body = json.decode(response.body);

    if (body.containsKey("idError")) {
      if (body["idError"] != 0) {
        return HttpServiceResponse(
            success: false,
            errorCode: body["idError"],
            body: response.body,
            message: body["mensaje"]);
      }
    }
    return HttpServiceResponse(
        success: success, message: response.body, body: response.body);
  }
}

final HttpService httpService = HttpService();

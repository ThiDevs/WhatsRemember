import 'dart:convert';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start WhatsRememberAPI Group Code

class WhatsRememberAPIGroup {
  static String baseUrl =
      'https://b26e-2804-14d-ae83-87cc-ed78-324e-b28f-d6ed.sa.ngrok.io';
  static Map<String, String> headers = {};
  static VerifiqueNumberCall verifiqueNumberCall = VerifiqueNumberCall();
}

class VerifiqueNumberCall {
  Future<ApiCallResponse> call({
    String? number = '22',
  }) {
    final body = '''
{
  "number": "${number}",
  "txt": "Numero verificado. :)"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VerifiqueNumber',
      apiUrl: '${WhatsRememberAPIGroup.baseUrl}/sendMessage',
      callType: ApiCallType.POST,
      headers: {
        ...WhatsRememberAPIGroup.headers,
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }
}

/// End WhatsRememberAPI Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

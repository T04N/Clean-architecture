import 'package:dio/dio.dart';
import 'package:nvvm/app/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio(); // Không cần từ khóa 'new' trong Dart hiện đại
    int _timeOut = 60 * 1000;  // Thời gian timeout (60 giây)

    // Tạo headers
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      DEFAULT_LANGUAGE: "en"
    };

    // Thiết lập BaseOptions cho Dio
    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: Duration(milliseconds:_timeOut ) ,   // Thời gian chờ kết nối
      receiveTimeout: Duration(milliseconds:_timeOut ),   // Thời gian chờ nhận phản hồi
      headers: headers,           // Headers truyền vào cho request
    );

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,      // Log phần headers của request
      requestBody: true,        // Log body của request (nếu có)
      responseBody: true,       // Log body của response
      responseHeader: false,    // Không cần log headers của response
    ));
    return dio;  // Trả về Dio đã được cấu hình
  }
}

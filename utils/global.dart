import '../../features/service/domain/entities/service_customer_view_entity.dart';
import '../features/kyc_document_details_lang/domain/entities/kyc_document_details_lang_entity.dart';

List<GetCustomerViewJsonResultEntity> globalGetCustomerViewJsonResult = [];
List<LangDetailsEntity> globalGetLanguageResult = [];
List<GetKycDocDetailsSearchEntity> globalGetKYCResult = [];
String adviceNo = "";
String imagePkId = "";

final Global global = Global();

class Global {
  String _mobileModel = "";
  String _androidID = "";
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _connectivityType = "";

  String get mobileModel => _mobileModel;
  String get androidID => _androidID;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get connectivityType => _connectivityType;

  set latitude(double latitude) {
    if (latitude == 0.0) {
      _latitude = latitude;
    }
  }

  set longitude(double longitude) {
    if (longitude == 0.0) {
      _longitude = longitude;
    }
  }

  set connectivityType(String connectivityType) {
    if (mobileModel.isNotEmpty) {
      _connectivityType = connectivityType;
    }
  }

  set mobileModel(String mobileModel) {
    if (mobileModel.isNotEmpty) {
      _mobileModel = mobileModel;
    }
  }

  set androidID(String androidID) {
    if (androidID.isNotEmpty) {
      _androidID = androidID;
    }
  }
}

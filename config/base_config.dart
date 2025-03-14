abstract class BaseConfig {
  String get scheme;
  String get apiHost;
  String get getToken;
  String get login;
  String get svsMobileService;
  String get arcUnoExtendableservice;
  String get loginService;
  String get unoMobileService;
  String get arcUnoExtendableServiceResestService;
  String get getMenuDetails;
  String get unoMobileServiceResestService;
  String get getMyCustomerLoanData;
  // String get loanArrearChecking;
}

class DevConfig implements BaseConfig {
  @override
  String get scheme => "http://";
  @override
  String get apiHost => "${scheme}192.169.0.154";
  @override
  String get svsMobileService =>
      "$apiHost/SVSMobileService/SVSMobileService.svc";
  @override
  String get arcUnoExtendableservice =>
      "$apiHost/ARCUnoExtendableservice/UnoExtService.svc";
  @override
  String get loginService => "$apiHost/SVSServiceProjectSARC/LoginService.svc";
  @override
  String get unoMobileService => "$apiHost/UnoMobileService/UnoExtService.svc";
  @override
  String get login => "$loginService/LoginServiceCall";
  @override
  String get getToken => "$loginService/GetToken";

  @override
  String get arcUnoExtendableServiceResestService =>
      "$arcUnoExtendableservice/RestService";
  @override
  String get getMenuDetails =>
      "$arcUnoExtendableServiceResestService/MNovaServiceCall";

  @override
  String get unoMobileServiceResestService => "$unoMobileService/RestService";

  @override
  String get getMyCustomerLoanData =>
      "$unoMobileServiceResestService/CollectionServiceCall";

  // @override
  // String get loanArrearChecking => "$unoMobileServiceResestService/MNovaServiceCall";
}

class StagingConfig implements BaseConfig {
  @override
  String get scheme => "http://";
  @override
  String get apiHost => "${scheme}ebs.novactech.in";

  @override
  String get svsMobileService =>
      "$apiHost/SVSMobileService/SVSMobileService.svc";
  @override
  String get arcUnoExtendableservice =>
      "$apiHost/ARCUnoExtendableservice/UnoExtService.svc";
  @override
  String get loginService => "$apiHost/ARCSERV/LoginService.svc";
  @override
  String get unoMobileService => "$apiHost/UnoMobileService/UnoExtService.svc";
  @override
  String get login => "$loginService/LoginServiceCall";
  @override
  String get getToken => "$loginService/GetToken";

  @override
  String get arcUnoExtendableServiceResestService =>
      "$arcUnoExtendableservice/RestService";
  @override
  String get getMenuDetails =>
      "$arcUnoExtendableServiceResestService/MNovaServiceCall";

  @override
  String get unoMobileServiceResestService => "$unoMobileService/RestService";

  @override
  String get getMyCustomerLoanData =>
      "$unoMobileServiceResestService/CollectionServiceCall";
}

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => throw UnimplementedError();

  @override
  String get svsMobileService => "$apiHost/SVSMobileService";
  @override
  String get arcUnoExtendableservice => "$apiHost/SVSMobileService";
  @override
  String get loginService => "$apiHost/SVSMobileService";
  @override
  String get unoMobileService => "$apiHost/SVSMobileService";
  @override
  String get login => "";
  @override
  String get getToken => throw UnimplementedError();

  @override
  String get scheme => throw UnimplementedError();
  @override
  String get arcUnoExtendableServiceResestService =>
      "$arcUnoExtendableservice/RestService";
  @override
  String get getMenuDetails =>
      "$arcUnoExtendableServiceResestService/MNovaServiceCall";
  @override
  String get unoMobileServiceResestService => "$unoMobileService/RestService";

  @override
  String get getMyCustomerLoanData =>
      "$unoMobileServiceResestService/CollectionServiceCall";
}

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String dev = 'DEV';
  static const String sit = 'STAGING';
  static const String production = 'PROD';

  BaseConfig? config;
  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.production:
        return ProdConfig();
      case Environment.sit:
        return StagingConfig();
      default:
        return DevConfig();
    }
  }
}

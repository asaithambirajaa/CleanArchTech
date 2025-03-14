import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sarpl/core/features/kyc_document_details_lang/data/datasource/remote_datasource.dart';
import 'package:sarpl/core/features/kyc_document_details_lang/data/repositories/kyc_document_language_repository_impl.dart';
import 'package:sarpl/core/features/kyc_document_details_lang/domain/usecase/get_kyc_language_usecase.dart';
import 'package:sarpl/core/features/kyc_document_details_lang/presentation/cubit/kyc_language_cubit.dart';
import 'package:sarpl/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:sarpl/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sarpl/features/auth/domain/repositories/auth_repository.dart';
import 'package:sarpl/features/auth/domain/usecase/change_password_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/check_userid_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/forgot_mpin_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/get_token_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/get_verification_code_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/login_service_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/password_expiry_send_otp_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/password_expiry_verify_otp_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/set_mpin_usecase.dart';
import 'package:sarpl/features/auth/domain/usecase/verify_code_usecase.dart';
import 'package:sarpl/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sarpl/features/customer_loan_info/data/datasource/customer_loan_info_remote_datasource.dart';
import 'package:sarpl/features/customer_loan_info/domain/repositories/customer_loan_info_repo.dart';
import 'package:sarpl/features/customer_loan_info/domain/usecase/customer_loan_info_usecase.dart';
import 'package:sarpl/features/customer_loan_info/domain/usecase/get_menu_details_usecase.dart';
import 'package:sarpl/features/customer_loan_info/domain/usecase/loan_arrear_checking_usecase.dart';
import 'package:sarpl/features/customer_loan_info/domain/usecase/post_collection_image_storing_usecase.dart';
import 'package:sarpl/features/customer_loan_info/domain/usecase/view_loan_details_usecase.dart';
import 'package:sarpl/features/customer_loan_info/presentation/cubit/customer_loan_info_cubit.dart';
import 'package:sarpl/features/service/data/datasource/service_search_remote_datasource.dart';
import 'package:sarpl/features/service/data/repositories/service_search_repository_impl.dart';
import 'package:sarpl/features/service/domain/repositories/service_search_repository.dart';
import 'package:sarpl/features/service/domain/usecase/change_request_usecase.dart';
import 'package:sarpl/features/service/domain/usecase/fetch_customer_view_usecase.dart';
import 'package:sarpl/features/service/domain/usecase/get_address_using_pincode_usecase.dart';
import 'package:sarpl/features/service/domain/usecase/get_change_request_usecase.dart';
import 'package:sarpl/features/service/domain/usecase/get_mn_details_new_usecase.dart';
import 'package:sarpl/features/service/domain/usecase/search_usecase.dart';
import 'package:sarpl/features/service/domain/usecase/send_otp_usecase.dart';
import 'package:sarpl/features/service/domain/usecase/send_post_mobile_no_change_request_usecase.dart';
import 'package:sarpl/features/service/domain/usecase/verify_emailid_usecase.dart';
import 'package:sarpl/features/service/domain/usecase/verify_otp_usecase.dart';
import 'package:sarpl/features/service/presentation/cubit/service_cubit.dart';
import 'package:sarpl/features/transaction/data/datasource/last_transaction_datasource.dart';
import 'package:sarpl/features/transaction/data/repositories/last_transaction_repository_impl.dart';
import 'package:sarpl/features/transaction/domain/repositories/last_transaction_repository.dart';
import 'package:sarpl/features/transaction/domain/usecase/fetch_last_transaction_usecase.dart';
import 'package:sarpl/features/transaction/presentation/cubit/last_transaction_cubit.dart';

import 'core/core.dart';
import 'core/features/kyc_document_details_lang/domain/repositories/kyc_document_language_repository.dart';
import 'features/auth/domain/usecase/forgot_pwd_usecase.dart';
import 'features/customer_loan_info/data/repositories/customer_loan_info_repo_Impl.dart';
import 'features/customer_loan_info/domain/usecase/save_receipt_usecase.dart';
import 'features/service/domain/usecase/change_request_save_img_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Dio
  sl.registerLazySingleton(() => Dio());
  BaseApiService apiService = NetworkApiService(sl());
  sl.registerFactory<BaseApiService>(() => apiService);
  // Cubit

  sl.registerFactory<AuthCubit>(() => AuthCubit(
      sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  // Usecase
  sl.registerFactory<LoginServiceUsecase>(() => LoginServiceUsecase(sl()));
  sl.registerFactory<ChangePasswordUsecase>(() => ChangePasswordUsecase(sl()));
  sl.registerFactory<GetTokenUsecase>(() => GetTokenUsecase(sl()));
  sl.registerFactory<CheckUserIdUsecase>(() => CheckUserIdUsecase(sl()));
  sl.registerFactory<GetVerificationCodeUsecase>(
      () => GetVerificationCodeUsecase(sl()));
  sl.registerFactory<SetMpinUsecase>(() => SetMpinUsecase(sl()));
  sl.registerFactory<ForgotMpinUsecase>(() => ForgotMpinUsecase(sl()));
  sl.registerFactory<ForgotPwdUsecase>(() => ForgotPwdUsecase(sl()));
  sl.registerFactory<VerifyCodeUsecase>(() => VerifyCodeUsecase(sl()));
  sl.registerFactory<PasswordExpirySendOTPUsecase>(
      () => PasswordExpirySendOTPUsecase(sl()));
  sl.registerFactory<PasswordExpiryVerifyOTPUsecase>(
      () => PasswordExpiryVerifyOTPUsecase(sl()));
  // Repository
  sl.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDatasource: sl()));
  // Datasource
  sl.registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasouceImpl(baseApiService: sl()));

  sl.registerFactory<CustomerLoanInfoCubit>(
      () => CustomerLoanInfoCubit(sl(), sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory<CustomerLoanInfoUsecase>(
      () => CustomerLoanInfoUsecase(sl()));
  sl.registerFactory<SaveReceiptUsecase>(() => SaveReceiptUsecase(sl()));
  sl.registerFactory<PostCollectionImageStoringUsecase>(
      () => PostCollectionImageStoringUsecase(sl()));

  sl.registerFactory<GetMenuDetailsUsecase>(() => GetMenuDetailsUsecase(sl()));
  sl.registerFactory<LoanArrearCheckingUsecase>(
      () => LoanArrearCheckingUsecase(sl()));
  sl.registerFactory<ViewLoanDetailsUsecase>(
      () => ViewLoanDetailsUsecase(sl()));

  sl.registerFactory<CustomerLoanInfoRepository>(
    () => CustomerLoanInfoRepoImpl(remoteDatasource: sl()),
  );

  sl.registerFactory<ConnectivityCubit>(
    () => ConnectivityCubit(),
  );

  sl.registerFactory<CustomerLoanInfoRemoteDatasource>(
    () => CustomerLoanInfoRemoteDatasourceImpl(baseApiService: sl()),
  );

  // Last Transaction
  sl.registerFactory<KycLanguageCubit>(() => KycLanguageCubit(sl()));
  sl.registerFactory<GetKycLanguageUsecase>(() => GetKycLanguageUsecase(sl()));
  sl.registerFactory<KycDocumentLanguageRepository>(
      () => KycDocumentLanguageRepositoryImpl(remoteDatasource: sl()));
  sl.registerFactory<RemoteDatasource>(
      () => RemoteDatasourceImpl(apiService: sl()));

  // Last Transaction
  sl.registerFactory<LastTransactionCubit>(() => LastTransactionCubit(sl()));
  sl.registerFactory<FetchLastTransactionUsecase>(
      () => FetchLastTransactionUsecase(sl()));
  sl.registerFactory<LastTransactionRepository>(
      () => LastTransactionRepositoryImpl(remoteDatasource: sl()));
  sl.registerFactory<LastTransactionRemoteDatasource>(
      () => LastTransactionRemoteDatasourceImpl(baseApiService: sl()));
  // Service
  sl.registerFactory<ServiceCubit>(() =>
      ServiceCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<SearchUsecase>(() => SearchUsecase(sl()));
  sl.registerFactory<GetMnDetailsNewUsecase>(
      () => GetMnDetailsNewUsecase(sl()));
  sl.registerFactory<GetChangeRequestUsecase>(
      () => GetChangeRequestUsecase(sl()));
  sl.registerFactory<FetchCustomerViewUsecase>(
      () => FetchCustomerViewUsecase(sl()));
  sl.registerFactory<ChangeRequestUsecase>(() => ChangeRequestUsecase(sl()));
  sl.registerFactory<VerifyEmailidUsecase>(() => VerifyEmailidUsecase(sl()));
  sl.registerFactory<SendOtpUsecase>(() => SendOtpUsecase(sl()));
  sl.registerFactory<VerifyOtpUsecase>(() => VerifyOtpUsecase(sl()));
  sl.registerFactory<SendPostMobileNoChangeRequestUsecase>(
      () => SendPostMobileNoChangeRequestUsecase(sl()));
  sl.registerFactory<GetAddressUsingPincodeUsecase>(
      () => GetAddressUsingPincodeUsecase(sl()));
  sl.registerFactory<ChangeRequestSaveImgUsecase>(
      () => ChangeRequestSaveImgUsecase(sl()));
  sl.registerFactory<ServiceSearchRepository>(
      () => ServiceSearchRepositoryImpl(remoteDatasource: sl()));
  sl.registerFactory<ServiceSearchRemoteDatasource>(
      () => ServiceSearchRemoteDatasourceImpl(baseApiService: sl()));
}

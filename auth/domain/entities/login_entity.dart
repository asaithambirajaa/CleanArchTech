import 'package:equatable/equatable.dart';

class DoLoginSessionIDNewResultEntity extends Equatable {
  final DoLoginAndGetSessionIDNewResultEntity doLoginAndGetSessionIDNewResult;

  const DoLoginSessionIDNewResultEntity(
      {required this.doLoginAndGetSessionIDNewResult});

  @override
  List<Object?> get props => [doLoginAndGetSessionIDNewResult];
}

class DoLoginAndGetSessionIDNewResultEntity extends Equatable {
  final String errorMessage;
  final String userID;
  final String userName;
  final String loggedIn;
  final String sessionID;
  final String fOUnit;
  final String instrGapDays;
  final String systemDate;
  final String cashLimit;
  final String totalCollected;
  final String totalRemitted;
  final String uRLAgreementsByAgNo;
  final String uRLAgreementsByCustName;
  final String uRLAgreementsByVehNo;
  final String uRLChangePassword;
  final String uRLChangeTPIN;
  final String uRLReceipt;
  final String uRLGetNonPymtReasons;
  final String uRLFollowUp;
  final String uRLVersionUpdater;
  final String uRLResetTPIN;
  final String uRLLastTransaction;
  final String uRLReminder;
  final String uRLReminderDetail;
  final String uRLRanking;
  final String uRLAgreementService;
  final String uRLLeadURLs;
  final String userMobile;
  final String initMoneyOption;
  final String hRMSDOWNURL;
  final int minMobNoRng;
  final int maxMobNoRng;
  final String fingerPrint;
  final String morningNote;
  final String notification1;
  final String notification2;
  final String notification3;
  final String birthWish;
  final String iMEIChangedFlag;
  final String downloadPending;
  final String nextHybridVersion;
  final String nextHybridVersionURL;
  final String karzaGenerateURL;
  final String karzaGenerateAuthorizationKey;
  final String bridgecallvendor;
  final String bridgecallURL;
  final String cRMAppURL;
  final String sGIDownLoadURL;
  final String sGICUserID;
  final String sLICUserID;
  final String sLICDownLoadURL;
  final String sLICActivityName;
  final String sLICPackageName;
  final String jSONGoDigitValue;
  final String goDigitUserId;
  final String investmentAppData;
  final String covidEntryScreenShow;
  final String legalUser;
  final String sCUFUserID;

  const DoLoginAndGetSessionIDNewResultEntity({
    required this.errorMessage,
    required this.userID,
    required this.userName,
    required this.loggedIn,
    required this.sessionID,
    required this.fOUnit,
    required this.instrGapDays,
    required this.systemDate,
    required this.cashLimit,
    required this.totalCollected,
    required this.totalRemitted,
    required this.uRLAgreementsByAgNo,
    required this.uRLAgreementsByCustName,
    required this.uRLAgreementsByVehNo,
    required this.uRLChangePassword,
    required this.uRLChangeTPIN,
    required this.uRLReceipt,
    required this.uRLGetNonPymtReasons,
    required this.uRLFollowUp,
    required this.uRLVersionUpdater,
    required this.uRLResetTPIN,
    required this.uRLLastTransaction,
    required this.uRLReminder,
    required this.uRLReminderDetail,
    required this.uRLRanking,
    required this.uRLAgreementService,
    required this.uRLLeadURLs,
    required this.userMobile,
    required this.initMoneyOption,
    required this.hRMSDOWNURL,
    required this.minMobNoRng,
    required this.maxMobNoRng,
    required this.fingerPrint,
    required this.morningNote,
    required this.notification1,
    required this.notification2,
    required this.notification3,
    required this.birthWish,
    required this.iMEIChangedFlag,
    required this.downloadPending,
    required this.nextHybridVersion,
    required this.nextHybridVersionURL,
    required this.karzaGenerateURL,
    required this.karzaGenerateAuthorizationKey,
    required this.bridgecallvendor,
    required this.bridgecallURL,
    required this.cRMAppURL,
    required this.sGIDownLoadURL,
    required this.sGICUserID,
    required this.sLICUserID,
    required this.sLICDownLoadURL,
    required this.sLICActivityName,
    required this.sLICPackageName,
    required this.jSONGoDigitValue,
    required this.goDigitUserId,
    required this.investmentAppData,
    required this.covidEntryScreenShow,
    required this.legalUser,
    required this.sCUFUserID,
  });
//6383475565
  @override
  List<Object?> get props => [
        errorMessage,
        userID,
        userName,
        loggedIn,
        sessionID,
        fOUnit,
        instrGapDays,
        systemDate,
        cashLimit,
        totalCollected,
        totalRemitted,
        uRLAgreementsByAgNo,
        uRLAgreementsByCustName,
        uRLAgreementsByVehNo,
        uRLChangePassword,
        uRLChangeTPIN,
        uRLReceipt,
        uRLGetNonPymtReasons,
        uRLFollowUp,
        uRLVersionUpdater,
        uRLResetTPIN,
        uRLLastTransaction,
        uRLReminder,
        uRLReminderDetail,
        uRLRanking,
        uRLAgreementService,
        uRLLeadURLs,
        userMobile,
        initMoneyOption,
        hRMSDOWNURL,
        minMobNoRng,
        maxMobNoRng,
        fingerPrint,
        morningNote,
        notification1,
        notification2,
        notification3,
        birthWish,
        iMEIChangedFlag,
        downloadPending,
        nextHybridVersion,
        nextHybridVersionURL,
        karzaGenerateURL,
        karzaGenerateAuthorizationKey,
        bridgecallvendor,
        bridgecallURL,
        cRMAppURL,
        sGIDownLoadURL,
        sGICUserID,
        sLICUserID,
        sLICDownLoadURL,
        sLICActivityName,
        sLICPackageName,
        jSONGoDigitValue,
        goDigitUserId,
        investmentAppData,
        covidEntryScreenShow,
        legalUser,
        sCUFUserID,
      ];
}

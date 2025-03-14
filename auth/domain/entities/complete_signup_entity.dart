import 'package:equatable/equatable.dart';

class CompleteSignUpEntity extends Equatable{
  final CompleteSignUpResultEntity completeSignUpResult;

  const CompleteSignUpEntity({required this.completeSignUpResult});
  
  @override
  List<Object?> get props => [completeSignUpResult];
}

class CompleteSignUpResultEntity extends Equatable {
  final dynamic errorMessage;
  final dynamic userID;
  final dynamic userName;
  final dynamic loggedIn;
  final dynamic sessionID;
  final dynamic fOUnit;
  final dynamic instrGapDays;
  final dynamic systemDate;
  final dynamic cashLimit;
  final dynamic totalCollected;
  final dynamic totalRemitted;
  final dynamic uRLAgreementsByAgNo;
  final dynamic uRLAgreementsByCustName;
  final dynamic uRLAgreementsByVehNo;
  final dynamic uRLChangePassword;
  final dynamic uRLChangeTPIN;
  final dynamic uRLReceipt;
  final dynamic uRLGetNonPymtReasons;
  final dynamic uRLFollowUp;
  final dynamic uRLVersionUpdater;
  final dynamic uRLResetTPIN;
  final dynamic uRLLastTransaction;
  final dynamic uRLReminder;
  final dynamic uRLReminderDetail;
  final dynamic uRLRanking;
  final dynamic uRLAgreementService;
  final dynamic uRLLeadURLs;
  final dynamic userMobile;
  final dynamic initMoneyOption;
  final dynamic hRMSDOWNURL;
  final dynamic minMobNoRng;
  final dynamic maxMobNoRng;
  final dynamic fingerPrint;
  final dynamic morningNote;
  final dynamic notification1;
  final dynamic notification2;
  final dynamic notification3;
  final dynamic birthWish;
  final dynamic iMEIChangedFlag;
  final dynamic downloadPending;
  final dynamic nextHybridVersion;
  final dynamic nextHybridVersionURL;
  final dynamic karzaGenerateURL;
  final dynamic karzaGenerateAuthorizationKey;
  final dynamic bridgecallvendor;
  final dynamic bridgecallURL;
  final dynamic cRMAppURL;
  final dynamic sGIDownLoadURL;
  final dynamic sGICUserID;
  final dynamic sLICUserID;
  final dynamic sLICDownLoadURL;
  final dynamic sLICActivityName;
  final dynamic sLICPackageName;
  final dynamic jSONGoDigitValue;
  final dynamic goDigitUserId;
  final dynamic investmentAppData;
  final dynamic covidEntryScreenShow;
  final dynamic legalUser;
  final dynamic sCUFUserID;

  const CompleteSignUpResultEntity({
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

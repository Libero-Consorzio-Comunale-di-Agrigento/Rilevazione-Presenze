unit P289UPensioneUnjspfDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione, A000UInterfaccia,  RegistrazioneLog, OracleData, Oracle,
  R004UGestStoricoDtM, C700USelezioneAnagrafe,P999UGenerale, Variants, StrUtils,
  C180FunzioniGenerali, DBClient, Math;

type
  TP289FPensioneUnjspfDtM = class(TR004FGestStoricoDtM)
    selU120: TOracleDataSet;
    selU100: TOracleDataSet;
    dsrU100: TDataSource;
    selU120ID_UNJSPF: TFloatField;
    selU120PENSIONNUMBER: TStringField;
    selU120ENTRYTOFUNDDATE: TDateTimeField;
    selU120FIRSTNAME: TStringField;
    selU120MIDDLENAME: TStringField;
    selU120LASTNAME: TStringField;
    selU120BIRTHDATE: TDateTimeField;
    selU120NATIONALITY: TStringField;
    selU120COUNTRYOFBIRTH: TStringField;
    selU120GENDER: TStringField;
    selU120MARITALSTATUS: TStringField;
    selU120COMLANGUAGE: TStringField;
    selU120FORMERPENSIONNUMBER: TFloatField;
    selU120LASTUPDATED: TDateTimeField;
    selU125: TOracleDataSet;
    selU125ID_UNJSPF: TFloatField;
    selU125START_DATE: TDateTimeField;
    selU125COUNT: TFloatField;
    selU125LASTUPDATED: TDateTimeField;
    dsrU120: TDataSource;
    dsrU125: TDataSource;
    dsrU130: TDataSource;
    selU130: TOracleDataSet;
    selU130ID_UNJSPF: TFloatField;
    selU130EFFECTIVEDATE: TDateTimeField;
    selU130PARTTIMEPERCENTAGE: TFloatField;
    selU130LASTUPDATED: TDateTimeField;
    dsrU135: TDataSource;
    selU135: TOracleDataSet;
    selU135ID_UNJSPF: TFloatField;
    selU135LOCATION_CODE: TStringField;
    selU135EFFECTIVEDATE: TDateTimeField;
    selU135DUTYSTATIONCODE: TStringField;
    selU135DUTYSTATIONCOUNTRY: TStringField;
    selU135LASTUPDATED: TDateTimeField;
    dsrU140: TDataSource;
    selU140: TOracleDataSet;
    selU140ID_UNJSPF: TFloatField;
    selU140EFFECTIVEDATE: TDateTimeField;
    selU140CATEGORY: TStringField;
    selU140GRADE: TStringField;
    selU140STEP: TStringField;
    selU140LASTUPDATED: TDateTimeField;
    dsrU145: TDataSource;
    selU145: TOracleDataSet;
    selU145ID_UNJSPF: TFloatField;
    selU145STARTDATE: TDateTimeField;
    selU145ENDDATE: TDateTimeField;
    selU145REAPPOINTINDICATOR: TStringField;
    selU145LASTUPDATED: TDateTimeField;
    dsrU150: TDataSource;
    selU150: TOracleDataSet;
    selU150ID_UNJSPF: TFloatField;
    selU150EFFECTIVEDATE: TDateTimeField;
    selU150REASON: TStringField;
    selU150DEATHDATE: TDateTimeField;
    selU150LASTUPDATED: TDateTimeField;
    dsrU155: TDataSource;
    selU155: TOracleDataSet;
    selU155ID_UNJSPF: TFloatField;
    selU155EMPLOYEE_NUMBER: TStringField;
    selU155ORGDEPENDENTID: TFloatField;
    selU155SPOUSESTAFFID: TStringField;
    selU155LASTNAME: TStringField;
    selU155FIRSTNAME: TStringField;
    selU155BIRTHDATE: TDateTimeField;
    selU155GENDER: TStringField;
    selU155RELATIONSHIP: TStringField;
    selU155NATIONALITY: TStringField;
    selU155MARRIAGEDATE: TDateTimeField;
    selU155DIVORCEDATE: TDateTimeField;
    selU155DEATHDATE: TDateTimeField;
    selU155LASTUPDATED: TDateTimeField;
    dsrU160: TDataSource;
    selU160: TOracleDataSet;
    selU160ID_UNJSPF: TFloatField;
    selU160EMPLOYEE_NUMBER: TStringField;
    selU160ORGCHILDID: TFloatField;
    selU160LASTNAME: TStringField;
    selU160FIRSTNAME: TStringField;
    selU160BIRTHDATE: TDateTimeField;
    selU160GENDER: TStringField;
    selU160NATIONALITY: TStringField;
    selU160DEATHDATE: TDateTimeField;
    selU160DISABILITYDATE: TDateTimeField;
    selU160DISABILITYENDDATE: TDateTimeField;
    selU160LASTUPDATED: TDateTimeField;
    selU165: TOracleDataSet;
    dsrU165: TDataSource;
    selU165ID_UNJSPF: TFloatField;
    selU165STARTDATE: TDateTimeField;
    selU165ENDDATE: TDateTimeField;
    selU165LASTUPDATED: TDateTimeField;
    dsrU170: TDataSource;
    selU170: TOracleDataSet;
    selU170ID_UNJSPF: TFloatField;
    selU170ADDRESS_TYPE: TStringField;
    selU170EFFECTIVEDATE: TDateTimeField;
    selU170LINE1: TStringField;
    selU170LINE2: TStringField;
    selU170LINE3: TStringField;
    selU170STATE: TStringField;
    selU170CITY: TStringField;
    selU170POSTALCODE: TStringField;
    selU170COUNTRY: TStringField;
    dsrU175: TDataSource;
    selU175: TOracleDataSet;
    selU175ID_UNJSPF: TFloatField;
    selU175PHONE_TYPE: TStringField;
    selU175PHONE_NUMBER: TStringField;
    selU180: TOracleDataSet;
    dsrU180: TDataSource;
    selU180ID_UNJSPF: TFloatField;
    selU180TYPE: TStringField;
    selU180EMAILADDRESS: TStringField;
    selU190: TOracleDataSet;
    dsrU190: TDataSource;
    selU120EMPLOYEE_NUMBER: TStringField;
    selU125EMPLOYEE_NUMBER: TStringField;
    selU130EMPLOYEE_NUMBER: TStringField;
    selU135EMPLOYEE_NUMBER: TStringField;
    selU140EMPLOYEE_NUMBER: TStringField;
    selU145EMPLOYEE_NUMBER: TStringField;
    selU150EMPLOYEE_NUMBER: TStringField;
    selU165EMPLOYEE_NUMBER: TStringField;
    selU170EMPLOYEE_NUMBER: TStringField;
    selU170LINE4: TStringField;
    selU170COUNTRYISOCODE: TStringField;
    selU175EMPLOYEE_NUMBER: TStringField;
    selU180EMPLOYEE_NUMBER: TStringField;
    selU125LASTNAME: TStringField;
    selU125FIRSTNAME: TStringField;
    selU130LASTNAME: TStringField;
    selU130FIRSTNAME: TStringField;
    selU135LASTNAME: TStringField;
    selU135FIRSTNAME: TStringField;
    selU140LASTNAME: TStringField;
    selU140FIRSTNAME: TStringField;
    selU145LASTNAME: TStringField;
    selU145FIRSTNAME: TStringField;
    selU150LASTNAME: TStringField;
    selU150FIRSTNAME: TStringField;
    selU155LASTNAME_1: TStringField;
    selU155FIRSTNAME_1: TStringField;
    selU160LASTNAME_1: TStringField;
    selU160FIRSTNAME_1: TStringField;
    selU165LASTNAME: TStringField;
    selU165FIRSTNAME: TStringField;
    selU170LASTNAME: TStringField;
    selU170FIRSTNAME: TStringField;
    selU175LASTNAME: TStringField;
    selU175FIRSTNAME: TStringField;
    selU180LASTNAME: TStringField;
    selU180FIRSTNAME: TStringField;
    selU100TIPO_FLUSSO: TStringField;
    selU100DATA_FINE_PERIODO: TDateTimeField;
    selU100ID_UNJSPF: TFloatField;
    selU100DATA_ESPORTAZIONE: TDateTimeField;
    selU100CHIUSO: TStringField;
    selU100DATA_CHIUSURA: TDateTimeField;
    selU120Diff: TOracleDataSet;
    dsrU120Diff: TDataSource;
    selDataPrec: TOracleQuery;
    selU120DiffDATA: TDateTimeField;
    selU120DiffEMPLOYEE_NUMBER: TStringField;
    selU120DiffPENSIONNUMBER: TStringField;
    selU120DiffENTRYTOFUNDDATE: TDateTimeField;
    selU120DiffFIRSTNAME: TStringField;
    selU120DiffMIDDLENAME: TStringField;
    selU120DiffLASTNAME: TStringField;
    selU120DiffBIRTHDATE: TDateTimeField;
    selU120DiffNATIONALITY: TStringField;
    selU120DiffCOUNTRYOFBIRTH: TStringField;
    selU120DiffGENDER: TStringField;
    selU120DiffMARITALSTATUS: TStringField;
    selU120DiffCOMLANGUAGE: TStringField;
    selU120DiffFORMERPENSIONNUMBER: TFloatField;
    selU125Diff: TOracleDataSet;
    dsrU125Diff: TDataSource;
    selU125DiffDATA: TDateTimeField;
    selU125DiffEMPLOYEE_NUMBER: TStringField;
    selU125DiffSTART_DATE: TDateTimeField;
    selU125DiffCOUNT: TFloatField;
    selU125DiffLASTNAME: TStringField;
    selU125DiffFIRSTNAME: TStringField;
    selU130Diff: TOracleDataSet;
    dsrU130Diff: TDataSource;
    selU130DiffDATA: TDateTimeField;
    selU130DiffEMPLOYEE_NUMBER: TStringField;
    selU130DiffEFFECTIVEDATE: TDateTimeField;
    selU130DiffPARTTIMEPERCENTAGE: TFloatField;
    selU130DiffLASTNAME: TStringField;
    selU130DiffFIRSTNAME: TStringField;
    selU135Diff: TOracleDataSet;
    dsrU135Diff: TDataSource;
    selU135DiffDATA: TDateTimeField;
    selU135DiffEMPLOYEE_NUMBER: TStringField;
    selU135DiffLOCATION_CODE: TStringField;
    selU135DiffEFFECTIVEDATE: TDateTimeField;
    selU135DiffDUTYSTATIONCODE: TStringField;
    selU135DiffDUTYSTATIONCOUNTRY: TStringField;
    selU135DiffLASTNAME: TStringField;
    selU135DiffFIRSTNAME: TStringField;
    selU140Diff: TOracleDataSet;
    dsrU140Diff: TDataSource;
    selU140DiffDATA: TDateTimeField;
    selU140DiffEMPLOYEE_NUMBER: TStringField;
    selU140DiffEFFECTIVEDATE: TDateTimeField;
    selU140DiffCATEGORY: TStringField;
    selU140DiffGRADE: TStringField;
    selU140DiffSTEP: TStringField;
    selU140DiffLASTNAME: TStringField;
    selU140DiffFIRSTNAME: TStringField;
    selU145Diff: TOracleDataSet;
    dsrU145Diff: TDataSource;
    selU145DiffDATA: TDateTimeField;
    selU145DiffEMPLOYEE_NUMBER: TStringField;
    selU145DiffSTARTDATE: TDateTimeField;
    selU145DiffENDDATE: TDateTimeField;
    selU145DiffREAPPOINTINDICATOR: TStringField;
    selU145DiffLASTNAME: TStringField;
    selU145DiffFIRSTNAME: TStringField;
    dsrU150Diff: TDataSource;
    selU150Diff: TOracleDataSet;
    selU150DiffDATA: TDateTimeField;
    selU150DiffEMPLOYEE_NUMBER: TStringField;
    selU150DiffEFFECTIVEDATE: TDateTimeField;
    selU150DiffREASON: TStringField;
    selU150DiffDEATHDATE: TDateTimeField;
    selU150DiffLASTNAME: TStringField;
    selU150DiffFIRSTNAME: TStringField;
    dsrU155Diff: TDataSource;
    selU155Diff: TOracleDataSet;
    selU155DiffDATA: TDateTimeField;
    selU155DiffEMPLOYEE_NUMBER: TStringField;
    selU155DiffORGDEPENDENTID: TFloatField;
    selU155DiffSPOUSESTAFFID: TStringField;
    selU155DiffLASTNAME: TStringField;
    selU155DiffFIRSTNAME: TStringField;
    selU155DiffBIRTHDATE: TDateTimeField;
    selU155DiffGENDER: TStringField;
    selU155DiffRELATIONSHIP: TStringField;
    selU155DiffNATIONALITY: TStringField;
    selU155DiffMARRIAGEDATE: TDateTimeField;
    selU155DiffDIVORCEDATE: TDateTimeField;
    selU155DiffDEATHDATE: TDateTimeField;
    selU155DiffLASTNAME_1: TStringField;
    selU155DiffFIRSTNAME_1: TStringField;
    selU160Diff: TOracleDataSet;
    dsrU160Diff: TDataSource;
    selU160DiffDATA: TDateTimeField;
    selU160DiffEMPLOYEE_NUMBER: TStringField;
    selU160DiffORGCHILDID: TFloatField;
    selU160DiffLASTNAME: TStringField;
    selU160DiffFIRSTNAME: TStringField;
    selU160DiffBIRTHDATE: TDateTimeField;
    selU160DiffGENDER: TStringField;
    selU160DiffNATIONALITY: TStringField;
    selU160DiffDEATHDATE: TDateTimeField;
    selU160DiffDISABILITYDATE: TDateTimeField;
    selU160DiffDISABILITYENDDATE: TDateTimeField;
    selU160DiffLASTNAME_1: TStringField;
    selU160DiffFIRSTNAME_1: TStringField;
    dsrU165Diff: TDataSource;
    selU165Diff: TOracleDataSet;
    selU165DiffDATA: TDateTimeField;
    selU165DiffEMPLOYEE_NUMBER: TStringField;
    selU165DiffSTARTDATE: TDateTimeField;
    selU165DiffENDDATE: TDateTimeField;
    selU165DiffLASTNAME: TStringField;
    selU165DiffFIRSTNAME: TStringField;
    dsrU170Diff: TDataSource;
    selU170Diff: TOracleDataSet;
    selU170DiffDATA: TDateTimeField;
    selU170DiffEMPLOYEE_NUMBER: TStringField;
    selU170DiffADDRESS_TYPE: TStringField;
    selU170DiffEFFECTIVEDATE: TDateTimeField;
    selU170DiffLINE1: TStringField;
    selU170DiffLINE2: TStringField;
    selU170DiffLINE3: TStringField;
    selU170DiffLINE4: TStringField;
    selU170DiffSTATE: TStringField;
    selU170DiffCITY: TStringField;
    selU170DiffPOSTALCODE: TStringField;
    selU170DiffCOUNTRY: TStringField;
    selU170DiffCOUNTRYISOCODE: TStringField;
    selU170DiffLASTNAME: TStringField;
    selU170DiffFIRSTNAME: TStringField;
    dsrU175Diff: TDataSource;
    selU175Diff: TOracleDataSet;
    selU175DiffDATA: TDateTimeField;
    selU175DiffEMPLOYEE_NUMBER: TStringField;
    selU175DiffPHONE_TYPE: TStringField;
    selU175DiffPHONE_NUMBER: TStringField;
    selU175DiffLASTNAME: TStringField;
    selU175DiffFIRSTNAME: TStringField;
    selU180Diff: TOracleDataSet;
    dsrU180Diff: TDataSource;
    selU180DiffDATA: TDateTimeField;
    selU180DiffEMPLOYEE_NUMBER: TStringField;
    selU180DiffTYPE: TStringField;
    selU180DiffEMAILADDRESS: TStringField;
    selU180DiffLASTNAME: TStringField;
    selU180DiffFIRSTNAME: TStringField;
    selU120PROGRESSIVO: TFloatField;
    selU125PROGRESSIVO: TFloatField;
    selU130PROGRESSIVO: TFloatField;
    selU135PROGRESSIVO: TFloatField;
    selU140PROGRESSIVO: TFloatField;
    selU145PROGRESSIVO: TFloatField;
    selU150PROGRESSIVO: TFloatField;
    selU155PROGRESSIVO: TFloatField;
    selU160PROGRESSIVO: TFloatField;
    selU165PROGRESSIVO: TFloatField;
    selU170PROGRESSIVO: TFloatField;
    selU175PROGRESSIVO: TFloatField;
    selU180PROGRESSIVO: TFloatField;
    selU120DiffPROGRESSIVO: TFloatField;
    selU125DiffPROGRESSIVO: TFloatField;
    selU130DiffPROGRESSIVO: TFloatField;
    selU135DiffPROGRESSIVO: TFloatField;
    selU140DiffPROGRESSIVO: TFloatField;
    selU145DiffPROGRESSIVO: TFloatField;
    selU150DiffPROGRESSIVO: TFloatField;
    selU155DiffPROGRESSIVO: TFloatField;
    selU160DiffPROGRESSIVO: TFloatField;
    selU165DiffPROGRESSIVO: TFloatField;
    selU170DiffPROGRESSIVO: TFloatField;
    selU175DiffPROGRESSIVO: TFloatField;
    selU180DiffPROGRESSIVO: TFloatField;
    selU190ID_UNJSPF: TFloatField;
    selU190PROGRESSIVO: TFloatField;
    selU190EMPLOYEE_NUMBER: TStringField;
    selU190PENSION_NUMBER: TStringField;
    selU190DATE_EARNED: TDateTimeField;
    selU190DATE_PAYMENT: TDateTimeField;
    selU190FIRST_NAME: TStringField;
    selU190LAST_NAME: TStringField;
    selU190DATE_OF_BIRTH: TDateTimeField;
    selU190TRANSACTION_TYPE: TStringField;
    selU190EFFECTIVE_START_DATE: TDateTimeField;
    selU190EFFECTIVE_END_DATE: TDateTimeField;
    selU190LWOP_CONTRIB_FLAG: TStringField;
    selU190CATEGORY: TStringField;
    selU190GRADE: TStringField;
    selU190STEP: TStringField;
    selU190DUTY_STATION: TStringField;
    selU190PARTTIME_PERCENT: TFloatField;
    selU190CURRENCY_CODE: TStringField;
    selU190EXCHANGE_RATE: TFloatField;
    selU190PRRATE_LOCAL_AMOUNT: TFloatField;
    selU190PRRATE_BASE_AMOUNT: TFloatField;
    selU190LANGUAGE_ALLOWANCELOCAL_AMOUNT: TFloatField;
    selU190LANGUAGE_ALLOWANCEBASE_AMOUNT: TFloatField;
    selU190PRORATEDRATIO: TFloatField;
    selU190CONTRIBUTION_LOCAL_AMOUNTSM: TFloatField;
    selU190CONTRIBUTION_BASE_AMOUNTSM: TFloatField;
    selU190CONTRIBUTION_LOCAL_AMOUNTORG: TFloatField;
    selU190CONTRIBUTION_BASE_AMOUNTORG: TFloatField;
    selU190ADJUSTMENT_LOCAL_AMOUNTSM: TFloatField;
    selU190ADJUSTMENT_BASE_AMOUNTSM: TFloatField;
    selU190ADJUSTMENT_LOCAL_AMOUNTORG: TFloatField;
    selU190ADJUSTMENT_BASE_AMOUNTORG: TFloatField;
    selU190ADJUSTMENT_LOCAL_AMOUNTFULLSM: TFloatField;
    selU190ADJUSTMENT_BASE_AMOUNTFULLSM: TFloatField;
    selU190ADJUSTMENT_LOCAL_AMOUNTFULLORG: TFloatField;
    selU190ADJUSTMENT_BASE_AMOUNTFULLORG: TFloatField;
    selU190VALIDATION_AMOUNTSM: TFloatField;
    selU190VALIDATION_AMOUNTORG: TFloatField;
    selU190RESTORATION_AMOUNTSM: TFloatField;
    selU190RESTORATION_AMOUNTORG: TFloatField;
    dsrU190Diff: TDataSource;
    selU190Diff: TOracleDataSet;
    selU190DiffDATA: TDateTimeField;
    selU190DiffPROGRESSIVO: TFloatField;
    selU190DiffEMPLOYEE_NUMBER: TStringField;
    selU190DiffPENSION_NUMBER: TStringField;
    selU190DiffFIRST_NAME: TStringField;
    selU190DiffLAST_NAME: TStringField;
    selU190DiffDATE_OF_BIRTH: TDateTimeField;
    selU190DiffLWOP_CONTRIB_FLAG: TStringField;
    selU190DiffCATEGORY: TStringField;
    selU190DiffGRADE: TStringField;
    selU190DiffSTEP: TStringField;
    selU190DiffDUTY_STATION: TStringField;
    selU190DiffPARTTIME_PERCENT: TFloatField;
    selU190DiffCURRENCY_CODE: TStringField;
    selU190DiffTRANSACTION_TYPE: TStringField;
    selU190DiffEFFECTIVE_START_DATE: TDateTimeField;
    selU190DiffEFFECTIVE_END_DATE: TDateTimeField;
    selU190DiffPRRATE_LOCAL_AMOUNT: TFloatField;
    selU190DiffLANGUAGE_ALLOWANCELOCAL_AMOUNT: TFloatField;
    selU190DiffPRORATEDRATIO: TFloatField;
    selU190DiffCONTRIBUTION_LOCAL_AMOUNTSM: TFloatField;
    selU190DiffCONTRIBUTION_LOCAL_AMOUNTORG: TFloatField;
    selU190DiffADJUSTMENT_LOCAL_AMOUNTSM: TFloatField;
    selU190DiffADJUSTMENT_LOCAL_AMOUNTORG: TFloatField;
    selU190DiffADJUSTMENT_LOCAL_AMOUNTFULLSM: TFloatField;
    selU190DiffADJUSTMENT_LOCAL_AMOUNTFULLORG: TFloatField;
    selU190DiffVALIDATION_AMOUNTSM: TFloatField;
    selU190DiffVALIDATION_AMOUNTORG: TFloatField;
    selU190DiffRESTORATION_AMOUNTSM: TFloatField;
    selU190DiffRESTORATION_AMOUNTORG: TFloatField;
    selU100DATA_ELABORAZIONE: TDateTimeField;
    selU190ACTUARIAL_COSTSSM: TFloatField;
    selU190ACTUARIAL_COSTSORG: TFloatField;
    selU190INTEREST_CONTRIBUTIONSM: TFloatField;
    selU190INTEREST_CONTRIBUTIONORG: TFloatField;
    selU190MISC_ADJUSTMENTSM: TFloatField;
    selU190MISC_ADJUSTMENTORG: TFloatField;
    selU190DiffACTUARIAL_COSTSSM: TFloatField;
    selU190DiffACTUARIAL_COSTSORG: TFloatField;
    selU190DiffINTEREST_CONTRIBUTIONSM: TFloatField;
    selU190DiffINTEREST_CONTRIBUTIONORG: TFloatField;
    selU190DiffMISC_ADJUSTMENTSM: TFloatField;
    selU190DiffMISC_ADJUSTMENTORG: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selU120NewRecord(DataSet: TDataSet);
    procedure selU100AfterScroll(DataSet: TDataSet);
    procedure selU125NewRecord(DataSet: TDataSet);
    procedure selU130NewRecord(DataSet: TDataSet);
    procedure selU135NewRecord(DataSet: TDataSet);
    procedure selU140NewRecord(DataSet: TDataSet);
    procedure selU145NewRecord(DataSet: TDataSet);
    procedure selU150NewRecord(DataSet: TDataSet);
    procedure selU155NewRecord(DataSet: TDataSet);
    procedure selU160NewRecord(DataSet: TDataSet);
    procedure selU165NewRecord(DataSet: TDataSet);
    procedure selU170NewRecord(DataSet: TDataSet);
    procedure selU175NewRecord(DataSet: TDataSet);
    procedure selU180NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    procedure NewRecord(DataSet: TDataSet);
  public
    { Public declarations }
    AnnoRegole:Integer;
  end;

var
  P289FPensioneUnjspfDtM: TP289FPensioneUnjspfDtM;

implementation

uses P289UPensioneUnjspf;

{$R *.DFM}


procedure TP289FPensioneUnjspfDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selU100,[evBeforeEdit,
                             evBeforeInsert,
                             evBeforePost,
                             evBeforeDelete,
                             evAfterDelete,
                             evAfterPost,
                             evOnNewRecord,
                             evOnTranslateMessage]);
  P289FPensioneUnjspf.DButton.DataSet:=selU100;
end;

procedure TP289FPensioneUnjspfDtM.selU100AfterScroll(DataSet: TDataSet);
begin
  inherited;
  P289FPensioneUnjspf.pgcPrincipaleChange(nil);
end;

procedure TP289FPensioneUnjspfDtM.selU120NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
  selU120.FieldByName('PENSIONNUMBER').AsString:=C700SelAnagrafe.FieldByName('T430COD_UNJSPF').AsString;
  if not C700SelAnagrafe.FieldByName('T430UN_ENTRY_DATE').IsNull then
    selU120.FieldByName('ENTRYTOFUNDDATE').AsDateTime:=C700SelAnagrafe.FieldByName('T430UN_ENTRY_DATE').AsDateTime;
  selU120.FieldByName('FIRSTNAME').AsString:=C700SelAnagrafe.FieldByName('NOME').AsString;
  selU120.FieldByName('LASTNAME').AsString:=C700SelAnagrafe.FieldByName('COGNOME').AsString;
  if not C700SelAnagrafe.FieldByName('DATANAS').IsNull then
    selU120.FieldByName('BIRTHDATE').AsDateTime:=C700SelAnagrafe.FieldByName('DATANAS').AsDateTime;
  if Trim(C700SelAnagrafe.FieldByName('T430NATIONALITY').AsString) = '' then
    selU120.FieldByName('NATIONALITY').AsString:='XXX'
  else
    selU120.FieldByName('NATIONALITY').AsString:=C700SelAnagrafe.FieldByName('T430NATIONALITY').AsString;
  selU120.FieldByName('GENDER').AsString:=IfThen(C700SelAnagrafe.FieldByName('SESSO').AsString = 'M','Male','Female');
  if C700SelAnagrafe.FieldByName('T430CIVIL_STATUS').AsString = '1' then
    selU120.FieldByName('MARITALSTATUS').AsString:='Single'
  else if C700SelAnagrafe.FieldByName('T430CIVIL_STATUS').AsString = '2' then
    selU120.FieldByName('MARITALSTATUS').AsString:='Married'
  else if C700SelAnagrafe.FieldByName('T430CIVIL_STATUS').AsString = '3' then
    selU120.FieldByName('MARITALSTATUS').AsString:='Married'
  else if C700SelAnagrafe.FieldByName('T430CIVIL_STATUS').AsString = '4' then
    selU120.FieldByName('MARITALSTATUS').AsString:='Non-traditional Union'
  else if C700SelAnagrafe.FieldByName('T430CIVIL_STATUS').AsString = '5' then
    selU120.FieldByName('MARITALSTATUS').AsString:='Divorced'
  else if C700SelAnagrafe.FieldByName('T430CIVIL_STATUS').AsString = '6' then
    selU120.FieldByName('MARITALSTATUS').AsString:='Single';
end;

procedure TP289FPensioneUnjspfDtM.selU125NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.selU130NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.selU135NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.selU140NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.selU145NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.selU150NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.selU155NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.selU160NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.selU165NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.selU170NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.selU175NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.selU180NewRecord(DataSet: TDataSet);
begin
  inherited;
  NewRecord(DataSet);
end;

procedure TP289FPensioneUnjspfDtM.NewRecord(DataSet: TDataSet);
begin
  if C700SelAnagrafe.RecordCount <= 0 then
    raise exception.Create('Nessun dipendente selezionato!');
  if C700SelAnagrafe.FieldByName('T430UN_EXTRACT').AsString <> 'Y' then
    if R180MessageBox('Attenzione: il dato UN_EXTRACT per il dipendente corrente ha valore diverso da ''Y''. Continuare comunque?','DOMANDA') <> mrYes then
      Abort;
  DataSet.FieldByName('ID_UNJSPF').AsInteger:=selU100.FieldByName('ID_UNJSPF').AsInteger;
  DataSet.FieldByName('PROGRESSIVO').AsInteger:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  DataSet.FieldByName('EMPLOYEE_NUMBER').AsString:='7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString;
end;

end.


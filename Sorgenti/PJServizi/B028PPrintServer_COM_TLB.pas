unit B028PPrintServer_COM_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 52393 $
// File generated on 23/11/2020 15:52:00 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\SVN\Sviluppo\PJServizi\B028PPrintServer_COM (1)
// LIBID: {1AAD6340-2C9A-4F75-8F88-2558F81F9686}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v1.0 Midas, (midas.dll)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, Midas, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;



// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  B028PPrintServer_COMMajorVersion = 1;
  B028PPrintServer_COMMinorVersion = 0;

  LIBID_B028PPrintServer_COM: TGUID = '{1AAD6340-2C9A-4F75-8F88-2558F81F9686}';

  IID_IB028PrintServer: TGUID = '{5ECBE935-B434-4A45-9014-4ABC40C08E32}';
  CLASS_B028PrintServer: TGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IB028PrintServer = interface;
  IB028PrintServerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  B028PrintServer = IB028PrintServer;


// *********************************************************************//
// Interface: IB028PrintServer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5ECBE935-B434-4A45-9014-4ABC40C08E32}
// *********************************************************************//
  IB028PrintServer = interface(IAppServer)
    ['{5ECBE935-B434-4A45-9014-4ABC40C08E32}']
    procedure ProvaStampa(const NomeFile: WideString); safecall;
    procedure PrintA045(const SelezioneAnagrafica: WideString; const FileOutput: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA061(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA043(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA074(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA042(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA092(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA081(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA051(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA090(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA116(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA077(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintP077(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA059(const FilePDF: WideString; const Operatore: WideString;
                        const Azienda: WideString; const DBServer: WideString;
                        const DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA068(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA058(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA105(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA104(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA047(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA167(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA145(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintS715(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant; var MessaggioAggiuntivo: OleVariant); safecall;
    procedure PrintA065(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA040(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintS404(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintP500(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant; var MessaggioAggiuntivo: OleVariant); safecall;
    procedure PrintP273(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintP700(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintP710(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA083(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA097(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintS304(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintS203(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA027(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintS201(const FilePDF: WideString; const Operatore: WideString;
                        const Azienda: WideString; const DBServer: WideString;
                        const DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA202(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintP715(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintP690(const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintP461(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintA049(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
    procedure PrintP314(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant; var MessaggioAggiuntivo: OleVariant); safecall;
    procedure PrintP283(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); safecall;
  end;

// *********************************************************************//
// DispIntf:  IB028PrintServerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5ECBE935-B434-4A45-9014-4ABC40C08E32}
// *********************************************************************//
  IB028PrintServerDisp = dispinterface
    ['{5ECBE935-B434-4A45-9014-4ABC40C08E32}']
    procedure ProvaStampa(const NomeFile: WideString); dispid 301;
    procedure PrintA045(const SelezioneAnagrafica: WideString; const FileOutput: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 302;
    procedure PrintA061(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 303;
    procedure PrintA043(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 304;
    procedure PrintA074(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 305;
    procedure PrintA042(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 306;
    procedure PrintA092(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 307;
    procedure PrintA081(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 308;
    procedure PrintA051(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 309;
    procedure PrintA090(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 310;
    procedure PrintA116(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 311;
    procedure PrintA077(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 312;
    procedure PrintP077(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 313;
    procedure PrintA059(const FilePDF: WideString; const Operatore: WideString;
                        const Azienda: WideString; const DBServer: WideString;
                        const DatiUtente: WideString; var DettaglioLog: OleVariant); dispid 314;
    procedure PrintA068(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 315;
    procedure PrintA058(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 316;
    procedure PrintA105(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 317;
    procedure PrintA104(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 318;
    procedure PrintA047(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 319;
    procedure PrintA167(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 320;
    procedure PrintA145(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 321;
    procedure PrintS715(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant; var MessaggioAggiuntivo: OleVariant); dispid 322;
    procedure PrintA065(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 323;
    procedure PrintA040(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 324;
    procedure PrintS404(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 325;
    procedure PrintP500(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant; var MessaggioAggiuntivo: OleVariant); dispid 326;
    procedure PrintP273(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 327;
    procedure PrintP700(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 328;
    procedure PrintP710(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 329;
    procedure PrintA083(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 330;
    procedure PrintA097(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 331;
    procedure PrintS304(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 332;
    procedure PrintS203(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 333;
    procedure PrintA027(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 334;
    procedure PrintS201(const FilePDF: WideString; const Operatore: WideString;
                        const Azienda: WideString; const DBServer: WideString;
                        const DatiUtente: WideString; var DettaglioLog: OleVariant); dispid 335;
    procedure PrintA202(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 336;
    procedure PrintP715(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 337;
    procedure PrintP690(const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 338;
    procedure PrintP461(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 339;
    procedure PrintA049(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 340;
    procedure PrintP314(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant; var MessaggioAggiuntivo: OleVariant); dispid 341;
    procedure PrintP283(const SelezioneAnagrafica: WideString; const FilePDF: WideString;
                        const Operatore: WideString; const Azienda: WideString;
                        const DBServer: WideString; const DatiUtente: WideString;
                        var DettaglioLog: OleVariant); dispid 342;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: SYSINT;
                             out ErrorCount: SYSINT; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: SYSINT; out RecsOut: SYSINT;
                           Options: SYSINT; const CommandText: WideString; var Params: OleVariant;
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: SYSINT;
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString;
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// The Class CoB028PrintServer provides a Create and CreateRemote method to
// create instances of the default interface IB028PrintServer exposed by
// the CoClass B028PrintServer. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoB028PrintServer = class
    class function Create: IB028PrintServer;
    class function CreateRemote(const MachineName: string): IB028PrintServer;
  end;

implementation

uses System.Win.ComObj;

class function CoB028PrintServer.Create: IB028PrintServer;
begin
  Result := CreateComObject(CLASS_B028PrintServer) as IB028PrintServer;
end;

class function CoB028PrintServer.CreateRemote(const MachineName: string): IB028PrintServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_B028PrintServer) as IB028PrintServer;
end;

end.


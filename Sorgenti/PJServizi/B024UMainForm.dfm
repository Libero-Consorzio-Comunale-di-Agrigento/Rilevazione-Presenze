object B024FMainForm: TB024FMainForm
  Left = 390
  Top = 301
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<B024> Server SOAP ADS Catanzaro'
  ClientHeight = 86
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblInfo: TLabel
    Left = 8
    Top = 32
    Width = 88
    Height = 13
    Caption = 'Informazioni server'
  end
  object IdSoapServer1: TIdSoapServer
    Active = True
    DefaultNamespace = 'urn:nevrona.com/indysoap/v1/'
    EncodingOptions = [seoUseCrLf, seoCheckStrings, seoReferences, seoRequireTypes]
    EncodingType = etIdAutomatic
    ITIResourceName = 'B024UADSCatanzaroIntf'
    ITISource = islResource
    RTTINamesType = rntInclude
    SessionSettings.SessionPolicy = sspNoSessions
    SessionSettings.AutoAcceptSessions = False
    WsdlOptions.UseCategories = False
    XMLProvider = xpOpenXML
    SoapVersions = [IdSoapV1_1]
    Left = 218
    Top = 18
  end
  object IdSOAPServerHTTP1: TIdSOAPServerHTTP
    Active = True
    Bindings = <>
    DefaultPort = 8080
    ReuseSocket = rsTrue
    SOAPPath = '/soap/'
    SOAPServer = IdSoapServer1
    WSDLPath = '/wsdl'
    Compression = False
    Left = 311
    Top = 18
  end
end

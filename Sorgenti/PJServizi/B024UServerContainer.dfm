object B024FServerContainer: TB024FServerContainer
  OldCreateOrder = False
  AllowPause = False
  DisplayName = 'B024FADSCatanzaro'
  OnStart = ServiceStart
  Height = 112
  Width = 253
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
    Left = 42
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
    Left = 143
    Top = 18
  end
end

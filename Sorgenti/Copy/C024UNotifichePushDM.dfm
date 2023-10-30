inherited C024FNotifichePushDM: TC024FNotifichePushDM
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  object HTTPClient: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 5000
    ResponseTimeout = 5000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    OnRequestCompleted = HTTPClientRequestCompleted
    OnRequestError = HTTPClientRequestError
    Left = 24
    Top = 16
  end
end

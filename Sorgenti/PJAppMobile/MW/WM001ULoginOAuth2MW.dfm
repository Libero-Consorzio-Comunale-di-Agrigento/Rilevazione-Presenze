object WM001FLoginOAuth2MW: TWM001FLoginOAuth2MW
  OldCreateOrder = False
  Height = 91
  Width = 201
  object HTTPClient: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 24
    Top = 16
  end
  object HTTPRequest: TNetHTTPRequest
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    Client = HTTPClient
    Left = 104
    Top = 16
  end
end

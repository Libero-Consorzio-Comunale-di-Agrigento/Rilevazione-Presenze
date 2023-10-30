object WM000FServerModule: TWM000FServerModule
  OldCreateOrder = False
  OnCreate = UniGUIServerModuleCreate
  OnDestroy = UniGUIServerModuleDestroy
  AutoCoInitialize = True
  FilesFolder = 'wwwroot\IrisAPP\'
  TempFolder = 'temp\'
  Title = 'IrisAPP'
  Favicon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    000001002000000000000004000036310000363100000000000000000000EBD5
    C5A9EBD5C5FBEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5
    C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FBEBD5C5A9EBD5
    C5FAEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFECD6C6FFEBD5
    C5FFE9D3C3FFEAD4C4FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FAEBD5
    C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFE4CDBDFFE4CEBDFFCCB2
    A1FFC1A694FFD3BAA9FFECD6C6FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFECD5
    C5FFEDD5C5FFEDD5C5FFECD5C5FFECD5C5FFEED7C6FFDAC1AFFFAB8D79FF9472
    5CFF88654DFF9E7F69FFE5CFBEFFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFD7D3
    CAFFCED1CDFFD2D0CCFFD8D1CAFFE0D1C8FFD0CBCDFFD0C9CBFFA7928AFFA391
    91FF968BA1FFB39EA0FFE7D0C0FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FF8ECC
    DDFF60C4EAFF75BDE6FF8BBFE0FFA4BDD9FF70A9E7FF76A1E5FF8BA4D9FF728F
    E0FF7386E4FF666EE4FFD6C3CAFFEED8C5FFEBD5C5FFEBD5C5FFEBD5C5FF88CB
    DFFF56C3EDFF6EBCE8FF51B0F0FF5AA7EDFF83B0E1FF729FE5FF92AADCFF90A0
    DBFF6D81E2FF646CE2FFBCADCCFFC3B4C8FFECD6C5FFEBD5C5FFEBD5C5FF86CB
    DFFF54C3EDFF6CBBE8FF5EB3ECFF6AACE8FF6FA9E7FF6E9DE6FF89A5DEFF5B82
    E8FF6E83E2FF8B8BDAFFD0BEC8FFB0A4C9FFB5A8C9FFEBD5C5FFEBD5C5FFB4CF
    D4FF98CBDBFFA6C7D8FF83BBE2FF8AB7E0FFBBC4D2FFA8B7D7FFBDBFD1FFA9AE
    D5FF8491DDFFABA4D3FFEAD4C5FFE3CEC6FFB5A8C9FFB5A8C9FFEDD7C5FFECD5
    C5FFECD5C5FFECD5C5FFEDD5C5FFEDD6C5FFEDD6C5FFECD5C5FFECD5C5FFEDD6
    C5FFEBD5C5FFEDD6C5FFEBD5C5FFECD6C5FFE3CEC6FFAEA2C9FFD3C1C7FFEBD5
    C5FFEBD5C5FFEBD5C5FFEDD6C5FFECD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5
    C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEDD6C5FFBDAEC8FFCBBAC7FFEBD5
    C5FFEBD5C5FFE3CEC6FFCCBBC7FFE1CDC6FFE9D3C5FFECD6C5FFEDD7C5FFECD6
    C5FFECD6C5FFECD6C5FFECD6C5FFECD6C5FFEDD6C5FFB9ABC9FFBEAFC8FFEBD5
    C5FFECD6C5FFDCC8C6FFB0A3C9FFA69CCAFFACA0C9FFB9ABC9FFC2B3C8FFD2C0
    C7FFDBC7C6FFDECAC6FFDDCAC6FFD3C1C7FFB0A4C9FFC6B6C8FFEBD5C5FFEBD5
    C5FFEBD5C5FFEBD5C5FFECD6C5FFE4CFC5FFD6C3C6FFCCBBC7FFBBADC8FFAEA2
    C9FFB0A3C9FFACA0C9FFA499CAFFA89DCAFFC7B7C8FFE0CCC6FFECD6C5FFEBD5
    C5FAEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFECD6C5FFEDD6C5FFEDD7C5FFEBD5
    C5FFE9D3C5FFE7D2C5FFE6D1C5FFEAD5C5FFECD6C5FFECD6C5FFEBD5C5FAEBD5
    C5A9EBD5C5FBEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5
    C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FFEBD5C5FBEBD5C5A90000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  SuppressErrors = []
  Bindings = <>
  CustomFiles.Strings = (
    
      'https://maps.googleapis.com/maps/api/js?key=AIzaSyCWNZW68FwUw_zx' +
      'J-MvS5I0IvYbYQzCxXc')
  CustomCSS.Strings = (
    '.x-text-center{text-align:center;}'
    ''
    '.x-display-block{display: block;}'
    ''
    '.activeClick:active'
    '{'
    '    background-color: #c2ddf2 !important;'
    '    -ms-transition-duration: 0.2s;'
    '    -ms-transform: scale(0.90);'
    '    -webkit-transition-duration: 0.2s;'
    '    -webkit-transform: scale(0.90);'
    '    -moz-transition-duration: 0.2s;'
    '    -moz-transform: scale(0.90);'
    '    -o-transition-duration: 0.2s;'
    '    -o-transform: scale(0.90);'
    '}'
    ''
    '.activeColor:active'
    '{'
    '    background-color: #c2ddf2 !important;'
    '    -ms-transition-duration: 0.2s;'
    '    -webkit-transition-duration: 0.2s;'
    '    -moz-transition-duration: 0.2s;'
    '    -o-transition-duration: 0.2s;'
    '}'
    ''
    '.x-fill-el'
    '{'
    '   background-color: #157fcc !important;'
    '}'
    ''
    '.background-blue'
    '{'
    '   background-color: #157fcc;'
    '   color: #ffffff;'
    '}'
    ''
    '.background-white'
    '{'
    '   background-color: #ffffff;'
    '   color: #157fcc; '
    '}'
    ''
    '.overflow-wrap-anywhere'
    '{'
    '   overflow-wrap: anywhere;'
    '}'
    ''
    '.text-overflow-ellipsis'
    '{'
    '   white-space: nowrap;'
    '   overflow: hidden;'
    '   text-overflow: ellipsis;'
    '}'
    ''
    '.white-space-nowrap'
    '{'
    '   white-space: nowrap;'
    '}'
    ''
    '.allegato-presente'
    '{'
    '   background-color: #ffcc00;'
    '}'
    ''
    '.allegato-obbligatorio'
    '{'
    '   background-color: #cc0000;'
    '}'
    ''
    '.x-tab'
    '{'
    '    flex: 1;'
    '}')
  ServerMessages.UnavailableErrMsg = 'Errore di comunicazione'
  ServerMessages.LoadingMessage = 'Caricamento...'
  ServerMessages.InvalidSessionTemplate.Strings = (
    '<html>'
    '<body bgcolor="#dfe8f6">'
    '<p style="text-align:center;color:#0000A0">[###message###]</p>'
    
      '<p style="text-align:center;color:#A05050"><a href="[###url###]"' +
      '>Riavvia l'#39'applicazione</a></p>'
    '</body>'
    '</html>')
  ServerMessages.InvalidSessionMessage = 'Sessione non valida oppure timeout'
  ServerMessages.TerminateMessage = 'Sessione terminata'
  ExtLocale = 'it'
  SSL.Enabled = True
  SSL.SSLOptions.RootCertFile = 'root.pem'
  SSL.SSLOptions.CertFile = 'cert.pem'
  SSL.SSLOptions.KeyFile = 'key.pem'
  SSL.SSLOptions.Method = sslvTLSv1_1
  SSL.SSLOptions.SSLVersions = [sslvTLSv1_1]
  SSL.SSLOptions.Mode = sslmUnassigned
  SSL.SSLOptions.VerifyMode = []
  SSL.SSLOptions.VerifyDepth = 0
  ServerLogger.Enabled = False
  ServerLogger.Options = []
  ConnectionFailureRecovery.ErrorMessage = 'Errore di connessione'
  ConnectionFailureRecovery.RetryMessage = 'Riconnessione...'
  Height = 150
  Width = 215
end

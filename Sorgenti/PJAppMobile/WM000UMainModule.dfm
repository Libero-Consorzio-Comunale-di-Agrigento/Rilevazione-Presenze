object WM000FMainModule: TWM000FMainModule
  OldCreateOrder = False
  OnCreate = UniGUIMainModuleCreate
  OnDestroy = UniGUIMainModuleDestroy
  BackButtonAction = bbaWarnUser
  Theme = 'neptune'
  TouchTheme = 'neptune'
  MonitoredKeys.Keys = <
    item
    end>
  EnableSynchronousOperations = True
  ExtLocale = 'it'
  ServerMessages.UnavailableErrMsg = 'Errore di comunicazione'
  ServerMessages.LoadingMessage = 'Caricamento...'
  ServerMessages.ExceptionTemplate.Strings = (
    '<html>'
    '<body bgcolor="#dfe8f6">'
    
      '<p style="text-align:center;color:#A05050">Si &egrave; verificat' +
      'a un'#39'eccezione nell'#39'applicazione:</p>'
    '<p style="text-align:center;color:#0000A0">[###message###]</p>'
    
      '<p style="text-align:center;color:#A05050"><a href="[###url###]"' +
      '>Riavvia applicazione</a></p>'
    '</body>'
    '</html>')
  ServerMessages.InvalidSessionTemplate.Strings = (
    '<html>'
    '<body bgcolor="rgb(197, 213, 235)">'
    
      '<p style="text-align:center;color: rgb(197, 213, 235)">[###messa' +
      'ge###]</p>'
    
      '<p style="text-align:center;color:#A05050"><a href="[###url###]"' +
      '>Riavvia applicazione</a></p>'
    '</body>'
    '</html>')
  ServerMessages.InvalidSessionMessage = 'Sessione non valida oppure timeout'
  ServerMessages.TerminateMessage = 'Sessione terminata'
  Title = 'IrisAPP'
  OnBeforeLogin = UniGUIMainModuleBeforeLogin
  Height = 150
  Width = 215
end

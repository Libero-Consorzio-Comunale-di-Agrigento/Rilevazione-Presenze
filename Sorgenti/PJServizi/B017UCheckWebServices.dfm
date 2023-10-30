object B017FCheckWebServices: TB017FCheckWebServices
  OldCreateOrder = False
  DisplayName = 'B017FCheckWebServices'
  StartType = stManual
  AfterInstall = ServiceAfterInstall
  OnShutdown = ServiceShutdown
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end

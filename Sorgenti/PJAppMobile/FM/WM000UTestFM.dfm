inherited WM000FTestFM: TWM000FTestFM
  OnCreate = UniFrameCreate
  OnReady = UniFrameReady
  ClientEvents.UniEvents.Strings = (
    
      'afterCreate=function afterCreate(sender)'#13#10'{    '#13#10'   //registrazi' +
      'oneNotifichePush("/IrisAPP/ServiceWorker.js");'#13#10'   //iscrizioneN' +
      'otifichePush("BPHkCt-By5ue1HIRUa2EuuBzM_9oYLDNZTae5JIn2EcKfGXYc_' +
      'zzQNQa6F4xBPt6TrpFJCMcFA9CO9ZWv3Hx0J8", inviaDatiIrisAPP);'#13#10'}')
  inherited MainPanel: TMedpUnimPanelBase
    Left = -8
    ExplicitLeft = -8
  end
end

object WM015FTimbraturaVirtualeMappaFM: TWM015FTimbraturaVirtualeMappaFM
  Left = 0
  Top = 0
  Width = 391
  Height = 590
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  OnCreate = UniFrameCreate
  OnDestroy = UniFrameDestroy
  Layout = 'vbox'
  LayoutAttribs.Align = 'center'
  LayoutAttribs.Pack = 'start'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Anchors = []
  TabOrder = 0
  AutoScroll = True
  ClientEvents.UniEvents.Strings = (
    
      'beforeInit=function beforeInit(sender, config) '#13#10'{'#13#10'  // console' +
      '.log('#39'WM015 UniEvents beforeInit'#39');'#13#10#13#10'  var map=null;'#13#10'  var ma' +
      'rkerPosizione=null;'#13#10'  var arrayMarkerRilevatori=[];'#13#10'  var arra' +
      'yCerchiRilevatori=[];'#13#10'  '#13#10'  // effettua operazioni se la geoloc' +
      'alizzazione '#232' disponibile'#13#10'  if (navigator.geolocation) '#13#10'  {'#13#10' ' +
      '   // imposta le opzioni di geolocalizzazione'#13#10'    var options =' +
      ' '#13#10'    {'#13#10'      enableHighAccuracy: true,'#13#10'      timeout: 15000'#13 +
      #10'    };'#13#10#13#10'    /**'#13#10'     * onSuccess callback'#13#10'     * @param pos' +
      'ition contiene le coordinate GPS correnti'#13#10'     */'#13#10'    onSucces' +
      's = function (position) '#13#10'    {'#13#10'      try'#13#10'      {'#13#10'         aj' +
      'axRequest('#13#10'                      WM015FTimbraturaVirtualeMappaF' +
      'M.lblOra,'#13#10'                      "CurrentPositionOk",'#13#10'         ' +
      '             ["lat=" + position.coords.latitude,'#13#10'              ' +
      '        "lng=" + position.coords.longitude,'#13#10'                   ' +
      '   "acc=" + position.coords.accuracy,'#13#10'                      "al' +
      't=" + position.coords.altitude,'#13#10'                      "altacc="' +
      ' + position.coords.altitudeAccuracy,'#13#10'                      "hea' +
      'd=" + position.coords.heading,'#13#10'                      "speed=" +' +
      ' position.coords.speed,'#13#10'                      "ts=" + position.' +
      'coords.timestamp]'#13#10'                     );'#13#10'      }'#13#10'      catch' +
      ' (err)'#13#10'      {'#13#10'         document.getElementById("map_canvas").' +
      'innerHTML = "Errore: " + err;'#13#10'      }'#13#10'    };'#13#10#13#10'    /**'#13#10'     ' +
      '* onError callback'#13#10'     * @param error contiene l'#39'errore relati' +
      'vo alla geolocalizzazione'#13#10'     */'#13#10'    onError = function (erro' +
      'r) '#13#10'    {'#13#10'      ajaxRequest'#13#10'      ('#13#10'        WM015FTimbratura' +
      'VirtualeMappaFM.lblOra,'#13#10'        "CurrentPositionError",'#13#10'      ' +
      '  ["errorCode=" + error.code,'#13#10'        "errorMessage=" + error.m' +
      'essage]'#13#10'      );'#13#10'      console.error("error", error);'#13#10'    };'#13 +
      #10#13#10'    /**'#13#10'     * locateMe: funzione per localizzazione'#13#10'     *' +
      '/'#13#10'    locateMe = function () '#13#10'    {'#13#10'      navigator.geolocati' +
      'on.getCurrentPosition(onSuccess, onError, options);'#13#10'    };'#13#10'  }' +
      #13#10#13#10'  /**'#13#10'   * updateTime'#13#10'   *   metodo per aggiornamento data' +
      ' / ora lato client'#13#10'   * @param dateLabel label data'#13#10'   * @para' +
      'm hourLabel label ora'#13#10'   */'#13#10'  updateTime = function (dateLabel' +
      ', hourLabel) '#13#10'  {'#13#10'    const currDate = new Date();'#13#10'    const ' +
      'dateStr = currDate.toLocaleDateString("it-IT", '#13#10'    {'#13#10'      we' +
      'ekday: "long",'#13#10'      year: "numeric",'#13#10'      month: "long",'#13#10'  ' +
      '    day: "2-digit"'#13#10'    });'#13#10'    const hourStr = currDate.toLoca' +
      'leTimeString'#13#10'    ("it-IT", '#13#10'            {'#13#10'             hour: ' +
      '"2-digit",'#13#10'             minute: "2-digit",'#13#10'             second' +
      ': "2-digit"'#13#10'            }'#13#10'    );'#13#10'    dateLabel.setHtml(dateSt' +
      'r);'#13#10'    hourLabel.setHtml(hourStr);'#13#10'  };'#13#10#13#10'  /**'#13#10'   * drawMa' +
      'p'#13#10'   *   metodo per il disegno della mappa con la propria posiz' +
      'ione e i rilevatori'#13#10'   * @param lat latitudine'#13#10'   * @param lng' +
      ' longitudine'#13#10'   * @param rilevatori elenco di rilevatori'#13#10'   * ' +
      '@param rilevatore codice del rilevatore corrente'#13#10'   */'#13#10'  drawM' +
      'ap = function (lat, lng, rilevatori, rilevatore) '#13#10'  {'#13#10'    try ' +
      #13#10'    {'#13#10'      /* imposta le coordinate utente */'#13#10'      var myL' +
      'atLng = new google.maps.LatLng(lat, lng);'#13#10'      /* crea oggetto' +
      ' map e specifica l'#39'elemento del DOM a cui collegarla */'#13#10'      m' +
      'ap = new google.maps.Map(document.getElementById("map_canvas"), ' +
      #13#10'                                                {'#13#10'           ' +
      '                                        center: myLatLng,'#13#10'     ' +
      '                                              fullscreenControl:' +
      ' false,'#13#10'                                                   zoom' +
      ': 17,'#13#10'                                                   mapTyp' +
      'eId: google.maps.MapTypeId.ROADMAP,'#13#10'                           ' +
      '                        mapTypeControl: false,'#13#10'                ' +
      '                                   streetViewControl: false'#13#10'   ' +
      '                                             }'#13#10'                ' +
      '               );'#13#10'      '#13#10'      updatePosizione(lat, lng);'#13#10'   ' +
      '   updateRilevatori(rilevatori, rilevatore);  '#13#10'    }'#13#10'    catch' +
      ' (err) '#13#10'    {'#13#10'      document.getElementById("map_canvas").inne' +
      'rHTML = "Errore: " + err;'#13#10'    }'#13#10'  };'#13#10'  '#13#10'  updatePosizione = ' +
      'function(lat, lng)'#13#10'  {'#13#10'      if(map)'#13#10'      {'#13#10'         clearP' +
      'osizione();'#13#10'         '#13#10'         var myLatLng = new google.maps.' +
      'LatLng(lat, lng);'#13#10'      '#13#10'         markerPosizione = new google' +
      '.maps.Marker'#13#10'         ({'#13#10'            map: map,'#13#10'            po' +
      'sition: myLatLng,'#13#10'            label: "A",'#13#10'            title: "' +
      'Posizione corrente"'#13#10'         });'#13#10'      }'#13#10'  };'#13#10'  '#13#10'  updateRi' +
      'levatori = function(rilevatori, rilevatore)'#13#10'  {'#13#10'      if(map)'#13 +
      #10'      {'#13#10'         clearRilevatori();'#13#10'      '#13#10'         for (var' +
      ' ril in rilevatori) '#13#10'         {'#13#10'            /* crea il marker ' +
      'per il rilevatore e ne imposta la posizione */'#13#10'            var ' +
      'markerRilevatore = new google.maps.Marker'#13#10'            ({'#13#10'     ' +
      '          map: map,'#13#10'               position: rilevatori[ril].ce' +
      'nter,'#13#10'               label: ril,'#13#10'               title: ril'#13#10'  ' +
      '          });'#13#10'        '#13#10'            arrayMarkerRilevatori.push(' +
      'markerRilevatore);'#13#10'        '#13#10'            /* disegna un'#39'area cir' +
      'colare intorno al marker */'#13#10'            var circleColor = (rile' +
      'vatore === ril) ? "#FF0000" : "#0000FF";'#13#10'            var rilCir' +
      'cle = new google.maps.Circle'#13#10'            ({'#13#10'               str' +
      'okeColor: circleColor,'#13#10'               strokeOpacity: 0.8,'#13#10'    ' +
      '           strokeWeight: 2,'#13#10'               fillColor: circleCol' +
      'or,'#13#10'               fillOpacity: 0.15,'#13#10'               map: map,' +
      #13#10'               center: rilevatori[ril].center,'#13#10'              ' +
      ' radius: rilevatori[ril].radius'#13#10'            });'#13#10'        '#13#10'    ' +
      '        arrayCerchiRilevatori.push(rilCircle);'#13#10'         }'#13#10'    ' +
      '  }      '#13#10'  };'#13#10'  '#13#10'  clearRilevatori = function()'#13#10'  {'#13#10'      ' +
      'var i;'#13#10'      '#13#10'      for (i = 0; i < arrayMarkerRilevatori.leng' +
      'th; i++) '#13#10'      {'#13#10'         if(arrayMarkerRilevatori[i])'#13#10'     ' +
      '    {'#13#10'            arrayMarkerRilevatori[i].setMap(null);'#13#10'     ' +
      '    }'#13#10'            '#13#10'      }'#13#10'      arrayMarkerRilevatori=[];'#13#10' ' +
      '     '#13#10'      for (i = 0; i < arrayCerchiRilevatori.length; i++) ' +
      #13#10'      {'#13#10'         if(arrayCerchiRilevatori[i])'#13#10'         {'#13#10'  ' +
      '          arrayCerchiRilevatori[i].setMap(null);'#13#10'         }  '#13#10 +
      '      }'#13#10'      arrayCerchiRilevatori=[];'#13#10'  };'#13#10'  '#13#10'  clearPosiz' +
      'ione = function()'#13#10'  {'#13#10'      if(markerPosizione)'#13#10'      {'#13#10'    ' +
      '     markerPosizione.setMap(null);'#13#10'         markerPosizione=nul' +
      'l;'#13#10'      }'#13#10'  };'#13#10'  '#13#10'  clear = function()'#13#10'  {'#13#10'      clearRil' +
      'evatori();  '#13#10'      clearPosizione();'#13#10'      map=null;'#13#10'  };'#13#10'}'#13 +
      #10)
  DesignSize = (
    391
    590)
  object pnlTimbratura: TUnimContainerPanel
    Left = 0
    Top = 0
    Width = 391
    Height = 567
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    CreateOrder = 1
    AutoScroll = True
    Anchors = []
    LayoutAttribs.Align = 'center'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.Width = '100%'
    Flex = 1
    DesignSize = (
      391
      567)
    ScrollHeight = 567
    ScrollWidth = 391
    object lblData: TUnimLabel
      Left = 3
      Top = 9
      Width = 385
      Height = 28
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 1
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblData'
      Anchors = []
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'   sender.setStyle(' +
          '"display: flex; justify-content: center; align-items: center;");' +
          '// font-size: 18px;");'#13#10'}')
      LayoutConfig.Height = '25'
      LayoutConfig.Width = '100%'
      ParentFont = False
      Font.Height = -15
      Font.Style = [fsBold]
    end
    object lblOra: TUnimLabel
      Left = 3
      Top = 43
      Width = 385
      Height = 44
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 2
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblOra'
      Anchors = []
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'   sender.setStyle(' +
          '"display: flex; justify-content: center; align-items: center;");' +
          '// font-size: 26px;");'#13#10'}')
      LayoutConfig.Height = '38'
      LayoutConfig.Width = '100%'
      ParentFont = False
      Font.Height = -31
      Font.Style = [fsBold]
      OnAjaxEvent = lblOraAjaxEvent
    end
    object pnlCausale: TUnimPanel
      Left = 0
      Top = 90
      Width = 391
      Height = 84
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 3
      Constraints.MaxWidth = 450
      Anchors = []
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'start'
      LayoutConfig.Height = '70'
      LayoutConfig.Width = '98%'
      BorderStyle = ubsNone
      DesignSize = (
        391
        84)
      object lblCausale: TUnimLabel
        Left = 0
        Top = 0
        Width = 391
        Height = 23
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        AutoSize = False
        Caption = 'Causale'
        Anchors = []
        ClientEvents.UniEvents.Strings = (
          
            'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'   sender.setStyle(' +
            '"display: flex; justify-content: flex-start; align-items: center' +
            ';");// font-size: 18px;");'#13#10'}')
        LayoutConfig.Height = '25'
        LayoutConfig.Width = '100%'
        ParentFont = False
        Font.Height = -16
        Font.Style = [fsBold]
      end
      object cmbCausale: TUnimSelect
        Left = 0
        Top = 23
        Width = 391
        Height = 40
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Anchors = []
        ClientEvents.UniEvents.Strings = (
          
            'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'   sender.getPicker' +
            '().getDoneButton().setText("Conferma");'#13#10'   sender.getPicker().g' +
            'etCancelButton().setText("Annulla");'#13#10'}')
        LayoutConfig.Height = '35'
        LayoutConfig.Width = '100%'
        TabOrder = 2
      end
    end
    object pnlRilevatore: TUnimPanel
      Left = 0
      Top = 174
      Width = 391
      Height = 69
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 4
      Constraints.MaxWidth = 450
      Anchors = []
      Layout = 'hbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'justify'
      LayoutConfig.Height = 'auto'
      LayoutConfig.Width = '98%'
      BorderStyle = ubsNone
      DesignSize = (
        391
        69)
      object UnimPanel1: TUnimPanel
        Left = 0
        Top = 0
        Width = 343
        Height = 69
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Anchors = []
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        LayoutConfig.Height = 'auto'
        LayoutConfig.Width = '100%'
        Flex = 1
        BorderStyle = ubsNone
        object lblRilevatore: TUnimLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 337
          Height = 23
          Hint = ''
          AutoSize = False
          Caption = 'Rilevatore'
          Align = alTop
          ClientEvents.UniEvents.Strings = (
            
              'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'   sender.setStyle(' +
              '"display: flex; justify-content: flex-start; align-items: center' +
              ';");// font-size: 18px;");'#13#10'}')
          LayoutConfig.Height = '25'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Height = -16
          Font.Style = [fsBold]
        end
        object lblRilevatoreValue: TUnimLabel
          AlignWithMargins = True
          Left = 3
          Top = 32
          Width = 337
          Height = 23
          Hint = ''
          AutoSize = False
          Caption = ''
          Align = alTop
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '100%'
          LayoutConfig.Margin = '2'
          ParentFont = False
          Font.Height = -16
          Font.Style = [fsItalic]
        end
      end
      object btnMostraPosizione: TUnimButton
        Left = 343
        Top = 0
        Width = 40
        Height = 40
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Anchors = []
        Caption = ''
        IconCls = 'maps'
        UI = 'normal'
        LayoutConfig.Height = '50'
        LayoutConfig.Width = '50'
        OnClick = btnMostraPosizioneClick
      end
    end
    object pnlPulsanti: TUnimPanel
      Left = 0
      Top = 243
      Width = 391
      Height = 70
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 5
      Constraints.MaxWidth = 450
      Anchors = []
      Layout = 'hbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'center'
      LayoutConfig.Height = '65'
      LayoutConfig.Width = '98%'
      BorderStyle = ubsNone
      DesignSize = (
        391
        70)
      object btnEntrata: TUnimButton
        Left = 24
        Top = 3
        Width = 150
        Height = 63
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Anchors = []
        Caption = 'Entrata'
        ClientEvents.ExtEvents.Strings = (
          
            'orientationchange=function orientationchange(eOpts)'#13#10'{'#13#10'   conso' +
            'le.log('#39'eOpts'#39', eOpts);'#13#10'}')
        IconAlign = iaTop
        IconCls = 'arrow_right'
        UI = 'normal'
        Flex = 1
        ScreenMask.Enabled = True
        ScreenMask.WaitData = True
        ScreenMask.Message = 'Timbratura di Entrata...'
        ScreenMask.Target = pnlTimbratura
        ScreenMask.Opacity = 0.600000023841857900
        Font.Color = clGreen
        LayoutConfig.Height = '55'
        LayoutConfig.Width = '35%'
        OnClick = btnEntrataClick
      end
      object UnimLabel1: TUnimLabel
        Left = 185
        Top = 24
        Width = 30
        Height = 23
        Hint = ''
        CreateOrder = 2
        AutoSize = False
        Caption = ''
        Anchors = []
        LayoutConfig.Height = '50'
        LayoutConfig.Width = '30%'
        ParentFont = False
      end
      object btnUscita: TUnimButton
        Left = 238
        Top = 3
        Width = 130
        Height = 63
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 3
        Anchors = []
        Caption = 'Uscita'
        IconAlign = iaTop
        IconCls = 'arrow_left'
        UI = 'normal'
        Flex = 1
        ScreenMask.Enabled = True
        ScreenMask.WaitData = True
        ScreenMask.Message = 'Timbratura di Uscita...'
        ScreenMask.Target = pnlTimbratura
        ScreenMask.Opacity = 0.600000023841857900
        Font.Color = clRed
        LayoutConfig.Height = '55'
        LayoutConfig.Width = '35%'
        OnClick = btnUscitaClick
      end
    end
    object HTMLFrame: TUnimHTMLFrame
      Left = 0
      Top = 313
      Width = 391
      Height = 254
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 10
      HTML.Strings = (
        
          '<div id="map_canvas" style="position: absolute; width: 100%; hei' +
          'ght: 100%"></div>')
      Anchors = []
    end
  end
  object lblErrori: TUnimLabel
    Left = 0
    Top = 567
    Width = 391
    Height = 23
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Alignment = taCenter
    AutoSize = False
    Caption = ''
    Anchors = []
    ParentColor = False
    Color = clRed
    Transparent = False
    LayoutConfig.Height = 'auto'
    LayoutConfig.Width = '100%'
    ParentFont = False
    Font.Color = clBtnFace
  end
  object tmrOrario: TUnimTimer
    Enabled = False
    ClientEvent.Strings = (
      'function(sender) {'
      
        '  updateTime(WM015FTimbraturaVirtualeMappaFM.lblData, WM015FTimb' +
        'raturaVirtualeMappaFM.lblOra);'
      '}')
    Left = 48
    Top = 40
  end
end

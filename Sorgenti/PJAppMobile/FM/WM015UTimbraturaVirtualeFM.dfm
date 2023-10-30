inherited WM015FTimbraturaVirtualeFM: TWM015FTimbraturaVirtualeFM
  OnCreate = UniFrameCreate
  OnReady = UniFrameReady
  Layout = 'vbox'
  LayoutAttribs.Align = 'center'
  LayoutAttribs.Pack = 'start'
  ClientEvents.UniEvents.Strings = (
    
      'beforeInit=function beforeInit(sender, config) '#13#10'{'#13#10'  // console' +
      '.log('#39'WM015 UniEvents beforeInit'#39');'#13#10#13#10'  var map=null;'#13#10'  var ma' +
      'rkerPosizione=null;'#13#10'  var arrayMarkerRilevatori=[];'#13#10'  var arra' +
      'yCerchiRilevatori=[];'#13#10'  var serverDate=new Date();'#13#10'  '#13#10'  // ef' +
      'fettua operazioni se la geolocalizzazione '#232' disponibile'#13#10'  if (n' +
      'avigator.geolocation) '#13#10'  {'#13#10'    // imposta le opzioni di geoloc' +
      'alizzazione'#13#10'    var options = '#13#10'    {'#13#10'      enableHighAccuracy' +
      ': true,'#13#10'      timeout: 15000'#13#10'    };'#13#10#13#10'    /**'#13#10'     * onSucce' +
      'ss callback'#13#10'     * @param position contiene le coordinate GPS c' +
      'orrenti'#13#10'     */'#13#10'    onSuccess = function (position) '#13#10'    {'#13#10' ' +
      '     try'#13#10'      {'#13#10'         ajaxRequest('#13#10'                      ' +
      'WM015FTimbraturaVirtualeFM.lblOra,'#13#10'                      "Curre' +
      'ntPositionOk",'#13#10'                      ["lat=" + position.coords.' +
      'latitude,'#13#10'                      "lng=" + position.coords.longit' +
      'ude,'#13#10'                      "acc=" + position.coords.accuracy,'#13#10 +
      '                      "alt=" + position.coords.altitude,'#13#10'      ' +
      '                "altacc=" + position.coords.altitudeAccuracy,'#13#10' ' +
      '                     "head=" + position.coords.heading,'#13#10'       ' +
      '               "speed=" + position.coords.speed,'#13#10'              ' +
      '        "ts=" + position.coords.timestamp]'#13#10'                    ' +
      ' );'#13#10'      }'#13#10'      catch (err)'#13#10'      {'#13#10'         document.getE' +
      'lementById("map_canvas").innerHTML = "Errore: " + err;'#13#10'      }'#13 +
      #10'    };'#13#10#13#10'    /**'#13#10'     * onError callback'#13#10'     * @param error' +
      ' contiene l'#39'errore relativo alla geolocalizzazione'#13#10'     */'#13#10'   ' +
      ' onError = function (error) '#13#10'    {'#13#10'      ajaxRequest'#13#10'      ('#13 +
      #10'        WM015FTimbraturaVirtualeFM.lblOra,'#13#10'        "CurrentPos' +
      'itionError",'#13#10'        ["errorCode=" + error.code,'#13#10'        "erro' +
      'rMessage=" + error.message]'#13#10'      );'#13#10'      console.error("erro' +
      'r", error);'#13#10'    };'#13#10#13#10'    /**'#13#10'     * locateMe: funzione per lo' +
      'calizzazione'#13#10'     */'#13#10'    locateMe = function () '#13#10'    {'#13#10'     ' +
      ' navigator.geolocation.getCurrentPosition(onSuccess, onError, op' +
      'tions);'#13#10'    };'#13#10'  }'#13#10#13#10'  /**'#13#10'   * updateTime'#13#10'   *   metodo pe' +
      'r aggiornamento data / ora con dati provenienti dal server'#13#10'   *' +
      '/'#13#10'  updateTime = function (dateLabel, hourLabel, year, month, d' +
      'ay, hours, minutes, seconds, milliseconds) '#13#10'  {'#13#10'    serverDate' +
      ' = new Date(year, month-1, day, hours, minutes, seconds, millise' +
      'conds);'#13#10'    const dateStr = serverDate.toLocaleDateString("it-I' +
      'T", '#13#10'    {'#13#10'      weekday: "long",'#13#10'      year: "numeric",'#13#10'   ' +
      '   month: "long",'#13#10'      day: "2-digit"'#13#10'    });'#13#10'    const hour' +
      'Str = serverDate.toLocaleTimeString'#13#10'    ("it-IT", '#13#10'           ' +
      ' {'#13#10'             hour: "2-digit",'#13#10'             minute: "2-digit' +
      '",'#13#10'             second: "2-digit"'#13#10'            }'#13#10'    );'#13#10'    d' +
      'ateLabel.setHtml(dateStr);'#13#10'    hourLabel.setHtml(hourStr);'#13#10'  }' +
      ';'#13#10'  '#13#10'  /**'#13#10'  * updateSeconds'#13#10'  *   metodo per aggiornamento ' +
      'data / ora lato client + 1 secondo'#13#10'  */'#13#10'  updateSeconds = func' +
      'tion(dateLabel, hourLabel)'#13#10'  {'#13#10'      serverDate = new Date(ser' +
      'verDate.getTime() + 1000);'#13#10'      const dateStr = serverDate.toL' +
      'ocaleDateString("it-IT", '#13#10'      {'#13#10'         weekday: "long",'#13#10' ' +
      '        year: "numeric",'#13#10'         month: "long",'#13#10'         day:' +
      ' "2-digit"'#13#10'      });'#13#10'      const hourStr = serverDate.toLocale' +
      'TimeString'#13#10'      ("it-IT", '#13#10'            {'#13#10'             hour: ' +
      '"2-digit",'#13#10'             minute: "2-digit",'#13#10'             second' +
      ': "2-digit"'#13#10'            }'#13#10'      );'#13#10'      dateLabel.setHtml(da' +
      'teStr);'#13#10'      hourLabel.setHtml(hourStr);'#13#10'  };'#13#10'  '#13#10'  /**'#13#10'  *' +
      ' inviaDataClient'#13#10'  *   metodo per invio della data aggiornata l' +
      'ato client'#13#10'  */'#13#10'  inviaDataClient = function(btnObj, eventName' +
      ')'#13#10'  {'#13#10'      ajaxRequest('#13#10'                  btnObj,'#13#10'         ' +
      '         eventName,'#13#10'                  ['#13#10'                   "an' +
      'no=" + serverDate.getFullYear(),'#13#10'                   "mese=" + (' +
      'serverDate.getMonth() + 1),'#13#10'                   "giorno=" + serv' +
      'erDate.getDate(),'#13#10'                   "ora=" + serverDate.getHou' +
      'rs(),'#13#10'                   "minuti=" + serverDate.getMinutes(),'#13#10 +
      '                   "secondi=" + serverDate.getSeconds(),        ' +
      '         '#13#10'                  ]'#13#10'      );'#13#10'  };'#13#10#13#10'  /**'#13#10'   * dr' +
      'awMap'#13#10'   *   metodo per il disegno della mappa con la propria p' +
      'osizione e i rilevatori'#13#10'   * @param lat latitudine'#13#10'   * @param' +
      ' lng longitudine'#13#10'   * @param rilevatori elenco di rilevatori'#13#10' ' +
      '  * @param rilevatore codice del rilevatore corrente'#13#10'   */'#13#10'  d' +
      'rawMap = function (lat, lng, rilevatori, rilevatore) '#13#10'  {'#13#10'    ' +
      'try '#13#10'    {'#13#10'      /* imposta le coordinate utente */'#13#10'      var' +
      ' myLatLng = new google.maps.LatLng(lat, lng);'#13#10'      /* crea ogg' +
      'etto map e specifica l'#39'elemento del DOM a cui collegarla */'#13#10'   ' +
      '   map = new google.maps.Map(document.getElementById("map_canvas' +
      '"), '#13#10'                                                {'#13#10'       ' +
      '                                            center: myLatLng,'#13#10' ' +
      '                                                  fullscreenCont' +
      'rol: false,'#13#10'                                                   ' +
      'zoom: 17,'#13#10'                                                   ma' +
      'pTypeId: google.maps.MapTypeId.ROADMAP,'#13#10'                       ' +
      '                            mapTypeControl: false,'#13#10'            ' +
      '                                       streetViewControl: false'#13 +
      #10'                                                }'#13#10'            ' +
      '                   );'#13#10'      '#13#10'      updatePosizione(lat, lng);'#13 +
      #10'      updateRilevatori(rilevatori, rilevatore);  '#13#10'    }'#13#10'    c' +
      'atch (err) '#13#10'    {'#13#10'      document.getElementById("map_canvas").' +
      'innerHTML = "Errore: " + err;'#13#10'    }'#13#10'  };'#13#10'  '#13#10'  updatePosizion' +
      'e = function(lat, lng)'#13#10'  {'#13#10'      if(map)'#13#10'      {'#13#10'         cl' +
      'earPosizione();'#13#10'         '#13#10'         var myLatLng = new google.m' +
      'aps.LatLng(lat, lng);'#13#10'      '#13#10'         markerPosizione = new go' +
      'ogle.maps.Marker'#13#10'         ({'#13#10'            map: map,'#13#10'          ' +
      '  position: myLatLng,'#13#10'            label: "A",'#13#10'            titl' +
      'e: "Posizione corrente"'#13#10'         });'#13#10'      }'#13#10'  };'#13#10'  '#13#10'  upda' +
      'teRilevatori = function(rilevatori, rilevatore)'#13#10'  {'#13#10'      if(m' +
      'ap)'#13#10'      {'#13#10'         clearRilevatori();'#13#10'      '#13#10'         for ' +
      '(var ril in rilevatori) '#13#10'         {'#13#10'            /* crea il mar' +
      'ker per il rilevatore e ne imposta la posizione */'#13#10'            ' +
      'var markerRilevatore = new google.maps.Marker'#13#10'            ({'#13#10' ' +
      '              map: map,'#13#10'               position: rilevatori[ril' +
      '].center,'#13#10'               label: ril,'#13#10'               title: ril' +
      #13#10'            });'#13#10'        '#13#10'            arrayMarkerRilevatori.p' +
      'ush(markerRilevatore);'#13#10'        '#13#10'            /* disegna un'#39'area' +
      ' circolare intorno al marker */'#13#10'            var circleColor = (' +
      'rilevatore === ril) ? "#FF0000" : "#0000FF";'#13#10'            var ri' +
      'lCircle = new google.maps.Circle'#13#10'            ({'#13#10'              ' +
      ' strokeColor: circleColor,'#13#10'               strokeOpacity: 0.8,'#13#10 +
      '               strokeWeight: 2,'#13#10'               fillColor: circl' +
      'eColor,'#13#10'               fillOpacity: 0.15,'#13#10'               map: ' +
      'map,'#13#10'               center: rilevatori[ril].center,'#13#10'          ' +
      '     radius: rilevatori[ril].radius'#13#10'            });'#13#10'        '#13#10 +
      '            arrayCerchiRilevatori.push(rilCircle);'#13#10'         }'#13#10 +
      '      }      '#13#10'  };'#13#10'  '#13#10'  clearRilevatori = function()'#13#10'  {'#13#10'  ' +
      '    var i;'#13#10'      '#13#10'      for (i = 0; i < arrayMarkerRilevatori.' +
      'length; i++) '#13#10'      {'#13#10'         if(arrayMarkerRilevatori[i])'#13#10' ' +
      '        {'#13#10'            arrayMarkerRilevatori[i].setMap(null);'#13#10' ' +
      '        }'#13#10'            '#13#10'      }'#13#10'      arrayMarkerRilevatori=[]' +
      ';'#13#10'      '#13#10'      for (i = 0; i < arrayCerchiRilevatori.length; i' +
      '++) '#13#10'      {'#13#10'         if(arrayCerchiRilevatori[i])'#13#10'         {' +
      #13#10'            arrayCerchiRilevatori[i].setMap(null);'#13#10'         }' +
      '  '#13#10'      }'#13#10'      arrayCerchiRilevatori=[];'#13#10'  };'#13#10'  '#13#10'  clearP' +
      'osizione = function()'#13#10'  {'#13#10'      if(markerPosizione)'#13#10'      {'#13#10 +
      '         markerPosizione.setMap(null);'#13#10'         markerPosizione' +
      '=null;'#13#10'      }'#13#10'  };'#13#10'  '#13#10'  clear = function()'#13#10'  {'#13#10'      clea' +
      'rRilevatori();  '#13#10'      clearPosizione();'#13#10'      map=null;'#13#10'  };' +
      #13#10'}')
  inherited MainPanel: TMedpUnimPanelBase
    Height = 587
    CreateOrder = 1
    LayoutConfig.Width = '100%'
    Flex = 1
    ExplicitHeight = 587
    object pnlDataOra: TMedpUnimPanelBase
      Left = 73
      Top = 0
      Width = 200
      Height = 65
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 1
      Anchors = []
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'start'
      LayoutConfig.Height = 'auto'
      LayoutConfig.Width = 'auto'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '15px'
      BoxModel.CSSMargin.Bottom = '5px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '8px'
      BoxModel.CSSPadding.Bottom = '6px'
      BoxModel.CSSPadding.Right = '15px'
      BoxModel.CSSPadding.Left = '15px'
      BoxModel.CSSBorder.Top = '2px solid black'
      BoxModel.CSSBorder.Bottom = '2px solid black'
      BoxModel.CSSBorder.Right = '2px solid black'
      BoxModel.CSSBorder.Left = '2px solid black'
      BoxModel.CSSBorderRadius = '5px'
      DesignSize = (
        200
        65)
      object lblData: TMedpUnimLabel
        Left = 0
        Top = 10
        Width = 188
        Height = 33
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Caption = 'lblData'
        LayoutConfig.Height = '25'
        LayoutConfig.Width = 'auto'
        ParentFont = False
        Font.Height = -20
        Font.Style = [fsBold]
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '0px'
        BoxModel.CSSPadding.Top = '0px'
        BoxModel.CSSPadding.Bottom = '0px'
        BoxModel.CSSPadding.Right = '0px'
        BoxModel.CSSPadding.Left = '0px'
        BoxModel.CSSBorder.Top = '0px'
        BoxModel.CSSBorder.Bottom = '0px'
        BoxModel.CSSBorder.Right = '0px'
        BoxModel.CSSBorder.Left = '0px'
        BoxModel.CSSBorderRadius = '0px'
        DesignSize = (
          188
          33)
      end
      object lblOra: TMedpUnimLabel
        Left = 43
        Top = 20
        Width = 134
        Height = 45
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Caption = 'lblOra'
        LayoutConfig.Height = '38'
        LayoutConfig.Width = 'auto'
        ParentFont = False
        Font.Height = -40
        Font.Style = [fsBold]
        OnAjaxEvent = lblOraAjaxEvent
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '0px'
        BoxModel.CSSPadding.Top = '0px'
        BoxModel.CSSPadding.Bottom = '0px'
        BoxModel.CSSPadding.Right = '0px'
        BoxModel.CSSPadding.Left = '0px'
        BoxModel.CSSBorder.Top = '0px'
        BoxModel.CSSBorder.Bottom = '0px'
        BoxModel.CSSBorder.Right = '0px'
        BoxModel.CSSBorder.Left = '0px'
        BoxModel.CSSBorderRadius = '0px'
        DesignSize = (
          134
          45)
      end
    end
    object lblCausale: TMedpUnimLabel
      Left = 0
      Top = 59
      Width = 347
      Height = 25
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 3
      Caption = 'Causale'
      LayoutConfig.Height = '25'
      LayoutConfig.Width = '98%'
      ParentFont = False
      Font.Height = -16
      Font.Style = [fsBold]
      JustifyContent = JustifyStart
      BoxModel.CSSMargin.Top = '5px'
      BoxModel.CSSMargin.Bottom = '0px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '0px'
      BoxModel.CSSPadding.Bottom = '0px'
      BoxModel.CSSPadding.Right = '0px'
      BoxModel.CSSPadding.Left = '0px'
      BoxModel.CSSBorder.Top = '0px'
      BoxModel.CSSBorder.Bottom = '0px'
      BoxModel.CSSBorder.Right = '0px'
      BoxModel.CSSBorder.Left = '0px'
      BoxModel.CSSBorderRadius = '0px'
      DesignSize = (
        347
        25)
    end
    object cmbCausale: TMedpUnimSelect
      Left = 0
      Top = 83
      Width = 347
      Height = 45
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 4
      Anchors = []
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
          'se); }')
      LayoutConfig.Height = 'auto'
      LayoutConfig.Width = '98%'
      TabOrder = 2
      Picker = dptFloated
      BoxModel.CSSMargin.Top = '0px'
      BoxModel.CSSMargin.Bottom = '0px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '0px'
      BoxModel.CSSPadding.Bottom = '0px'
      BoxModel.CSSPadding.Right = '0px'
      BoxModel.CSSPadding.Left = '0px'
      BoxModel.CSSBorder.Top = '0px'
      BoxModel.CSSBorder.Bottom = '0px'
      BoxModel.CSSBorder.Right = '0px'
      BoxModel.CSSBorder.Left = '0px'
      BoxModel.CSSBorderRadius = '0px'
      SeparatoreTesto = ' '
      ElementoVuoto = True
      DesignSize = (
        347
        45)
    end
    object pnlRilevatore: TMedpUnimPanelBase
      Left = 0
      Top = 122
      Width = 347
      Height = 65
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 5
      Anchors = []
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      Layout = 'hbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'start'
      LayoutConfig.Height = 'auto'
      LayoutConfig.Width = '98%'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '10px'
      BoxModel.CSSMargin.Bottom = '0px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '0px'
      BoxModel.CSSPadding.Bottom = '0px'
      BoxModel.CSSPadding.Right = '0px'
      BoxModel.CSSPadding.Left = '0px'
      BoxModel.CSSBorder.Top = '0px'
      BoxModel.CSSBorder.Bottom = '0px'
      BoxModel.CSSBorder.Right = '0px'
      BoxModel.CSSBorder.Left = '0px'
      BoxModel.CSSBorderRadius = '0px'
      DesignSize = (
        347
        65)
      object pnlLabelsRilevatore: TMedpUnimPanelBase
        Left = 0
        Top = -9
        Width = 273
        Height = 65
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Constraints.MinHeight = 35
        Anchors = []
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        LayoutConfig.Height = 'auto'
        Flex = 1
        ClickEnabled = True
        ChangeEnabled = True
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '10px'
        BoxModel.CSSMargin.Left = '0px'
        BoxModel.CSSPadding.Top = '3px'
        BoxModel.CSSPadding.Bottom = '3px'
        BoxModel.CSSPadding.Right = '3px'
        BoxModel.CSSPadding.Left = '3px'
        BoxModel.CSSBorder.Top = '1px solid black'
        BoxModel.CSSBorder.Bottom = '1px solid black'
        BoxModel.CSSBorder.Right = '1px solid black'
        BoxModel.CSSBorder.Left = '1px solid black'
        BoxModel.CSSBorderRadius = '5px'
        DesignSize = (
          273
          65)
        object lblRilevatore: TMedpUnimLabel
          Left = 0
          Top = 13
          Width = 207
          Height = 25
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 1
          Caption = 'Rilevatore'
          LayoutConfig.Height = '25'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Height = -16
          Font.Style = [fsBold]
          BoxModel.CSSMargin.Top = '0px'
          BoxModel.CSSMargin.Bottom = '0px'
          BoxModel.CSSMargin.Right = '0px'
          BoxModel.CSSMargin.Left = '0px'
          BoxModel.CSSPadding.Top = '0px'
          BoxModel.CSSPadding.Bottom = '0px'
          BoxModel.CSSPadding.Right = '0px'
          BoxModel.CSSPadding.Left = '0px'
          BoxModel.CSSBorder.Top = '0px'
          BoxModel.CSSBorder.Bottom = '0px'
          BoxModel.CSSBorder.Right = '0px'
          BoxModel.CSSBorder.Left = '0px'
          BoxModel.CSSBorderRadius = '0px'
          DesignSize = (
            207
            25)
        end
        object lblRilevatoreValue: TMedpUnimLabel
          Left = 0
          Top = 33
          Width = 201
          Height = 24
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 2
          Caption = '- -'
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Height = -16
          Font.Style = [fsItalic]
          BoxModel.CSSMargin.Top = '0px'
          BoxModel.CSSMargin.Bottom = '0px'
          BoxModel.CSSMargin.Right = '0px'
          BoxModel.CSSMargin.Left = '0px'
          BoxModel.CSSPadding.Top = '0px'
          BoxModel.CSSPadding.Bottom = '0px'
          BoxModel.CSSPadding.Right = '0px'
          BoxModel.CSSPadding.Left = '0px'
          BoxModel.CSSBorder.Top = '0px'
          BoxModel.CSSBorder.Bottom = '0px'
          BoxModel.CSSBorder.Right = '0px'
          BoxModel.CSSBorder.Left = '0px'
          BoxModel.CSSBorderRadius = '0px'
          DesignSize = (
            201
            24)
        end
      end
      object btnMostraPosizione: TMedpUnimButton
        Left = 289
        Top = 4
        Width = 50
        Height = 45
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Anchors = []
        UI = 'action'
        IconCls = 'maps'
        Caption = ''
        LayoutConfig.Height = '50'
        LayoutConfig.Width = '50'
        OnClick = btnMostraPosizioneClick
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '3px'
        BoxModel.CSSMargin.Left = '0px'
        BoxModel.CSSPadding.Top = '0px'
        BoxModel.CSSPadding.Bottom = '0px'
        BoxModel.CSSPadding.Right = '0px'
        BoxModel.CSSPadding.Left = '0px'
        BoxModel.CSSBorder.Top = '0px'
        BoxModel.CSSBorder.Bottom = '0px'
        BoxModel.CSSBorder.Right = '0px'
        BoxModel.CSSBorder.Left = '0px'
        BoxModel.CSSBorderRadius = '0px'
        DesignSize = (
          50
          45)
      end
    end
    object pnlPulsanti: TMedpUnimPanelBase
      Left = 0
      Top = 184
      Width = 347
      Height = 81
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 7
      Anchors = []
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      Layout = 'hbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'justify'
      LayoutConfig.Height = 'auto'
      LayoutConfig.Width = '98%'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '10px'
      BoxModel.CSSMargin.Bottom = '10px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '0px'
      BoxModel.CSSPadding.Bottom = '0px'
      BoxModel.CSSPadding.Right = '0px'
      BoxModel.CSSPadding.Left = '0px'
      BoxModel.CSSBorder.Top = '0px'
      BoxModel.CSSBorder.Bottom = '0px'
      BoxModel.CSSBorder.Right = '0px'
      BoxModel.CSSBorder.Left = '0px'
      BoxModel.CSSBorderRadius = '0px'
      DesignSize = (
        347
        81)
      object btnEntrata: TMedpUnimButton
        Left = 24
        Top = 16
        Width = 89
        Height = 45
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Constraints.MaxWidth = 350
        Anchors = []
        ClientEvents.ExtEvents.Strings = (
          
            'tap=function tap(sender, e, eOpts)'#13#10'{'#13#10'   inviaDataClient(WM015F' +
            'TimbraturaVirtualeFM.btnEntrata, "btnEntrataClick");'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.WaitData = True
        ScreenMask.Message = 'Timbratura virtuale in corso...'
        UI = 'action'
        IconAlign = iaTop
        IconCls = 'arrow_right'
        Caption = 'Entrata'
        LayoutConfig.Height = '55'
        LayoutConfig.Width = '35%'
        OnAjaxEvent = btnTimbraturaAjaxEvent
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '15px'
        BoxModel.CSSPadding.Top = '0px'
        BoxModel.CSSPadding.Bottom = '0px'
        BoxModel.CSSPadding.Right = '0px'
        BoxModel.CSSPadding.Left = '0px'
        BoxModel.CSSBorder.Top = '0px'
        BoxModel.CSSBorder.Bottom = '0px'
        BoxModel.CSSBorder.Right = '0px'
        BoxModel.CSSBorder.Left = '0px'
        BoxModel.CSSBorderRadius = '0px'
        DesignSize = (
          89
          45)
      end
      object btnUscita: TMedpUnimButton
        Left = 216
        Top = 16
        Width = 89
        Height = 45
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Constraints.MaxWidth = 350
        Anchors = []
        ClientEvents.ExtEvents.Strings = (
          
            'tap=function tap(sender, e, eOpts)'#13#10'{'#13#10'   inviaDataClient(WM015F' +
            'TimbraturaVirtualeFM.btnUscita, "btnUscitaClick");'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.WaitData = True
        ScreenMask.Message = 'Timbratura virtuale in corso...'
        UI = 'action'
        IconAlign = iaTop
        IconCls = 'arrow_left'
        Caption = 'Uscita'
        LayoutConfig.Height = '55'
        LayoutConfig.Width = '35%'
        OnAjaxEvent = btnTimbraturaAjaxEvent
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '15px'
        BoxModel.CSSMargin.Left = '0px'
        BoxModel.CSSPadding.Top = '0px'
        BoxModel.CSSPadding.Bottom = '0px'
        BoxModel.CSSPadding.Right = '0px'
        BoxModel.CSSPadding.Left = '0px'
        BoxModel.CSSBorder.Top = '0px'
        BoxModel.CSSBorder.Bottom = '0px'
        BoxModel.CSSBorder.Right = '0px'
        BoxModel.CSSBorder.Left = '0px'
        BoxModel.CSSBorderRadius = '0px'
        DesignSize = (
          89
          45)
      end
    end
    object lblTimbratureDiOggi: TMedpUnimLabel
      Left = 48
      Top = 272
      Width = 232
      Height = 32
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 8
      Caption = 'Timbrature di oggi'
      LayoutConfig.Height = 'auto'
      LayoutConfig.Width = '98%'
      ParentFont = False
      Font.Style = [fsBold]
      JustifyContent = JustifyStart
      BoxModel.CSSMargin.Top = '0px'
      BoxModel.CSSMargin.Bottom = '4px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '0px'
      BoxModel.CSSPadding.Bottom = '0px'
      BoxModel.CSSPadding.Right = '0px'
      BoxModel.CSSPadding.Left = '0px'
      BoxModel.CSSBorder.Top = '0px'
      BoxModel.CSSBorder.Bottom = '0px'
      BoxModel.CSSBorder.Right = '0px'
      BoxModel.CSSBorder.Left = '0px'
      BoxModel.CSSBorderRadius = '0px'
      DesignSize = (
        232
        32)
    end
    object pnlListaTimbrature: TMedpUnimPanelListaElem
      Left = 0
      Top = 304
      Width = 347
      Height = 283
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 9
      AutoScroll = True
      Anchors = []
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'start'
      LayoutConfig.Height = 'auto'
      LayoutConfig.Width = '98%'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '0px'
      BoxModel.CSSMargin.Bottom = '5px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '0px'
      BoxModel.CSSPadding.Bottom = '0px'
      BoxModel.CSSPadding.Right = '0px'
      BoxModel.CSSPadding.Left = '0px'
      BoxModel.CSSBorder.Top = '1px solid black'
      BoxModel.CSSBorder.Bottom = '0px'
      BoxModel.CSSBorder.Right = '0px'
      BoxModel.CSSBorder.Left = '0px'
      BoxModel.CSSBorderRadius = '0px'
      ColorPari = 16448250
      CSSBordoSeparatore = '1px solid #f0f0f0'
      DesignSize = (
        347
        283)
    end
  end
  object lblErrori: TUnimLabel
    Left = 0
    Top = 587
    Width = 347
    Height = 23
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    CreateOrder = 2
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
  object tmrAggiornaOrario: TUnimTimer
    Interval = 30000
    Enabled = False
    ClientEvent.Strings = (
      'function(sender) '
      '{'
      '}')
    OnTimer = tmrAggiornaOrarioTimer
    Left = 288
    Top = 8
  end
  object tmrAggiornaSecondi: TUnimTimer
    Enabled = False
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      
        '  updateSeconds(WM015FTimbraturaVirtualeFM.lblData, WM015FTimbra' +
        'turaVirtualeFM.lblOra);'
      '}')
    Left = 288
    Top = 56
  end
end

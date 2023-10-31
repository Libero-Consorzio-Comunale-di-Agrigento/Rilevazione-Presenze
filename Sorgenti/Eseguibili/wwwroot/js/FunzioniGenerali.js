String.prototype.padRight = function(lunghezza,carattere) {
  return this + Array(lunghezza - this.length + 1).join(carattere || " ");
}

$.fn.medpPopolaComboBox = function(listaOption, svuota, nomeLabel, nomeValue){
  svuota = (typeof svuota === 'undefined' || svuota === null ? true : false);
  nomeLabel = (nomeLabel ? nomeLabel : "label");
  nomeValue = (nomeValue ? nomeValue : "value");
  $(this).each(function(index, elemento){
    if (elemento.tagName.toLowerCase() === 'select'){
	  if (svuota)
	    $(elemento).empty();	  
	  $.each(listaOption, function(indexOption, elementoLista){
        $(elemento).append("<option value=\"" + elementoLista[nomeValue] + "\">" + elementoLista[nomeLabel] + "</option>");
      });	  
	}
  });
}

var numChiamateAJAXInCorso=0;

function IsAnnoBisestile(intYear) {
  if (intYear % 100 == 0) {
    if (intYear % 400 == 0) { 
      return true; 
    }
  }
  else {
    if ((intYear % 4) == 0) { 
      return true; 
    }
  }
  return false;
}

function trim(str) {
  //return str.replace(/^\s+|\s+$/g,"");
  // la replace sottostante considera anche gli spazi &nbsp;
  return str.replace(/(^[\s\xA0]+|[\s\xA0]+$)/g, '');
}

function checkKeyCode(objEvent) {
  var cod;
  if (window.event) {
    // IE
    cod = objEvent.keyCode;
  } else if(objEvent.which) {
    // Netscape/Firefox/Opera
    cod = objEvent.which;
  }
  return cod;
}

//Opzioni calendario jQuery
/*
  defaultDate:     ["+nn"]
                   ["-nn"]
                   ["+2"]

  minDate:         ["+nn"]
                   ["-nn"]
                   ["+5"]

  showOtherMonths: [true]
                   [false]

  showAnim:   ["fadeIn"]
              [""]

  dateFormat: 
    Formato della data
    Valori ammessi:  ["dd/mm/yy"] 
                     ["mm/yy"] 

  constrainInput
    Obbliga l'utente a digitare la data nel formato definito in "dateFormat"
    Valori ammessi:  [true]
                     [false]

  changeMonth
    Consente aggiunta di combobox per selezione mese
    Valori ammessi:  [true]
                     [false]

  changeYear
    Consente aggiunta di combobox per selezione anno
    Valori ammessi:  [true]
                     [false]
*/

var pickerOpts = {
  showOtherMonths: true,
  showAnim: "",
  changeMonth: false,
  changeYear: false,
  showButtonPanel: false
};

var pickerOptsMese = {
  showOtherMonths: false,
  dateFormat: "mm/yy",
  showAnim: "",
  changeMonth: false,
  changeYear: false
};

function getDate(element) {
  var date;

  try {
    date = $(element).datepicker("getDate");
    date.setMinutes(date.getMinutes() - date.getTimezoneOffset());
  } catch (error) {
    date = null;
  }
  
  return date;
}

function gestioneErrori(msg,url,lineNum) { 
  // gestione generica del messaggio: visualizzazione di un alert
  var msgErr = "Attenzione: si e verificato un errore nella pagina.\r\n\r\n";

  // stringa di errore nel formato:
  //   [testo_errore | nome_funzione | checkpoint numerico ]
  // oppure semplicemente
  //   [testo_errore]
  var errArr = msg.split("|");
  if (errArr.length != 3) {
    // errore normale
    var msgL = msg.toLowerCase();

    // array associativo per gestione errori noti
    // sintassi
    //   "messaggio" : "livello_eccezione"
    // valori
    //   messaggio         = parte del testo del messaggio da considerare (in minuscolo!)
    //   livello_eccezione = 0: silenziosa
    //                       1: messaggio di alert
    var arrMsg = { 
      "iwrelease is not a function" : "0",                          // IW: causa sconosciuta
      "impossibile spostare lo stato attivo sul controllo" : "0",   // IE: se ActiveControl è nascosto / inesistente dà errore
      "ieeventhandlers[...].length" : "0",                          // IE: causa sconosciuta (commistione script jquery - calendario forse)
      "metodo non supportato": "1"                                  // IE: causa sconosciuta
      //"'elements' è nullo o non è un oggetto": "0"                  //
    }

    // ciclo su messaggi dell'array per gestione specifica
    for (var key in arrMsg) {
      if (msgL.indexOf(key) >= 0) {
        var azione = arrMsg[key];
        if (azione == "0") {
          // errore silenzioso
          return true;
        }
        else if (azione == "1") {
          // messaggio di alert
          msgErr += "Errore: " + msg + "\r\n";
          alert(msgErr);
          return true;
        }
      }
    }

    // rilancia l'eccezione
    throw msg;
  }
  else {
    // errore generato con sintassi specifica
    msgErr += "Funzione: " + errArr[1] + "\r\n";
    msgErr += "Errore: " + errArr[0] + "\r\n";
    msgErr += "Posizione: " + errArr[2] + "\r\n";
    //msgErr += "URL: " + url + "\r\n";
    //msgErr += "Linea: " + lineNum + "\r\n";
  }

  // alert del messaggio
  msgErr += "\r\nFare click su OK per continuare.\r\n";
  alert(msgErr);

  // richiama funzione delphi per salvare messaggio su db
  // non utilizzato per bug intraweb (access violation con combinazioni di componenti)
  try {
    executeAjaxEvent("&err=" + msg,null,"OnJsErroreJs",false,null,false);
  }
  catch(err) {
  }
  return true;
}

function logConsole(msg,startTime) {
  try {
    msg = ("[  js  ] " + msg).padRight(60," ") + ": ";
    var endTime = new Date().getTime();

    var d = (endTime - startTime);
    var z = (d % 1000);
    var s = Math.trunc(d / 1000) - z;
    if (s < 0)  { s = 0; }
    if (s < 10) { s = "0" + s; }
    if (z < 10) { z = "00" + z; }
    else if (z < 100) { z = "0" + z;}
    var timeMsg = (s + "." + z + " s");
    console.log(msg + timeMsg); 
  }
  catch(errore) {
  }
}

function preloadImgFisse() {
  if (document.images) {
    // oggetto immagine
    var imageObj = new Image();

    // imposta array di immagini da precaricare
    var images = new Array();
    var i = 0;
    images[i++]="img/logo_irisweb.png";
    images[i++]="img/chiudi.png";
    images[i++]="img/chiudi_sel.png";
    images[i++]="img/error.png";
    images[i++]="img/information.png";
    images[i++]="img/warning.png";
    images[i++]="img/btnPrimo.png";
    images[i++]="img/btnPrimo_Disabled.png";
    images[i++]="img/btnPrecedente.png";
    images[i++]="img/btnPrecedente_Disabled.png";
    images[i++]="img/btnSuccessivo.png";
    images[i++]="img/btnSuccessivo_Disabled.png";
    images[i++]="img/btnUltimo.png";
    images[i++]="img/btnUltimo_Disabled.png";
    images[i++]="img/btnInserisci2.png";
    images[i++]="img/btnModifica2.png";
    images[i++]="img/btnElimina2.png";
    images[i++]="img/btnConferma2.png";
    images[i++]="img/btnAnnulla2.png";
    images[i++]="img/btnStampa22.png";
    images[i++]="img/btnDefinisci2.png";
    images[i++]="img/btnRevoca2.png";
    images[i++]="img/btnCancPeriodo.png";
    images[i++]="img/btnAggiorna2.png";
    images[i++]="img/btnSchedaAnagrafica2.png";
    images[i++]="img/btnCambiaDatoGriglia.png";
    images[i++]="img/btnCopia2.png";
    images[i++]="img/btnConteggi2.png";
    images[i++]="img/btnElenco2.png";
    images[i++]="img/btnElenco2Highlight.png";
    images[i++]="img/btnAttachment2.png";
    images[i++]="img/btnAttachment2Highlight.png";
    images[i++]="img/btnAttachment2Obblig.png";
    images[i++]="img/btnAccedi2.png";
    images[i++]="img/btnC700SelezioneAnagrafe2.png";
    images[i++]="img/mail-icon.png";
    images[i++]="img/mail-icon-ok.png";
    // selezione anagrafica
    images[i++]="img/btnApri.png";
    images[i++]="img/btnSalva.png";
    images[i++]="img/btnElimina.png";
    images[i++]="img/btnEseguiSelezione.png";
    images[i++]="img/btnAnnota.png";
    images[i++]="img/btnElimina.png";
    images[i++]="img/btnAnnullaSelezione.png";
    // icone file
    images[i++]="img/ico_oth.png";
    images[i++]="img/ico_avi.png";
    images[i++]="img/ico_bmp.png";
    images[i++]="img/ico_doc.png";
    images[i++]="img/ico_gif.png";
    images[i++]="img/ico_html.png";
    images[i++]="img/ico_jpg.png";
    images[i++]="img/ico_pdf.png";
    images[i++]="img/ico_ppt.png";
    images[i++]="img/ico_txt.png";
    images[i++]="img/ico_xls.png";
    images[i++]="img/ico_zip.png";
    // icone treeview
    images[i++]="img/folder_closed.png";
    images[i++]="img/folder_open.png";

    // preloading
    for (i = 0; i < images.length; i++) {
      imageObj.src = images[i];
    }
  }
}

// precarica le immagini legate a iriscloud presenti in (quasi) tutte le form
function preloadImgFisse_IrisCloud() {
  if (document.images) {
    // oggetto immagine
    var imageObj = new Image();

    // imposta array di immagini da precaricare
    var images = new Array();
    var i = 0;
    // C700
    images[i++]="img/logo_iriscloud.png";
    images[i++]="img/btnC700SelezioneAnagrafe.png";
    images[i++]="img/btnC700SelezioneAnagrafe_Disabled.png";
    images[i++]="img/btnC700Aggiorna.png";
    images[i++]="img/btnC700Aggiorna_Disabled.png";
    images[i++]="img/btnC700Cerca.png";
    images[i++]="img/btnC700Cerca_Disabled.png";
    images[i++]="img/btnC700Primo.png";
    images[i++]="img/btnC700Primo_Disabled.png";
    images[i++]="img/btnC700Precedente.png";
    images[i++]="img/btnC700Precedente_Disabled.png";
    images[i++]="img/btnC700Successivo.png";
    images[i++]="img/btnC700Successivo_Disabled.png";
    images[i++]="img/btnC700Ultimo.png";
    images[i++]="img/btnC700Ultimo_Disabled.png";

    // preloading
    for (i = 0; i < images.length; i++) {
      imageObj.src = images[i];
    }
  }
}

function preloadImgVar(images) {
  if (document.images) {
    var i = 0;
    var imageArray = new Array();
    imageArray = images.split(',');
    var imageObj = new Image();
    for (i = 0; i <= imageArray.length - 1; i++) {
      imageObj.src = imageArray[i];
    }
  }
}

function onscrollWR010() {
//registra lo scroll attuale della pagina nei campi previsti per questa gestione
  var scrolltop = document.getElementById("HIDDEN_WR010SCROLLTOP");
  var scrollleft = document.getElementById("HIDDEN_WR010SCROLLLEFT");
  scrollleft.value = window.pageXOffset;
  scrolltop.value = window.pageYOffset;
}

function onscrollDivWR010(div,namescrolltop,namescrollleft) {
//registra lo scroll attuale del div nei campi indicati dal chiamante
  var scrolltop = document.getElementById(namescrolltop);
  var scrollleft = document.getElementById(namescrollleft);
  scrolltop.value = div.scrollTop;
  scrollleft.value = div.scrollLeft;
}

function mostraDialogErrore(messaggioErrore, dettagliErrore, onCloseCallback, rispostaRemota){
  $("#txtAppError").html(messaggioErrore);
  $("#lblAppErrorDetails").html("Dettagli errore");
  $("#txtAppErrorDetails").text("");  
  
  var pulsantiDialog = [];  
  if (dettagliErrore){
	$("#txtAppErrorDetails").text(dettagliErrore);
	pulsantiDialog.push({
      id: "btn-dettagli",
      text: "Dettagli",
      "class": "pulsante", // per bug di YUI Compressor
      click: function() {
        $("#bugReport").toggle();
      }
    });   
  }  
  pulsantiDialog.push({
	text: "OK",
	"class": "pulsante", // per bug di YUI Compressor
	click: function() {
	  $(this).dialog("close");
	  $("#txtAppError").html("");
	  $("#lblAppErrorDetails").html("");
	  $("#txtAppErrorDetails").html("");	  
	  if (onCloseCallback){
	    onCloseCallback(rispostaRemota);
	  }
	}
  });

  $("#dlgAppError").dialog({
    modal: true,
    height: "auto",
	width: 400,
	closeOnEscape: false,
	open: function(event, ui) {                              
	  $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
	}, 
	buttons: pulsantiDialog
  });
    
}

/* ---------------------
    SUPPORTO AJAX  
   --------------------- */
   
function GestisciLockAJAX(){
  if (numChiamateAJAXInCorso > 0){
    $("#medpAJAXLock").show();
  }
  else{
	$("#medpAJAXLock").hide();
  }
}

function eseguiChiamataAJAX(idProcDelphiJS, parametri, fnCallback, bloccaInterfaccia){  
  if (!idProcDelphiJS){
    alert("eseguiChiamataAjax(): idProcDelphiJS non definita!");
	return;
  } 
  var edtAJAXFormID = FindElem("EDTAJAXFORMID");
  if (!edtAJAXFormID){
    alert("eseguiChiamataAjax(): Errore critico, campo ID univoco metodi AJAX del form non trovato!");
	return;
  }
  var parametriCh={};
  if (parametri){
    parametriCh=parametri;
  }	  
  if (!fnCallback){
    fnCallback='';	  
  }  
  if (typeof fnCallback != "string"){
	alert("Il nome della funzione di callback specificato non è una stringa!");
	return;
  }
  if (bloccaInterfaccia === null || bloccaInterfaccia === undefined)
    bloccaInterfaccia=true;

  var idMetodiAJAX = $(edtAJAXFormID).val();
  idProcDelphiJS = idMetodiAJAX + idProcDelphiJS;
  var idMemoParametriChiamata = idProcDelphiJS.toUpperCase();
  var parametriChiamataJSON=JSON.stringify(parametriCh);
  var memoParametriJS = FindElem(idMemoParametriChiamata);
  if (!memoParametriJS){
    alert("eseguiChiamataAjax(): impossibile trovare la textarea con id \"" + idMemoParametriChiamata + "\" !"); 
	return;
  }
  $(memoParametriJS).val(parametriChiamataJSON); 
  
  if (bloccaInterfaccia){	
	numChiamateAJAXInCorso++;
	GestisciLockAJAX();
  }
  
  // Effettuo una chiamata via POST come se la aspetta il server Intraweb
  $.ajax({
    url: GURLBase + "/callback?callback=" + idProcDelphiJS  +"&medpCallbackJS=" + fnCallback, 
	type: "POST",
	contentType: "application/x-www-form-urlencoded",	
	data: $(memoParametriJS).serialize(),
	success: function(data, textStatus, jqXHR){
	  if ((data) && (data.indexOf("/* PLACEHOLDER SESSIONE VALIDA */") > 0)){
		// La sessione non è scaduta
  	    var d = loadAjaxResponse(data); // Elaboro la risposta di Intraweb che comprende il mio callback
		processAjaxResponse(d); 
	  }
	  else{
  		mostraDialogErrore("La sessione &egrave; scaduta.<br>Effettuare nuovamente il login per continuare.",null,null,null);  
	  }
	},
	error: function(jqXHR,textStatus,errorThrown){
	  if (errorThrown == ""){
        errorThrown = "Nessuna risposta o risposta non valida da parte del server!";	
	  }	  
	  mostraDialogErrore(errorThrown,null,null,null);	  
	},
	complete: function(jqXHR, textStatus ){
	  if (bloccaInterfaccia){	    
	    numChiamateAJAXInCorso--;
        GestisciLockAJAX();		
	  }
	}
  });   
  
  $(memoParametriJS).val("");
}

function eseguiCallbackChiamataAJAX(rispostaRemota, funzCallbackUtente){	
  // Controllo della risposta remota
  if (!rispostaRemota){
    mostraDialogErrore("Il server ha restituito una risposta vuota!",null,null,null);	
	return;
  }
  
  if (!rispostaRemota.esito){
	mostraDialogErrore("Il server ha restituito una risposta non valida!",null,null,null);  	
	return;
  }
  
  if (rispostaRemota.esito === "success" || rispostaRemota.esito === "warning"){
    if (funzCallbackUtente){
	  funzCallbackUtente(rispostaRemota); 
	}
  }
  else if (rispostaRemota.esito === "fail"){
	var messaggioErrore = "Si è verificato un errore durante l'elaborazione della richiesta.";
	var dettagliErrore = null;
	if (rispostaRemota.errori && rispostaRemota.errori.length > 0){
	  if (rispostaRemota.errori.length == 1){
	    messaggioErrore = rispostaRemota.errori[0];
	  }
	  else{
		messaggioErrore = "Si sono verificati i seguenti errori:";
		messaggioErrore += "<ul>";  
	    for(var i=0; i<rispostaRemota.errori.length; i++){
  		  messaggioErrore+="<li>" + rispostaRemota.errori[i] + "</li>";	  
	    }
		messaggioErrore+="</ul>";
	  }
	}
	if (rispostaRemota.infoDebug)
	  dettagliErrore=rispostaRemota.infoDebug;	
	mostraDialogErrore(messaggioErrore,dettagliErrore,funzCallbackUtente,rispostaRemota);	
  }    
}

function rispChiamataAJAXSuccess(rispostaRemota){
  if (rispostaRemota && rispostaRemota.esito){
    return (rispostaRemota.esito === "success");
  }	  
  else{
    mostraDialogErrore("Il server ha restituito una risposta non valida!",null,null,null);
	return null;
  }  
}

function rispChiamataAJAXWarning(rispostaRemota){
  if (rispostaRemota && rispostaRemota.esito){
    return (rispostaRemota.esito === "warning");
  }	  
  else{
    mostraDialogErrore("Il server ha restituito una risposta non valida!",null,null,null);
	return null;
  }  
}

function rispChiamataAJAXError(rispostaRemota){
  if (rispostaRemota && rispostaRemota.esito){
    return (rispostaRemota.esito === "fail");
  }	  
  else{
    mostraDialogErrore("Il server ha restituito una risposta non valida!",null,null,null);
	return null;
  }  
}

function medpunload(){	 	
	data = "GAppID="+GAppID;
	url = GURLBase+"MEDPendsession";
	if((navigator.userAgent.indexOf("MSIE") != -1 ) || (!!document.documentMode == true )){ //IF IE > 10    
		if(window.XMLHttpRequest){
		var xmlhttp = new XMLHttpRequest();
		}else{
		var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		};
		if(xmlhttp != null){
		xmlhttp.open("POST", url, false);
		xmlhttp.send(data);
		};		      
	}else{ //ALTRI BROWSER
		navigator.sendBeacon(url, data);
	}		
}

function ReCAPTCHA_OnCallBack(resp){
	eseguiChiamataAJAX("ReCAPTCHA_OnCallBack", {response: resp}, "", false);
}

function ReCAPTCHA_OnCallBackExpired(resp){
	eseguiChiamataAJAX("ReCAPTCHA_OnCallBackExpired", {}, "", false);
}
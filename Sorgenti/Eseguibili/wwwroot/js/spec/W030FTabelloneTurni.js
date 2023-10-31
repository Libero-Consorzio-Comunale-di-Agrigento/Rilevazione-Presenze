// $.fn.tooltip di JQuery Tools sovrascrive $.fn.tooltip di JQuery UI.
// Ridefiniamo il widget "medpjqueryuitooltip" che punta al widget Tooltip di JQueryUI.
$.widget.bridge('medpjqueryuitooltip', $.ui.tooltip);

var parametriTabellone = {
  jqGridRowNum: false, // numero di elementi per pagina, se false la paginazione è spenta
  NRIGHEBLOCCATE: null,
  NUM_COLONNE_FISSE: null,
  classiCelle: null,
  modificabilitaCelle: null,
  datiTooltip: null,
  registrazioneAbilitata: false,
  gestioneCambioSquadra: false,
  edtHdnRigaSelHTMLName: null,
  edtHdnColonnaSelHTMLName: null,
  edtHdnPaginaAttualeHTMLName: null,
  edtHdnScrollTopHTMLName: null,
  edtHdnScrollLeftHTMLName: null,
  btnHdnCopiaPianifHTMLName: null,
  btnHdnVisCompResAssHTMLName: null,
  btnHdnInsCancGiustifHTMLName: null,
  btnHdnPianifReperHTMLName: null,
  btnHdnVisProgresTurnHTMLName:null,
  btnHdnEsportaExcelHTMLName: null,
  chkVisRigaTurniHTMLName: null,
  chkVisTotTurniHTMLName:null,
  chkVisRiposiHTMLName:null,
  chkVisMatricolaHTMLName:null,
  solaLettura: false
};

var costantiTabellone = {
  templateTooltip:{
    inizio: "<table class=\"WA058-tooltip-table\">",
	blocco: "<tr><td><b>${nomeCampo}</b></td><td>${valoreCampo}</td></tr>",
	fine: "</table>"
  }
};

function richiediDatiTabelloneJQGrid(){
  if ($.fn.jqGrid != undefined)
    eseguiChiamataAJAX("GetDatiTabellaJQGrid", null, "popolaTabelloneJQGrid", true);
  else{
    // jqGrid non è stato caricato perchè la versione del browser è troppo vecchia
    $("#WA058_DivAvvisi").html("Questo browser &egrave; obsoleto e non supporta il tabellone turni.<br>Utilizzare un browser più recente o un browser diverso e riprovare.");
	$("#WA058_DivAvvisi").show();
  }
}

function initTooltipTabellone(){
  // Tooltip
  $("#tabellone_jqgrid").find("[medptooltip=true]").medpjqueryuitooltip({
	position: {
	  my: "left-50 top+20",
	  at: "right center",
	  collision: "flipfit"
	},
	show: false,
	hide: false,
    content: function(){	
      var idRiga=$(this).attr("idriga");
      var idcolonna=$(this).attr("idcolonna");
	  var templateTooltip=costantiTabellone.templateTooltip;
	  var tooltipHTML=templateTooltip.inizio;	  
      var datiCella=parametriTabellone.datiTooltip[idRiga][idcolonna];
      // Orario
	  tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Orario");
	  tooltipHTML=tooltipHTML.replace("${valoreCampo}",datiCella.Ora != "" ? datiCella.Ora : "(non assegnato)");
	  // Turno1
	  if ((trim(datiCella.T1) != '') && (trim(datiCella.T1) != 'M') && (trim(datiCella.T1) != 'A')){
		tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Num. fascia 1&ordm; turno");
		tooltipHTML=tooltipHTML.replace("${valoreCampo}", datiCella.T1 + datiCella.T1EU + datiCella.SiglaT1 + " " + datiCella.T1OraInizio + "-" + datiCella.T1OraFine);
	  }
	  // Turno2
	  if (trim(datiCella.T2) != ''){
		tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Num. fascia 2&ordm; turno");
		tooltipHTML=tooltipHTML.replace("${valoreCampo}", datiCella.T2 + datiCella.T2EU + datiCella.SiglaT2 + " " + datiCella.T2OraInizio + "-" + datiCella.T2OraFine);        
	  
	  }
	  // Area
	  if (trim(datiCella.Area) != ''){
		tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Area");
		tooltipHTML=tooltipHTML.replace("${valoreCampo}", "(" + datiCella.sArea + ") " + datiCella.dArea);        
	  }
	  if (datiCella.Antincendio){
	    tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Responsabile antincendio");
		tooltipHTML=tooltipHTML.replace("${valoreCampo}","<span class=\"ui-icon ui-icon-check\"></span>");
	  }
	  if (datiCella.Referente){
		tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Referente");
		tooltipHTML=tooltipHTML.replace("${valoreCampo}","<span class=\"ui-icon ui-icon-check\"></span>");
	  }
	  if (datiCella.RichiestoDaTurnista){
		tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Richiesto da turnista");
		tooltipHTML=tooltipHTML.replace("${valoreCampo}","<span class=\"ui-icon ui-icon-check\"></span>");
	  }
	  if (datiCella.Ass1 != ""){
	    tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Assenze a giornata");
		tooltipHTML=tooltipHTML.replace("${valoreCampo}",datiCella.Ass1 + " " + datiCella.Ass2);
	  }
	  if (datiCella.AssOre && datiCella.AssOre.length > 0){
	    tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Altre assenze");
		var testoAssOre="";
		$.each(datiCella.AssOre, function(indexInArray, value){
		  if (indexInArray > 0)
		    testoAssOre+="<br>";
		  testoAssOre+=value;
		});
		tooltipHTML=tooltipHTML.replace("${valoreCampo}",testoAssOre);
	  }
	  if (datiCella.TurnoRep1 != "") {
		tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Reperibile");
		var valoreRep=(datiCella.TurnoRep1Sigla !== "" ? datiCella.TurnoRep1Sigla : datiCella.TurnoRep1) + " " + datiCella.TurnoRep1OraInizio + "-" + datiCella.TurnoRep1OraFine;
		if (datiCella.TurnoRep2 != ""){
	      valoreRep+="<br>" + (datiCella.TurnoRep2Sigla !== "" ? datiCella.TurnoRep2Sigla : datiCella.TurnoRep2) + " " + datiCella.TurnoRep2OraInizio + "-" + datiCella.TurnoRep2OraFine;
		}
		if (datiCella.TurnoRep3 != ""){
	      valoreRep+="<br>" + (datiCella.TurnoRep3Sigla !== "" ? datiCella.TurnoRep3Sigla : datiCella.TurnoRep3) + " " + datiCella.TurnoRep3OraInizio + "-" + datiCella.TurnoRep3OraFine;
		}
		tooltipHTML=tooltipHTML.replace("${valoreCampo}",valoreRep);	  
	  }
      if (trim(datiCella.Note) != ""){
	    tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Note");
		tooltipHTML=tooltipHTML.replace("${valoreCampo}",datiCella.Note);	  
	  }
	  if (datiCella.Anomalie && datiCella.Anomalie.length > 0){
		var anomalieBody="";
		$.each(datiCella.Anomalie, function(indexInArray, value){
		  anomalieBody+="&#8226; " + value + "<br>";
		});		
	    tooltipHTML+=templateTooltip.blocco.replace("${nomeCampo}","Anomalie");				
		tooltipHTML=tooltipHTML.replace("${valoreCampo}",anomalieBody);	  
	  }
      
      tooltipHTML+=templateTooltip.fine;      
	  return tooltipHTML;
	},
    open: function(event, ui){
	  $(ui.tooltip).contextmenu(function(e){
	    return false;
	  });
	},
	close: function(event, ui){
	  $(ui.tooltip).off("contextmenu");
	}
  }); 	
}

function onGridCompleteHandler(){ 
  $("#tabellone_jqgrid").find("[medptooltip=true]").medpjqueryuitooltip("destroy");
  $(".cella_turno").destroyContextMenu();
  var paginaAttuale = $("#tabellone_jqgrid").jqGrid("getGridParam", "page");
  $("#" + parametriTabellone.edtHdnPaginaAttualeHTMLName).val(paginaAttuale.toString());  
  var idRighe=$("#tabellone_jqgrid").jqGrid("getDataIDs");
  var colModel=$("#tabellone_jqgrid").jqGrid("getGridParam","colModel");
  var idxColoreColonna = 0; // Pari: riga bianca. Dispari: riga colorata.  
  for(var i=0; i < idRighe.length; i++){
    if ((i > 0) && (parametriTabellone.datiTooltip[idRighe[i - 1]].OPER != parametriTabellone.datiTooltip[idRighe[i]].OPER))
	  idxColoreColonna++;
    var idRiga=idRighe[i];
	for(var j=0; j < colModel.length; j++){
	  if (j < parametriTabellone.NUM_COLONNE_FISSE)
	    $("#tabellone_jqgrid").jqGrid("setCell",idRiga,j,"",(idxColoreColonna % 2 == 1 ? "ui-state-active" : "ui-state-default")); // Righe alternate	  
	  else{
		if ((parametriTabellone.classiCelle[idRiga]) && (parametriTabellone.classiCelle[idRiga][colModel[j].name])) // Imposto la classe per il colore di sfondo
		  $("#tabellone_jqgrid").jqGrid("setCell",idRiga,j,"",parametriTabellone.classiCelle[idRiga][colModel[j].name]);
		else
		  $("#tabellone_jqgrid").jqGrid("setCell",idRiga,j,"","cella_sfondo_bianco");
	  
	    var idColonna="GG" + (j - parametriTabellone.NUM_COLONNE_FISSE).toString();
		$("#tabellone_jqgrid").jqGrid("setCell",idRiga,j,"","cella_turno", { 
			idriga: idRiga,
			idxriga: i + parametriTabellone.NRIGHEBLOCCATE,
			idcolonna: idColonna,
			idxcolonna: j
		});
		if ((trim($("#tabellone_jqgrid").jqGrid("getCell",idRiga,j)) != "") || (trim(parametriTabellone.datiTooltip[idRiga][idColonna].Note) != "") 
			|| (trim(parametriTabellone.datiTooltip[idRiga][idColonna].Ass1) != "") || (trim(parametriTabellone.datiTooltip[idRiga][idColonna].Ass2) != "") || 
			(parametriTabellone.datiTooltip[idRiga][idColonna].AssOre.length > 0)){ // Se la cella contiene qualcosa
		  $("#tabellone_jqgrid").jqGrid("setCell",idRiga,j,"","",{
		    medptooltip:true,
			title: "-"
		  });
		}
		
		if (parametriTabellone.modificabilitaCelle[idRiga][colModel[j].name]){
		  $("#tabellone_jqgrid").jqGrid("setCell",idRiga,j,"","cella_modificabile"); // Stile per mettere il cursore a manina
	    }
	  }	  	  
	}
  }  
  initTooltipTabellone();
  // Context menu
  $(".cella_turno").contextMenu({
      menu: "pmnMenuCella"	  
    },
	function(action, el, pos){	  
	  var idRiga=el.attr("idriga");
	  var idxRiga=parseInt(el.attr("idxriga"));
	  var idxColonna=parseInt(el.attr("idxcolonna"));
	  var idColonna=el.attr("idcolonna");
	  $("#" + parametriTabellone.edtHdnRigaSelHTMLName).val(idxRiga);
	  $("#" + parametriTabellone.edtHdnColonnaSelHTMLName).val(idxColonna);
	  if (action === "ModificaItem"){
		if (parametriTabellone.registrazioneAbilitata && (!parametriTabellone.gestioneCambioSquadra || parametriTabellone.modificabilitaCelle[idRiga][idColonna]))
  		  ondblClickRowHandler(idRiga, idxRiga, idxColonna, null);		
		else
		  mostraDialogErrore("Questo giorno non pu&ograve; essere modificato.");
	  }
	  else if (action === "CopiaPianItem"){
		if (!parametriTabellone.solaLettura)
	      SubmitClick(parametriTabellone.btnHdnCopiaPianifHTMLName, "", true)
	  }
	  else if (action === "VisCompResAssItem")
	    SubmitClick(parametriTabellone.btnHdnVisCompResAssHTMLName, "", true);
	  else if (action === "InsCancGiustItem")
		SubmitClick(parametriTabellone.btnHdnInsCancGiustifHTMLName, "", true);
	  else if (action === "PianifRepItem")
		SubmitClick(parametriTabellone.btnHdnPianifReperHTMLName, "", true);
	  else if (action === "ProgTurnazioneItem")
		SubmitClick(parametriTabellone.btnHdnVisProgresTurnHTMLName, "", true);
      else if (action === "EsportaInExcelItem"){
		SubmitClick(parametriTabellone.btnHdnEsportaExcelHTMLName, "", true);
		ShowBusy(false);
	  }
	}
  );   
}

function ondblClickRowHandler(rowId, iRow, iCol, e){  
  if (iCol < parametriTabellone.NUM_COLONNE_FISSE)
    return;  

  var nomeColonna=$("#tabellone_jqgrid").jqGrid("getGridParam","colModel")[iCol].name;
  if (parametriTabellone.registrazioneAbilitata && (!parametriTabellone.gestioneCambioSquadra || parametriTabellone.modificabilitaCelle[rowId][nomeColonna])){      
    var paginaAttuale = $("#tabellone_jqgrid").jqGrid("getGridParam", "page");
    var rowNum=iRow;
    if (parametriTabellone.jqGridRowNum && paginaAttuale > 1)
      rowNum = rowNum + parametriTabellone.jqGridRowNum *(paginaAttuale - 1);
    eseguiChiamataAJAX("GetDatiDialogModificaTurno",{
      rowNum: rowNum,
	  colIdx: iCol
    },"apriDialogDettTurni");
  }
}

function resetParametriTabellone(){
  parametriTabellone.registrazioneAbilitata=false;
  parametriTabellone.gestioneCambioSquadra=false;
  parametriTabellone.classiCelle=null;
  parametriTabellone.modificabilitaCelle=null;
  parametriTabellone.datiTooltip=null; 
}

function setOffsetScrollTabellone(offset){
  $("#" + parametriTabellone.edtHdnScrollTopHTMLName).val((offset.scrollTop != undefined && !isNaN(offset.scrollTop)) ? offset.scrollTop.toString() : "0" ); 
  $("#" + parametriTabellone.edtHdnScrollLeftHTMLName).val((offset.scrollLeft != undefined && !isNaN(offset.scrollLeft)) ? offset.scrollLeft.toString() : "0" ); 
}

function getOffsetScrollTabellone(){
  var scrollInfo={};
  try{
    scrollInfo.scrollTop=parseInt($("#" + parametriTabellone.edtHdnScrollTopHTMLName).val());
	scrollInfo.scrollLeft=parseInt($("#" + parametriTabellone.edtHdnScrollLeftHTMLName).val());
  }
  catch(err){
    scrollInfo.scrollTop=0;
    scrollInfo.scrollLeft=0;
  }
  return scrollInfo;
}

function tabelloneScrollHandler(e){
  var divTabellone=$("#tabellone_jqgrid").closest(".ui-jqgrid-bdiv");
  setOffsetScrollTabellone({
    scrollTop: divTabellone.scrollTop(),
	scrollLeft: divTabellone.scrollLeft()
  });    
}

function onSelectRowHandler(rowId,bStatus,e){
  var rowNum=$("#tabellone_jqgrid").jqGrid("getInd", rowId);
  var pageNum=$("#tabellone_jqgrid").jqGrid("getGridParam", "page");
  if (pageNum > 1 && parametriTabellone.jqGridRowNum){
    rowNum=rowNum + parametriTabellone.jqGridRowNum * (pageNum - 1);
  }
  eseguiChiamataAJAX("GetContatoriOperatore",{
   rowNum: rowNum	  
  }, "callbackGetContatoriOperatore"); 	 
}

function callbackGetContatoriOperatore(rispostaRemota){
  var visRigaTurni=$("#" + parametriTabellone.chkVisRigaTurniHTMLName + "_CHECKBOX").prop("checked");
  if (rispChiamataAJAXSuccess(rispostaRemota)){
	// Prima del destroyFrozenColumns() devo sempre mostrare il footer
	$("#jqgrid-div-container .ui-jqgrid-sdiv").show();
	$("#tabellone_jqgrid").jqGrid("destroyFrozenColumns");  
  	$("#tabellone_jqgrid").jqGrid("footerData","set",rispostaRemota.dati);	
	$("#tabellone_jqgrid").jqGrid("setFrozenColumns");  	
	if (!visRigaTurni) $("#jqgrid-div-container .ui-jqgrid-sdiv").hide(); 
	allineaScrollDivTabelle();	
  }
}

function popolaTabelloneJQGrid(rispostaRemota){     
  resetParametriTabellone();  
  if (rispChiamataAJAXSuccess(rispostaRemota)){
	 $("#WA058_DivAvvisi").hide();
     $("#WA058_BtnDatiOpzionali").show();
     $("#WA058_BtnRicercaAnomalie").show();
	 $("#WA058_SpanRicercaAnomalie").show();
	 $("#WA058_DivPulsantiRight").show();
	 parametriTabellone.classiCelle=rispostaRemota.dati.classiCelle;
	 parametriTabellone.numeroColonne=rispostaRemota.dati.colonne.length;
	 parametriTabellone.modificabilitaCelle=rispostaRemota.dati.modificabilitaCelle;
	 parametriTabellone.registrazioneAbilitata=rispostaRemota.dati.registrazioneAbilitata;
	 parametriTabellone.gestioneCambioSquadra=rispostaRemota.dati.gestioneCambioSquadra;
	  // Dati per tooltip
	 parametriTabellone.datiTooltip=rispostaRemota.dati.datiTooltip;	 
	 // Istanzio jqgrid	 
     var divWidth=$("#jqgrid-div-container").width() - 15; 
	 var rowNum=rispostaRemota.dati.righe.length;
     if (parametriTabellone.jqGridRowNum)
	   rowNum=parametriTabellone.jqGridRowNum;     
	 $("#tabellone_jqgrid").jqGrid({
	   datatype: "local",
	   data: rispostaRemota.dati.righe,
	   colModel: rispostaRemota.dati.colonne,
	   cmTemplate: {
		  sortable: false		  
	   },
	   loadonce: true,
	   autoencode: false,
	   caption: rispostaRemota.dati.caption,	   
	   width: divWidth,
	   height: "440px",	   
	   shrinkToFit: false,
	   pager: "#tabellone_jqgrid_pager",
	   rowNum: rowNum,	   
	   hoverrows: false,
	   hidegrid: false,
	   responsive: true,
	   footerrow: true,
	   userData: rispostaRemota.dati.intestazione,
	   userDataOnFooter: true,	   
       ondblClickRow: ondblClickRowHandler,
	   onSelectRow: onSelectRowHandler
	 });	 
	 $("#tabellone_jqgrid").jqGrid("setFrozenColumns");	
	 var visRigaTurni=$("#" + parametriTabellone.chkVisRigaTurniHTMLName + "_CHECKBOX").prop("checked");
	 if (!visRigaTurni) $("#jqgrid-div-container .ui-jqgrid-sdiv").hide();
	 // Imposto il css degli header della tabella
	 $.each(rispostaRemota.dati.colonne, function(indexInArray, colonna){
	   if (colonna.medpClasseHeader && colonna.medpClasseHeader != ""){
	     $("#jqgh_tabellone_jqgrid_" + colonna.name).addClass(colonna.medpClasseHeader);
	   }
	 });
	 
	 // Reimposto lo stato precedente della grid, se possibile. 
	 var paginaInizialeStr=$("#" + parametriTabellone.edtHdnPaginaAttualeHTMLName).val();
	 var paginaIniziale=1;
	 try{ paginaIniziale=parseInt(paginaInizialeStr);} catch(err){ paginaIniziale=1; }
	 if (paginaIniziale > $("#tabellone_jqgrid").jqGrid("getGridParam","lastpage"))
	   paginaIniziale=1;
     $("#tabellone_jqgrid").jqGrid("setGridParam", {
		 page:paginaIniziale,
		 gridComplete: onGridCompleteHandler // da ora in avanti abilito l'handler sull'evento gridComplete
	 });
	 $("#tabellone_jqgrid").trigger("reloadGrid");	 
	 $("#tabellone_jqgrid").closest(".ui-jqgrid-bdiv").scrollTop(getOffsetScrollTabellone().scrollTop);
	 $("#tabellone_jqgrid").closest(".ui-jqgrid-bdiv").scrollLeft(getOffsetScrollTabellone().scrollLeft);
	 
     $("#tabellone_jqgrid").closest(".ui-jqgrid-bdiv").scroll(tabelloneScrollHandler);	 
	 $("#WA058_SpanBtnSalva").toggle(rispostaRemota.dati.registrazioneVisibile);
	 $("#WA058_SpanBtnCancella").toggle(rispostaRemota.dati.cancellazioneVisibile);	 
	 $("#WA058_SpanBtnOperativa").toggle(rispostaRemota.dati.rendiOperativaVisibile);
	 $("#WA058_SpanBtnBlocca").toggle(rispostaRemota.dati.bloccoVisibile);
	 $("#WA058_SpanBtnSblocca").toggle(rispostaRemota.dati.sbloccoVisibile);
  }
  else{
	$("#WA058_SpanBtnSalva").hide();
	$("#WA058_SpanBtnCancella").hide();
	$("#WA058_SpanBtnOperativa").hide();
	$("#WA058_SpanBtnBlocca").hide();
	$("#WA058_SpanBtnSblocca").hide();
    $("#WA058_BtnDatiOpzionali").hide();
    $("#WA058_BtnRicercaAnomalie").hide();	 	
	$("#WA058_SpanRicercaAnomalie").hide();
	$("#WA058_DivPulsantiRight").hide();
	if (rispChiamataAJAXWarning(rispostaRemota)){
	  $("#WA058_DivAvvisi").html(rispostaRemota.avvisi[0]);
	  $("#WA058_DivAvvisi").show();
	}
  }
}

function resetDialogDettTurni(){
  $("#WA058_DivDettTurno").find("select").empty();
  $("#WA058_DivDettTurno").find("input[type='hidden']").val("");
  $("#WA058_DivDettTurno_ChkAntincendio").prop("checked", false);
  $("#WA058_DivDettTurno_MemoNote").val("");
  $("#WA058_DivDettTurno_CmbOrario").off("change");  
  $("#WA058_DivDettTurno_Conferma").off("click");
  $("#WA058_DivDettTurno_Annulla").off("click");
  bloccaControlliDialogDettTurni(false);
}

function bloccaControlliDialogDettTurni(blocca){
  if (blocca){
    $("#WA058_DivDettTurno_CmbOrario").prop("disabled", true);
	$("#WA058_DivDettTurno_CmbAss1").prop("disabled", true);
    $("#WA058_DivDettTurno_CmbAss2").prop("disabled", true);
  }
  else{
    $("#WA058_DivDettTurno_CmbOrario").prop("disabled", !$("#WA058_DivDettTurno_CmbOrario").prop("medpComboAttiva"));
	$("#WA058_DivDettTurno_CmbAss1").prop("disabled", !$("#WA058_DivDettTurno_CmbAss1").prop("medpComboAttiva"));
	$("#WA058_DivDettTurno_CmbAss2").prop("disabled", !$("#WA058_DivDettTurno_CmbAss2").prop("medpComboAttiva"));
  }
  $("#WA058_DivDettTurno_CmbTurno1").prop("disabled", blocca);
  $("#WA058_DivDettTurno_CmbTurnoEU1").prop("disabled", blocca);
  $("#WA058_DivDettTurno_CmbTurno2").prop("disabled", blocca);
  $("#WA058_DivDettTurno_CmbTurnoEU2").prop("disabled", blocca);
  $("#WA058_DivDettTurno_CmbArea").prop("disabled", blocca);
  
  $("#WA058_DivDettTurno_Conferma").prop("disabled" ,blocca);
  $("#WA058_DivDettTurno_Annulla").prop("disabled", blocca);
}

function apriDialogDettTurni(rispostaRemota){
  resetDialogDettTurni();  
  if (rispChiamataAJAXSuccess(rispostaRemota)){	  
    $("#WA058_DivDettTurno_CmbOrario").medpPopolaComboBox(rispostaRemota.dati.cmbOrarioItems);
	$("#WA058_DivDettTurno_CmbOrario").val(rispostaRemota.dati.cmbOrarioSelectedItem);
	$("#WA058_DivDettTurno_CmbOrario").prop("medpComboAttiva", rispostaRemota.dati.cmbOrarioEnabled);
	$("#WA058_DivDettTurno_CmbOrario").prop("disabled",!$("#WA058_DivDettTurno_CmbOrario").prop("medpComboAttiva"));
	$("#WA058_DivDettTurno_CmbOrario").change(function(e){
	  var indDipendente=$("#WA058_DivDettTurno_IndDipendente").val();
  	  var indGiorno=$("#WA058_DivDettTurno_IndGiorno").val();
      var orarioSel=$("#WA058_DivDettTurno_CmbOrario").find("option:selected").text();
      eseguiChiamataAJAX("GetDatiTurno",{
        indDipendente: parseInt(indDipendente),
        indGiorno: parseInt(indGiorno),
        orarioSel: orarioSel			
      },"valorizzaComboTurnoDialog");
	});
	
	$("#WA058_DivDettTurno_CmbTurno1").medpPopolaComboBox(rispostaRemota.dati.cmbTurnoItems);
	$("#WA058_DivDettTurno_CmbTurno2").medpPopolaComboBox(rispostaRemota.dati.cmbTurnoItems);
	$("#WA058_DivDettTurno_CmbTurno1").val(rispostaRemota.dati.cmbTurno1SelectedItem);
	$("#WA058_DivDettTurno_CmbTurno2").val(rispostaRemota.dati.cmbTurno2SelectedItem);
	
	$("#WA058_DivDettTurno_CmbTurnoEU1").medpPopolaComboBox(rispostaRemota.dati.cmbTurnoEUItems);
	$("#WA058_DivDettTurno_CmbTurnoEU2").medpPopolaComboBox(rispostaRemota.dati.cmbTurnoEUItems);
	$("#WA058_DivDettTurno_CmbTurnoEU1").val(rispostaRemota.dati.cmbTurnoEU1SelectedItem);	
	$("#WA058_DivDettTurno_CmbTurnoEU2").val(rispostaRemota.dati.cmbTurnoEU2SelectedItem);
	
	$("#WA058_DivDettTurno_CmbAss1").medpPopolaComboBox(rispostaRemota.dati.cmbAssItems);	
	$("#WA058_DivDettTurno_CmbAss2").medpPopolaComboBox(rispostaRemota.dati.cmbAssItems);		
	$("#WA058_DivDettTurno_CmbAss1").val(rispostaRemota.dati.cmbAss1SelectedItem);	
	$("#WA058_DivDettTurno_CmbAss2").val(rispostaRemota.dati.cmbAss2SelectedItem);
	$("#WA058_DivDettTurno_CmbAss1").prop("medpComboAttiva", rispostaRemota.dati.cmbAss1Enabled);
	$("#WA058_DivDettTurno_CmbAss1").prop("disabled",!$("#WA058_DivDettTurno_CmbAss1").prop("medpComboAttiva"));
	$("#WA058_DivDettTurno_CmbAss2").prop("medpComboAttiva", rispostaRemota.dati.cmbAss2Enabled);
	$("#WA058_DivDettTurno_CmbAss2").prop("disabled",!$("#WA058_DivDettTurno_CmbAss2").prop("medpComboAttiva"));

  $("#WA058_DivDettTurno_CmbArea").medpPopolaComboBox(rispostaRemota.dati.cmbAreaItems);
	$("#WA058_DivDettTurno_CmbArea").val(rispostaRemota.dati.cmbAreaSelectedItem);
	$("#WA058_DivDettTurno_CmbArea").prop("medpComboAttiva", rispostaRemota.dati.cmbAreaEnabled);
	$("#WA058_DivDettTurno_CmbArea").prop("disabled",!$("#WA058_DivDettTurno_CmbArea").prop("medpComboAttiva"));
	
	$("#WA058_DivDettTurno_ChkAntincendio").prop("checked", rispostaRemota.dati.chkAntincendio);
	$("#WA058_DivDettTurno_ChkReferente").prop("checked", rispostaRemota.dati.chkReferente);
	$("#WA058_DivDettTurno_ChkRichiestoDaTurnista").prop("checked", rispostaRemota.dati.chkRichiestoDaTurnista);
	$("#WA058_DivDettTurno_MemoNote").val(rispostaRemota.dati.memoNote);
	
	$("#WA058_DivDettTurno_IndDipendente").val(rispostaRemota.dati.indDipendente.toString());
	$("#WA058_DivDettTurno_IndGiorno").val(rispostaRemota.dati.indGiorno.toString());
	
	$("#WA058_DivDettTurno_Conferma").click(function(e){	 
	  var parametriChiamataDett={
	    indDipendente: parseInt($("#WA058_DivDettTurno_IndDipendente").val()), 
		indGiorno: parseInt($("#WA058_DivDettTurno_IndGiorno").val()),
		cmbOrario: $("#WA058_DivDettTurno_CmbOrario").find("option:selected").text(),
		cmbTurno1: $("#WA058_DivDettTurno_CmbTurno1").find("option:selected").text(),
		cmbTurno2: $("#WA058_DivDettTurno_CmbTurno2").find("option:selected").text(),
		cmbTurnoEU1: $("#WA058_DivDettTurno_CmbTurnoEU1").find("option:selected").text(),
		cmbTurnoEU2: $("#WA058_DivDettTurno_CmbTurnoEU2").find("option:selected").text(),
		cmbAss1: $("#WA058_DivDettTurno_CmbAss1").find("option:selected").text(),
		cmbAss2: $("#WA058_DivDettTurno_CmbAss2").find("option:selected").text(),
		cmbArea: $("#WA058_DivDettTurno_CmbArea").find("option:selected").text(),
		chkAntincendio:  $("#WA058_DivDettTurno_ChkAntincendio").prop("checked"),
		chkReferente: $("#WA058_DivDettTurno_ChkReferente").prop("checked"),
		chkRichiestoDaTurnista: $("#WA058_DivDettTurno_ChkRichiestoDaTurnista").prop("checked"),
		memoNote: $("#WA058_DivDettTurno_MemoNote").val()
	  };
	  eseguiChiamataAJAX("confermaDatiTurno", parametriChiamataDett, "callbackConfermaTurno");
	  bloccaControlliDialogDettTurni(true);
	});
	$("#WA058_DivDettTurno_Annulla").click(function(e){
      resetDialogDettTurni();
      $("#WA058_DivDettTurno").dialog("close"); 	
	});
	$("#WA058_DivDettTurno").dialog({		
   	  width: 405,
      minHeight: 60,
	  modal: true,
	  hide: "fade",
	  title: rispostaRemota.dati.dialogCaptionTitolo,
	  closeOnEscape: false,
	  resizable: true,
      dialogClass: 'no-closeButton'
	});
  }
}

function valorizzaComboTurnoDialog(rispostaRemota){
  $("#WA058_DivDettTurno_CmbTurno1").empty();
  $("#WA058_DivDettTurno_CmbTurno2").empty();
  if (rispChiamataAJAXSuccess(rispostaRemota)){
    $("#WA058_DivDettTurno_CmbTurno1").medpPopolaComboBox(rispostaRemota.dati);
    $("#WA058_DivDettTurno_CmbTurno2").medpPopolaComboBox(rispostaRemota.dati);
  }
}

function callbackConfermaTurno(rispostaRemota){
  if (rispChiamataAJAXSuccess(rispostaRemota)){
    resetDialogDettTurni();
    $("#WA058_DivDettTurno").dialog("close"); 		
	// Ripulisco l'attributo class di tutti i td presenti nel DOM in questo momento (pagina attiva)
	var idRighePaginaAttuale=$("#tabellone_jqgrid").jqGrid("getDataIDs");
	$.each(idRighePaginaAttuale, function(idx, matricola){
	  var riga=$("#tabellone_jqgrid").find("tr#" + matricola); // tr
	  for(var i=parametriTabellone.NUM_COLONNE_FISSE; i < riga.children().length; i++){
	    var cella=$(riga.children()[i]); // td
	    var nuoveClassi="cella_turno";
	    if (cella.hasClass("bordo_festivo"))
	     nuoveClassi="sfondo_festivo bordo_festivo cella_turno";
	    cella.prop("class",nuoveClassi);
	    cella.removeAttr("medptooltip");
	    cella.removeAttr("title");
	  }		
	});
	$("#jqgrid-div-container .ui-jqgrid-sdiv").show(); // Prima del destroyFrozenColumns() devo sempre mostrare il footer
	$("#tabellone_jqgrid").jqGrid("destroyFrozenColumns");		
	// Imposto i nuovi dati 
	$("#tabellone_jqgrid").jqGrid("setGridParam", {data: rispostaRemota.dati.righe});
	parametriTabellone.datiTooltip=rispostaRemota.dati.datiTooltip;	
	parametriTabellone.classiCelle=rispostaRemota.dati.classiCelle;
	parametriTabellone.modificabilitaCelle=rispostaRemota.dati.modificabilitaCelle;
	$("#tabellone_jqgrid").trigger("reloadGrid"); 
	//Aggiorniamo la riga di intestazione, se presente
	if (rispostaRemota.dati.intestazione)
	  $("#tabellone_jqgrid").jqGrid("footerData","set",rispostaRemota.dati.intestazione);
	$("#tabellone_jqgrid").jqGrid("setFrozenColumns");
	allineaScrollDivTabelle();
	var visRigaTurni=$("#" + parametriTabellone.chkVisRigaTurniHTMLName + "_CHECKBOX").prop("checked");
	if (!visRigaTurni) $("#jqgrid-div-container .ui-jqgrid-sdiv").hide();
    $("#WA058_SpanBtnSalva").toggle(rispostaRemota.dati.registrazioneVisibile);
  }
  else if (rispChiamataAJAXError(rispostaRemota)){
    bloccaControlliDialogDettTurni(false);
  }
}

function modificaVisDatiOpzionali(){
	var visRigaTurni=$("#" + parametriTabellone.chkVisRigaTurniHTMLName + "_CHECKBOX").prop("checked"),
	    visTotTurni=$("#" + parametriTabellone.chkVisTotTurniHTMLName + "_CHECKBOX").prop("checked"),        
        visRiposi=$("#" + parametriTabellone.chkVisRiposiHTMLName + "_CHECKBOX").prop("checked"),
        visMatricola=$("#" + parametriTabellone.chkVisMatricolaHTMLName + "_CHECKBOX").prop("checked")
	var colonneVisibili = [];
	var colonneNascoste = [];	
	visTotTurni ? colonneVisibili.push("TOTTURNIDIP") : colonneNascoste.push("TOTTURNIDIP");	
	visRiposi ? colonneVisibili.push("RIP_FES_TLAV") : colonneNascoste.push("RIP_FES_TLAV");
	visMatricola ? colonneVisibili.push("MATRICOLA") : colonneNascoste.push("MATRICOLA");
	// Prima del destroyFrozenColumns() devo sempre mostrare il footer
	$("#jqgrid-div-container .ui-jqgrid-sdiv").show();
	$("#tabellone_jqgrid").jqGrid("destroyFrozenColumns");	
	$("#tabellone_jqgrid").jqGrid("showCol",colonneVisibili);
	$("#tabellone_jqgrid").jqGrid("hideCol",colonneNascoste);
	$("#tabellone_jqgrid").jqGrid("setFrozenColumns"); // ricreo div e tabelle frozen
	allineaScrollDivTabelle();
	if (!visRigaTurni) $("#jqgrid-div-container .ui-jqgrid-sdiv").hide();
}

function distruggiERicaricaTabellone(){  
  $("#tabellone_jqgrid").find("[medptooltip=true]").medpjqueryuitooltip("destroy"); // Distruzione e unbind tooltip
  $(".cella_turno").destroyContextMenu(); // Distruzione e unbind context menu
  $("#tabellone_jqgrid").closest(".ui-jqgrid-bdiv").off("scroll"); // unbind gestore scroll
  $("#jqgrid-div-container .ui-jqgrid-sdiv").show(); // Prima del destroyFrozenColumns() devo sempre mostrare il footer
  $("#tabellone_jqgrid").jqGrid("destroyFrozenColumns"); // Distruggo table e div frozen  
  $("#tabellone_jqgrid").jqGrid("setGridParam", { // Unbind degli eventi jqGrid
    gridComplete: null,
    ondblClickRow: null,
	onSelectRow: null
  });
  $("#tabellone_jqgrid").jqGrid("clearGridData",true); // Svuoto i dati
  $.jgrid.gridUnload("#tabellone_jqgrid"); // Distruzione jqGrid
  resetParametriTabellone();
  richiediDatiTabelloneJQGrid();
}

function allineaScrollDivTabelle(){
  // Allinea lo scroll dei div che contengono la tabella vera e propria e quella con le colonne frozen
  $(".frozen-bdiv.ui-jqgrid-bdiv").scrollTop($(".ui-jqgrid-bdiv").scrollTop());
}

function apriDialogLegenda(){
  $("#WA058_DivLegenda").dialog({
    modal: true,
	width: "650px",
	resizable: false
  });
}
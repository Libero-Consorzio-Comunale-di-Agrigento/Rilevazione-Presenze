// $.fn.tooltip di JQuery Tools sovrascrive $.fn.tooltip di JQuery UI.
// Ridefiniamo il widget "medpjqueryuitooltip" che punta al widget Tooltip di JQueryUI.
$.widget.bridge('medpjqueryuitooltip', $.ui.tooltip);

var parametriTabella = {
	jqGridRowNum: false,
	classiCelle: null,
	datiTooltip: null,
	mappaPaginaDatiRaggr: null,
	btnHdnEsportaExcelHTMLName: null
};

function getDatiTabellaProspetto(){
	if ($.fn.jqGrid != undefined)
		eseguiChiamataAJAX("GetDatiTabellaProspetto", null, "attivaProspettoJqGrid", true);
	else{
		// jqGrid non è stato caricato perchè la versione del browser è troppo vecchia
		$("#W033_DivWarning").html("<p>Questo browser &egrave; obsoleto e non supporta questa funzionalit&agrave.<br>Utilizzare un browser pi&ugrave; recente per accedere al prospetto assenze.</p>" + 
		                           "<p>This browser is outdated and it does not support this feature.<br>Please try using an updated browser.</p>");
		$("#W033_DivWarning").show();
	}
}

function attivaProspettoJqGrid(rispostaRemota){
	if (rispChiamataAJAXWarning(rispostaRemota)){
		$("#W033_DivContent").hide();
		$("#W033_DivWarning").html(rispostaRemota.avvisi[0]);
		$("#W033_DivWarning").show();
	}
	else if (rispChiamataAJAXSuccess(rispostaRemota)){
		$("#W033_DivContent").show();
		$("#W033_DivWarning").hide();
		var rowNum=rispostaRemota.dati.righe.length;
		if (parametriTabella.jqGridRowNum)
			rowNum=parametriTabella.jqGridRowNum;
		parametriTabella.classiCelle=rispostaRemota.dati.classiCelle;
		parametriTabella.datiTooltip=rispostaRemota.dati.datiTooltip;
		if (rispostaRemota.dati.mappaPaginaDatiRaggr){
			parametriTabella.mappaPaginaDatiRaggr=rispostaRemota.dati.mappaPaginaDatiRaggr;
			$("#W033_jqgrid-div-raggr-corrente").show();
		}
		var divWidth=$("#W033_jqgrid-div-container").width() - 15;
		$("#tabella_jqgrid").jqGrid({
		   datatype: "local",
		   data: rispostaRemota.dati.righe,
		   colModel: rispostaRemota.dati.colonne,
		   cmTemplate: {
			  sortable: false		  
		   },
		   loadonce: true,
		   autoencode: false,
		   caption: rispostaRemota.dati.caption,		      		   
		   height: "440px",
		   width: divWidth,
		   shrinkToFit: false,
		   pager: "#tabella_jqgrid_pager",
		   rowNum: rowNum,	   
		   hoverrows: false,
		   hidegrid: false,
		   responsive: true
		});	
		$("#tabella_jqgrid").jqGrid("setFrozenColumns");
		// Imposto il css degli header della tabella
		$.each(rispostaRemota.dati.colonne, function(indexInArray, colonna){
			if (colonna.medpClasseHeader && colonna.medpClasseHeader != "")
				$("#jqgh_tabella_jqgrid_" + colonna.name).addClass(colonna.medpClasseHeader);
		});
		var paginaInizialeStr=$(FindElem("EDTHDNPAGINAATTUALE")).val();
		var paginaIniziale=1;
		try{ paginaIniziale=parseInt(paginaInizialeStr);} catch(err){ paginaIniziale=1; }
		if (paginaIniziale > $("#tabella_jqgrid").jqGrid("getGridParam","lastpage"))
			paginaIniziale=1;
		$("#tabella_jqgrid").jqGrid("setGridParam", {
			page:paginaIniziale,
			gridComplete: onGridCompleteHandler // da ora in avanti abilito l'handler sull'evento gridComplete
		});
		$("#tabella_jqgrid").trigger("reloadGrid");	 
		$("#tabella_jqgrid").closest(".ui-jqgrid-bdiv").scrollTop(getOffsetScrollTabella().scrollTop);
		$("#tabella_jqgrid").closest(".ui-jqgrid-bdiv").scrollLeft(getOffsetScrollTabella().scrollLeft);
		$("#tabella_jqgrid").closest(".ui-jqgrid-bdiv").scroll(tabellaScrollHandler);			
	}
}

function onGridCompleteHandler(){     
	$("#tabella_jqgrid").find("[medptooltip=true]").medpjqueryuitooltip("destroy"); // Distruzione e unbind tooltip
	// Salvo il numero di pagina attuale
	var paginaAttuale = $("#tabella_jqgrid").jqGrid("getGridParam", "page");
	$(FindElem("EDTHDNPAGINAATTUALE")).val(paginaAttuale.toString());
	// Imposto le classi opzionali per lo sfondo alle celle e l'eventuale title per il tooltip
	var idRighe=$("#tabella_jqgrid").jqGrid("getDataIDs");
	var colModel=$("#tabella_jqgrid").jqGrid("getGridParam","colModel");
	for(var i=0; i < idRighe.length; i++){
		var idRiga=idRighe[i];
		for(var j=0; j < colModel.length; j++){	
			var nomeColonna = colModel[j].name;			
			if (parametriTabella.classiCelle[idRiga] && parametriTabella.classiCelle[idRiga][nomeColonna])
				$("#tabella_jqgrid").jqGrid("setCell",idRiga,nomeColonna,"",parametriTabella.classiCelle[idRiga][nomeColonna]);
			else if (nomeColonna != 'NOMINATIVO')
				$("#tabella_jqgrid").jqGrid("setCell",idRiga,nomeColonna,"","W033_cella_sfondo_bianco");
			if (parametriTabella.datiTooltip[idRiga] && parametriTabella.datiTooltip[idRiga][nomeColonna])
				$("#tabella_jqgrid").jqGrid("setCell",idRiga,nomeColonna,"","",{
					title: parametriTabella.datiTooltip[idRiga][nomeColonna],
                    medptooltip: true					
				});
		}
	}
	$("#tabella_jqgrid").find("[medptooltip=true]").medpjqueryuitooltip({
		position: {
		  my: "left-50 top+20",
		  at: "right center",
		  collision: "flipfit"
		},
		show: false,
		hide: false,
		content: function(){
			return $(this).attr("title"); // Necessario per evitare escape
		}
	});
	if (parametriTabella.mappaPaginaDatiRaggr)
		$("#W033_jqgrid-div-raggr-corrente").html(parametriTabella.mappaPaginaDatiRaggr["_" + paginaAttuale]);
  
	$(".W033_cella_sfondo_bianco").contextMenu({
			menu: "pmnMenuCella"
	},	
	function(action, el, pos){
	  if (action === "EsportaInExcelItem"){
		SubmitClick(parametriTabella.btnHdnEsportaExcelHTMLName, "", true);
	  }
	}
  );	
	$(".bg_nonlavorativo").contextMenu({
			menu: "pmnMenuCella"
	},	
	function(action, el, pos){
	  if (action === "EsportaInExcelItem"){
		SubmitClick(parametriTabella.btnHdnEsportaExcelHTMLName, "", true);
	  }
	}
  );			
}

function setOffsetScrollTabella(offset){
	$(FindElem("EDTHDNSCROLLTOP")).val((offset.scrollTop != undefined && !isNaN(offset.scrollTop)) ? offset.scrollTop.toString() : "0" ); 
	$(FindElem("EDTHDNSCROLLLEFT")).val((offset.scrollLeft != undefined && !isNaN(offset.scrollLeft)) ? offset.scrollLeft.toString() : "0" ); 
}

function getOffsetScrollTabella(){
	var scrollInfo={};
	try{
		scrollInfo.scrollTop=parseInt($(FindElem("EDTHDNSCROLLTOP")).val());
		scrollInfo.scrollLeft=parseInt($(FindElem("EDTHDNSCROLLLEFT")).val());
	}
	catch(err){
		scrollInfo.scrollTop=0;
		scrollInfo.scrollLeft=0;
	}
	return scrollInfo;
}

function tabellaScrollHandler(e){
	var divTabella=$("#tabella_jqgrid").closest(".ui-jqgrid-bdiv");
	setOffsetScrollTabella({
		scrollTop: divTabella.scrollTop(),
		scrollLeft: divTabella.scrollLeft()
	});    
}

function causaleAut(idRich){
	$(FindElem("EDTHDNIDRICHIESTA")).val(idRich);
	SubmitClick("BTNHDNCAUSALEAUT","",true);
}
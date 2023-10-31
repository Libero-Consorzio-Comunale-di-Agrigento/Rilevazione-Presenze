/**
 * jqTooltip 
 */
try { 
  // generico
  posErr = ".tooltipHtml";
  $elem = jQuery.root.find(".tooltipHtml"); 
  if ($elem.length) { 
    $elem.tooltip({ 
      //relative: true,              // posizione relativa all'elemento parent (true dà problemi con i message dialog!!!)
      effect: "fade",                // effetto "fade"
      fadeOutSpeed: 100,             // dissolvenza (100 è simile al default del browser)
      predelay: 200,                 // ms prima della visualizzazione
      delay: 0                       // ritardo sul mouseout
    }).dynamic({                     // comportamento dinamico
      left: { direction: "left" }, 
      right: { direction: "right" } 
    });
  } 

  // icone accesso rapido
  posErr = ".icona_sez3";
  $elem = jQuery.root.find(".icona_sez3"); 
  if ($elem.length) {    
    $elem.tooltip({
	  tipClass: "tooltip_icone",
	  position: "bottom center",
	  offset: [10, 0],
      effect: "fade",
      fadeOutSpeed: 100,
      predelay: 50,
      delay: 0
	});    
  }
 
  // history
  posErr = ".tooltipHistory";
  $elem = jQuery.root.find(".tooltipHistory"); 
  if ($elem.length) { 
    $elem.tooltip({
      tipClass: "tooltip_history",
      position: "bottom center",
      offset: [15, 30],
      effect: "toggle",
      fadeOutSpeed: 0,
      predelay: 0,
      delay: 200
    });
  }
  
  // login
  posErr = "#login";
  $elem = jQuery.root.find("#login"); 
  if ($elem.length) { 
    $elem.tooltip({
      tip: "#loginTooltip",
      position: "bottom center",
      offset: [5, 0],
      effect: "fade",
      fadeOutSpeed: 500,
      predelay: 100,
      delay: 0
    });
  }
} 
catch (err) {
  gestioneErrori(err.message + "|" + "jqTooltip" + "|" + posErr,"",0);
}

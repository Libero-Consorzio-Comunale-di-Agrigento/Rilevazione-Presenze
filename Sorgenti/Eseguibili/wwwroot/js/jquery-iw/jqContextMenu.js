/**
 * jqContextMenu
 */ 
try {
  var comp = "%s";
  $elem = jQuery.root.find("#" + comp);
  posErr = "#" + comp;
  if ($elem.length) {
    $elem.contextMenu({
      menu: "%s"
    },
    function(action, el, pos) {
      // 1. versione con submit
      //SubmitClick("lnkContextMenu", action + "&" + $(el).attr("id"), true);
      // 2. versione async
      ShowBusy(true); // in caso di compiti lunghi visualizza la gif di attesa
      executeAjaxEvent("&azione=" + action + "&sender=" + $(el).attr("id"), null,"%s.OnContextMenuJs",false,null,false);
      return true;
    });
  }
}
catch(e) {
  gestioneErrori(err.message + "|" + "jqContextMenu[" + comp + "] |" + posErr, "", 0);
}

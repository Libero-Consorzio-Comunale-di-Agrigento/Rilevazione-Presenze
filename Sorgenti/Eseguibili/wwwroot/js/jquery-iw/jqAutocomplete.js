/**
 * jqAutocomplete
 */ 
try {
  posErr = 'select.combobox:not([disabled])'; 
  $elem = jQuery.root.find("select.combobox:not([disabled])"); 
  if ($elem.length) { 
    $elem.wrap("<div class=\"ui-widget\"><\/div>").combobox(); 
  } 
} 
catch (err) { 
  gestioneErrori(err.message + "|" + "jqAutocomplete" + "|" + posErr,"",0); 
}

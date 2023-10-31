/**
 * jqWatermark
 */
try {

  var comp = "%s";
  $elem = jQuery.root.find("#" + comp);
  posErr = comp;
  if ($elem.length) {
    $elem.Watermark("%s");
  }
}
catch(e) {
  gestioneErrori(err.message + "|" + "jqWatermark" + "|" + posErr, "", 0);
};

/**
 * jqGritter
 */ 
try {
  posErr = '$.gritter';
  $.gritter.add({
    title: "%s",
    text: "%s",
    image: "%s",
    sticky: %s,
    time: "%d",
    class_name: "%s"
  });
}
catch(e) {
  gestioneErrori(err.message + "|" + "jqGritter" + "|" + posErr, "", 0);
};

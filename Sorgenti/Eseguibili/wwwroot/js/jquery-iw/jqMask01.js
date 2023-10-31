/**
 * jqMask01.js
 *
 * Impostazioni specifiche per IrisWeb
 *
 * Utilizzato per formattazione e controllo di valori:
 * - orari
 */
try {
  // valori orari
  posErr = ".input_hour_hhmm";
  $elem = jQuery.root.find(".input_hour_hhmm");
  if ($elem.length) {
    $elem.mask("99.99").validator({
      format: "time",
      correct: function(f, v) {
        validatorOk(f, v);
      },
      error: function(f, v, err) {
        validatorErr(f, v, err);
      }
    });
  }

  posErr = ".input_hour_hhmm2";
  $elem = jQuery.root.find(".input_hour_hhmm2");
  if ($elem.length) {
    $elem.each(function (i, e) {
      if (!$(this).is('[readonly]')) {
        $(this).autoNumeric(HOUR_NUMBER_99);
      }
    });
  }

  posErr = ".input_hour_99mm";
  $elem = jQuery.root.find(".input_hour_99mm");
  if ($elem.length) {
    $elem.mask("99.99");
  }

  posErr = ".input_hour_hhhmm";
  $elem = jQuery.root.find(".input_hour_hhhmm");
  if ($elem.length) {
    $elem.mask("999.99");
  }

  posErr = ".input_hour_hhhmm2";
  $elem = jQuery.root.find(".input_hour_hhhmm2");
  if ($elem.length) {
    $elem.each(function (i, e) {
      if (!$(this).is('[readonly]')) {
        $(this).autoNumeric(HOUR_NUMBER_999);
      }
    });
  }

  posErr = ".input_hour_hhhhmm";
  $elem = jQuery.root.find(".input_hour_hhhhmm");
  if ($elem.length) {
    $elem.mask("9999.99");
  }

  posErr = ".input_hour_hhhhmm2";
  $elem = jQuery.root.find(".input_hour_hhhhmm2");
  if ($elem.length) {
    $elem.each(function(i, e) {
      if (!$(this).is("[readonly]")) {
        $(this).autoNumeric(HOUR_NUMBER_9999);
      }
    });
  }
} catch (err) {
  gestioneErrori(err.message + "|" + "jqMask01" + "|" + posErr, "", 0);
}

/**
 * jqMask02.js
 * 
 * Impostazioni specifiche per IrisCloud 
 * 
 * Utilizzato per formattazione e controllo di valori:
 * - orari
 */
try {
  // valori orari
  posErr = 'input_hour_hhmm';
  $elem = jQuery.root.find(".input_hour_hhmm");
  if ($elem.length) {
    $elem.each(function (i, e) {
      if (!$(this).is('[readonly]')) {
        $(this).autoNumeric(HOUR_NUMBER_99);
      }
    });
  }

  posErr = 'input_hour_hhhmm';
  $elem = jQuery.root.find(".input_hour_hhhmm");
  if ($elem.length) {
    $elem.each(function (i, e) {
      if (!$(this).is('[readonly]')) {
        $(this).autoNumeric(HOUR_NUMBER_999);
      }
    });
  }

  posErr = 'input_hour_hhhhmm';
  $elem = jQuery.root.find(".input_hour_hhhhmm");
  if ($elem.length) {
    $elem.each(function (i, e) {
      if (!$(this).is('[readonly]')) {
        $(this).autoNumeric(HOUR_NUMBER_9999);
      }
    });
  }

  posErr = 'input_hour_of_day';
  $elem = jQuery.root.find(".input_hour_of_day");
  if ($elem.length) {
    $elem.each(function (i, e) {
      if (!$(this).is('[readonly]')) {
        $(this).autoNumeric(HOUR_OF_DAY_NUMBER)
          .validator({
            format: "time",
            correct: function (f, v) {
              validatorOk(f, v);
            },
            error: function (f, v, err) {
              validatorErr(f, v, err);
            }
          });
      }
    });
  }

  posErr = 'input_hour_hhmmss';
  $elem = jQuery.root.find(".input_hour_hhmmss");
  if ($elem.length) {
    $elem.each(function (i, e) {
      if (!$(this).is('[readonly]')) {
        $(this).autoNumeric(HOUR_HHMMSS)
          .validator({
            format: "time_hhmmss",
            correct: function (f, v) {
              validatorOk(f, v);
            },
            error: function (f, v, err) {
              validatorErr(f, v, err);
            }
          });
      }
    });
  }

  posErr = 'input_lat_lng';
  $elem = jQuery.root.find(".input_lat_lng");
  if ($elem.length) {
    $elem.each(function (i, e) {
      if (!$(this).is('[readonly]')) {
        $(this).autoNumeric(LAT_LNG);
      }
    });
  }
} catch (err) {
  gestioneErrori(err.message + "|" + "jqMask02" + "|" + posErr, "", 0);
}

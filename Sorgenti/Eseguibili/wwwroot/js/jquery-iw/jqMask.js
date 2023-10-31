/**
 * jqMask.js 
 * 
 * Impostazioni condivise tra IrisWeb e IrisCloud 
 * 
 * Utilizzato per formattazione e controllo di valori:
 * - di tipo data
 * - numerici
 * - testo maiuscolo e minuscolo
*/
try {
  // variabili di supporto per plugin autonumeric
  var NUM                        = {aSep: '', aDec: ','};
  var POS_INTEGER                = {aSep: '', aDec: ',', mDec: '0', aPad: false};
  var POS_INTEGER_SIZE_15        = {aSep: '', aDec: ',', mDec: '0', aPad: false, vMax: '999999999999999'};

  var POS_ONE_DECIMAL            = {aSep: '', aDec: ',', mDec: '1', aPad: false};
  var POS_TWO_DECIMALS           = {aSep: '', aDec: ',', mDec: '2', aPad: false};
  var POS_THREE_DECIMALS         = {aSep: '', aDec: ',', mDec: '3', aPad: false};
  var POS_FIVE_DECIMALS          = {aSep: '', aDec: ',', mDec: '5', aPad: false};

  var POS_INTEGER_9              = {aSep: '', aDec: ',', mDec: '0', aPad: false, vMax: '9'};
  var POS_INTEGER_99             = {aSep: '', aDec: ',', mDec: '0', aPad: false, vMax: '99'};
  var POS_INTEGER_999            = {aSep: '', aDec: ',', mDec: '0', aPad: false, vMax: '999'};
  var POS_INTEGER_9999           = {aSep: '', aDec: ',', mDec: '0', aPad: false, vMax: '9999'};
  var POS_INTEGER_99999          = {aSep: '', aDec: ',', mDec: '0', aPad: false, vMax: '99999'};
  var NEG_INTEGER_99             = {aSep: '', aDec: '.', mDec: '0', aPad: false, vMin: '-99',                   vMax: '99'};
  var NEG_INTEGER_999            = {aSep: '', aDec: '.', mDec: '0', aPad: false, vMin: '-999',                  vMax: '999'};
  var NEG_INTEGER_9999           = {aSep: '', aDec: '.', mDec: '0', aPad: false, vMin: '-9999',                 vMax: '9999'};
  var NEG_INTEGER_99999          = {aSep: '', aDec: '.', mDec: '0', aPad: false, vMin: '-99999',                vMax: '99999'};

  var POS_TWO_DECIMALS_9         = {aSep: '', aDec: ',', mDec: '2', aPad: false, vMax: '9.99'};
  var POS_TWO_DECIMALS_99        = {aSep: '', aDec: ',', mDec: '2', aPad: false, vMax: '99.99'};
  var POS_TWO_DECIMALS_999       = {aSep: '', aDec: ',', mDec: '2', aPad: false, vMax: '999.99'};
  var POS_TWO_DECIMALS_99999     = {aSep: '', aDec: ',', mDec: '2', aPad: false, vMax: '99999.99'};
  var POS_THREE_DECIMALS_9       = {aSep: '', aDec: ',', mDec: '3', aPad: false, vMax: '9.999'};
  var POS_TEN_DECIMALS_99999     = {aSep: '', aDec: ',', mDec: '10',aPad: false, vMin: '-99999.9999999999',     vMax: '99999.9999999999'};
  var POS_SIX_DECIMALS_999       = {aSep: '', aDec: ',', mDec: '6', aPad: false, vMax: '999.999999'};
  var POS_ONE_DECIMAL_999        = {aSep: '', aDec: ',', mDec: '1', aPad: false, vMax: '999.9'};

  var NEG_ONE_DECIMAL_99         = {aSep: '', aDec: ',', mDec: '1', aPad: false, vMin: '-99.9',                 vMax: '99.9'};
  var NEG_ONE_DECIMAL_999        = {aSep: '', aDec: ',', mDec: '1', aPad: false, vMin: '-999.9',                vMax: '999.9'};
  var NEG_ONE_DECIMAL_9999       = {aSep: '', aDec: ',', mDec: '1', aPad: false, vMin: '-9999.9',               vMax: '9999.9'};
  var NEG_TWO_DECIMALS_99        = {aSep: '', aDec: ',', mDec: '2', aPad: false, vMin: '-99.99',                vMax: '99.99'};
  var NEG_TWO_DECIMALS_999       = {aSep: '', aDec: ',', mDec: '2', aPad: false, vMin: '-999.99',               vMax: '999.99'};
  var NEG_TWO_DECIMALS_9999      = {aSep: '', aDec: ',', mDec: '2', aPad: false, vMin: '-9999.99',              vMax: '9999.99'};
  var NEG_TWO_DECIMALS_99999     = {aSep: '', aDec: ',', mDec: '2', aPad: false, vMin: '-99999.99',             vMax: '99999.99'};
  var NEG_TWO_DECIMALS_GENERIC   = {aSep: '', aDec: ',', mDec: '2', aPad: false, vMin: '-999999999999.99',      vMax: '999999999999.99'};
  var NEG_FIVE_DECIMALS_9        = {aSep: '', aDec: ',', mDec: '5', aPad: false, vMin: '-9.99999',              vMax: '9.99999'};
  var NEG_FIVE_DECIMALS_99999    = {aSep: '', aDec: ',', mDec: '5', aPad: false, vMin: '-99999.99999',          vMax: '99999.99999'};
  var NEG_FIVE_DECIMALS_12DIG    = {aSep: '', aDec: ',', mDec: '5', aPad: false, vMin: '-999999999999.99999',   vMax: '999999999999.99999'};
  var NEG_TEN_DECIMALS_12DIG     = {aSep: '', aDec: ',', mDec: '10',aPad: false, vMin: '-999999999999.9999999999',     vMax: '999999999999.9999999999'};

  var HOUR_NUMBER                = {aSep: '', aDec: '.', mDec: '2', aPad: true};
  var HOUR_NUMBER_99             = {aSep: '', aDec: '.', mDec: '2', aPad: true, iPad: '2' , vMax:'99.99' ,    mMax: '59'}; 
  var HOUR_NUMBER_999            = {aSep: '', aDec: '.', mDec: '2', aPad: true, iPad: '2' , vMax: '999.99',   mMax: '59'};
  var HOUR_NUMBER_9999           = {aSep: '', aDec: '.', mDec: '2', aPad: true, iPad: '2' , vMax: '9999.99',  mMax: '59'};
  var NEG_HOUR_NUMBER_99         = {aSep: '', aDec: '.', mDec: '2', aPad: true, iPad: '2' , vMin: '-9.99',    vMax: '99.99',    mMax: '59', negPad: false};
  var NEG_HOUR_NUMBER_999        = {aSep: '', aDec: '.', mDec: '2', aPad: true, iPad: '2' , vMin: '-99.99',   vMax: '999.99',   mMax: '59'};
  var NEG_HOUR_NUMBER_9999       = {aSep: '', aDec: '.', mDec: '2', aPad: true, iPad: '2' , vMin: '-999.99',  vMax: '9999.99',  mMax: '59'};
  var NEG_HOUR_NUMBER_99999      = {aSep: '', aDec: '.', mDec: '2', aPad: true, iPad: '2' , vMin: '-9999.99', vMax: '99999.99', mMax: '59'};
  var HOUR_OF_DAY_NUMBER         = {aSep: '', aDec: '.', mDec: '2', aPad: true, iPad: '2' , hMax:'23' ,       mMax: '59'};
  var HOUR_HHMMSS                = {aSep: '', aDec: '.', mDec: '2', aPad: true, iPad: '2' , vMax:'99.99.99' , mMax: '59'};

  var MONTH_NUMBER               = {aSep: '', aDec: '.', mDec: '2', aPad: false, vMin: '1', vMax: '12'};  
  var DAY_OF_WEEK_NUMBER         = {aSep: '', aDec: '.', mDec: '2', aPad: false, vMin: '1', vMax: '7'};  
  
  var LAT_LNG                    = {aSep: '', aDec: ',', mDec: '8', aPad: false, vMax: '360'};

  // funzioni per plugin validator
  var validatorOk = function (f,v) {
    $(f).siblings(".invalidFormatTip").remove();
  }
  var validatorErr = function (f,v,err) {
    $(f).siblings(".invalidFormatTip").remove();
    $(f).after("<div class=\"invalidFormatTip\">" + err.message + "<\/div>");
  }
  
  // valori di tipo iban
  posErr = ".input_iban";
  $elem = jQuery.root.find(".input_iban");
  if ($elem.length) {
    $elem
      .mask("aa-99-a-99999-99999-************");
  }

  posErr = ".input_iban_partial";
  $elem = jQuery.root.find(".input_iban_partial");
  if ($elem.length) {
    $elem
      .mask("?aa-99-a-99999-99999-************");
  }
  // valori di tipo gg/mm
  posErr = ".input_ggmm";
  $elem = jQuery.root.find(".input_ggmm");
  if ($elem.length) {
    $elem
      .mask("99/99");
  }

  // valori di tipo data 
  posErr = ".input_data_dmy";
  $elem = jQuery.root.find(".input_data_dmy");
  if ($elem.length) {
    $elem
      .mask("99/99/9999")
      .validator({
        format: "date",
        correct: function(f,v) { validatorOk(f,v); },
        error: function(f,v,err) { validatorErr(f,v,err); }
      });
  } 

  posErr = ".input_data_dmyhhmm";
  $elem = jQuery.root.find(".input_data_dmyhhmm");
  if ($elem.length) {
    $elem
      .mask("99/99/9999 ?99.99");
  }

  // valori minutes
  posErr = ".input_minutes";
  $elem = jQuery.root.find(".input_minutes");
  if ($elem.length) {
    $elem.validator({
      format: "minutes",
      correct: function(f,v) { validatorOk(f,v); },
      error: function(f,v,err) { validatorErr(f,v,err); }
    });
  }

  // valori orari
  posErr = ".input_hour_hhhmm_neg";
  $elem = jQuery.root.find(".input_hour_hhhmm_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_HOUR_NUMBER_999);} }); 
  }

  posErr = ".input_hour_hhhhmm_neg";
  $elem = jQuery.root.find(".input_hour_hhhhmm_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_HOUR_NUMBER_9999);} }); 
  }

  // valori numerici
  posErr = ".input_integer";
  $elem = jQuery.root.find(".input_integer");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_INTEGER);} }); 
  }

  posErr = ".input_integer_15";
  $elem = jQuery.root.find(".input_integer_15");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_INTEGER_SIZE_15);} }); 
  }

  posErr = ".input_num_12n10d_neg";
  $elem = jQuery.root.find(".input_num_12n10d_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_TEN_DECIMALS_12DIG);} }); 
  }

  posErr = ".input_num_n";
  $elem = jQuery.root.find(".input_num_n");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_INTEGER_9);} }); 
  }

  posErr = ".input_num_nn";
  $elem = jQuery.root.find(".input_num_nn");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_INTEGER_99);} }); 
  }

  posErr = ".input_num_nnn";
  $elem = jQuery.root.find(".input_num_nnn");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_INTEGER_999);} }); 
  }

  posErr = ".input_num_nnnn";
  $elem = jQuery.root.find(".input_num_nnnn");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_INTEGER_9999);} }); 
  }

  posErr = ".input_num_nnnnn";
  $elem = jQuery.root.find(".input_num_nnnnn");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_INTEGER_99999);} }); 
  }

  posErr = ".input_num_ndd";
  $elem = jQuery.root.find(".input_num_ndd");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_TWO_DECIMALS_9);} }); 
  }  
  
  posErr = ".input_num_nndd";
  $elem = jQuery.root.find(".input_num_nndd");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_TWO_DECIMALS_99);} }); 
  }

  posErr = ".input_num_nnndd";
  $elem = jQuery.root.find(".input_num_nnndd");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_TWO_DECIMALS_999);} }); 
  }

  posErr = ".input_num_nnnnndd";
  $elem = jQuery.root.find(".input_num_nnnnndd");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_TWO_DECIMALS_99999);} }); 
  }

  posErr = ".input_num_nnnd";
  $elem = jQuery.root.find(".input_num_nnnd");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_ONE_DECIMAL_999);} }); 
  }

  posErr = ".input_num_nddd";
  $elem = jQuery.root.find(".input_num_nddd");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_THREE_DECIMALS_9);} }); 
  }

  posErr = ".input_num_generic";
  $elem = jQuery.root.find(".input_num_generic");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_TWO_DECIMALS);} }); 
  }


  posErr = ".input_num_generic_neg";
  $elem = jQuery.root.find(".input_num_generic_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_TWO_DECIMALS_GENERIC);} }); 
  }

  posErr = ".input_num_generic_3_dec";
  $elem = jQuery.root.find(".input_num_generic_3_dec");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_THREE_DECIMALS);} }); 
  }

  posErr = ".input_num_generic_5_dec";
  $elem = jQuery.root.find(".input_num_generic_5_dec");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_FIVE_DECIMALS);} }); 
  }


  // valori numerici negativi
  posErr = ".input_num_nn_neg";
  $elem = jQuery.root.find(".input_num_nn_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_INTEGER_99);} }); 
  }

  posErr = ".input_num_nnn_neg";
  $elem = jQuery.root.find(".input_num_nnn_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_INTEGER_999);} }); 
  }

  posErr = ".input_num_nnnn_neg";
  $elem = jQuery.root.find(".input_num_nnnn_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_INTEGER_9999);} }); 
  }

  posErr = ".input_num_nnd_neg";
  $elem = jQuery.root.find(".input_num_nnd_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_ONE_DECIMAL_99);} }); 
  }

  posErr = ".input_hour_hhhhhmm_neg";
  $elem = jQuery.root.find(".input_hour_hhhhhmm_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_HOUR_NUMBER_99999);} }); 
  }

  posErr = ".input_num_nndd_neg";
  $elem = jQuery.root.find(".input_num_nndd_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_TWO_DECIMALS_99);} }); 
  }

  posErr = ".input_num_nnndd_neg";
  $elem = jQuery.root.find(".input_num_nnndd_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_TWO_DECIMALS_999);} }); 
  }

  posErr = ".input_num_nnnndd_neg";
  $elem = jQuery.root.find(".input_num_nnnndd_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_TWO_DECIMALS_9999);} }); 
  }

  posErr = ".input_num_nnnnndd_neg";
  $elem = jQuery.root.find(".input_num_nnnnndd_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_TWO_DECIMALS_99999);} }); 
  }

  posErr = ".input_num_nnnd_neg";
  $elem = jQuery.root.find(".input_num_nnnd_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_ONE_DECIMAL_999);} }); 
  }

  posErr = ".input_num_nnnnd_neg";
  $elem = jQuery.root.find(".input_num_nnnnd_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_ONE_DECIMAL_9999);} }); 
  }

  posErr = ".input_hour_hhmm_neg";
  $elem = jQuery.root.find(".input_hour_hhmm_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_HOUR_NUMBER_99);} }); 
  }

  posErr = ".input_month";
  $elem = jQuery.root.find(".input_month");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(MONTH_NUMBER);} }); 
  }

  posErr = ".input_day_of_week";
  $elem = jQuery.root.find(".input_day_of_week");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(DAY_OF_WEEK_NUMBER);} }); 
  }

  posErr = ".input_num_nddddd_neg";
  $elem = jQuery.root.find(".input_num_nddddd_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_FIVE_DECIMALS_9);} }); 
  }

  posErr = ".input_num_nnnnnddddd_neg";
  $elem = jQuery.root.find(".input_num_nnnnnddddd_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_FIVE_DECIMALS_99999);} }); 
  }

  posErr = ".input_num_nnndddddd";
  $elem = jQuery.root.find(".input_num_nnndddddd");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_SIX_DECIMALS_999);} }); 
  }

  posErr = ".input_num_nnnnn10d";
  $elem = jQuery.root.find(".input_num_nnnnn10d");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(POS_TEN_DECIMALS_99999);} }); 
  }

  posErr = ".input_num_12n5d_neg";
  $elem = jQuery.root.find(".input_num_12n5d_neg");
  if ($elem.length) {
    $elem.each(function(i,e) { if (!$(this).is('[readonly]')) { $(this).autoNumeric(NEG_FIVE_DECIMALS_12DIG);} }); 
  }

  // testo maiuscolo / minuscolo
  posErr = ".maiuscolo";
  $elem = jQuery.root.find(".maiuscolo");
  if ($elem.length) {
    $elem.uppercase();
  }

  posErr = ".minuscolo";
  $elem = jQuery.root.find(".minuscolo");
  if ($elem.length) {
    $elem.lowercase();
  }
}
catch (err) {
  gestioneErrori(err.message + "|" + "jqMask" + "|" + posErr,"",0);
}

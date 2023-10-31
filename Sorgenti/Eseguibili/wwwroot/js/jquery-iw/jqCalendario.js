/* jqCalendario */
try {
  posErr = ".input_data_dmy";
  $(".input_data_dmy:not([readonly])").each(function (index) {
    //$(this).datepicker(pickerOpts);
    $(this).datepicker({
      showOtherMonths: true,
      showAnim: "",
      changeMonth: false,
      changeYear: false,
      showButtonPanel: false,
      onClose: function (s, dp) {
        $(this).trigger("change");
      }
      })
    })
    ;

  // imposta datepicker formato mm/yyyy
  posErr = ".input_data_my";
  $(".input_data_my").each(function (index) {
    var rdOnly = $(this).attr('readonly');
    if (!rdOnly)
      $(this).datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: 'mm/yy',
        showButtonPanel: true,
        closeText: 'OK',
        onClose: function (s, dp) {
          var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
          var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
          if (iYear == 1899) {
            $(this).datepicker('setDate', null);
          } else {
            $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
          }
          $(".ui-datepicker-calendar").hide();
          $(this).change();
          $(".ui-datepicker-calendar").hide();
        },
        beforeShow: function () {
          if ((selDate = $(this).val()).length > 0) {
            var iYear = selDate.substring(selDate.length - 4, selDate.length);
            var iMonth = selDate.substring(0, 2);
            $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth - 1, 1));
            $(this).datepicker('setDate', new Date(iYear, iMonth - 1, 1));
            $(".ui-datepicker-calendar").hide();
            return true;
          }
        }
      });
  });

  $('.input_data_my').keyup(function () {
    if ($(this).val().length == 7) {
      var _date = $(this).val();
      var iYear = _date.substring(_date.length - 4, _date.length);
      var iMonth = _date.substring(0, 2);
      $(this).datepicker('setDate', new Date(iYear, iMonth - 1, 1));
    }
    /*Alberto: al momento non applicato. 
      Serve per annullare la data quando si lascia l'input vuoto evitando che vada a riassegnare la data del plugin
    if( $(this).val().length == 0) {
      $(this).datepicker('setDate', new Date(1899, 11, 30));
    } 
    */
    $(".ui-datepicker-calendar").hide();
  });

  $(".input_data_my").click(function () {
    $(this).focus();
  });

  $(".input_data_my").focus(function () {
    $(".ui-datepicker-calendar").detach();
    $(".ui-datepicker-calendar").hide();
    $("#ui-datepicker-div").position({
      my: "left top",
      at: "left bottom",
      of: $(this)
    });
  });
} catch (err) {
  gestioneErrori(err.message + "|" + "jqCalendario" + "|" + posErr, "", 0);
}

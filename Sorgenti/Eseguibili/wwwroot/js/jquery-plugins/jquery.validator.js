/*************************************************************************
*
* jQuery Validator
* Author: Igor Gladkov (igor.gladkov@gmail.com)
* Homepage: http://igorgladkov.com/jquery/validator.html
*
* jQuery Validator is Copyright (C) 2009-2010
* Igor Gladkov. All Rights Reserved.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
* 
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
**************************************************************************/

(function($)
{
  var PLUGIN_NAME = 'validator';
  
  var Data = {
    defaults: {
      className: 'invalidFormat', //'validator_error',
      trigger: 'change blur',
      format: null,
      invalidEmpty: false,
      minLength: null,
      maxLength: null,
      minValue: null,
      maxValue: null,
      contains: null,
      notContains: null,
      equals: null,
      notEquals: null,
      checked: null,
      before: null, // define function that will be called before validation (output will be used for validation); this = field; agrs(field, value);
      after: null,  // define function that will be called after default validation (output will be used for error notification (true - valid, false - invalid)); this = field; agrs(field, value, error);
      error: null,  // define function that will be called after error occurs (return: true/false - default error code run); this = field; agrs(field, value, error);
      correct: null // define function that will be called after correct state occurs (return: true/false - default correct code run); this = field; agrs(field, value, error);
    },
    formats: {
      email: new RegExp('^[a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$', 'i'),
      ip: /^(\d{1,3}\.){3}\d{1,3}$/,
      date: /^\d{2}[- \/.]\d{2}[- \/.]\d{4}$/,
      date_my: /^\d{2}[- \/.]\d{4}$/,
      datetime: /^\d{2}[- \/.]\d{2}[- \/.]\d{4}\s*?\d{2}[- :.]\d{2}$/,
      time: /^\d{2}[- :.]\d{2}$/,
			time_hhmmss: /^\d{2}[- :.]\d{2}[- :.]\d{2}$/,
      minutes: /^([0-9,]+).[0-5][0-9]$/,
      phone: /^\d{10,15}$/,
      zipUS: /^(\d{5})(-\d{4})?$/,
      zipCanada: /^[a-z][0-9][a-z]\s*?[0-9][a-z][0-9]$/i,
      creditCard: /^\d{13,16}$/,
      numeric: /^\d+$/,
      decimal: /^[0-9\.,]+$/,
      alphanumeric: /^([a-z]|\d|\s|-|\.|_|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+$/i,
      iban: /^[a-zA-Z]{2}[0-9]{2}[a-zA-Z0-9]{4}[0-9]{7}([a-zA-Z0-9]?){0,16}$/
    },
    errors: {
      empty: 'non pu� essere vuoto',
      checked: 'deve essere selezionato',
      email: 'formato email non corretto',
      ip: 'formato IP non corretto. Esempio: 111.111.111.111',
      date: 'formato data non corretto. Esempio: gg/mm/aaaa',
      date_my: 'formato mese non corretto. Esempio: mm/aaaa',
      datetime: 'formato data-ora non corretto. Esempio: gg/mm/aaaa hh:mm',
      time: 'formato ora non corretto. Esempio: hh.mm',
      minutes: 'I minuti devono essere minori di 60',
      phone: 'Phone number has wrong format. Example: 1234567890',
      zipUS: 'US zip code has wrong format. Example: 10001',
      zipCanada: 'Canada zip code has wrong format. Example: A6A 6A6',
      creditCard: 'numero carta di credito non valido (solo cifre)',
      numeric: 'il dato numerico pu� contenere solo cifre',
      decimal: 'formato del dato numerico non corretto',
      alphanumeric: 'sono ammessi solo caratteri alfanumerici',
      iban: 'codice IBAN non valido'
    }
  };
  
  var PlugIn = {
    initialized: false,
    
    init: function()
    {
      PlugIn.initialized = true;
    },
    
    attach: function(o)
    {
      var $el = $(this);
      
      o = $.extend({}, Data.defaults, o);
      
      // save options
      $el.data(PLUGIN_NAME, o);
      
      // set trigger events
      $.each(o.trigger.split(' '), function(i, eventType) {
        eventType += '.' + PLUGIN_NAME;
        
        $el.unbind(eventType).bind(eventType, function(e) {
          PlugIn.runValidation(this);
        });
      });
    },
    
    validate: function()
    {
      var error = false;
      
      $(this).each(function(i, el) {
        if(!PlugIn.runValidation(el)) {
          error = true;
        }
      });
      
      return !error;
    },
    
    runValidation: function(field)
    {
      $field = $(field);
      
      var er = {
        status: false,
        type: '',
        message: ''
      };
      
      var o = $field.data(PLUGIN_NAME);
      
      // check if validator activated for element
      if(!o) return true;
      
      // get field value to validate
      var v = $field.val();
      
      // call before function (assign return to value)
      if(o.before) {
        v = o.before.apply($field[0], [$field[0], $field.val()]);
      }
      
      // make sure value is a string
      v += '';
      
      // validate
      if($field.is(':checkbox') || $field.is(':radio')) {
        if(o.checked != null && o.checked != $field.is(':checked')) {
          er.status = true;
          er.type = 'checked';
          er.message = Data.errors.checked;
        }
      }
      else {
        if(v.length == 0) {
          if(o.invalidEmpty == true) {
            er.status = true;
            er.type = 'invalidEmpty';
            er.message = Data.errors.empty;
          }
        }
        else {
          if(o.format != null && v.length > 0 && v.search(Data.formats[o.format]) == -1) {
            er.status = true;
            er.type = 'format';
            er.message = Data.errors[o.format];
          }
          else if(o.minLength != null && v.length < o.minLength) {
            er.status = true;
            er.type = 'minLength';
            er.message = 'lunghezza minima: ' + o.minLength + ' caratteri';
          }
          else if(o.maxLength != null && v.length > o.maxLength) {
            er.status = true;
            er.type = 'maxLength';
            er.message = 'lunghezza massima: ' + o.maxLength + ' caratteri';
          }
          else if(o.minValue != null && !isNaN(v) && (v * 1 < o.minValue)) {
            er.status = true;
            er.type = 'minValue';
            er.message = 'non puo essere minore di ' + o.minValue;
          }
          else if(o.maxValue != null && !isNaN(v) && (v * 1 > o.maxValue)) {
            er.status = true;
            er.type = 'maxValue';
            er.message = 'non puo essere maggiore di ' + o.maxValue;
          }
          else if(o.contains != null && v.search(o.contains) == -1) {
            er.status = true;
            er.type = 'contains';
            er.message = 'deve contenere "' + o.contains + '"';
          }
          else if(o.notContains != null && v.search(o.notContains) != -1) {
            er.status = true;
            er.type = 'notContains';
            er.message = 'non puo contenere "' + o.notContains + '"';
          }
          else if(o.equals != null && v != o.equals) {
            er.status = true;
            er.type = 'equals';
            er.message = 'deve essere uguale a "' + o.equals + '"';
          }
          else if(o.notEquals != null && v == o.notEquals) {
            er.status = true;
            er.type = 'notEquals';
            er.message = 'deve essere diverso da "' + o.notEquals + '"';
          }
          
          // parse dei formati di data e ora
          if (o.format != null) {
            if (o.format == "date") {
              if (Date.parse(v,"dd/mm/yyyy") == null) {
                er.status = true;
                er.type = 'date';
                er.message = 'data non valida';
              }
            }
            if (o.format == "date_my") {
              if (Date.parse(v,"mm/yyyy") == null) {
                er.status = true;
                er.type = 'date';
                er.message = 'mese non valido';
              }
            }
            else if (o.format == "time") {
              if (Date.parseExact(v,"HH.mm") == null) {
                er.status = true;
                er.type = 'time';
                er.message = 'ora non valida';
              }
            }
          }
          // new.fine
        }
      }
      
      // run after function
      if(o.after) {
        o.after.apply($field[0], [$field[0], $field.val(), er]);
      }
      
      if(er.status === true) {
        $field.data('validatorError', true);
        
        if(o.error == null || o.error.apply($field[0], [$field[0], $field.val(), er]) !== false) {
          $field.addClass(o.className);
          /*
          if(er.type == 'date' || er.type == 'time') {
          	alert(er.message);
            $field.val("");
            $field.focus(function(){});
          }*/
        }

      }
      else if(er.status === false) {
        $field.removeData('validatorError');
        
        if(o.correct == null || o.correct.apply($field[0], [$field[0], $field.val(), er]) !== false) {
          $field.removeClass(o.className);
        }
      }
      return !er.status;
    }
  };
  
  $.fn.validator = function()
  {
    if(!PlugIn.initialized) {
      PlugIn.init();
    }
   
    var output;
    
    if(typeof arguments[0] == 'string') {
      if($.isFunction(PlugIn[arguments[0]])) {
        output = PlugIn[arguments[0]].apply(this, Array.prototype.slice.call(arguments, 1));
      }
    }
    else {
      output = PlugIn.attach.apply(this, [arguments[0]]);
    }
    return (output != undefined ? output : this);
  };
  $.validator = Data;
})(jQuery);
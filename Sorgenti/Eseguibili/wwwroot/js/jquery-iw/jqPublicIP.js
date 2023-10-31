/**
 * jqPublicIP 
 */
/* Visualizziamo il nostro div che copre l'intero documento per evitare che l'utente possa interagire
   con la pagina prima che si verifichi l'evento onLoad (quello di IW viene nascosto in automatico). */
numChiamateAJAXInCorso++;
GestisciLockAJAX();
$(window).load(function(){
	try {
		// reperimento ip pubblico ed esecuzione metodo per aggiornare questo dato sul server
		var myForm = "%s";
		var callbackFn = myForm + "." + "OnPublicIPRicevutoJs";
		// in precedenza provato "http://jsonip.com", ma molto meno affidabile
		var publicIpAPI = "https://api.ipify.org?format=json";

		posErr = "$.getJSON";
		$.getJSON(publicIpAPI)
			.done(function (data) {
				executeAjaxEvent("&myForm=" + myForm + "&status=OK&publicIp=" + data.ip, null, callbackFn, false, null, false);
			})
			.fail(function (x, txt, err) {
				executeAjaxEvent("&myForm=" + myForm + "&status=ERR&textStatus=" + txt + "&error=" + err, null, callbackFn, false, null, false);
		});
	} catch (err) {
		gestioneErrori(err.message + "|" + "jqPublicIP" + "|" + posErr, "", 0);
	}
});


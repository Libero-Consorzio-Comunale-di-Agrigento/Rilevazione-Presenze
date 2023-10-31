/**
 * jqReplaceCache
 */
try {
	posErr = "img";
	$("img").each(function (index) {
		var iText = $(this).attr("src");
		if (typeof iText != 'undefined') {
			if (iText.indexOf("/$/Cache/") == 0) {
				iText = iText.replace("/$/Cache/", "$/Cache/");
				$(this).attr("src", iText);
			}
		}
	});

	posErr = "iframe";
	$("iframe").each(function (index) {
		var iText = $(this).attr("src");
		if (typeof iText != 'undefined') {
			if (iText.indexOf("/$/Cache/") == 0) {
				iText = iText.replace("/$/Cache/", "$/Cache/");
				$(this).attr("src", iText);
			}
		}
	});
} catch (err) {
	gestioneErrori(err.message + "|" + "jqReplaceCache" + "|" + posErr, "", 0);
}

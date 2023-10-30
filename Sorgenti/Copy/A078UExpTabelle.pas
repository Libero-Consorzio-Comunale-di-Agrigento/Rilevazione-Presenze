unit A078UExpTabelle;

interface

uses Classes, Variants;

type
   TA078Relazioni = record
     Padre,
     Figlio,
     Obbligatorio:String;
   end;

const
  A078Relazioni:array [1..173] of TA078Relazioni =
    ((Padre:'T010_CALENDIMPOSTAZ.CODICE';Figlio:'T430_STORICO.CALENDARIO';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T021_FASCEORARI.CODICE';Obbligatorio:'S'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T080_PIANIFORARI.ORARIO';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T221_PROFILISETTIMANA.LUNEDI';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T221_PROFILISETTIMANA.MARTEDI';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T221_PROFILISETTIMANA.MERCOLEDI';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T221_PROFILISETTIMANA.GIOVEDI';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T221_PROFILISETTIMANA.VENERDI';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T221_PROFILISETTIMANA.SABATO';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T221_PROFILISETTIMANA.DOMENICA';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T221_PROFILISETTIMANA.NONLAV';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T221_PROFILISETTIMANA.FESTIVO';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T611_CICLIGIORNALIERI.ORARIO';Obbligatorio:'N'),
     (Padre:'T020_ORARI.CODICE';Figlio:'T630_SPOSTSQUADRA.ORARIO';Obbligatorio:'N'),
     (Padre:'T025_CONTMENSILI.CODICE';Figlio:'T430_STORICO.PERSELASTICO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.MATRICOLA';Figlio:'T030_ANAGRAFICO.MATRICOLA';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P254_VOCIPROGRAMMATE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P256_VOCIRIASSORBIBILI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P258_ADDIZIONALIIRPEF.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P262_MOD730TESTATA.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P264_MOD730IMPORTI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P266_MODONAOSI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P268_RAPPORTIPRECEDENTI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P270_REDDITIANNUALI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P272_RETRIBUZIONE_CONTRATTUALE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P430_ANAGRAFICO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P430_APPOGGIO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P440_CEDOLINOSTATO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P441_CEDOLINO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P445_CEDOLINOTEMP.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P448_CEDOLINOPARKVOCI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P450_DATIMENSILI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P504_CUDTESTATE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P605_770DATIINDIVIDUALI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P663_FLUSSIDATIINDIVIDUALI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'P673_XMLDATIINDIVIDUALI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'SG100_PROVVEDIMENTO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'SG101_FAMILIARI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'SG102_DOCUMENTI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'SG110_CURRICULUM.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'SG113_PREFERENZE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'SG651_PIANIFICAZIONECORSI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'SG656_RESIDUOCREDITI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T012_CALENDINDIVID.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T040_GIUSTIFICATIVI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T041_PROVVISORIO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T042_PERIODIASSENZA.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T043_RIEPILOGOASSENZE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T044_STORICOGIUSTIFICATIVI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T046_GIUSTIFICATIVIFAMILIARI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T050_RICHIESTEASSENZA.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T070_SCHEDARIEPIL.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T071_SCHEDAFASCE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T072_SCHEDAINDPRES.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T073_SCHEDACAUSPRES.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T074_CAUSPRESFASCE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T075_STRESTERNO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T076_CAUSPRESPAGHE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T080_PIANIFORARI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T081_PROVVISORIO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T090_PLUSORAINDIV.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T100_TIMBRATURE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T101_ANOMALIE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T102_FESTELAVORATE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T130_RESIDANNOPREC.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T131_RESIDPRESENZE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T134_ORELIQUIDATEANNIPREC.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T180_DATIBLOCCATI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T195_SCARTI_DA_CANC.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T195_VOCIVARIABILI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T246_ISCRIZIONISINDACATI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T247_PARTECIPAZIONISINDACATI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T248_PERMESSISINDACALI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T263_PROFASSIND.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T264_RESIDASSANN.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T280_MESSAGGIWEB.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T295_MESSAGGIINVIATI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T299_MESSAGGIRICHIESTI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T320_PIANLIBPROFESSIONE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T332_PIAN_ATT_AGGIUNTIVE.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T340_TURNIREPERIB.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T370_TIMBMENSA.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T375_ACCESSIMENSA.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T380_PIANIFREPERIB.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T410_PASTI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T430_STORICO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T433_CDC_PERCENT.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T435_BADGESERVIZIO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T620_TURNAZIND.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T630_SPOSTSQUADRA.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T680_BUONIMENSILI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T690_ACQUISTOBUONI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T692_RESIDUOBUONI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T762_INCENTIVIMATURATI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T775_QUOTEINDIVIDUALI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T820_LIMITIIND.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'T825_LIQUIDINDANNUO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'M040_MISSIONI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'M060_ANTICIPI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'M052_INDENNITAKM.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'M051_DETTAGLIORIMBORSO.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'M050_RIMBORSI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T030_ANAGRAFICO.PROGRESSIVO';Figlio:'M140_RICHIESTE_MISSIONI.PROGRESSIVO';Obbligatorio:'N'),
     (Padre:'T162_INDENNITA.CODICE';Figlio:'T072_SCHEDAINDPRES.CODINDPRES';Obbligatorio:'N'),
     (Padre:'T162_INDENNITA.CODICE';Figlio:'T160_PROFILIINDENNITA.INDENNITA';Obbligatorio:'S'),
     (Padre:'T162_INDENNITA.CODICE';Figlio:'T164_ASSOCIAZIONIINDENNITA.CODICE';Obbligatorio:'S'),
     (Padre:'T163_CODICIINDENNITA.CODICE';Figlio:'T080_PIANIFORARI.INDPRESENZA';Obbligatorio:'N'),
     (Padre:'T163_CODICIINDENNITA.CODICE';Figlio:'T160_PROFILIINDENNITA.CODICE';Obbligatorio:'N'),
     (Padre:'T163_CODICIINDENNITA.CODICE';Figlio:'T430_STORICO.IPRESENZA';Obbligatorio:'N'),
     (Padre:'T200_CONTRATTI.CODICE';Figlio:'T430_STORICO.CONTRATTO';Obbligatorio:'N'),
     (Padre:'T200_CONTRATTI.CODICE';Figlio:'T201_MAGGIORAZIONI.CODICE';Obbligatorio:'S'),
     (Padre:'T210_MAGGIORAZIONI.CODICE';Figlio:'T071_SCHEDAFASCE.CODFASCIA';Obbligatorio:'N'),
     (Padre:'T210_MAGGIORAZIONI.CODICE';Figlio:'T074_CAUSPRESFASCE.CODFASCIA';Obbligatorio:'N'),
     (Padre:'T210_MAGGIORAZIONI.CODICE';Figlio:'T201_MAGGIORAZIONI.MAGGIOR1';Obbligatorio:'N'),
     (Padre:'T210_MAGGIORAZIONI.CODICE';Figlio:'T201_MAGGIORAZIONI.MAGGIOR2';Obbligatorio:'N'),
     (Padre:'T210_MAGGIORAZIONI.CODICE';Figlio:'T201_MAGGIORAZIONI.MAGGIOR3';Obbligatorio:'N'),
     (Padre:'T210_MAGGIORAZIONI.CODICE';Figlio:'T201_MAGGIORAZIONI.MAGGIOR4';Obbligatorio:'N'),
     (Padre:'T220_PROFILIORARI.CODICE';Figlio:'T221_PROFILISETTIMANA.CODICE';Obbligatorio:'S'),
     (Padre:'T220_PROFILIORARI.CODICE';Figlio:'T430_STORICO.PORARIO';Obbligatorio:'N'),
     (Padre:'T240_ORGANIZZAZIONISINDACALI.CODICE';Figlio:'T246_ISCRIZIONISINDACATI.COD_SINDACATO';Obbligatorio:'N'),
     (Padre:'T240_ORGANIZZAZIONISINDACALI.CODICE';Figlio:'T247_PARTECIPAZIONISINDACATI.COD_SINDACATO';Obbligatorio:'N'),
     (Padre:'T240_ORGANIZZAZIONISINDACALI.CODICE';Figlio:'T248_PERMESSISINDACALI.COD_SINDACATO';Obbligatorio:'N'),
     (Padre:'T262_PROFASSANN.CODPROFILO';Figlio:'T430_STORICO.PASSENZE';Obbligatorio:'N'),
     (Padre:'T260_RAGGRASSENZE.CODICE';Figlio:'T260_RAGGRASSENZE.RAGGRUPPAMENTO_RESIDUO';Obbligatorio:'N'),
     (Padre:'T260_RAGGRASSENZE.CODICE';Figlio:'T262_PROFASSANN.CODRAGGR';Obbligatorio:'N'),
     (Padre:'T260_RAGGRASSENZE.CODICE';Figlio:'T263_PROFASSIND.CODRAGGR';Obbligatorio:'N'),
     (Padre:'T260_RAGGRASSENZE.CODICE';Figlio:'T264_RESIDASSANN.CODRAGGR';Obbligatorio:'N'),
     (Padre:'T260_RAGGRASSENZE.CODICE';Figlio:'T265_CAUASSENZE.CODRAGGR';Obbligatorio:'N'),
     (Padre:'T265_CAUASSENZE.CODICE';Figlio:'T040_GIUSTIFICATIVI.CAUSALE';Obbligatorio:'N'),
     (Padre:'T265_CAUASSENZE.CODICE';Figlio:'T042_PERIODIASSENZA.CAUSALE';Obbligatorio:'N'),
     (Padre:'T265_CAUASSENZE.CODICE';Figlio:'T044_STORICOGIUSTIFICATIVI.CAUSALE';Obbligatorio:'N'),
     (Padre:'T265_CAUASSENZE.CODICE';Figlio:'T046_GIUSTIFICATIVIFAMILIARI.CAUSALE';Obbligatorio:'N'),
     (Padre:'T265_CAUASSENZE.CODICE';Figlio:'T050_RICHIESTEASSENZA.CAUSALE';Obbligatorio:'N'),
     (Padre:'T265_CAUASSENZE.CODICE';Figlio:'T265_CAUASSENZE.CODCAUINIZIO';Obbligatorio:'N'),
     (Padre:'T265_CAUASSENZE.CODICE';Figlio:'T265_CAUASSENZE.CODCAUFRUIZIONE';Obbligatorio:'N'),
     (Padre:'T265_CAUASSENZE.CODICE';Figlio:'T611_CICLIGIORNALIERI.CAUSALE';Obbligatorio:'N'),
     (Padre:'T265_CAUASSENZE.ID';Figlio:'T230_CAUASSENZE_PARSTO.ID';Obbligatorio:'N'),
     (Padre:'T270_RAGGRPRESENZE.CODICE';Figlio:'T275_CAUPRESENZE.CODRAGGR';Obbligatorio:'N'),
     (Padre:'T275_CAUPRESENZE.CODICE';Figlio:'T040_GIUSTIFICATIVI.CAUSALE';Obbligatorio:'N'),
     (Padre:'T275_CAUPRESENZE.CODICE';Figlio:'T073_SCHEDACAUSPRES.CAUSALE';Obbligatorio:'N'),
     (Padre:'T275_CAUPRESENZE.CODICE';Figlio:'T074_CAUSPRESFASCE.CAUSALE';Obbligatorio:'N'),
     (Padre:'T275_CAUPRESENZE.CODICE';Figlio:'T100_TIMBRATURE.CAUSALE';Obbligatorio:'N'),
     (Padre:'T275_CAUPRESENZE.CODICE';Figlio:'T131_RESIDPRESENZE.CAUSALE';Obbligatorio:'N'),
     (Padre:'T275_CAUPRESENZE.CODICE';Figlio:'T275_CAUPRESENZE.CAUS_FUORI_TURNO';Obbligatorio:'N'),
     (Padre:'T275_CAUPRESENZE.CODICE';Figlio:'T277_CAUFASCEABILITATE.CODICE';Obbligatorio:'S'),
     (Padre:'T275_CAUPRESENZE.CODICE';Figlio:'T311_DETTLIBPROF.CAUSALE';Obbligatorio:'N'),
     (Padre:'T275_CAUPRESENZE.CODICE';Figlio:'T320_PIANLIBPROFESSIONE.CAUSALE';Obbligatorio:'N'),
     (Padre:'T275_CAUPRESENZE.ID';Figlio:'T235_CAUPRESENZE_PARSTO.ID';Obbligatorio:'N'),
     (Padre:'T300_RAGGRGIUSTIF.CODICE';Figlio:'T305_CAUGIUSTIF.CODRAGGR';Obbligatorio:'N'),
     (Padre:'T305_CAUGIUSTIF.CODICE';Figlio:'T070_SCHEDARIEPIL.CAUSALE1MINASS';Obbligatorio:'N'),
     (Padre:'T305_CAUGIUSTIF.CODICE';Figlio:'T070_SCHEDARIEPIL.CAUSALE2MINASS';Obbligatorio:'N'),
     (Padre:'T305_CAUGIUSTIF.CODICE';Figlio:'T100_TIMBRATURE.CAUSALE';Obbligatorio:'N'),
     (Padre:'T305_CAUGIUSTIF.CODICE';Figlio:'T370_TIMBMENSA.CAUSALE';Obbligatorio:'N'),
     (Padre:'T305_CAUGIUSTIF.CODICE';Figlio:'T410_PASTI.CAUSALE';Obbligatorio:'N'),
     (Padre:'T350_REGREPERIB.CODICE';Figlio:'T380_PIANIFREPERIB.TURNO1';Obbligatorio:'N'),
     (Padre:'T350_REGREPERIB.CODICE';Figlio:'T380_PIANIFREPERIB.TURNO2';Obbligatorio:'N'),
     (Padre:'T350_REGREPERIB.CODICE';Figlio:'T380_PIANIFREPERIB.TURNO3';Obbligatorio:'N'),
     (Padre:'T361_OROLOGI.CODICE';Figlio:'T100_TIMBRATURE.RILEVATORE';Obbligatorio:'N'),
     (Padre:'T450_TIPORAPPORTO.CODICE';Figlio:'T430_STORICO.TIPORAPPORTO';Obbligatorio:'N'),
     (Padre:'T460_PARTTIME.CODICE';Figlio:'T430_STORICO.PARTTIME';Obbligatorio:'N'),
     (Padre:'T670_REGOLEBUONI.CODICE';Figlio:'T670_REGOLEBUONI.CODICE';Obbligatorio:'N'),
     (Padre:'M010_PARAMETRICONTEGGIO.CODICE';Figlio:'M065_TARIFFE_INDENNITA.CODICE';Obbligatorio:'N'),
     (Padre:'M010_PARAMETRICONTEGGIO.CODICE';Figlio:'M066_RIDUZIONI.CODICE';Obbligatorio:'N'),
     (Padre:'M065_TARIFFE_INDENNITA.COD_TARIFFA';Figlio:'M066_RIDUZIONI.COD_TARIFFA';Obbligatorio:'N'),
     (Padre:'M040_MISSIONI.TIPOREGISTRAZIONE';Figlio:'M011_TIPOMISSIONE.CODICE';Obbligatorio:'N'),
     (Padre:'M020_TIPIRIMBORSI.CODICE';Figlio:'M170_RICHIESTE_MEZZI.CODICE';Obbligatorio:'N'),
     (Padre:'M020_TIPIRIMBORSI.CODICE';Figlio:'M150_RICHIESTE_RIMBORSI.CODICE';Obbligatorio:'N'),
     (Padre:'M025_MOTIVAZIONI.CODICE';Figlio:'M175_RICHIESTE_MOTIVAZIONI.CODICE';Obbligatorio:'N'),
     (Padre:'M025_MOTIVAZIONI.CODICE';Figlio:'M160_RICHIESTE_ANTICIPI.CODICE';Obbligatorio:'N'),
     (Padre:'M140_RICHIESTE_MISSIONI.ID';Figlio:'M160_RICHIESTE_ANTICIPI.ID';Obbligatorio:'N'),
     (Padre:'M140_RICHIESTE_MISSIONI.ID';Figlio:'M150_RICHIESTE_RIMBORSI.ID';Obbligatorio:'N'),
     (Padre:'M140_RICHIESTE_MISSIONI.ID';Figlio:'M170_RICHIESTE_MEZZI.ID';Obbligatorio:'N'),
     (Padre:'M140_RICHIESTE_MISSIONI.ID';Figlio:'M175_RICHIESTE_MOTIVAZIONI.ID';Obbligatorio:'N')
     );

implementation

end.

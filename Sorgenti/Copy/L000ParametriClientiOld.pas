(*
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Budget}
  {$DEFINE Buonimensa}
  {$DEFINE Selser}
  {$DEFINE IndennitaTurno}
  {$DEFINE Incentivi}
  {$DEFINE PiantaOrganica}
  {$DEFINE MonitoraggioLog}
  {$DEFINE LiberaProfessione}
  {$DEFINE Missioni}

  {$DEFINE IntegrazioneFTP}
  {$DEFINE Eutron}
*)

{$DEFINE MONDOEDP}
//{$DEFINE DEMO}
//{$DEFINE BASE}
//{$DEFINE STATO_GIURIDICO}
//{$DEFINE ACQUAVIVADELLEFONTI_COMUNE}
//{$DEFINE ASOLA_COMUNE}
//{$DEFINE ASTI_ASL19}
//{$DEFINE ASTI_COGESA}
//{$DEFINE BAGHERIA_COMUNE}
//{$DEFINE BARI_AMGAS}
//{$DEFINE BARI_ASL1}
//{$DEFINE BARI_PROVINCIA}
//{$DEFINE BEINASCO_PORTA}
//{$DEFINE BEINASCO_VICTORIA}
//{$DEFINE BELLUNO_COMUNE}
//{$DEFINE BENEVENTO_ASL1}
//{$DEFINE BORGOSDALMAZZO_COMUNE}
//{$DEFINE BRESCIA_POLIAMBULANZA}
//{$DEFINE BRINDISI_ASL1}
//{$DEFINE BRUINO_COMUNE}
//{$DEFINE CAGLIARI_POLICLINICO}
//{$DEFINE CAGLIARI_PROVINCIA}
//{$DEFINE CALTAGIRONE_HGRAVINA}
//{$DEFINE CARBONIA_ASL7}
//{$DEFINE CASALEMONFERRATO_CASARIPOSO}
//{$DEFINE CASALROMANO_COMUNE}
//{$DEFINE CASNATEBERNATE_COMUNE}
//{$DEFINE CERTALDO_COMUNE}
//{$DEFINE CHIERI_COMUNE}
//{$DEFINE CHIUSAPESIO_HRICOVERO}
//{$DEFINE CHIVASSO_ASL7}
//{$DEFINE COMO_ASL}
//{$DEFINE CUNEO_CARCERE}
//{$DEFINE CUNEO_CSAC}
//{$DEFINE CUNEO_PROVVEDITORATO}
//{$DEFINE CUORGNE_COMUNE}
//{$DEFINE FOSSANO_CARCERE}
//{$DEFINE FIRENZE_ARDSU}
//{$DEFINE GENOVA_HGALLIERA}
//{$DEFINE GERMIGNAGA_COMUNE}
//{$DEFINE GRAVELLONATOCE_COMUNE}
//{$DEFINE GRUGLIASCO_CISAP}
//{$DEFINE GUIDIZZOLO_COMUNE}
//{$DEFINE IMPERIA_ASL1}
//{$DEFINE IVREA_ASL9}
//{$DEFINE JESI_ASL5}
//{$DEFINE LASPEZIA_ASL5}
//{$DEFINE LECCE_ASL1}
//{$DEFINE LEINI_COMUNE}
//{$DEFINE LOCOROTONDO_COMUNE}
//{$DEFINE MANTOVA_APAM}
//{$DEFINE MANTOVA_HPOMA}
//{$DEFINE MASSAROSA_COMUNE}
//{$DEFINE MELEGNANO_ASL2}
//{$DEFINE MELEGNANO_HPREDABISSI}
//{$DEFINE MESSINA_ASL5}
//{$DEFINE MILANO_HBESTA}
//{$DEFINE MILANO_HMAGGIORE}
//{$DEFINE MILANO_HSACCO}
//{$DEFINE MILANO_HSPAOLO}
//{$DEFINE MONCALIERI_ASL8}
//{$DEFINE MONSUMMANO_COMUNE}
//{$DEFINE MONZA_HSGERARDO}
//{$DEFINE NAPOLI_HPASCALE}
//{$DEFINE NARDO_COMUNE}
//{$DEFINE NOICATTARO_COMUNE}
//{$DEFINE ORBASSANO_HSLUIGI}
//{$DEFINE ORISTANO_ASL5}
//{$DEFINE OVADA_COMUNE}
//{$DEFINE PALERMO_ANAS}
//{$DEFINE PANTELLERIA_COMUNE}
//{$DEFINE PECETTOTORINESE_COMUNE}
//{$DEFINE PERUGIA_COMUNITAMONTANA}
//{$DEFINE PESARO_ASL1}
//{$DEFINE PESARO_HSSALVATORE}
//{$DEFINE PIETRASANTA_COMUNE}
//{$DEFINE PIEVEDISOLIGO_ASL7}
//{$DEFINE PINEROLO_ASL10}
//{$DEFINE PINOTORINESE_COMUNE}
//{$DEFINE PISTOIA_PROVINCIA}
//{$DEFINE POIRINO_COMUNE}
//{$DEFINE RIVAROLO_COMUNE}
//{$DEFINE ROMA_ASLC}
//{$DEFINE ROMA_CARCEREREBIBBIA}
//{$DEFINE ROMA_HSGIOVANNI}
//{$DEFINE ROSIGNANO_COMUNE}
//{$DEFINE ROVAGNATE_COMUNE}
//{$DEFINE SAINTMARCEL_COMUNE}
//{$DEFINE SANTENA_COMUNE}
//{$DEFINE SASSARI_ZOOPROFILATTICO}
//{$DEFINE SAVIGLIANO_ASL17}
//{$DEFINE SDONATOMILANESE_COMUNE}
//{$DEFINE SIENA_ARDSU}
//{$DEFINE SIENA_ASL7}
//{$DEFINE SIRACUSA_HUMBERTO}
//{$DEFINE SONDALO_HMORELLI}
//{$DEFINE SONDRIO_ASL}
//{$DEFINE SONDRIO_PROVINCIA}
//{$DEFINE SPIETROVERNOTICO_COMUNE}
//{$DEFINE STRAMBINO_COMUNE}
//{$DEFINE STRESA_COMUNE}
//{$DEFINE TORINO_ARPA}
//{$DEFINE TORINO_ASL2}
//{$DEFINE TORINO_ASL4}
//{$DEFINE TORINO_HCTO}
//{$DEFINE TORINO_HGRADENIGO}
//{$DEFINE TORINO_HMOLINETTE}
//{$DEFINE TORINO_HSANNA}
//{$DEFINE TORINO_OPENNET}
//{$DEFINE TORINO_PROVINCIA}
//{$DEFINE TORINO_ZOOPROFILATTICO}
//{$DEFINE TROFARELLO_COMUNE}
//{$DEFINE UMBRIA_REGIONE}
//{$DEFINE VADOLIGURE_COMUNE}
//{$DEFINE VARESE_ASL}
//{$DEFINE VENEGONOINFERIORE_COMUNE}
//{$DEFINE VENEZIA_IUAV}
//{$DEFINE VILLASTELLONE_COMUNE}
//{$DEFINE VOLTAMANTOVANA_COMUNE}

{$IFDEF MONDOEDP}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Budget}
  {$DEFINE Buonimensa}
  {$DEFINE Selser}
  {$DEFINE IndennitaTurno}
  {$DEFINE Incentivi}
  {$DEFINE PiantaOrganica}
  {$DEFINE MonitoraggioLog}
  {$DEFINE LiberaProfessione}
  {$DEFINE Missioni}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF DEMO}
  L000NumeroMaxDipendenti = 20;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Budget}
  {$DEFINE Buonimensa}
  {$DEFINE Selser}
  {$DEFINE IndennitaTurno}
  {$DEFINE Incentivi}
  {$DEFINE PiantaOrganica}
  {$DEFINE MonitoraggioLog}
  {$DEFINE LiberaProfessione}
  {$DEFINE Missioni}
{$ENDIF}

{$IFDEF BASE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF STATO_GIURIDICO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Selser}
  {$DEFINE MonitoraggioLog}
{$ENDIF}

{$IFDEF ACQUAVIVADELLEFONTI_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Città di Acquaviva delle Fonti';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF ASOLA_COMUNE}
  L000NumeroMaxDipendenti = 80;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Comune di Asola';
{$ENDIF}

{$IFDEF ASTI_ASL19}
  L000NumeroMaxDipendenti = 100;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Selser}
  {$DEFINE Reperibilita}
  {$DEFINE Budget}
  {$DEFINE Pasti}
  {$DEFINE Buonimensa}
  {$DEFINE Turni}
  {$DEFINE IntegrazioneFTP}
  {$DEFINE IndennitaTurno}
  {$DEFINE Incentivi}
  {$DEFINE MonitoraggioLog}
{$ENDIF}

{$IFDEF ASTI_COGESA}
  L000NumeroMaxDipendenti = 100;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'CO.GE.SA.';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF BAGHERIA_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Buonimensa}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF BARI_AMGAS}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'A.S.GAS';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF BARI_ASL1}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'AUSL BA/1';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Buonimensa}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF BARI_PROVINCIA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Provincia di Bari';
  {$DEFINE Eutron}
  {$DEFINE Reperibilita}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF BEINASCO_PORTA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF BEINASCO_VICTORIA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF BELLUNO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Turni}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF BENEVENTO_ASL1}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF BORGOSDALMAZZO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF BRESCIA_POLIAMBULANZA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'CONGREG. SUORE ANCELLE DELLA CARITA'' - CASA DI CURA POLIAMBULANZA   Posizioni assicurative: 34060168/69 34127962/61';
{$ENDIF}

{$IFDEF BRINDISI_ASL1}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Azienda Unità Sanitaria Locale BR/1';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF BRUINO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF CAGLIARI_POLICLINICO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF CAGLIARI_PROVINCIA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Provincia di Cagliari';
{$ENDIF}

{$IFDEF CALTAGIRONE_HGRAVINA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF CARBONIA_ASL7}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Pasti}
{$ENDIF}

{$IFDEF CASALEMONFERRATO_CASARIPOSO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF CASALROMANO_COMUNE}
  L000NumeroMaxDipendenti = 80;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Comune di Casalromano';
{$ENDIF}

{$IFDEF CASNATEBERNATE_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF CERTALDO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF CHIERI_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF CHIUSAPESIO_HRICOVERO}
  L000NumeroMaxDipendenti = 100;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Ospedale Ricovero di Chiusa di Pesio';
{$ENDIF}

{$IFDEF CHIVASSO_ASL7}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE PiantaOrganica}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF COMO_ASL}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE MonitoraggioLog}
  {$DEFINE Reperibilita}
  {$DEFINE Budget}
  {$DEFINE Pasti}
{$ENDIF}

{$IFDEF CUNEO_CARCERE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF CUNEO_CSAC}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
  {$DEFINE Turni}
{$ENDIF}

{$IFDEF CUNEO_PROVVEDITORATO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Provveditorato agli studi di Cuneo';
{$ENDIF}

{$IFDEF CUORGNE_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF FOSSANO_CARCERE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF FIRENZE_ARDSU}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Buonimensa}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF GENOVA_HGALLIERA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Selser}
  {$DEFINE Turni}
{$ENDIF}

{$IFDEF  GERMIGNAGA_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}


{$IFDEF GRAVELLONATOCE_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF GRUGLIASCO_CISAP}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF GUIDIZZOLO_COMUNE}
  L000NumeroMaxDipendenti = 80;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Comune di Guidizzolo';
{$ENDIF}

{$IFDEF IMPERIA_ASL1}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Budget}
  {$DEFINE Selser}
  {$DEFINE Incentivi}
  {$DEFINE LiberaProfessione}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF IVREA_ASL9}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Budget}
  {$DEFINE Selser}
  {$DEFINE PiantaOrganica}
{$ENDIF}

{$IFDEF JESI_ASL5}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF LASPEZIA_ASL5}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE IndennitaTurno}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF LECCE_ASL1}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE MonitoraggioLog}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF LEINI_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
  {$DEFINE Turni}
{$ENDIF}

{$IFDEF LOCOROTONDO_COMUNE}
  L000NumeroMaxDipendenti = 150;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Comune di Locorotondo';
{$ENDIF}

{$IFDEF MANTOVA_APAM}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF MANTOVA_HPOMA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE PiantaOrganica}
  {$DEFINE MonitoraggioLog}
{$ENDIF}

{$IFDEF MASSAROSA_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF MELEGNANO_ASL2}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE Pasti}
  {$DEFINE Budget}
  {$DEFINE Buonimensa}
  {$DEFINE MonitoraggioLog}
{$ENDIF}

{$IFDEF MELEGNANO_HPREDABISSI}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF MESSINA_ASL5}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF MILANO_HBESTA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Budget}
  {$DEFINE Selser}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF MILANO_HMAGGIORE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Selser}
  {$DEFINE MonitoraggioLog}
{$ENDIF}

{$IFDEF MILANO_HSACCO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF MILANO_HSPAOLO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE Pasti}
  {$DEFINE Reperibilita}
  {$DEFINE Buonimensa}
  {$DEFINE MonitoraggioLog}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF MONCALIERI_ASL8}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE PiantaOrganica}
{$ENDIF}

{$IFDEF MONSUMMANO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF MONZA_HSGERARDO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Budget}
  {$DEFINE Selser}
  {$DEFINE IndennitaTurno}
  {$DEFINE Incentivi}
  {$DEFINE MonitoraggioLog}
{$ENDIF}

{$IFDEF NAPOLI_HPASCALE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Buonimensa}
  {$DEFINE MonitoraggioLog}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF NARDO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Città di Nardo''';
  {$DEFINE Eutron}
  {$DEFINE Buonimensa}
{$ENDIF}

{$IFDEF NOICATTARO_COMUNE}
  L000NumeroMaxDipendenti = 150;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Comune di Noicattaro';
{$ENDIF}

{$IFDEF ORBASSANO_HSLUIGI}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Selser}
  {$DEFINE PiantaOrganica}
  {$DEFINE MonitoraggioLog}
  {$DEFINE LiberaProfessione}
{$ENDIF}

{$IFDEF ORISTANO_ASL5}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF OVADA_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
  {$DEFINE Selser}
  {$DEFINE Reperibilita}
{$ENDIF}

{$IFDEF PALERMO_ANAS}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF PANTELLERIA_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF PECETTOTORINESE_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF PERUGIA_COMUNITAMONTANA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Comunità montana monti del Trasimeno';
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF PESARO_ASL1}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF PESARO_HSSALVATORE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
{$ENDIF}

{$IFDEF PIETRASANTA_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF PIEVEDISOLIGO_ASL7}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Budget}
  {$DEFINE Selser}
  {$DEFINE IndennitaTurno}
{$ENDIF}

{$IFDEF PINEROLO_ASL10}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE PiantaOrganica}
{$ENDIF}

{$IFDEF PINOTORINESE_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF PISTOIA_PROVINCIA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Buonimensa}
  {$DEFINE Selser}
  {$DEFINE Missioni}
{$ENDIF}

{$IFDEF POIRINO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF RIVAROLO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF ROMA_ASLC}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Budget}
  {$DEFINE Buonimensa}
  {$DEFINE Selser}
  {$DEFINE MonitoraggioLog}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF ROMA_CARCEREREBIBBIA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF ROMA_HSGIOVANNI}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Budget}
  {$DEFINE Selser}
  {$DEFINE IndennitaTurno}
  {$DEFINE MonitoraggioLog}
  {$DEFINE IntegrazioneFTP}
{$ENDIF}

{$IFDEF ROSIGNANO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF ROVAGNATE_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF SAINTMARCEL_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF SANTENA_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF SASSARI_ZOOPROFILATTICO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Buonimensa}
{$ENDIF}

{$IFDEF SAVIGLIANO_ASL17}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF SDONATOMILANESE_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF SIENA_ARDSU}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE PiantaOrganica}
{$ENDIF}

{$IFDEF SIENA_ASL7}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Selser}
  {$DEFINE Pasti}
  {$DEFINE MonitoraggioLog}
{$ENDIF}

{$IFDEF SIRACUSA_HUMBERTO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF SONDALO_HMORELLI}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Buonimensa}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF SONDRIO_ASL}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF SONDRIO_PROVINCIA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF SPIETROVERNOTICO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Comune di San Pietro Vernotico';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF STRAMBINO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF STRESA_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Eutron}
{$ENDIF}

{$IFDEF TORINO_ARPA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Buonimensa}
  {$DEFINE MonitoraggioLog}
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF TORINO_ASL2}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Selser}
  {$DEFINE Pasti}
{$ENDIF}

{$IFDEF TORINO_ASL4}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Turni}
  {$DEFINE Budget}
  {$DEFINE Selser}
  {$DEFINE MonitoraggioLog}
{$ENDIF}

{$IFDEF TORINO_HCTO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Budget}
  {$DEFINE PiantaOrganica}
{$ENDIF}

{$IFDEF TORINO_HGRADENIGO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Selser}
  {$DEFINE Budget}
  {$DEFINE MonitoraggioLog}
  {$DEFINE Turni}
{$ENDIF}

{$IFDEF TORINO_HMOLINETTE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Budget}
  {$DEFINE Selser}
  {$DEFINE MonitoraggioLog}
{$ENDIF}

{$IFDEF TORINO_HSANNA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Turni}
  {$DEFINE Budget}
  {$DEFINE Selser}
  {$DEFINE MonitoraggioLog}
{$ENDIF}

{$IFDEF TORINO_OPENNET}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF TORINO_PROVINCIA}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Budget}
  {$DEFINE Selser}
  {$DEFINE Buonimensa}
  {$DEFINE MonitoraggioLog}
{$ENDIF}

{$IFDEF TORINO_ZOOPROFILATTICO}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Budget}
  {$DEFINE Buonimensa}
  {$DEFINE Selser}
  {$DEFINE PiantaOrganica}
{$ENDIF}

{$IFDEF TROFARELLO_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Buonimensa}
  {$DEFINE Selser}
{$ENDIF}


{$IFDEF UMBRIA_REGIONE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Selser}
{$ENDIF}

{$IFDEF VADOLIGURE_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF VARESE_ASL}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Reperibilita}
  {$DEFINE Pasti}
  {$DEFINE Selser}
  {$DEFINE BuoniMensa}
{$ENDIF}

{$IFDEF VENEGONOINFERIORE_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF VENEZIA_IUAV}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
  {$DEFINE Turni}
  {$DEFINE Budget}
  {$DEFINE Buonimensa}
{$ENDIF}

{$IFDEF VILLASTELLONE_COMUNE}
  L000NumeroMaxDipendenti = -1;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = '';
{$ENDIF}

{$IFDEF VOLTAMANTOVANA_COMUNE}
  L000NumeroMaxDipendenti = 80;
  L000NumeroMaxSessioni = -1;
  L000RagioneSociale = 'Comune di Volta Mantovana';
{$ENDIF}


unit A077UGeneratoreStampeMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, R003UGeneratoreStampeMW,
  Oracle, Data.DB, OracleData, C180FunzioniGenerali;

type
  TA077FGeneratoreStampeMW = class(TR003FGeneratoreStampeMW)
    Ins920_1: TOracleQuery;
    Ins920_2: TOracleQuery;
    Ins920_3: TOracleQuery;
    Ins920_4: TOracleQuery;
    Ins920_5: TOracleQuery;
    Ins920_6: TOracleQuery;
    Ins920_7: TOracleQuery;
    Ins920_8: TOracleQuery;
    Ins920_9: TOracleQuery;
    Ins920_10: TOracleQuery;
    Ins920_11: TOracleQuery;
    Ins920_12: TOracleQuery;
    Ins920_13: TOracleQuery;
    Ins920_14: TOracleQuery;
    Ins920_15: TOracleQuery;
    Ins920_16: TOracleQuery;
    Ins920_17: TOracleQuery;
    Ins920_18: TOracleQuery;
    Ins920_19: TOracleQuery;
    Ins920_20: TOracleQuery;
    Ins920_21: TOracleQuery;
    Ins920_22: TOracleQuery;
    Ins920_23: TOracleQuery;
    Ins920_24: TOracleQuery;
    Ins920_25: TOracleQuery;
    selT162: TOracleDataSet;
    selM020: TOracleDataSet;
    seldistT195: TOracleDataSet;
    selT240: TOracleDataSet;
    selSG650: TOracleDataSet;
    selT241: TOracleDataSet;
    Ins920_26: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  protected
    procedure CaricaDatiRiep; override;
    procedure CaricaSerbatoi; override;
    procedure CaricaTabelleCollegate; override;
  public
    function getListAssenze: TStringList;
    function getListPresenze: TStringList;
    function getListIndPresenza: TStringList;
    function getListRimborsi: TStringList;
    function getListVociPaghe: TStringList;
    function getListOrgSindacali: TStringList;
    function getListCorsiFormazione(Tutto: Boolean; Anno: Integer): TStringList;
    function getListRecapitoSindacato: TStringList;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA077FGeneratoreStampeMW.CaricaDatiRiep;
var i:Integer;
const
  ConstDatiRiep:array[0..1040] of TRiep = (
      //Consuntivi orari: X = 5 (1..133)
      (N:0117;R:002;W:10;T:1;F:0;M:5;X:05;KC:0;Fex:'N';D:'Progressivo5'),
      (N:0102;R:002;W:10;T:1;F:3;M:5;X:05;KC:1;Fex:'N';D:'Data riepilogo mensile'),
      (N:0103;R:002;W:10;T:1;F:0;M:5;X:05;KC:1;Fex:'N';D:'Anno riepilogo mensile'),
      (N:0001;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Debito contrattuale'),
      (N:0002;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Debito aggiuntivo'),
      (N:0123;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Debito aggiuntivo annuo'),
      (N:0124;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Debito aggiuntivo residuo'),
      (N:0125;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Debito aggiuntivo reso mese'),
      (N:0126;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Debito aggiuntivo reso anno'),
      (N:0003;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Debito mensile'),
      (N:0004;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore rese fascia 1'),
      (N:0005;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore rese fascia 2'),
      (N:0006;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore rese fascia 3'),
      (N:0007;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore rese fascia 4'),
      (N:0008;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore rese totali'),
      (N:0120;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore rese INAIL'),
      (N:0009;R:002;W:06;T:1;F:0;M:5;X:05;KC:1;Fex:'N';D:'Causale assestamento 1'),
      (N:0010;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Assestamento 1 fascia 1'),
      (N:0011;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Assestamento 1 fascia 2'),
      (N:0012;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Assestamento 1 fascia 3'),
      (N:0013;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Assestamento 1 fascia 4'),
      (N:0014;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Assestamento 1 totale'),
      (N:0015;R:002;W:06;T:1;F:0;M:5;X:05;KC:1;Fex:'N';D:'Causale assestamento 2'),
      (N:0016;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Assestamento 2 fascia 1'),
      (N:0017;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Assestamento 2 fascia 2'),
      (N:0018;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Assestamento 2 fascia 3'),
      (N:0019;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Assestamento 2 fascia 4'),
      (N:0020;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Assestamento 2 totale'),
      (N:0021;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore in turno fascia 1'),
      (N:0022;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore in turno fascia 2'),
      (N:0023;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore in turno fascia 3'),
      (N:0024;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore in turno fascia 4'),
      (N:0025;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore in turno totali'),
      (N:0026;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore rese da presenza'),
      (N:0027;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore rese da presenza fascia 1'),
      (N:0028;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore rese da assenza'),
      (N:0029;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo mese netto'),
      (N:0030;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo mese lordo'),
      (N:0031;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo mese liquidato'),
      (N:0032;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo al mese precedente'),
      (N:0033;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo al mese prec.netto'),
      (N:0034;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo anno precedente'),
      (N:0035;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo anno corrente'),
      (N:0036;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo anno totale'),
      (N:0037;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo complessivo netto'),
      (N:0038;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Comp. anno precedente'),
      (N:0039;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liq. anno precedente'),
      (N:0040;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Comp. anno corrente'),
      (N:0041;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liq. anno corrente'),
      (N:0042;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Comp+Liq anno prec.'),
      (N:0043;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Comp+Liq anno corr.'),
      (N:0044;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Compensabile complessivo'),
      (N:0106;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo anno liquidato'),
      (N:0107;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Variazioni saldo anno'),
      (N:0108;R:002;W:06;T:1;F:3;M:5;X:05;KC:0;Fex:'N';D:'Data di variazione saldo anno'),
      (N:0109;R:002;W:20;T:1;F:0;M:5;X:05;KC:0;Fex:'N';D:'Note di variazione saldo anno'),
      (N:0045;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Recupero anno precedente'),
      (N:0046;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Recupero anno corrente'),
      (N:0047;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Debito P.O. anno'),
      (N:0048;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'P.O. reso'),
      (N:0049;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo P.O. anno'),
      (N:0050;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str.fatto mese fascia 1'),
      (N:0051;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str.fatto mese fascia 2'),
      (N:0052;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str.fatto mese fascia 3'),
      (N:0053;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str.fatto mese fascia 4'),
      (N:0054;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str.fatto mese totale'),
      (N:0055;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. dal mese fascia 1'),
      (N:0056;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. dal mese fascia 2'),
      (N:0057;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. dal mese fascia 3'),
      (N:0058;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. dal mese fascia 4'),
      (N:0059;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. dal mese totale'),
      (N:0060;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. nel mese fascia 1'),
      (N:0061;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. nel mese fascia 2'),
      (N:0062;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. nel mese fascia 3'),
      (N:0063;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. nel mese fascia 4'),
      (N:0064;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. nel mese totale'),
      (N:0065;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str. fatto anno fascia 1'),
      (N:0066;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str. fatto anno fascia 2'),
      (N:0067;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str. fatto anno fascia 3'),
      (N:0068;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str. fatto anno fascia 4'),
      (N:0069;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str. fatto anno totale'),
      (N:0070;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. nell''anno fascia 1'),
      (N:0071;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. nell''anno fascia 2'),
      (N:0072;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. nell''anno fascia 3'),
      (N:0073;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. nell''anno fascia 4'),
      (N:0074;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Liquid. nell''anno totale'),
      (N:0075;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str. da liquidare fascia 1'),
      (N:0076;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str. da liquidare fascia 2'),
      (N:0077;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str. da liquidare fascia 3'),
      (N:0078;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str. da liquidare fascia 4'),
      (N:0079;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Str. da liquidare totale'),
      (N:0080;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ecc.comp. nel mese'),
      (N:0081;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ecc.comp. nell''anno'),
      (N:0082;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ecc.comp.residua'),
      (N:0121;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ecc.comp.mensile residua'),
      (N:0083;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore fascia 1'),
      (N:0084;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore fascia 2'),
      (N:0085;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore fascia 3'),
      (N:0086;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore fascia 4'),
      (N:0087;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore totale'),
      (N:0088;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore liquidata nel mese'),
      (N:0129;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore liq. mese (variazione)'),
      (N:0089;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore liquidata nell''anno'),
      (N:0110;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore recuperata nel mese'),
      (N:0111;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore recuperata nell''anno'),
      (N:0130;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore rec.intern.nel mese'),
      (N:0112;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore dell''anno'),
      (N:0090;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore residua'),
      (N:0113;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Banca ore anno prec.'),
      (N:0091;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore addebitate alle paghe'),
      (N:0127;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore carenti oltre saldo neg.min.'),
      (N:0128;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore oltre saldo neg.min.recuperate'),
      (N:0116;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Negativi non recuperati'),
      (N:0092;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore perse periodicamente'),
      (N:0093;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore escluse compensabili'),
      (N:0094;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore compensabili troncate'),
      (N:0131;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Saldo neg. recuperato con riep. ass.'),
      (N:0095;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Straord. max mensile'),
      (N:0096;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ecced.residua autorizzata'),
      (N:0114;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Straord. max mensile teorico'),
      (N:0115;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ecced.residua autorizzata teorica'),
      (N:0097;R:003;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Residuo ore anno prec.'),
      (N:0098;R:003;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Residuo ecc.comp. anno prec.'),
      (N:0122;R:003;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Residuo liquidabile a fine anno'),
      (N:0099;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Riposi compensativi maturati'),
      (N:0100;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Riposi compensativi abbattuti'),
      (N:0101;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Riposi compensativi residui'),
      (N:0104;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Riposi compensativi del mese'),
      (N:0105;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Riposi compensativi mese prec.'),
      (N:0118;R:002;W:07;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Riposi non fruiti GG'),
      (N:0119;R:002;W:07;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Riposi non fruiti Ore'),
      (N:0131;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore permessi addebitate'),
      (N:0132;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ore permessi da recuperare'),

      //Indennità/varie X = 5 (201..242)
      (N:0201;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Giorni di presenza'),
      (N:0202;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Giorni vuoti'),
      (N:0203;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Primi turni'),
      (N:0204;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Secondi turni'),
      (N:0205;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Terzi turni'),
      (N:0206;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Quarti turni'),
      (N:0207;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ind.festive intere'),
      (N:0208;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ind.festive ridotte'),
      (N:0209;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ind.notturna gg'),
      (N:0210;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ind.notturna ore'),
      (N:0219;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ind.festive intere calc.'),
      (N:0220;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ind.festive ridotte calc.'),
      (N:0221;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ind.notturna gg calc.'),
      (N:0222;R:002;W:06;T:0;F:2;M:5;X:05;KC:0;Fex:'N';D:'Ind.notturna ore calc.'),
      (N:0217;R:002;W:03;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Festivi non goduti'),
      (N:0218;R:003;W:06;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ind.presenza totali'),
      (N:0213;R:003;W:06;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Rientri pom. teorici dovuti'),
      (N:0214;R:003;W:06;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Rientri pom. reali dovuti'),
      (N:0215;R:003;W:06;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Rientri pom. resi'),
      (N:0216;R:003;W:06;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Saldo rientri pom.'),
      (N:0223;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Buoni pasto maturati'),
      (N:0224;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Buoni pasto variati'),
      (N:0225;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Buoni pasto acquistati'),
      (N:0226;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Buoni pasto residui'),
      (N:0211;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Buoni pasto recuperati'),
      (N:0234;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Buoni pasto anno prec.'),
      (N:0236;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Buoni maturati totali'),
      (N:0237;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Buoni acquistati totali'),
      (N:0227;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ticket maturati'),
      (N:0228;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ticket variati'),
      (N:0229;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ticket acquistati'),
      (N:0230;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ticket residui'),
      (N:0212;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ticket recuperati'),
      (N:0235;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ticket anno prec.'),
      (N:0238;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ticket maturati totali'),
      (N:0239;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Ticket acquistati totali'),
      (N:0240;R:003;W:10;T:0;F:3;M:5;X:05;KC:0;Fex:'N';D:'Fornitura Buoni pasto acquistati'),
      (N:0241;R:003;W:15;T:0;F:0;M:5;X:05;KC:0;Fex:'N';D:'Blocchetti acquistati'),
      (N:0242;R:003;W:15;T:0;F:0;M:5;X:05;KC:0;Fex:'N';D:'Note acquisto Buoni/Ticket'),
      (N:0231;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Numero pasti'),
      (N:0232;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Pasti convenzionati'),
      (N:0233;R:003;W:04;T:0;F:1;M:5;X:05;KC:0;Fex:'N';D:'Pasti interi'),
      //Turni reperibilità: X = 9 (300..314)
      (N:0300;R:012;W:06;T:1;F:0;M:9;X:09;KC:0;Fex:'N';D:'Progressivo9'),
      (N:0301;R:012;W:10;T:1;F:3;M:9;X:09;KC:1;Fex:'N';D:'IR_Data'),
      (N:0302;R:012;W:06;T:1;F:0;M:9;X:09;KC:1;Fex:'N';D:'IR_Anno'),
      (N:0303;R:012;W:06;T:1;F:0;M:9;X:09;KC:1;Fex:'N';D:'IR_VP_Turno'),
      (N:0304;R:012;W:06;T:1;F:0;M:9;X:09;KC:1;Fex:'N';D:'IR_VP_Spezzoni'),
      (N:0305;R:012;W:06;T:1;F:0;M:9;X:09;KC:1;Fex:'N';D:'IR_VP_Ore maggiorate'),
      (N:0306;R:012;W:06;T:1;F:0;M:9;X:09;KC:1;Fex:'N';D:'IR_VP_Ore non magg.'),
      (N:0311;R:012;W:06;T:1;F:0;M:9;X:09;KC:1;Fex:'N';D:'IR_VP_Turni oltre max'),
      (N:0312;R:012;W:06;T:1;F:0;M:9;X:09;KC:1;Fex:'N';D:'IR_VP_Gettone chiamata'),
      (N:0307;R:012;W:03;T:0;F:1;M:9;X:09;KC:0;Fex:'N';D:'Reperibilita turni'),
      (N:0308;R:012;W:06;T:0;F:2;M:9;X:09;KC:0;Fex:'N';D:'Reperibilita spezzoni'),
      (N:0309;R:012;W:06;T:0;F:2;M:9;X:09;KC:0;Fex:'N';D:'Reperibilita ore maggiorate'),
      (N:0310;R:012;W:06;T:0;F:2;M:9;X:09;KC:0;Fex:'N';D:'Reperibilita ore non magg.'),
      (N:0313;R:012;W:03;T:0;F:1;M:9;X:09;KC:0;Fex:'N';D:'Reperibilita turni oltre max'),
      (N:0314;R:012;W:03;T:0;F:1;M:9;X:09;KC:0;Fex:'N';D:'Reperibilita gettone chiamata'),
      //Indennità di presenza X = 1 (400..408)
      (N:0400;R:004;W:08;T:1;F:0;M:1;X:01;KC:0;Fex:'S';D:'Progressivo1'),
      (N:0401;R:004;W:07;T:1;F:0;M:1;X:01;KC:1;Fex:'N';D:'Cod.Ind.presenza'),
      (N:0402;R:004;W:07;T:1;F:0;M:1;X:01;KC:0;Fex:'N';D:'Desc.Ind.presenza'),
      (N:0403;R:004;W:10;T:1;F:3;M:1;X:01;KC:1;Fex:'N';D:'Data Ind.presenza'),
      (N:0404;R:004;W:10;T:1;F:0;M:1;X:01;KC:1;Fex:'N';D:'Anno Ind.presenza'),
      (N:0405;R:004;W:07;T:1;F:0;M:1;X:01;KC:1;Fex:'N';D:'Importo Ind.presenza'),
      (N:0406;R:004;W:07;T:0;F:1;M:1;X:01;KC:0;Fex:'N';D:'Numero Ind.presenza'),
      (N:0408;R:004;W:07;T:0;F:1;M:1;X:01;KC:0;Fex:'N';D:'Resto Ind.presenza'),
      (N:0407;R:004;W:07;T:0;F:1;M:1;X:01;KC:0;Fex:'N';D:'Costo Ind.presenza'),
      //Dati anagrafici: X = 0 (500..799)
      (N:0500;R:001;W:05;T:0;F:1;M:0;X:00;KC:0;Fex:'N';D:'Num ordine'),
      (N:0501;R:001;W:10;T:0;F:3;M:0;X:00;KC:0;Fex:'N';D:'Fine periodo prova'),
      (N:0502;R:001;W:10;T:0;F:3;M:0;X:00;KC:0;Fex:'N';D:'Metà periodo prova'),
      (N:0503;R:001;W:80;T:0;F:0;M:0;X:00;KC:0;Fex:'N';D:'CDCPerc_Codice'),
      (N:0504;R:001;W:80;T:0;F:0;M:0;X:00;KC:0;Fex:'N';D:'CDCPerc_Descrizione'),
      (N:0505;R:001;W:05;T:0;F:0;M:0;X:00;KC:0;Fex:'N';D:'CDCPerc_Percentuale'),
      (N:0506;R:001;W:05;T:0;F:1;M:0;X:00;KC:0;Fex:'N';D:'P430PERC_IRPEF_TASS_SEP'),
      (N:0507;R:001;W:200;T:0;F:0;M:0;X:00;KC:0;Fex:'N';D:'I060EMAIL'),
      (N:0508;R:001;W:200;T:0;F:0;M:0;X:00;KC:0;Fex:'N';D:'I060EMAIL_PEC'),
      (N:0509;R:001;W:200;T:0;F:0;M:0;X:00;KC:0;Fex:'N';D:'I060CELLULARE'),
      //Dati giornalieri: X = 4 (800..926) - Liberi:
      (N:0800;R:008;W:08;T:1;F:0;M:4;X:04;KC:0;Fex:'S';D:'Progressivo4'),
      (N:0801;R:008;W:08;T:1;F:3;M:4;X:04;KC:1;Fex:'S';D:'Data conteggio'),
      (N:0802;R:008;W:08;T:1;F:0;M:4;X:04;KC:1;Fex:'S';D:'Anno conteggio'),
      (N:0803;R:008;W:08;T:1;F:0;M:4;X:04;KC:1;Fex:'S';D:'Mese conteggio'),
      (N:0804;R:008;W:08;T:1;F:3;M:4;X:04;KC:1;Fex:'S';D:'Settimana conteggio'),
      (N:0805;R:008;W:02;T:1;F:0;M:4;X:04;KC:1;Fex:'N';D:'GG lavorativo'),
      (N:0806;R:008;W:02;T:1;F:0;M:4;X:04;KC:1;Fex:'N';D:'GG festivo'),
      (N:0807;R:008;W:02;T:1;F:0;M:4;X:04;KC:1;Fex:'N';D:'Rilevatori del giorno'),
      (N:0808;R:008;W:20;T:1;F:0;M:4;X:04;KC:0;Fex:'S';D:'Timbrature effettive'),
      (N:0809;R:008;W:20;T:1;F:0;M:4;X:04;KC:0;Fex:'S';D:'Timbrature conteggiate'),
      (N:0810;R:008;W:20;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Timbrature nominali'),
      (N:0811;R:008;W:05;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Timbrature di mensa'),
      (N:0899;R:008;W:06;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Pasto intero'),
      (N:0900;R:008;W:06;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Pasto convenzionato'),
      (N:0922;R:008;W:06;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Buono pasto maturato'),
      (N:0812;R:008;W:12;T:1;F:0;M:4;X:04;KC:0;Fex:'S';D:'Giustificativi'),
      (N:0813;R:008;W:06;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'GG vuoto'),
      (N:0814;R:008;W:06;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Esistenza timbrature'),
      (N:0815;R:008;W:06;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'GG di presenza'),
      (N:0816;R:008;W:06;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Presenza pomeridiana'),
      (N:0817;R:008;W:10;T:1;F:0;M:4;X:04;KC:1;Fex:'N';D:'Anomalia bloccante'),
      (N:0818;R:008;W:05;T:1;F:0;M:4;X:04;KC:1;Fex:'N';D:'Modello orario'),
      (N:0829;R:008;W:04;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Turni non pianificati'),
      (N:0820;R:008;W:04;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Turni pianificati'),
      (N:0897;R:008;W:04;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Turni riconosciuti'),
      (N:0821;R:008;W:04;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Sigla turni'),
      (N:0822;R:008;W:05;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Livello pianificato'),
      (N:0823;R:008;W:05;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Indennità pianificate'),
      (N:0824;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Debito gg'),
      (N:0825;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Debito cartellino'),
      (N:0826;R:008;W:05;T:0;F:0;M:4;X:04;KC:1;Fex:'N';D:'Debito settimanale'),
      (N:0827;R:008;W:05;T:0;F:0;M:4;X:04;KC:1;Fex:'N';D:'Giorni lavorativi'),
      (N:0828;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Eccedenza compensabile'),
      (N:0829;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore da assenza'),
      (N:0830;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore da timbrature'),
      (N:0831;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore di presenza lorde'),
      (N:0832;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore rese'),
      (N:0833;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore rese 1'),
      (N:0834;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore rese 2'),
      (N:0835;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore rese 3'),
      (N:0836;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore rese 4'),
      (N:0837;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore escluse dalle normali'),
      (N:0838;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore rese fuori fascia'),
      (N:0839;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore obbligatorie rese'),
      (N:0840;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore obbligatorie carenti'),
      (N:0841;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore facoltative rese'),
      (N:0842;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore facoltative carenti'),
      (N:0843;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Carenza oraria coperta'),
      (N:0844;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore liquidabili'),
      (N:0845;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore liquidabili 1'),
      (N:0846;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore liquidabili 2'),
      (N:0847;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore liquidabili 3'),
      (N:0848;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore liquidabili 4'),
      (N:0849;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Scostamento'),
      (N:0850;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Scostamento negativo'),
      (N:0851;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Scostamento positivo'),
      (N:0852;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore maturate per pausa mensa'),
      (N:0853;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Detrazione pausa mensa'),
      (N:0903;R:008;W:05;T:0;F:0;M:4;X:04;KC:1;Fex:'N';D:'Tipo detr. pausa mensa'),
      (N:0854;R:008;W:02;T:1;F:0;M:4;X:04;KC:1;Fex:'N';D:'Pausa mensa gestita'),
      (N:0915;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Inizio pausa mensa'),
      (N:0916;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Fine pausa mensa'),
      (N:0855;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore per ind.festiva'),
      (N:0856;R:008;W:05;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Ind.festiva maturata'),
      (N:0857;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore di oggi per ind.presenza'),
      (N:0858;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore di ieri per ind.presenza'),
      (N:0859;R:008;W:05;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Ind.presenza maturata'),
      (N:0860;R:008;W:04;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Scavalco mezzanotte'),
      (N:0861;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ind.notturna maturata'),
      (N:0917;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore ind.turno'),
      (N:0918;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore ind.turno 1'),
      (N:0919;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore ind.turno 2'),
      (N:0920;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore ind.turno 3'),
      (N:0921;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore ind.turno 4'),
      (N:0898;R:008;W:05;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Festivita non goduta'),
      (N:0862;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore rese di mattina'),
      (N:0863;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Ore rese di pomeriggio'),
      (N:0909;R:008;W:05;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Rientro pomeridiano'),
      (N:0910;R:008;W:05;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Buono obbl. da rientro pom.'),
      (N:0911;R:008;W:05;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Buono suppl. da rientro pom.'),
      (N:0864;R:008;W:02;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Prima timbratura in uscita'),
      (N:0865;R:008;W:02;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Ultima timbratura in entrata'),
      (N:0866;R:008;W:02;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Esiste timbratura precedente'),
      (N:0867;R:008;W:02;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Esiste timbratura successiva'),
      (N:0868;R:008;W:02;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Ind.pres.da assenza'),
      (N:0869;R:008;W:06;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'GG in servizio'),
      (N:0870;R:008;W:06;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'GG lav.in servizio'),
      (N:0871;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Abbattimento anno prec.'),
      (N:0872;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Abbattimento anno att.'),
      (N:0873;R:008;W:12;T:0;F:4;M:4;X:04;KC:0;Fex:'N';D:'Riepilogo ore causalizzate'),
      (N:0874;R:008;W:12;T:0;F:4;M:4;X:04;KC:0;Fex:'N';D:'Riepilogo ore assenza'),
      (N:0875;R:008;W:05;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Causali presenza'),
      (N:0876;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore di presenza causalizzate'),
      (N:0904;R:008;W:40;T:0;F:0;M:4;X:04;KC:0;Fex:'N';D:'Ore caus.a blocchi'),
      (N:0877;R:008;W:05;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Causali assenza'),
      (N:0878;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore di assenza causalizzate'),
      (N:0879;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Ore di assenza rese'),
      (N:0880;R:008;W:05;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Turni reperibilita'),
      (N:0881;R:008;W:05;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Turni reperib.:liv.pianif.'),
      (N:0882;R:008;W:11;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Libera professione'),
      (N:0883;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Prolungamento inibito'),
      (N:0905;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Prolungamento in E inibito'),
      (N:0906;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Prolungamento in U inibito'),
      (N:0884;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Prolungamento non causalizz.'),
      (N:0907;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Prolungamento in E non causalizz.'),
      (N:0908;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Prolungamento in U non causalizz.'),
      (N:0896;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Prolungamento in uscita non caus.'),
      (N:0885;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Prolungamento non conteggiato'),
      (N:0886;R:008;W:03;T:1;F:0;M:4;X:04;KC:1;Fex:'N';D:'Rilevatore'),
      (N:0887;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Rilevatore:ore rese'),
      (N:0888;R:008;W:05;T:1;F:0;M:4;X:04;KC:1;Fex:'N';D:'Assenza:causale'),
      (N:0889;R:008;W:20;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Assenza:descrizione'),
      (N:0901;R:008;W:16;T:0;F:3;M:4;X:04;KC:1;Fex:'N';D:'Assenza:data familiare'),
      (N:0902;R:008;W:05;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Assenza:U.M.Fruizione'),
      (N:0890;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Assenza:ore rese'),
      (N:0891;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Assenza:ore valenza'),
      (N:0923;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Assenza:fruiz.competenze'),
      (N:0892;R:008;W:05;T:0;F:1;M:4;X:04;KC:0;Fex:'N';D:'Assenza:giornate'),
      (N:0893;R:008;W:05;T:1;F:0;M:4;X:04;KC:1;Fex:'N';D:'Presenza:causale'),
      (N:0894;R:008;W:20;T:1;F:0;M:4;X:04;KC:0;Fex:'N';D:'Presenza:descrizione'),
      (N:0895;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Presenza:ore rese'),
      (N:0917;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Presenza:ore rese 1'),
      (N:0918;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Presenza:ore rese 2'),
      (N:0919;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Presenza:ore rese 3'),
      (N:0920;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'S';D:'Presenza:ore rese 4'),
      (N:0819;R:008;W:05;T:0;F:0;M:4;X:04;KC:1;Fex:'N';D:'Libera professione:causale'),
      (N:0914;R:008;W:20;T:0;F:0;M:4;X:04;KC:1;Fex:'N';D:'Libera professione:descrizione'),
      (N:0912;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Libera professione:ore pianif.'),
      (N:0913;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Libera professione:ore rese'),
      (N:0916;R:008;W:05;T:0;F:0;M:4;X:04;KC:1;Fex:'N';D:'Anomalie GG:ID'),
      (N:0917;R:008;W:05;T:0;F:0;M:4;X:04;KC:0;Fex:'N';D:'Anomalie GG:Livello'),
      (N:0918;R:008;W:05;T:0;F:0;M:4;X:04;KC:0;Fex:'N';D:'Anomalie GG:Numero'),
      (N:0919;R:008;W:30;T:0;F:0;M:4;X:04;KC:0;Fex:'N';D:'Anomalie GG:Descrizione'),
      (N:0924;R:008;W:10;T:1;F:0;M:4;X:04;KC:1;Fex:'N';D:'Convenzionati:struttura'),
      (N:0925;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Convenzionati:ore previste'),
      (N:0926;R:008;W:05;T:0;F:2;M:4;X:04;KC:0;Fex:'N';D:'Convenzionati:ore rese'),
      //Iscrizioni ai sindacati X = 11 (1000..1027)
      (N:1000;R:014;W:10;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'Progressivo11'),
      (N:1001;R:014;W:10;T:0;F:3;M:11;X:11;KC:1;Fex:'N';D:'IS_Data_Iscrizione'),
      (N:1002;R:014;W:06;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Prot_Iscrizione'),
      (N:1003;R:014;W:10;T:0;F:3;M:11;X:11;KC:0;Fex:'N';D:'IS_Decorrenza_Iscrizione'),
      (N:1004;R:014;W:10;T:0;F:3;M:11;X:11;KC:0;Fex:'N';D:'IS_Data_Cessazione'),
      (N:1005;R:014;W:10;T:0;F:3;M:11;X:11;KC:0;Fex:'N';D:'IS_Cessazione'),
      (N:1006;R:014;W:06;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Prot_Cessazione'),
      (N:1007;R:014;W:10;T:0;F:3;M:11;X:11;KC:0;Fex:'N';D:'IS_Decorrenza_Cessazione'),
      (N:1008;R:014;W:10;T:0;F:0;M:11;X:11;KC:1;Fex:'N';D:'IS_Sindacato'),
      (N:1009;R:014;W:20;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_D_Sindacato'),
      (N:1010;R:014;W:11;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Cod_Ministeriale'),
      (N:1011;R:014;W:06;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Vocepaghe'),
      (N:1012;R:014;W:01;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Rsu'),
      (N:1013;R:014;W:01;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Raggruppamento'),
      (N:1014;R:014;W:20;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Sind_Raggruppati'),
      (N:1015;R:014;W:01;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Tipo_Recapito'),
      (N:1016;R:014;W:20;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Rec_Descrizione'),
      (N:1017;R:014;W:20;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Indirizzo'),
      (N:1018;R:014;W:05;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Cap'),
      (N:1019;R:014;W:10;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Comune'),
      (N:1020;R:014;W:12;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Telefono'),
      (N:1021;R:014;W:12;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Fax'),
      (N:1022;R:014;W:20;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Rec_Cognome'),
      (N:1023;R:014;W:20;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Rec_Nome'),
      (N:1024;R:014;W:12;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Rec_Tel_Casa'),
      (N:1025;R:014;W:12;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Rec_Tel_Ufficio'),
      (N:1026;R:014;W:12;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Rec_Cellulare'),
      (N:1027;R:014;W:20;T:0;F:0;M:11;X:11;KC:0;Fex:'N';D:'IS_Rec_Email'),
      //Organizzazioni sindacali X = 12 (1100..1140) [prima era (1030..1066)]
      (N:1100;R:015;W:10;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'Progressivo12'),
      (N:1101;R:015;W:10;T:0;F:3;M:12;X:12;KC:1;Fex:'N';D:'OS_Data_Inizio'),
      (N:1102;R:015;W:10;T:0;F:3;M:12;X:12;KC:0;Fex:'N';D:'OS_Data_Fine'),
      (N:1103;R:015;W:05;T:0;F:0;M:12;X:12;KC:1;Fex:'N';D:'OS_Organismo'),
      (N:1104;R:015;W:20;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_D_Organismo'),
      (N:1105;R:015;W:01;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Fruizione_Permessi'),
      (N:1106;R:015;W:01;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Retribuito'),
      (N:1107;R:015;W:01;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Statutario'),
      (N:1108;R:015;W:01;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Abbatte_Competenze'),
      (N:1109;R:015;W:05;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Causale'),
      (N:1110;R:015;W:10;T:0;F:0;M:12;X:12;KC:1;Fex:'N';D:'OS_Sindacato'),
      (N:1111;R:015;W:20;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_D_Sindacato'),
      (N:1112;R:015;W:11;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Cod_Ministeriale'),
      (N:1113;R:015;W:06;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Vocepaghe'),
      (N:1114;R:015;W:01;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Rsu'),
      (N:1115;R:015;W:01;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Raggruppamento'),
      (N:1116;R:015;W:20;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Sind_Raggruppati'),
      (N:1117;R:015;W:11;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Sigla_Gedap'),
      (N:1118;R:015;W:08;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Competenze'),
      (N:1119;R:015;W:08;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Fruito'),
      (N:1120;R:015;W:08;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Residuo'),
      (N:1121;R:015;W:10;T:0;F:3;M:12;X:12;KC:0;Fex:'N';D:'OS_Competenze_Dal'),
      (N:1122;R:015;W:10;T:0;F:3;M:12;X:12;KC:0;Fex:'N';D:'OS_Competenze_Al'),
      (N:1123;R:015;W:08;T:0;F:2;M:12;X:12;KC:0;Fex:'N';D:'OS_Competenze_Ind'),
      (N:1124;R:015;W:08;T:0;F:2;M:12;X:12;KC:0;Fex:'N';D:'OS_Fruito_Ind'),
      (N:1125;R:015;W:08;T:0;F:2;M:12;X:12;KC:0;Fex:'N';D:'OS_Residuo_Ind'),
      (N:1126;R:015;W:10;T:0;F:3;M:12;X:12;KC:0;Fex:'N';D:'OS_Competenze_Dal_Ind'),
      (N:1127;R:015;W:10;T:0;F:3;M:12;X:12;KC:0;Fex:'N';D:'OS_Competenze_Al_Ind'),
      (N:1128;R:015;W:01;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Tipo_Recapito'),
      (N:1129;R:015;W:20;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Rec_Descrizione'),
      (N:1130;R:015;W:20;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Indirizzo'),
      (N:1131;R:015;W:05;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Cap'),
      (N:1132;R:015;W:10;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Comune'),
      (N:1133;R:015;W:12;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Telefono'),
      (N:1134;R:015;W:12;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Fax'),
      (N:1135;R:015;W:20;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Rec_Cognome'),
      (N:1136;R:015;W:20;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Rec_Nome'),
      (N:1137;R:015;W:12;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Rec_Tel_Casa'),
      (N:1138;R:015;W:12;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Rec_Tel_Ufficio'),
      (N:1139;R:015;W:12;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Rec_Cellulare'),
      (N:1140;R:015;W:20;T:0;F:0;M:12;X:12;KC:0;Fex:'N';D:'OS_Rec_Email'),
      //Permessi sindacali X = 13 (1200..1239) [prima era (1080..1114)]
      (N:1200;R:016;W:10;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'Progressivo13'),
      (N:1201;R:016;W:10;T:0;F:3;M:13;X:13;KC:1;Fex:'N';D:'PS_Data_Da'),
      (N:1202;R:016;W:10;T:0;F:3;M:13;X:13;KC:1;Fex:'N';D:'PS_Data'),
      (N:1203;R:016;W:10;T:0;F:0;M:13;X:13;KC:1;Fex:'N';D:'PS_Protocollo'),
      (N:1204;R:016;W:10;T:0;F:3;M:13;X:13;KC:1;Fex:'N';D:'PS_Data_Protocollo'),
      (N:1205;R:016;W:10;T:0;F:0;M:13;X:13;KC:1;Fex:'N';D:'PS_Protocollo_Modifica'),
      (N:1206;R:016;W:10;T:0;F:3;M:13;X:13;KC:1;Fex:'N';D:'PS_Data_Modifica'),
      (N:1207;R:016;W:05;T:0;F:0;M:13;X:13;KC:1;Fex:'N';D:'PS_Dalle'),
      (N:1208;R:016;W:05;T:0;F:0;M:13;X:13;KC:1;Fex:'N';D:'PS_Alle'),
      (N:1209;R:016;W:05;T:0;F:2;M:13;X:13;KC:0;Fex:'N';D:'PS_Ore'),
      (N:1210;R:016;W:01;T:0;F:0;M:13;X:13;KC:1;Fex:'N';D:'PS_Stato'),
      (N:1211;R:016;W:05;T:0;F:0;M:13;X:13;KC:1;Fex:'N';D:'PS_Organismo'),
      (N:1212;R:016;W:20;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_D_Organismo'),
      (N:1213;R:016;W:01;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Fruizione_Permessi'),
      (N:1214;R:016;W:01;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Retribuito'),
      (N:1215;R:016;W:01;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Statutario'),
      (N:1216;R:016;W:01;T:0;F:0;M:13;X:13;KC:1;Fex:'N';D:'PS_Abbatte_Competenze'),
      (N:1217;R:016;W:05;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Causale'),
      (N:1218;R:016;W:10;T:0;F:0;M:13;X:13;KC:1;Fex:'N';D:'PS_Sindacato'),
      (N:1219;R:016;W:20;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_D_Sindacato'),
      (N:1220;R:016;W:11;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Cod_Ministeriale'),
      (N:1221;R:016;W:06;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Vocepaghe'),
      (N:1222;R:016;W:01;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Rsu'),
      (N:1223;R:016;W:01;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Raggruppamento'),
      (N:1224;R:016;W:20;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Sind_Raggruppati'),
      (N:1225;R:016;W:11;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Sigla_Gedap'),
      (N:1226;R:016;W:01;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Inserito_Gedap'),
      (N:1227;R:016;W:01;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Tipo_Recapito'),
      (N:1228;R:016;W:20;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Rec_Descrizione'),
      (N:1229;R:016;W:20;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Indirizzo'),
      (N:1230;R:016;W:05;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Cap'),
      (N:1231;R:016;W:10;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Comune'),
      (N:1232;R:016;W:12;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Telefono'),
      (N:1233;R:016;W:12;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Fax'),
      (N:1234;R:016;W:20;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Rec_Cognome'),
      (N:1235;R:016;W:20;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Rec_Nome'),
      (N:1236;R:016;W:12;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Rec_Tel_Casa'),
      (N:1237;R:016;W:12;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Rec_Tel_Ufficio'),
      (N:1238;R:016;W:12;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Rec_Cellulare'),
      (N:1239;R:016;W:20;T:0;F:0;M:13;X:13;KC:0;Fex:'N';D:'PS_Rec_Email'),
      //Missioni/trasferte: X = 6 (1300..1329) (701..729)
      (N:1300;R:009;W:08;T:1;F:0;M:6;X:06;KC:0;Fex:'N';D:'Progressivo6'),
      (N:1301;R:009;W:08;T:1;F:3;M:6;X:06;KC:1;Fex:'N';D:'MT_Mese scarico'),
      (N:1302;R:009;W:08;T:1;F:3;M:6;X:06;KC:1;Fex:'N';D:'MT_Mese competenza'),
      (N:1303;R:009;W:10;T:1;F:3;M:6;X:06;KC:1;Fex:'N';D:'MT_Da data'),
      (N:1304;R:009;W:10;T:1;F:3;M:6;X:06;KC:1;Fex:'N';D:'MT_A data'),
      (N:1305;R:009;W:05;T:1;F:0;M:6;X:06;KC:1;Fex:'N';D:'MT_Da ora'),
      (N:1306;R:009;W:05;T:1;F:0;M:6;X:06;KC:1;Fex:'N';D:'MT_A ora'),
      (N:1307;R:009;W:10;T:1;F:0;M:6;X:06;KC:1;Fex:'N';D:'MT_Protocollo'),
      (N:1308;R:009;W:05;T:1;F:0;M:6;X:06;KC:1;Fex:'N';D:'MT_Missione/Formazione'),
      (N:1309;R:009;W:20;T:1;F:0;M:6;X:06;KC:1;Fex:'N';D:'MT_Partenza'),
      (N:1310;R:009;W:20;T:1;F:0;M:6;X:06;KC:1;Fex:'N';D:'MT_Destinazione'),
      (N:1311;R:009;W:03;T:0;F:1;M:6;X:06;KC:0;Fex:'N';D:'MT_Durata giorni'),
      (N:1312;R:009;W:06;T:0;F:2;M:6;X:06;KC:0;Fex:'N';D:'MT_Durata ore'),
      (N:1313;R:009;W:20;T:1;F:0;M:6;X:06;KC:1;Fex:'N';D:'MT_Indennita: tipo'),
      (N:1314;R:009;W:06;T:1;F:0;M:6;X:06;KC:0;Fex:'N';D:'MT_Indennita applicata'),
      (N:1315;R:009;W:06;T:0;F:1;M:6;X:06;KC:0;Fex:'N';D:'MT_Ore conteggiate'),
      (N:1316;R:009;W:06;T:0;F:1;M:6;X:06;KC:0;Fex:'N';D:'MT_Indennita: importo'),
      (N:1317;R:009;W:06;T:0;F:1;M:6;X:06;KC:0;Fex:'N';D:'MT_KM totali importo'),
      (N:1318;R:009;W:04;T:0;F:1;M:6;X:06;KC:0;Fex:'N';D:'MT_KM totali fatti'),
      (N:1319;R:009;W:06;T:0;F:1;M:6;X:06;KC:0;Fex:'N';D:'MT_Rimborsi totali'),
      (N:1320;R:009;W:06;T:0;F:1;M:6;X:06;KC:0;Fex:'N';D:'MT_Costi rimborsi totali'),
      (N:1321;R:009;W:06;T:0;F:1;M:6;X:06;KC:0;Fex:'N';D:'MT_Ind.suppl.totali'),
      (N:1322;R:009;W:06;T:0;F:1;M:6;X:06;KC:0;Fex:'N';D:'MT_Rimb/Ind.suppl.totali'),
      (N:1323;R:009;W:06;T:0;F:1;M:6;X:06;KC:0;Fex:'N';D:'MT_Importo totale'),
      (N:1324;R:009;W:06;T:0;F:1;M:6;X:06;KC:0;Fex:'N';D:'MT_Costo totale'),
      (N:1325;R:009;W:01;T:1;F:0;M:6;X:06;KC:0;Fex:'N';D:'MT_Modifica manuale'),
      (N:1329;R:009;W:01;T:1;F:0;M:6;X:06;KC:1;Fex:'N';D:'MT_Stato missione'),
      (N:1326;R:009;W:10;T:1;F:0;M:6;X:06;KC:0;Fex:'N';D:'MT_Note'),
      (N:1327;R:009;W:10;T:1;F:0;M:6;X:06;KC:1;Fex:'N';D:'MT_Commessa'),
      (N:1328;R:009;W:06;T:1;F:0;M:6;X:06;KC:1;Fex:'N';D:'MT_Voce paghe'),
      //Indennità km delle Missioni/trasferte: X = 14 (1400..1412) (741..750)
      (N:1400;R:017;W:08;T:1;F:0;M:14;X:14;KC:0;Fex:'N';D:'Progressivo14'),
      (N:1401;R:017;W:08;T:1;F:3;M:14;X:14;KC:1;Fex:'N';D:'MK_Mese scarico'),
      (N:1402;R:017;W:08;T:1;F:3;M:14;X:14;KC:1;Fex:'N';D:'MK_Mese competenza'),
      (N:1403;R:017;W:10;T:1;F:3;M:14;X:14;KC:1;Fex:'N';D:'MK_Da data'),
      (N:1404;R:017;W:05;T:1;F:0;M:14;X:14;KC:1;Fex:'N';D:'MK_Da ora'),
      (N:1405;R:017;W:05;T:1;F:0;M:14;X:14;KC:1;Fex:'N';D:'MK_Codice'),
      (N:1406;R:017;W:20;T:1;F:0;M:14;X:14;KC:0;Fex:'N';D:'MK_Descrizione'),
      (N:1407;R:017;W:06;T:0;F:1;M:14;X:14;KC:0;Fex:'N';D:'MK_Importo'),
      (N:1408;R:017;W:06;T:0;F:1;M:14;X:14;KC:0;Fex:'N';D:'MK_KMFatti'),
      (N:1409;R:017;W:06;T:0;F:0;M:14;X:14;KC:1;Fex:'N';D:'MK_Voce paghe'),
      (N:1410;R:017;W:05;T:0;F:0;M:14;X:14;KC:1;Fex:'N';D:'MK_Tipo missione'),
      (N:1411;R:017;W:10;T:0;F:0;M:14;X:14;KC:1;Fex:'N';D:'MK_Protocollo'),
      (N:1412;R:017;W:10;T:0;F:0;M:14;X:14;KC:1;Fex:'N';D:'MK_Commessa'),
      //Crediti formativi X = 10 (1500..1569) (750..776)
      (N:1500;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'Progressivo10'),
      (N:1501;R:013;W:10;T:1;F:3;M:10;X:10;KC:1;Fex:'N';D:'CF_Data_partecipazione'),
      (N:1502;R:013;W:10;T:1;F:3;M:10;X:10;KC:1;Fex:'N';D:'CF_Data_iscrizione'),
      (N:1503;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Operatore_iscrizione'),
      (N:1504;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Origine_iscrizione'),
      (N:1505;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Stato_iscrizione'),
      (N:1506;R:013;W:10;T:1;F:3;M:10;X:10;KC:0;Fex:'N';D:'CF_Data_autorizzazione'),
      (N:1507;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Operatore_autorizzazione'),
      (N:1508;R:013;W:10;T:1;F:3;M:10;X:10;KC:0;Fex:'N';D:'CF_Data_validazione'),
      (N:1509;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Operatore_validazione'),
      (N:1510;R:013;W:04;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Numero_giorno'),
      (N:1554;R:013;W:20;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_D_Numero_giorno'),
      (N:1566;R:013;W:05;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Inizio_matt'),
      (N:1567;R:013;W:05;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Fine_matt'),
      (N:1568;R:013;W:05;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Inizio_pom'),
      (N:1569;R:013;W:05;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Fine_pom'),
//    (N:1555;R:013;W:05;T:1;F:2;M:10;X:10;KC:0;Fex:'N';D:'CF_Ore_docenza'),
      (N:1511;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Ora_inizio'),
      (N:1512;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Ora_fine'),
      (N:1526;R:013;W:01;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Tipo_partecipazione'),
      (N:1562;R:013;W:01;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Tipo_docenza'),
      (N:1563;R:013;W:01;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Attivo_docenza'),
      (N:1555;R:013;W:05;T:1;F:2;M:10;X:10;KC:0;Fex:'N';D:'CF_Ore_docenza'),
      (N:1556;R:013;W:05;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_Crediti_docenza'),
      (N:1564;R:013;W:08;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_Tariffa_docenza'),
      (N:1565;R:013;W:20;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Note_docenza'),
      (N:1513;R:013;W:10;T:1;F:2;M:10;X:10;KC:0;Fex:'N';D:'CF_Durata_partecipazione'),
      (N:1514;R:013;W:20;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Note_partecipazione'),
      (N:1515;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Tipo_record'),
      (N:1516;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Cod_corso'),
      (N:1517;R:013;W:20;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Titolo'),
      (N:1518;R:013;W:10;T:1;F:3;M:10;X:10;KC:1;Fex:'N';D:'CF_Decorrenza'),
      (N:1519;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Edizione'),
      (N:1560;R:013;W:01;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Notificato'),
      (N:1561;R:013;W:01;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Definitivo'),
      (N:1520;R:013;W:10;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_Crediti'),
      (N:1521;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Luogo_corso'),
      (N:1522;R:013;W:20;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_D_Luogo_corso'),
      (N:1523;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Metodo'),
      (N:1524;R:013;W:20;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_D_Metodo'),
      (N:1525;R:013;W:20;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Note'),
      (N:1527;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Profilo_crediti'),
      (N:1528;R:013;W:20;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_D_profilo_crediti'),
      (N:1529;R:013;W:10;T:1;F:3;M:10;X:10;KC:1;Fex:'N';D:'CF_Inizio'),
      (N:1530;R:013;W:10;T:1;F:3;M:10;X:10;KC:1;Fex:'N';D:'CF_Fine'),
      (N:1531;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Durata_gg'),
      (N:1532;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Durata_hh'),
      (N:1533;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Numero_delibera'),
      (N:1534;R:013;W:10;T:1;F:3;M:10;X:10;KC:0;Fex:'N';D:'CF_Data_delibera'),
      (N:1535;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Tipo_corso'),
      (N:1536;R:013;W:20;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_D_Tipo_corso'),
      (N:1537;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Flag_interno'),
      (N:1538;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Evento'),
      (N:1539;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_GG_min'),
      (N:1540;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_HH_min'),
      (N:1541;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Max_partecipanti'),
      (N:1542;R:013;W:10;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_Max_iscritti'),
      (N:1543;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Ente'),
      (N:1544;R:013;W:20;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_D_Ente'),
      (N:1558;R:013;W:05;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Tipologia_Ente'),
      (N:1559;R:013;W:20;T:1;F:0;M:10;X:10;KC:0;Fex:'N';D:'CF_D_Tipologia_Ente'),
      (N:1545;R:013;W:10;T:1;F:0;M:10;X:10;KC:1;Fex:'N';D:'CF_Tipo_aggiornamento'),
      (N:1557;R:013;W:10;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_Crediti_Partecipazione'),
      (N:1546;R:013;W:10;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_Competenze'),
      (N:1547;R:013;W:10;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_CompetenzeMin'),
      (N:1548;R:013;W:10;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_CompetenzeMax'),
      (N:1549;R:013;W:10;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_Fruito'),
      (N:1550;R:013;W:10;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_Residuo'),
      (N:1551;R:013;W:10;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_ResiduoMin'),
      (N:1552;R:013;W:10;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_ResiduoMax'),
      (N:1553;R:013;W:10;T:1;F:1;M:10;X:10;KC:0;Fex:'N';D:'CF_Residuo Anno Prec.'),
      //Rimborsi delle Missioni/trasferte: X = 7 (1600..1622) (781..803)             //***1614 (795)
      (N:1600;R:010;W:08;T:1;F:0;M:7;X:07;KC:0;Fex:'N';D:'Progressivo7'),
      (N:1615;R:010;W:08;T:1;F:0;M:7;X:07;KC:1;Fex:'N';D:'MR_Richiesta'),            //***
      (N:1616;R:010;W:08;T:1;F:0;M:7;X:07;KC:1;Fex:'N';D:'MR_Indennita Km'),         //***
      (N:1617;R:010;W:08;T:1;F:0;M:7;X:07;KC:1;Fex:'N';D:'MR_Stato autorizzazione'), //***
      (N:1618;R:010;W:08;T:1;F:0;M:7;X:07;KC:1;Fex:'N';D:'MR_ID Missione'),          //***
      (N:1601;R:010;W:08;T:1;F:3;M:7;X:07;KC:1;Fex:'N';D:'MR_Mese scarico'),
      (N:1602;R:010;W:08;T:1;F:3;M:7;X:07;KC:1;Fex:'N';D:'MR_Mese competenza'),
      (N:1603;R:010;W:10;T:1;F:3;M:7;X:07;KC:1;Fex:'N';D:'MR_Da data'),
      (N:1604;R:010;W:05;T:1;F:0;M:7;X:07;KC:1;Fex:'N';D:'MR_Da ora'),
      (N:1605;R:010;W:05;T:1;F:0;M:7;X:07;KC:1;Fex:'N';D:'MR_Codice rimborso'),
      (N:1606;R:010;W:20;T:1;F:0;M:7;X:07;KC:0;Fex:'N';D:'MR_Descrizione rimborso'),
      (N:1607;R:010;W:01;T:1;F:0;M:7;X:07;KC:1;Fex:'N';D:'MR_Anticipo'),
      (N:1619;R:010;W:06;T:0;F:1;M:7;X:07;KC:0;Fex:'N';D:'MR_Rimborso richiesto'),    //***
      (N:1608;R:010;W:06;T:0;F:1;M:7;X:07;KC:0;Fex:'N';D:'MR_Rimborso riconosciuto'), //*** modificato: era MR_Rimborso
      (N:1689;R:010;W:06;T:0;F:1;M:7;X:07;KC:0;Fex:'N';D:'MR_Indennita suppl.'),
      (N:1610;R:010;W:06;T:0;F:1;M:7;X:07;KC:0;Fex:'N';D:'MR_Costo'),
      (N:1620;R:010;W:06;T:0;F:1;M:7;X:07;KC:0;Fex:'N';D:'MR_KM richiesti'),          //***
      (N:1621;R:010;W:06;T:0;F:1;M:7;X:07;KC:0;Fex:'N';D:'MR_KM riconosciuti'),       //***
      (N:1611;R:010;W:06;T:0;F:0;M:7;X:07;KC:1;Fex:'N';D:'MR_Voce paghe'),
      (N:1612;R:010;W:05;T:0;F:0;M:7;X:07;KC:1;Fex:'N';D:'MR_Tipo missione'),
      (N:1613;R:010;W:10;T:0;F:0;M:7;X:07;KC:1;Fex:'N';D:'MR_Protocollo'),
      (N:1614;R:010;W:10;T:0;F:0;M:7;X:07;KC:1;Fex:'N';D:'MR_Commessa'),
      (N:1622;R:010;W:10;T:0;F:0;M:7;X:07;KC:0;Fex:'N';D:'MR_Note'),                  //***
      //Riepilogo presenze X = 2 (1700..1750)
      (N:1700;R:005;W:05;T:1;F:0;M:2;X:02;KC:0;Fex:'N';D:'Progressivo2'),
      (N:1701;R:005;W:05;T:1;F:0;M:2;X:02;KC:1;Fex:'N';D:'Codice presenze'),
      (N:1702;R:005;W:20;T:1;F:0;M:2;X:02;KC:0;Fex:'N';D:'Descrizione presenze'),
      (N:1703;R:005;W:10;T:1;F:3;M:2;X:02;KC:1;Fex:'N';D:'Data riepilogo pres.'),
      (N:1704;R:005;W:10;T:1;F:0;M:2;X:02;KC:1;Fex:'N';D:'Anno riepilogo pres.'),
      (N:1705;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Presenze fascia 1'),
      (N:1706;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Presenze fascia 2'),
      (N:1707;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Presenze fascia 3'),
      (N:1708;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Presenze fascia 4'),
      (N:1709;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Presenze totali'),
      (N:1710;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Presenze annue fascia 1'),
      (N:1711;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Presenze annue fascia 2'),
      (N:1712;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Presenze annue fascia 3'),
      (N:1713;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Presenze annue fascia 4'),
      (N:1714;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Presenze annue totali'),
      (N:1715;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquidabili fascia 1'),
      (N:1716;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquidabili fascia 2'),
      (N:1717;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquidabili fascia 3'),
      (N:1718;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquidabili fascia 4'),
      (N:1719;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquidabili totali'),
      (N:1720;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquidate fascia 1'),
      (N:1721;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquidate fascia 2'),
      (N:1722;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquidate fascia 3'),
      (N:1723;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquidate fascia 4'),
      (N:1724;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquidate totali'),
      (N:1725;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquid.annue fascia 1'),
      (N:1726;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquid.annue fascia 2'),
      (N:1727;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquid.annue fascia 3'),
      (N:1728;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquid.annue fascia 4'),
      (N:1729;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.liquid.annue totali'),
      (N:1730;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.residue fascia 1'),
      (N:1731;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.residue fascia 2'),
      (N:1732;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.residue fascia 3'),
      (N:1733;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.residue fascia 4'),
      (N:1734;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.residue totali'),
      (N:1735;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.comp.registrate'),
      (N:1736;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.comp.effettive'),
      (N:1737;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.comp.annue registrate'),
      (N:1738;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.comp.annue effettive'),
      (N:1739;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.recuperata nel mese'),
      (N:1740;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.recuperata nell''anno'),
      (N:1746;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.perse fascia 1'),
      (N:1747;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.perse fascia 2'),
      (N:1748;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.perse fascia 3'),
      (N:1749;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.perse fascia 4'),
      (N:1750;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.perse totali'),
      (N:1741;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.banca ore fascia 1'),
      (N:1742;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.banca ore fascia 2'),
      (N:1743;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.banca ore fascia 3'),
      (N:1744;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.banca ore fascia 4'),
      (N:1745;R:005;W:06;T:0;F:2;M:2;X:02;KC:0;Fex:'N';D:'Pres.banca ore totali'),

      //Riepilogo assenze X = 3 (1800..1849)
      (N:1800;R:006;W:05;T:1;F:0;M:3;X:03;KC:0;Fex:'N';D:'Progressivo3'),
      (N:1801;R:006;W:05;T:1;F:0;M:3;X:03;KC:1;Fex:'N';D:'Codice assenze'),
      (N:1802;R:006;W:20;T:1;F:0;M:3;X:03;KC:0;Fex:'N';D:'Descrizione assenze'),
      (N:1803;R:006;W:10;T:1;F:3;M:3;X:03;KC:1;Fex:'N';D:'Data riepilogo ass.'),
      (N:1804;R:006;W:15;T:1;F:3;M:3;X:03;KC:1;Fex:'N';D:'Inizio periodo cumulo'),
      (N:1805;R:006;W:15;T:1;F:3;M:3;X:03;KC:1;Fex:'N';D:'Fine periodo cumulo'),
      (N:1806;R:006;W:16;T:1;F:3;M:3;X:03;KC:1;Fex:'N';D:'Data familiare'),
      (N:1807;R:006;W:02;T:1;F:0;M:3;X:03;KC:1;Fex:'N';D:'Misura assenze'),
      (N:1808;R:006;W:06;T:1;F:2;M:3;X:03;KC:1;Fex:'N';D:'Valenza giornaliera'),
      (N:1809;R:006;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze del mese'),
      (N:1810;R:019;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze da Qual.Min.'),
      (N:1811;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.ass.anno prec.'),
      (N:1812;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.ass.anno corr.'),
      (N:1813;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.ass.totali'),
      (N:1814;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.ass.totali 1'),
      (N:1815;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.ass.totali 2'),
      (N:1816;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.ass.totali 3'),
      (N:1817;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.ass.totali 4'),
      (N:1818;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.ass.totali 5'),
      (N:1819;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.ass.totali 6'),
      (N:1820;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Ass.fruite anno prec.'),
      (N:1821;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Ass.fruite anno corr.'),
      (N:1822;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze fruite'),
      (N:1823;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze fruite 1'),
      (N:1824;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze fruite 2'),
      (N:1825;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze fruite 3'),
      (N:1826;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze fruite 4'),
      (N:1827;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze fruite 5'),
      (N:1828;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze fruite 6'),
      (N:1829;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Ass.residue anno prec.'),
      (N:1830;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Ass.residue anno corr.'),
      (N:1831;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze residue'),
      (N:1832;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze residue 1'),
      (N:1833;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze residue 2'),
      (N:1834;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze residue 3'),
      (N:1835;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze residue 4'),
      (N:1836;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze residue 5'),
      (N:1837;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze residue 6'),
      (N:1838;R:006;W:06;T:0;F:2;M:3;X:03;KC:0;Fex:'N';D:'Resa oraria'),
      (N:1839;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Competenze parziali'),
      (N:1840;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Residuo parziale'),
      (N:1841;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Competenze del periodo'),
      (N:1842;R:006;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Assenze del mese in gg'),
      (N:1843;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.in gg'),
      (N:1844;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.ass.anno prec.in gg'),
      (N:1845;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Comp.ass.anno corr.in gg'),
      (N:1846;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Fruito in gg'),
      (N:1847;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Resid. in gg'),
      (N:1848;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Competenze parziali in gg'),
      (N:1849;R:007;W:06;T:0;F:1;M:3;X:03;KC:0;Fex:'N';D:'Competenze del periodo in gg'),

      //Voci paghe scaricate X = 8 (1900..1910)
      (N:1900;R:011;W:08;T:1;F:0;M:8;X:08;KC:0;Fex:'N';D:'Progressivo8'),
      (N:1901;R:011;W:08;T:1;F:3;M:8;X:08;KC:1;Fex:'N';D:'VP_Mese competenza'),
      (N:1902;R:011;W:04;T:1;F:0;M:8;X:08;KC:1;Fex:'N';D:'VP_Anno competenza'),
      (N:1903;R:011;W:08;T:1;F:3;M:8;X:08;KC:1;Fex:'N';D:'VP_Mese cassa'),
      (N:1904;R:011;W:04;T:1;F:0;M:8;X:08;KC:1;Fex:'N';D:'VP_Anno cassa'),
      (N:1905;R:011;W:06;T:1;F:0;M:8;X:08;KC:1;Fex:'N';D:'VP_Voce paghe'),
      (N:1906;R:011;W:04;T:1;F:0;M:8;X:08;KC:1;Fex:'N';D:'VP_Codice'),
      (N:1907;R:011;W:20;T:1;F:0;M:8;X:08;KC:0;Fex:'N';D:'VP_Descrizione'),
      (N:1908;R:011;W:01;T:1;F:0;M:8;X:08;KC:1;Fex:'N';D:'VP_Misura'),
      (N:1909;R:011;W:06;T:0;F:1;M:8;X:08;KC:0;Fex:'N';D:'VP_Valore'),
      (N:1910;R:011;W:06;T:0;F:1;M:8;X:08;KC:0;Fex:'N';D:'VP_Importo'),
      //Assestamento ore anni prec. X = 24 (1950..1961)
      (N:1950;R:028;W:08;T:1;F:0;M:24;X:24;KC:0;Fex:'N';D:'Progressivo24'),
      (N:1951;R:028;W:06;T:1;F:0;M:24;X:24;KC:1;Fex:'N';D:'VAP_Anno_competenza'),
      (N:1952;R:028;W:10;T:1;F:3;M:24;X:24;KC:1;Fex:'N';D:'VAP_Data_variazione'),
      (N:1953;R:028;W:02;T:1;F:0;M:24;X:24;KC:1;Fex:'N';D:'VAP_Ore_Perse'),
      (N:1954;R:028;W:07;T:1;F:2;M:24;X:24;KC:0;Fex:'N';D:'VAP_Ore_Liquidate'),
      (N:1955;R:028;W:07;T:1;F:2;M:24;X:24;KC:0;Fex:'N';D:'VAP_Variazione_Saldo'),
      (N:1956;R:028;W:07;T:1;F:2;M:24;X:24;KC:0;Fex:'N';D:'VAP_Saldo_Annuo'),
      (N:1957;R:028;W:07;T:1;F:2;M:24;X:24;KC:0;Fex:'N';D:'VAP_Tot_Variaz_Saldi'),
      (N:1958;R:028;W:07;T:1;F:2;M:24;X:24;KC:0;Fex:'N';D:'VAP_Tot_Ore_Perse'),
      (N:1959;R:028;W:07;T:1;F:2;M:24;X:24;KC:0;Fex:'N';D:'VAP_Tot_Variaz_Ore_Perse'),
      (N:1960;R:028;W:07;T:1;F:2;M:24;X:24;KC:0;Fex:'N';D:'VAP_Residuo_Ore_Perse'),
      (N:1961;R:028;W:20;T:1;F:0;M:24;X:24;KC:0;Fex:'N';D:'VAP_Note'),
      //Incentivi X = 15 (2000..2015)
      (N:2000;R:018;W:08;T:1;F:0;M:15;X:15;KC:0;Fex:'N';D:'Progressivo15'),
      (N:2001;R:018;W:10;T:1;F:3;M:15;X:15;KC:1;Fex:'N';D:'QI_Data'),
      (N:2002;R:018;W:01;T:1;F:0;M:15;X:15;KC:1;Fex:'N';D:'QI_Tipo_quota'),
      (N:2003;R:018;W:05;T:1;F:0;M:15;X:15;KC:1;Fex:'N';D:'QI_Cod_Tipo_quota'),
      (N:2004;R:018;W:15;T:1;F:0;M:15;X:15;KC:0;Fex:'N';D:'QI_Desc_Tipo_quota'),
      (N:2005;R:018;W:08;T:1;F:1;M:15;X:15;KC:0;Fex:'N';D:'QI_Incentivi'),
      (N:2006;R:018;W:08;T:1;F:1;M:15;X:15;KC:0;Fex:'N';D:'QI_VarIncentivi'),
      { commentato daniloc (N:2007;R:018;W:08;T:1;F:1;M:15;X:15;KC:0;Fex:'N';D:'QI_Risorse'),}
      { commentato daniloc (N:2008;R:018;W:08;T:1;F:1;M:15;X:15;KC:0;Fex:'N';D:'QI_VarRisorse'),}
      (N:2009;R:018;W:08;T:1;F:1;M:15;X:15;KC:0;Fex:'N';D:'QI_Abbattimento'),
      (N:2010;R:018;W:08;T:1;F:0;M:15;X:15;KC:1;Fex:'N';D:'QI_Tipo abbattimento'),
      { commentato daniloc (N:2011;R:018;W:08;T:1;F:1;M:15;X:15;KC:0;Fex:'N';D:'QI_Incentivi lordi'),}
      (N:2012;R:018;W:08;T:1;F:0;M:15;X:15;KC:1;Fex:'N';D:'QI_Cod_Tipo_importo'),
      (N:2013;R:018;W:25;T:1;F:0;M:15;X:15;KC:0;Fex:'N';D:'QI_Desc_Tipo_importo'),
      (N:2014;R:018;W:02;T:1;F:0;M:15;X:15;KC:1;Fex:'N';D:'QI_Risparmio'),
      (N:2015;R:018;W:06;T:1;F:1;M:15;X:15;KC:0;Fex:'N';D:'QI_Giorni'),
      //Anticipi delle Missioni/trasferte: X = 16 (2100..2114)
      (N:2100;R:020;W:08;T:1;F:0;M:16;X:16;KC:0;Fex:'N';D:'Progressivo16'),
      (N:2101;R:020;W:10;T:1;F:0;M:16;X:16;KC:1;Fex:'N';D:'MA_Cassa'),
      (N:2102;R:020;W:04;T:1;F:0;M:16;X:16;KC:1;Fex:'N';D:'MA_Anno movimento'),
      (N:2103;R:020;W:05;T:1;F:0;M:16;X:16;KC:1;Fex:'N';D:'MA_Codice voce'),
      (N:2104;R:020;W:10;T:1;F:3;M:16;X:16;KC:1;Fex:'N';D:'MA_Data impostazione stato'),
      (N:2105;R:020;W:10;T:1;F:3;M:16;X:16;KC:1;Fex:'N';D:'MA_Data missione'),
      (N:2106;R:020;W:10;T:1;F:3;M:16;X:16;KC:1;Fex:'N';D:'MA_Data movimento'),
      (N:2107;R:020;W:01;T:1;F:0;M:16;X:16;KC:1;Fex:'N';D:'MA_Flag totalizzatore'),
      (N:2108;R:020;W:08;T:1;F:1;M:16;X:16;KC:1;Fex:'N';D:'MA_Importo'),
      (N:2109;R:020;W:20;T:1;F:0;M:16;X:16;KC:0;Fex:'N';D:'MA_Note'),
      (N:2110;R:020;W:02;T:1;F:0;M:16;X:16;KC:1;Fex:'N';D:'MA_Numero movimento'),
      (N:2111;R:020;W:04;T:1;F:1;M:16;X:16;KC:1;Fex:'N';D:'MA_Quantità'),
      (N:2112;R:020;W:01;T:1;F:0;M:16;X:16;KC:1;Fex:'N';D:'MA_Stato'),
      (N:2113;R:020;W:01;T:1;F:0;M:16;X:16;KC:1;Fex:'N';D:'MA_ItaliaEstero'),
      (N:2114;R:020;W:03;T:1;F:0;M:16;X:16;KC:1;Fex:'N';D:'MA_Numero sospeso'),
      //Rischi/prescrizioni: X = 17 (2200..2222)
      (N:2200;R:021;W:08;T:1;F:0;M:17;X:17;KC:0;Fex:'N';D:'Progressivo17'),
      (N:2201;R:021;W:07;T:1;F:0;M:17;X:17;KC:1;Fex:'N';D:'RP_Tipo_rischio'),
      (N:2202;R:021;W:20;T:1;F:0;M:17;X:17;KC:0;Fex:'N';D:'RP_D_Tipo_rischio'),
      (N:2203;R:021;W:10;T:1;F:3;M:17;X:17;KC:1;Fex:'N';D:'RP_Data_inizio'),
      (N:2204;R:021;W:10;T:1;F:3;M:17;X:17;KC:0;Fex:'N';D:'RP_Data_fine'),
      (N:2205;R:021;W:07;T:1;F:0;M:17;X:17;KC:1;Fex:'N';D:'RP_Tipo_cessazione'),
      (N:2206;R:021;W:20;T:1;F:0;M:17;X:17;KC:0;Fex:'N';D:'RP_D_Tipo_cessazione'),
      (N:2219;R:021;W:05;T:1;F:0;M:17;X:17;KC:1;Fex:'N';D:'RP_Tipo_Attivita'),
      (N:2220;R:021;W:20;T:1;F:0;M:17;X:17;KC:0;Fex:'N';D:'RP_D_Tipo_Attivita'),
      (N:2221;R:021;W:05;T:1;F:0;M:17;X:17;KC:1;Fex:'N';D:'RP_Tipo_Esposizione'),
      (N:2222;R:021;W:20;T:1;F:0;M:17;X:17;KC:0;Fex:'N';D:'RP_D_Tipo_Esposizione'),
      (N:2207;R:021;W:20;T:1;F:0;M:17;X:17;KC:0;Fex:'N';D:'RP_Note_rischio'),
      (N:2208;R:021;W:10;T:1;F:3;M:17;X:17;KC:1;Fex:'N';D:'RP_Data_visita'),
      (N:2209;R:021;W:10;T:1;F:3;M:17;X:17;KC:0;Fex:'N';D:'RP_Data_periodo'),
      (N:2210;R:021;W:20;T:1;F:0;M:17;X:17;KC:0;Fex:'N';D:'RP_Esito_visita'),
      (N:2214;R:021;W:20;T:1;F:0;M:17;X:17;KC:0;Fex:'N';D:'RP_D_Esito_visita'),
      (N:2211;R:021;W:20;T:1;F:0;M:17;X:17;KC:1;Fex:'N';D:'RP_Periodicita_visita'),
      (N:2212;R:021;W:10;T:1;F:3;M:17;X:17;KC:0;Fex:'N';D:'RP_Data_prox_visita'),
      (N:2213;R:021;W:20;T:1;F:0;M:17;X:17;KC:0;Fex:'N';D:'RP_Note_visita'),
      (N:2215;R:021;W:20;T:1;F:0;M:17;X:17;KC:0;Fex:'N';D:'RP_Oggetto_visita'),
      (N:2216;R:021;W:07;T:1;F:0;M:17;X:17;KC:1;Fex:'N';D:'RP_Prescrizione_visita'),
      (N:2217;R:021;W:20;T:1;F:0;M:17;X:17;KC:0;Fex:'N';D:'RP_D_Prescrizione_visita'),
      (N:2218;R:021;W:10;T:1;F:3;M:17;X:17;KC:0;Fex:'N';D:'RP_Data_esito'),
      //Incarichi: X = 18 (2300..2348)
      (N:2300;R:022;W:08;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'Progressivo18'),
      (N:2301;R:022;W:20;T:1;F:0;M:18;X:18;KC:1;Fex:'N';D:'IN_Cod_UnitaOrg'),
      (N:2302;R:022;W:20;T:1;F:0;M:18;X:18;KC:1;Fex:'N';D:'IN_D_UnitaOrg'),
      (N:2303;R:022;W:05;T:1;F:0;M:18;X:18;KC:1;Fex:'N';D:'IN_TipoInc'),
      (N:2304;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_D_TipoInc'),
      (N:2305;R:022;W:05;T:1;F:0;M:18;X:18;KC:1;Fex:'N';D:'IN_Categoria'),
      (N:2306;R:022;W:20;T:1;F:0;M:18;X:18;KC:1;Fex:'N';D:'IN_Titolo_posizione'),
      (N:2307;R:022;W:10;T:1;F:3;M:18;X:18;KC:1;Fex:'N';D:'IN_Data_affidamento'),
      (N:2308;R:022;W:10;T:1;F:3;M:18;X:18;KC:1;Fex:'N';D:'IN_Data_scadenza'),
      (N:2309;R:022;W:10;T:1;F:3;M:18;X:18;KC:1;Fex:'N';D:'IN_Data_scadenza_prorogata'),
      (N:2310;R:022;W:10;T:1;F:3;M:18;X:18;KC:0;Fex:'N';D:'IN_Data_sottoscrizione'),
      (N:2311;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Tipo_assegnazione'),
      (N:2312;R:022;W:40;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Mansioni_competenze'),
      (N:2313;R:022;W:40;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Motivazioni'),
      (N:2314;R:022;W:40;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Obiettivi_generali'),
      (N:2315;R:022;W:40;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Risorse'),
      (N:2316;R:022;W:40;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Osservazioni_dirigente'),
      (N:2317;R:022;W:15;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_TipoAtto'),
      (N:2318;R:022;W:15;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_NumAtto'),
      (N:2319;R:022;W:10;T:1;F:3;M:18;X:18;KC:0;Fex:'N';D:'IN_DataAtto'),
      (N:2320;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Autorita'),
      (N:2321;R:022;W:10;T:1;F:3;M:18;X:18;KC:0;Fex:'N';D:'IN_DataEsec'),
      (N:2322;R:022;W:05;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Commissione'),
      (N:2323;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_D_Commissione'),
      (N:2324;R:022;W:10;T:1;F:3;M:18;X:18;KC:0;Fex:'N';D:'IN_Data_valutazione'),
      (N:2325;R:022;W:40;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Esito_valutazione'),
      (N:2326;R:022;W:40;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Giudizio_valutazione'),
      (N:2327;R:022;W:40;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Proposta_valutazione'),
      (N:2328;R:022;W:40;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Articolo_revoca'),
      (N:2329;R:022;W:40;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Annotazioni'),
      (N:2330;R:022;W:10;T:1;F:3;M:18;X:18;KC:0;Fex:'N';D:'IN_Data_Verifica'),
      (N:2331;R:022;W:05;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Cod_Tipo_Verifica'),
      (N:2332;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Desc_Tipo_Verifica'),
      (N:2333;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Esito_Verifica'),
      (N:2334;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Note_Verifica'),
      (N:2335;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_TipoAtto_Verifica'),
      (N:2336;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_NumAtto_Verifica'),
      (N:2337;R:022;W:10;T:1;F:3;M:18;X:18;KC:0;Fex:'N';D:'IN_DataAtto_Verifica'),
      (N:2338;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Autorita_Verifica'),
      (N:2339;R:022;W:10;T:1;F:3;M:18;X:18;KC:0;Fex:'N';D:'IN_DataEsec_Verifica'),
      (N:2340;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_D_Categoria'),
      (N:2341;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Categ_Area'),
      (N:2342;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Categ_RifContr'),
      (N:2343;R:022;W:20;T:1;F:0;M:18;X:18;KC:1;Fex:'N';D:'IN_Tipologia_posizione'),
      (N:2344;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_Direttore_TipoInc'),
      (N:2345;R:022;W:10;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_ValoreMens_TipoInc'),
      (N:2346;R:022;W:10;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_ValoreTeor_TipoInc'),
      (N:2347;R:022;W:05;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_IncSup_TipoInc'),
      (N:2348;R:022;W:20;T:1;F:0;M:18;X:18;KC:0;Fex:'N';D:'IN_IncSup_Titolo'),
      //Messaggi WEB: X = 19 (2400..2406)
      (N:2400;R:023;W:08;T:1;F:0;M:19;X:19;KC:0;Fex:'N';D:'Progressivo19'),
      (N:2401;R:023;W:10;T:1;F:3;M:19;X:19;KC:1;Fex:'N';D:'MW_Data'),
      (N:2402;R:023;W:08;T:1;F:0;M:19;X:19;KC:1;Fex:'N';D:'MW_Mittente'),
      (N:2403;R:023;W:20;T:1;F:0;M:19;X:19;KC:1;Fex:'N';D:'MW_Titolo'),
      (N:2404;R:023;W:20;T:1;F:0;M:19;X:19;KC:1;Fex:'S';D:'MW_Testo'),
      (N:2405;R:023;W:20;T:1;F:0;M:19;X:19;KC:1;Fex:'S';D:'MW_Log'),
      (N:2406;R:023;W:01;T:1;F:0;M:19;X:19;KC:1;Fex:'N';D:'MW_Flag'),
      //Richieste WEB: X = 20 (2430..2457)
      (N:2430;R:024;W:08;T:1;F:0;M:20;X:20;KC:0;Fex:'N';D:'Progressivo20'),
      (N:2454;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_ID_Richiesta'),
      (N:2431;R:024;W:08;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Richiesta'),
      (N:2432;R:024;W:10;T:1;F:3;M:20;X:20;KC:1;Fex:'N';D:'RW_Data1'),
      (N:2433;R:024;W:10;T:1;F:3;M:20;X:20;KC:1;Fex:'N';D:'RW_Data2'),
      (N:2434;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Causale'),
      (N:2435;R:024;W:15;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_D_Causale'),
      (N:2436;R:024;W:01;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Tipo'),
      (N:2437;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Ore1'),
      (N:2438;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Ore2'),
      (N:2439;R:024;W:10;T:1;F:3;M:20;X:20;KC:1;Fex:'N';D:'RW_DataNascita'),
      (N:2440;R:024;W:01;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Operazione'),
      (N:2441;R:024;W:15;T:1;F:0;M:20;X:20;KC:1;Fex:'S';D:'RW_Note1'),
      (N:2442;R:024;W:15;T:1;F:0;M:20;X:20;KC:1;Fex:'S';D:'RW_Note2'),
      (N:2443;R:024;W:01;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Autorizzazione'),
      (N:2444;R:024;W:08;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Responsabile'),
      (N:2445;R:024;W:01;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Elaborato'),
      (N:2448;R:024;W:10;T:1;F:3;M:20;X:20;KC:1;Fex:'N';D:'RW_Data_richiesta'),
      (N:2449;R:024;W:10;T:1;F:3;M:20;X:20;KC:1;Fex:'N';D:'RW_Data_autorizzazione'),
      (N:2446;R:024;W:01;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Verso_Orig'),
      (N:2447;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Causale_Orig'),
      (N:2450;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Causale_Rich'),
      (N:2451;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Tipo_Richiesta'),
      (N:2452;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Autorizz_Prev'),
      (N:2453;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Data_Autorizz_Prev'),
      (N:2455;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_ID2'),
      (N:2456;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Ore1_Prev'),
      (N:2457;R:024;W:05;T:1;F:0;M:20;X:20;KC:1;Fex:'N';D:'RW_Ore2_Prev'),
      //Carta dei servizi: X = 21 (2500..2520)
      (N:2500;R:025;W:08;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'Progressivo21'),
      (N:2501;R:025;W:05;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'CS_Campo1'),
      (N:2502;R:025;W:15;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'CS_D_Campo1'),
      (N:2503;R:025;W:05;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'CS_Campo2'),
      (N:2504;R:025;W:15;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'CS_D_Campo2'),
      (N:2505;R:025;W:10;T:1;F:3;M:21;X:21;KC:1;Fex:'N';D:'CS_Data'),
      (N:2506;R:025;W:01;T:1;F:0;M:21;X:21;KC:1;Fex:'N';D:'CS_Comandato'),
      (N:2507;R:025;W:05;T:1;F:0;M:21;X:21;KC:1;Fex:'N';D:'CS_Tipo_Turno'),
      (N:2508;R:025;W:15;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'CS_D_Tipo_turno'),
      (N:2509;R:025;W:03;T:1;F:0;M:21;X:21;KC:1;Fex:'N';D:'CS_Pattuglia'),
      (N:2510;R:025;W:05;T:1;F:0;M:21;X:21;KC:1;Fex:'N';D:'CS_Servizio'),
      (N:2511;R:025;W:15;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'CS_D_Servizio'),
      (N:2512;R:025;W:05;T:1;F:0;M:21;X:21;KC:1;Fex:'N';D:'CS_Dalle'),
      (N:2513;R:025;W:05;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'CS_Alle'),
      (N:2514;R:025;W:05;T:1;F:0;M:21;X:21;KC:1;Fex:'N';D:'CS_Causale'),
      (N:2515;R:025;W:15;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'CS_D_Causale'),
      (N:2516;R:025;W:20;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'CS_Note'),
      (N:2517;R:025;W:20;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'CS_Messaggi'),
      (N:2518;R:025;W:01;T:1;F:0;M:21;X:21;KC:1;Fex:'N';D:'CS_Stato'),
      (N:2519;R:025;W:03;T:1;F:0;M:21;X:21;KC:0;Fex:'N';D:'CS_Ordine'),
      (N:2520;R:025;W:15;T:1;F:0;M:21;X:21;KC:1;Fex:'N';D:'CS_Dotazione'),
      //Valutazioni: X = 22 (2600..2651)
      (N:2600;R:026;W:08;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'Progressivo22'),
      (N:2601;R:026;W:10;T:1;F:3;M:22;X:22;KC:1;Fex:'N';D:'VA_Data_valutazione'),
      (N:2602;R:026;W:04;T:1;F:0;M:22;X:22;KC:1;Fex:'N';D:'VA_Anno'),
      (N:2603;R:026;W:10;T:1;F:3;M:22;X:22;KC:0;Fex:'N';D:'VA_Dal_valutazione'),
      (N:2604;R:026;W:10;T:1;F:3;M:22;X:22;KC:0;Fex:'N';D:'VA_Al_valutazione'),
      (N:2605;R:026;W:04;T:1;F:0;M:22;X:22;KC:1;Fex:'N';D:'VA_Cod_Tipo_valutazione'),
      (N:2606;R:026;W:15;T:1;F:0;M:22;X:22;KC:1;Fex:'N';D:'VA_Desc_Tipo_valutazione'),
      (N:2607;R:026;W:06;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Cod_Regola'),
      (N:2608;R:026;W:25;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Desc_Regola'),
      (N:2609;R:026;W:05;T:1;F:0;M:22;X:22;KC:1;Fex:'N';D:'VA_Stato_avanzamento'),
      (N:2610;R:026;W:05;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Dipendente_Valutabile'),
      (N:2611;R:026;W:06;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Chiuso'),
      (N:2612;R:026;W:10;T:1;F:3;M:22;X:22;KC:0;Fex:'N';D:'VA_Data_chiusura'),
      (N:2613;R:026;W:25;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Desc_Stato_Scheda'),
      (N:2614;R:026;W:10;T:1;F:3;M:22;X:22;KC:0;Fex:'N';D:'VA_Data_compilazione'),
      (N:2615;R:026;W:30;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Progressivi_Valutatori'),
      (N:2616;R:026;W:93;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Desc_Valutatori'),
      (N:2617;R:026;W:06;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Punteggio_finale_pesato'),
      (N:2618;R:026;W:04;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Esito_Val_intermedia'),
      (N:2619;R:026;W:10;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Desc_Esito_Val_intermedia'),
      (N:2620;R:026;W:125;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Valutazione_intermedia'),
      (N:2621;R:026;W:125;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Storia_Val_intermedia'),
      (N:2622;R:026;W:125;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Valutazioni_complessive'),
      (N:2623;R:026;W:125;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Obiettivi_azioni'),
      (N:2624;R:026;W:03;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Proposte_formative_1'),
      (N:2625;R:026;W:03;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Proposte_formative_2'),
      (N:2626;R:026;W:03;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Proposte_formative_3'),
      (N:2627;R:026;W:125;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Proposte_formative'),
      (N:2628;R:026;W:04;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Accettazione_Valutato'),
      (N:2629;R:026;W:13;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Desc_Accettazione_Valutato'),
      (N:2630;R:026;W:10;T:1;F:3;M:22;X:22;KC:0;Fex:'N';D:'VA_Data_Accettazione_Valutato'),
      (N:2631;R:026;W:125;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Commenti_valutato'),
      (N:2632;R:026;W:125;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Storia_Commenti_valutato'),
      (N:2633;R:026;W:125;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Note'),
      (N:2634;R:026;W:08;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Numero_Protocollo'),
      (N:2635;R:026;W:04;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Anno_Protocollo'),
      (N:2636;R:026;W:10;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Data_Protocollo'),
      (N:2637;R:026;W:04;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Cod_Tipo_protocollo'),
      (N:2638;R:026;W:10;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Desc_Tipo_protocollo'),
      (N:2639;R:026;W:04;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Presa_visione_Dip'),
      (N:2640;R:026;W:10;T:1;F:3;M:22;X:22;KC:0;Fex:'N';D:'VA_Data_Presa_visione_Dip'),
      (N:2641;R:026;W:05;T:1;F:0;M:22;X:22;KC:1;Fex:'N';D:'VA_Cod_Area'),
      (N:2642;R:026;W:25;T:1;F:0;M:22;X:22;KC:1;Fex:'N';D:'VA_Desc_Area'),
      (N:2643;R:026;W:06;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Peso_Area'),
      (N:2644;R:026;W:05;T:1;F:0;M:22;X:22;KC:1;Fex:'N';D:'VA_Cod_Elemento'),
      (N:2645;R:026;W:25;T:1;F:0;M:22;X:22;KC:1;Fex:'N';D:'VA_Desc_Elemento'),
      (N:2646;R:026;W:09;T:1;F:1;M:22;X:22;KC:0;Fex:'N';D:'VA_Peso_Elemento'),
      (N:2647;R:026;W:05;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Elemento_Valutabile'),
      (N:2648;R:026;W:06;T:1;F:1;M:22;X:22;KC:0;Fex:'N';D:'VA_Punteggio'),
      (N:2649;R:026;W:06;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Cod_Punteggio'),
      (N:2650;R:026;W:09;T:1;F:1;M:22;X:22;KC:0;Fex:'N';D:'VA_Punteggio_pesato'),
      (N:2651;R:026;W:125;T:1;F:0;M:22;X:22;KC:0;Fex:'N';D:'VA_Note_Punteggio'),
      //Inc.Verifiche incarichi: X = 23 (2700..2711)
      (N:2700;R:027;W:08;T:1;F:0;M:23;X:23;KC:0;Fex:'N';D:'Progressivo23'),
      (N:2701;R:027;W:10;T:1;F:3;M:23;X:23;KC:1;Fex:'N';D:'IV_Data_Verifica'),
      (N:2702;R:027;W:20;T:1;F:0;M:23;X:23;KC:1;Fex:'N';D:'IV_Cod_Tipo_Verifica'),
      (N:2703;R:027;W:40;T:1;F:0;M:23;X:23;KC:1;Fex:'N';D:'IV_Desc_Tipo_Verifica'),
      (N:2704;R:027;W:10;T:1;F:3;M:23;X:23;KC:1;Fex:'N';D:'IV_Decorrenza_Ind'),
      (N:2705;R:027;W:10;T:1;F:3;M:23;X:23;KC:0;Fex:'N';D:'IV_Scadenza_Ind'),
      (N:2706;R:027;W:40;T:1;F:0;M:23;X:23;KC:0;Fex:'N';D:'IV_Note'),
      (N:2707;R:027;W:20;T:1;F:0;M:23;X:23;KC:1;Fex:'N';D:'IV_TipoAtto'),
      (N:2708;R:027;W:20;T:1;F:0;M:23;X:23;KC:1;Fex:'N';D:'IV_NumAtto'),
      (N:2709;R:027;W:10;T:1;F:3;M:23;X:23;KC:1;Fex:'N';D:'IV_DataAtto'),
      (N:2710;R:027;W:20;T:1;F:0;M:23;X:23;KC:0;Fex:'N';D:'IV_Autorita'),
      (N:2711;R:027;W:10;T:1;F:3;M:23;X:23;KC:0;Fex:'N';D:'IV_DataEsec'),
      //Iter autorizzativi WEB: X = 25 (2800..2845)
      (N:2800;R:029;W:08;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'Progressivo25'),
      (N:2801;R:029;W:08;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_ID'),
      (N:2802;R:029;W:08;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_ITER'),
      (N:2803;R:029;W:08;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_STRUTTURA_ITER'),
      (N:2804;R:029;W:10;T:1;F:3;M:25;X:25;KC:0;Fex:'N';D:'IA_DATA_RICHIESTA'),
      (N:2805;R:029;W:20;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_NOTE_RICHIESTA'),
      (N:2806;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_TIPO_RICHIESTA'),
      (N:2807;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_RICHIESTA_AUTOMATICA'),
      (N:2808;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_STATO_RICHIESTA'),
      (N:2809;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_LIVELLO_AUTORIZZAZIONE'),
      (N:2810;R:029;W:10;T:1;F:3;M:25;X:25;KC:0;Fex:'N';D:'IA_DATA_AUTORIZZAZIONE'),
      (N:2811;R:029;W:20;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_NOTE_AUTORIZZAZIONE'),
      (N:2812;R:029;W:15;T:1;F:0;M:25;X:25;KC:1;Fex:'S';D:'IA_AUTORIZZATORE'),
      (N:2813;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'S';D:'IA_AUTORIZZAZIONE'),
      (N:2814;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_AUTORIZZ_AUTOMATICA'),
      (N:2815;R:029;W:10;T:1;F:3;M:25;X:25;KC:1;Fex:'N';D:'IA_DAL'),
      (N:2816;R:029;W:10;T:1;F:3;M:25;X:25;KC:1;Fex:'N';D:'IA_AL'),
      (N:2817;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_T050_TIPO'),
      (N:2818;R:029;W:05;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_T050_CAUSALE'),
      (N:2819;R:029;W:15;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T050_D_CAUSALE'),
      (N:2820;R:029;W:05;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T050_DAORE'),
      (N:2821;R:029;W:05;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T050_AORE'),
      (N:2822;R:029;W:10;T:1;F:3;M:25;X:25;KC:1;Fex:'N';D:'IA_T050_DATANASCITA'),
      (N:2823;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_T050_ELABORATO'),
      (N:2824;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_T065_TIPO'),
      (N:2825;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_T065_IDCONGUAGLIO'),
      (N:2826;R:029;W:06;T:1;F:2;M:25;X:25;KC:0;Fex:'N';D:'IA_T065_ECCED_CALC'),
      (N:2827;R:029;W:06;T:1;F:2;M:25;X:25;KC:0;Fex:'N';D:'IA_T065_ECCED_RICH'),
      (N:2828;R:029;W:06;T:1;F:2;M:25;X:25;KC:0;Fex:'N';D:'IA_T065_COMP_RICH'),
      (N:2829;R:029;W:06;T:1;F:2;M:25;X:25;KC:0;Fex:'N';D:'IA_T065_LIQ_RICH'),
      (N:2830;R:029;W:06;T:1;F:2;M:25;X:25;KC:0;Fex:'N';D:'IA_T065_ECCED_AUT'),
      (N:2831;R:029;W:06;T:1;F:2;M:25;X:25;KC:0;Fex:'N';D:'IA_T065_COMP_AUT'),
      (N:2832;R:029;W:06;T:1;F:2;M:25;X:25;KC:0;Fex:'N';D:'IA_T065_LIQ_AUT'),
      (N:2845;R:029;W:10;T:1;F:3;M:25;X:25;KC:0;Fex:'N';D:'IA_T085_GIORNO_ORIG'),
      (N:2833;R:029;W:02;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T085_TIPOGIORNO_ORIG'),
      (N:2834;R:029;W:05;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T085_ORARIO_ORIG'),
      (N:2835;R:029;W:10;T:1;F:3;M:25;X:25;KC:0;Fex:'N';D:'IA_T085_GIORNO_RICH'),
      (N:2836;R:029;W:02;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T085_TIPOGIORNO_RICH'),
      (N:2837;R:029;W:05;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T085_ORARIO_RICH'),
      (N:2838;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_T105_OPERAZIONE'),
      (N:2839;R:029;W:05;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T105_CAUS_ORIG'),
      (N:2840;R:029;W:05;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T105_CAUSALE'),
      (N:2841;R:029;W:02;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T105_VERSO_ORIG'),
      (N:2842;R:029;W:02;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T105_VERSO'),
      (N:2843;R:029;W:05;T:1;F:0;M:25;X:25;KC:0;Fex:'N';D:'IA_T105_ORA'),
      (N:2844;R:029;W:02;T:1;F:0;M:25;X:25;KC:1;Fex:'N';D:'IA_T105_ELABORATO'),
      //Familiari X = 26 (2900..2960)
      (N:2900;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'Progressivo26'),
      (N:2901;R:030;W:10;T:1;F:3;M:26;X:26;KC:1;Fex:'N';D:'FM_DECORRENZA'),
      (N:2902;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_DECORRENZA_FINE'),
      (N:2903;R:030;W:08;T:1;F:0;M:26;X:26;KC:1;Fex:'N';D:'FM_NUMORD'),
      (N:2904;R:030;W:10;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_MATRICOLA'),
      (N:2905;R:030;W:10;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_ID_ESTERNO'),
      (N:2906;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_COGNOME'),
      (N:2907;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_NOME'),
      (N:2908;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_GRADOPAR'),
      (N:2909;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_NUMGRADO'),
      (N:2910;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_TIPOPAR'),
      (N:2911;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_SESSO'),
      (N:2912;R:030;W:10;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_CODFISCALE'),
      (N:2913;R:030;W:30;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_INDIRIZZO'),
      (N:2914;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_COMUNE'),
      (N:2915;R:030;W:10;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_CAP'),
      (N:2916;R:030;W:10;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_TELEFONO'),
      (N:2917;R:030;W:10;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_CAPNAS'),
      (N:2918;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_COMNAS'),
      (N:2919;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_DATANAS'),
      (N:2920;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_DATANAS_PRESUNTA'),
      (N:2921;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_DATA_PREADOZ'),
      (N:2922;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_DATAADOZ'),
      (N:2923;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_TIPO_ADOZ_AFFID'),
      (N:2924;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_NAZIONE'),
      (N:2925;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_TIPO_DETRAZIONE'),
      (N:2926;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_PERC_CARICO'),
      (N:2927;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_DATAMAT'),
      (N:2928;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_DATASEP'),
      (N:2929;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_DETR_FIGLIO_HANDICAP'),
      (N:2930;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_COMPONENTE_ANF'),
      (N:2931;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_REDDITO_ANF'),
      (N:2932;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_REDDITO_ALTRO_ANF'),
      (N:2933;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_SPECIALE_ANF'),
      (N:2934;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_INABILE_ANF'),
      (N:2935;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_CAUSALI_ABILITATE'),
      (N:2936;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_NOME_PA'),
      (N:2937;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_DURATA_PA'),
      (N:2938;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_NOME_PA_ALT'),
      (N:2939;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_DATA_ULT_FAM_CAR'),
      (N:2940;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_DETR_FIGLIO_100_AFFID'),
      (N:2941;R:030;W:05;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_ANNO_AVV'),
      (N:2942;R:030;W:05;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_ANNO_AVV_FAM'),
      (N:2943;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_TIPO_DISABILITA'),
      (N:2944;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_ANNO_REVISIONE'),
      (N:2945;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_MOTIVO_GRADO_3'),
      (N:2946;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_ALTERNATIVA'),
      (N:2947;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_MOTIVO_GRADO_3_ALT'),
      (N:2948;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_GRAV_INIZIO_TEOR'),
      (N:2949;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_GRAV_INIZIO_SCELTA'),
      (N:2950;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_GRAV_INIZIO_EFF'),
      (N:2951;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_GRAV_FINE'),
      (N:2952;R:030;W:20;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_MOTIVO_ESCLUSIONE'),
      (N:2953;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_CARTA_ID_NUMERO'),
      (N:2954;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_CARTA_ID_DATA_RIL'),
      (N:2955;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_CARTA_ID_DATA_SCAD'),
      (N:2956;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_PASSAPORTO_NUMERO'),
      (N:2957;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_PASSAPORTO_DATA_RIL'),
      (N:2958;R:030;W:10;T:1;F:3;M:26;X:26;KC:0;Fex:'N';D:'FM_PASSAPORTO_DATA_SCAD'),
      (N:2959;R:030;W:08;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_INSERIMENTU_CU'),
      (N:2960;R:030;W:30;T:1;F:0;M:26;X:26;KC:0;Fex:'N';D:'FM_NOTE')
      );
begin
  SetLength(DatiRiep,Length(ConstDatiRiep));
  for i:=0 to High(ConstDatiRiep) do
    DatiRiep[i]:=ConstDatiRiep[i];
end;

procedure TA077FGeneratoreStampeMW.CaricaSerbatoi;
var
  i: Integer;
begin
  //Descrizione dei serbatoi disponibili
  SetLength(Serbatoi,27);
  //Inizializzazioni
  for i:=0 to High(Serbatoi) do
  begin
    Serbatoi[i].Esclusivo:=False;
    Serbatoi[i].DatoDalAl:='';
  end;

  Serbatoi[0].N:=507;
  Serbatoi[0].R:=001;
  Serbatoi[0].M:=0;
  Serbatoi[0].X:=0;
  Serbatoi[0].Multiplo:=False;
  Serbatoi[0].Nome:='Dati anagrafici';
  Serbatoi[0].Tabelle:='T030_ANAGRAFICO,V430_STORICO';
  Serbatoi[0].Applicazione:='RILPRE,STAGIU,MISTRA';

  Serbatoi[1].N:=1;
  Serbatoi[1].M:=5;
  Serbatoi[1].X:=5;
  Serbatoi[1].Multiplo:=True;
  Serbatoi[1].Nome:='Riepiloghi mensili';
  Serbatoi[1].Applicazione:='RILPRE,STAGIU';

  Serbatoi[2].N:=1950;
  Serbatoi[2].M:=24;
  Serbatoi[2].X:=24;
  Serbatoi[2].Multiplo:=True;
  Serbatoi[2].Nome:='Assestamento ore anni prec.';
  Serbatoi[2].Applicazione:='RILPRE';

  Serbatoi[3].N:=400;
  Serbatoi[3].M:=1;
  Serbatoi[3].X:=1;
  Serbatoi[3].Multiplo:=True;
  Serbatoi[3].Nome:='Indennità di presenza';
  Serbatoi[3].Applicazione:='RILPRE';

  Serbatoi[4].N:=1700;
  Serbatoi[4].M:=2;
  Serbatoi[4].X:=2;
  Serbatoi[4].Multiplo:=True;
  Serbatoi[4].Nome:='Riepilogo presenze';
  Serbatoi[4].Applicazione:='RILPRE';

  Serbatoi[5].N:=1800;
  Serbatoi[5].M:=3;
  Serbatoi[5].X:=3;
  Serbatoi[5].Multiplo:=True;
  Serbatoi[5].Nome:='Riepilogo assenze';
  Serbatoi[5].Applicazione:='RILPRE,STAGIU,MISTRA';

  Serbatoi[6].N:=800;
  Serbatoi[6].M:=4;
  Serbatoi[6].X:=4;
  Serbatoi[6].Multiplo:=True;
  Serbatoi[6].Nome:='Dati giornalieri';
  Serbatoi[6].Applicazione:='RILPRE';

  Serbatoi[7].N:=1300;
  Serbatoi[7].M:=6;
  Serbatoi[7].X:=6;
  Serbatoi[7].Multiplo:=True;
  Serbatoi[7].Nome:='Missioni/Trasferte';
  Serbatoi[7].Applicazione:='RILPRE,MISTRA';

  Serbatoi[8].N:=1600;
  Serbatoi[8].M:=7;
  Serbatoi[8].X:=7;
  Serbatoi[8].Multiplo:=True;
  Serbatoi[8].Nome:='Missioni: rimborsi';
  Serbatoi[8].Applicazione:='RILPRE,MISTRA';

  Serbatoi[9].N:=1400;
  Serbatoi[9].M:=14;
  Serbatoi[9].X:=14;
  Serbatoi[9].Multiplo:=True;
  Serbatoi[9].Nome:='Missioni: indennità km';
  Serbatoi[9].Applicazione:='RILPRE,MISTRA';

  Serbatoi[10].N:=2100;
  Serbatoi[10].M:=16;
  Serbatoi[10].X:=16;
  Serbatoi[10].Multiplo:=True;
  Serbatoi[10].Nome:='Missioni: anticipi';
  Serbatoi[10].Applicazione:='RILPRE,MISTRA';

  Serbatoi[11].N:=1900;
  Serbatoi[11].M:=8;
  Serbatoi[11].X:=8;
  Serbatoi[11].Multiplo:=True;
  Serbatoi[11].Nome:='Voci paghe scaricate';
  Serbatoi[11].Applicazione:='RILPRE,STAGIU,MISTRA';

  Serbatoi[12].N:=300;
  Serbatoi[12].M:=9;
  Serbatoi[12].X:=9;
  Serbatoi[12].Multiplo:=True;
  Serbatoi[12].Nome:='Turni di reperibilità';
  Serbatoi[12].Applicazione:='RILPRE';

  Serbatoi[13].N:=1500;
  Serbatoi[13].M:=10;
  Serbatoi[13].X:=10;
  Serbatoi[13].Multiplo:=True;
  Serbatoi[13].Nome:='Corsi di formazione';
  Serbatoi[13].Applicazione:='STAGIU';

  Serbatoi[14].N:=1000;
  Serbatoi[14].M:=11;
  Serbatoi[14].X:=11;
  Serbatoi[14].Multiplo:=True;
  Serbatoi[14].Nome:='Iscrizioni sindacali';
  Serbatoi[14].Applicazione:='RILPRE';

  Serbatoi[15].N:=1100;
  Serbatoi[15].M:=12;
  Serbatoi[15].X:=12;
  Serbatoi[15].Multiplo:=True;
  Serbatoi[15].Nome:='Organismi sindacali';
  Serbatoi[15].Applicazione:='RILPRE';

  Serbatoi[16].N:=1200;
  Serbatoi[16].M:=13;
  Serbatoi[16].X:=13;
  Serbatoi[16].Multiplo:=True;
  Serbatoi[16].Nome:='Permessi sindacali';
  Serbatoi[16].Applicazione:='RILPRE';

  Serbatoi[17].N:=2000;
  Serbatoi[17].M:=15;
  Serbatoi[17].X:=15;
  Serbatoi[17].Multiplo:=True;
  Serbatoi[17].Nome:='Incentivi';
  Serbatoi[17].Applicazione:='RILPRE';

  Serbatoi[18].N:=2200;
  Serbatoi[18].M:=17;
  Serbatoi[18].X:=17;
  Serbatoi[18].Multiplo:=True;
  Serbatoi[18].Nome:='Rischi/Prescrizioni';
  Serbatoi[18].Applicazione:='STAGIU';

  Serbatoi[19].N:=2300;
  Serbatoi[19].M:=18;
  Serbatoi[19].X:=18;
  Serbatoi[19].Multiplo:=True;
  Serbatoi[19].Nome:='Incarichi';
  Serbatoi[19].Applicazione:='STAGIU';

  Serbatoi[20].N:=2700;
  Serbatoi[20].M:=23;
  Serbatoi[20].X:=23;
  Serbatoi[20].Multiplo:=True;
  Serbatoi[20].Nome:='Inc.: verifiche indennità';
  Serbatoi[20].Applicazione:='STAGIU';

  Serbatoi[21].N:=2400;
  Serbatoi[21].M:=19;
  Serbatoi[21].X:=19;
  Serbatoi[21].Multiplo:=True;
  Serbatoi[21].Nome:='Messaggi per WEB';
  Serbatoi[21].Applicazione:='RILPRE';

  Serbatoi[22].N:=2430;
  Serbatoi[22].M:=20;
  Serbatoi[22].X:=20;
  Serbatoi[22].Multiplo:=True;
  Serbatoi[22].Nome:='Iter autorizzativi da WEB';
  Serbatoi[22].Applicazione:='RILPRE';

  Serbatoi[23].N:=2500;
  Serbatoi[23].M:=21;
  Serbatoi[23].X:=21;
  Serbatoi[23].Multiplo:=True;
  Serbatoi[23].Nome:='Carta dei servizi';
  Serbatoi[23].Applicazione:='RILPRE';

  Serbatoi[24].N:=2600;
  Serbatoi[24].M:=22;
  Serbatoi[24].X:=22;
  Serbatoi[24].Multiplo:=True;
  Serbatoi[24].Nome:='Valutazioni';
  Serbatoi[24].Applicazione:='RILPRE,STAGIU';

  Serbatoi[25].N:=2800;
  Serbatoi[25].M:=25;
  Serbatoi[25].X:=25;
  Serbatoi[25].Multiplo:=True;
  Serbatoi[25].Nome:='Iter autorizzativi WEB';
  Serbatoi[25].Applicazione:='RILPRE';

  Serbatoi[26].N:=2900;
  Serbatoi[26].M:=26;
  Serbatoi[26].X:=26;
  Serbatoi[26].Multiplo:=True;
  Serbatoi[26].Nome:='Familiari';
  Serbatoi[26].Applicazione:='RILPRE,STAGIU';
end;

procedure TA077FGeneratoreStampeMW.CaricaTabelleCollegate;
var
  i: Integer;
begin
  //Descrizione delle tabelle collegate
  SetLength(TabelleCollegate,26);
  for i:=0 to High(TabelleCollegate) do
  begin
    TabelleCollegate[i].Esiste:=False;
    TabelleCollegate[i].Totalizzato:=False;
    TabelleCollegate[i].DaTotalizzare:=True;
    TabelleCollegate[i].Ordinato:=True;
    TabelleCollegate[i].Data[2]:='';
    TabelleCollegate[i].DatiDalAl:='';
    TabelleCollegate[i].InsDaSelect:=False;
  end;
  //Ind.Presenza
  TabelleCollegate[0].M:=1;
  TabelleCollegate[0].NomeKey:='T920_KEY1';
  TabelleCollegate[0].KeyTotale:='T920_KEYTOT1';
  TabelleCollegate[0].Join:='T0.PROGRESSIVO = PROGRESSIVO1(+)';
  TabelleCollegate[0].Progressivo:='PROGRESSIVO1';
  TabelleCollegate[0].Data[1]:='DATAINDPRESENZA';
  TabelleCollegate[0].DettaglioPeriodico:='M';
  TabelleCollegate[0].DatiNecessari:='DATAINDPRESENZA';
  TabelleCollegate[0].OQIns:=Ins920_1;
  //Causali di presenza
  TabelleCollegate[1].M:=2;
  TabelleCollegate[1].NomeKey:='T920_KEY2';
  TabelleCollegate[1].KeyTotale:='T920_KEYTOT2';
  TabelleCollegate[1].Join:='T0.PROGRESSIVO = PROGRESSIVO2(+)';
  TabelleCollegate[1].Progressivo:='PROGRESSIVO2';
  TabelleCollegate[1].Data[1]:='DATARIEPILOGOPRES';
  TabelleCollegate[1].DettaglioPeriodico:='M';
  TabelleCollegate[1].DatiNecessari:='DATARIEPILOGOPRES';
  TabelleCollegate[1].OQIns:=Ins920_2;
    //Causali di assenza
  TabelleCollegate[2].M:=3;
  TabelleCollegate[2].NomeKey:='T920_KEY3';
  TabelleCollegate[2].KeyTotale:='T920_KEYTOT3';
  TabelleCollegate[2].Join:='T0.PROGRESSIVO = PROGRESSIVO3(+)';
  TabelleCollegate[2].Progressivo:='PROGRESSIVO3';
  TabelleCollegate[2].Data[1]:='DATARIEPILOGOASS';
  TabelleCollegate[2].DettaglioPeriodico:='G';
  TabelleCollegate[2].DatiNecessari:='DATARIEPILOGOASS,MISURAASSENZE';
  TabelleCollegate[2].OQIns:=Ins920_3;
    //Dati giornalieri
  TabelleCollegate[3].M:=4;
  TabelleCollegate[3].NomeKey:='T920_KEY4';
  TabelleCollegate[3].KeyTotale:='T920_KEYTOT4';
  TabelleCollegate[3].Join:='T0.PROGRESSIVO = PROGRESSIVO4(+) AND T4.DATACONTEGGIO(+) BETWEEN T0.T430DATADECORRENZA AND T0.T430DATAFINE';
  TabelleCollegate[3].Progressivo:='PROGRESSIVO4';
  TabelleCollegate[3].Data[1]:='DATACONTEGGIO';
  TabelleCollegate[3].DettaglioPeriodico:='G';
  TabelleCollegate[3].DatiNecessari:='DATACONTEGGIO';
  TabelleCollegate[3].OQIns:=Ins920_4;
    //Dati mensili
  TabelleCollegate[4].M:=5;
  TabelleCollegate[4].NomeKey:='T920_KEY5';
  TabelleCollegate[4].KeyTotale:='T920_KEYTOT5';
  TabelleCollegate[4].Join:='T0.PROGRESSIVO = PROGRESSIVO5(+)';
  TabelleCollegate[4].Progressivo:='PROGRESSIVO5';
  TabelleCollegate[4].Data[1]:='DATARIEPILOGOMENSILE';
  TabelleCollegate[4].DettaglioPeriodico:='M';
  TabelleCollegate[4].DatiNecessari:='DATARIEPILOGOMENSILE';
  TabelleCollegate[4].OQIns:=Ins920_5;
    //Missioni/Trasferte
  TabelleCollegate[5].M:=6;
  TabelleCollegate[5].NomeKey:='T920_KEY6';
  TabelleCollegate[5].KeyTotale:='T920_KEYTOT6';
  TabelleCollegate[5].Join:='T0.PROGRESSIVO = PROGRESSIVO6(+)';
  TabelleCollegate[5].Progressivo:='PROGRESSIVO6';
  TabelleCollegate[5].Data[1]:='MT_MESESCARICO';
  TabelleCollegate[5].DettaglioPeriodico:='M';
  TabelleCollegate[5].DatiNecessari:='MT_MESESCARICO';
  TabelleCollegate[5].DatiDalAl:='MT_MESESCARICO,MT_MESECOMPETENZA,MT_DADATA';
  TabelleCollegate[5].OQIns:=Ins920_6;
    //Missioni:Rimborsi
  TabelleCollegate[6].M:=7;
  TabelleCollegate[6].NomeKey:='T920_KEY7';
  TabelleCollegate[6].KeyTotale:='T920_KEYTOT7';
  TabelleCollegate[6].Join:='T0.PROGRESSIVO = PROGRESSIVO7(+)';
  TabelleCollegate[6].Progressivo:='PROGRESSIVO7';
  TabelleCollegate[6].Data[1]:='MR_MESESCARICO';
  TabelleCollegate[6].DettaglioPeriodico:='M';
  TabelleCollegate[6].DatiNecessari:='MR_MESESCARICO';
  TabelleCollegate[6].DatiDalAl:='MR_MESESCARICO,MR_MESECOMPETENZA,MR_DADATA';
  TabelleCollegate[6].OQIns:=Ins920_7;
    //Voci paghe scaricate
  TabelleCollegate[7].M:=8;
  TabelleCollegate[7].NomeKey:='T920_KEY8';
  TabelleCollegate[7].KeyTotale:='T920_KEYTOT8';
  TabelleCollegate[7].Join:='T0.PROGRESSIVO = PROGRESSIVO8(+)';
  TabelleCollegate[7].Progressivo:='PROGRESSIVO8';
  TabelleCollegate[7].Data[1]:='VP_MESECOMPETENZA';
  TabelleCollegate[7].DettaglioPeriodico:='M';
  TabelleCollegate[7].DatiNecessari:='VP_MESECOMPETENZA,VP_MISURA';
  TabelleCollegate[7].OQIns:=Ins920_8;
    //Turni di reperibilità
  TabelleCollegate[8].M:=9;
  TabelleCollegate[8].NomeKey:='T920_KEY9';
  TabelleCollegate[8].KeyTotale:='T920_KEYTOT9';
  TabelleCollegate[8].Join:='T0.PROGRESSIVO = PROGRESSIVO9(+)';
  TabelleCollegate[8].Progressivo:='PROGRESSIVO9';
  TabelleCollegate[8].Data[1]:='IR_DATA';
  TabelleCollegate[8].DettaglioPeriodico:='M';
  TabelleCollegate[8].DatiNecessari:='IR_DATA';
  TabelleCollegate[8].OQIns:=Ins920_9;
    //Corsi di formazione
  TabelleCollegate[9].M:=10;
  TabelleCollegate[9].NomeKey:='T920_KEY10';
  TabelleCollegate[9].KeyTotale:='T920_KEYTOT10';
  TabelleCollegate[9].Join:='T0.PROGRESSIVO = PROGRESSIVO10(+)';
  TabelleCollegate[9].Progressivo:='PROGRESSIVO10';
  TabelleCollegate[9].Data[1]:='CF_DATA_PARTECIPAZIONE';
  TabelleCollegate[9].DettaglioPeriodico:='G';
  TabelleCollegate[9].DatiNecessari:='CF_DATA_PARTECIPAZIONE';
  TabelleCollegate[9].OQIns:=Ins920_10;
    //Iscrizioni ai sindacati (organizzazioni sindacali)
  TabelleCollegate[10].M:=11;
  TabelleCollegate[10].NomeKey:='T920_KEY11';
  TabelleCollegate[10].KeyTotale:='T920_KEYTOT11';
  TabelleCollegate[10].Join:='T0.PROGRESSIVO = PROGRESSIVO11(+)';
  TabelleCollegate[10].Progressivo:='PROGRESSIVO11';
  TabelleCollegate[10].Data[1]:='IS_DATA_ISCRIZIONE';
  TabelleCollegate[10].DettaglioPeriodico:='G';
  TabelleCollegate[10].DatiNecessari:='IS_DATA_ISCRIZIONE';
  TabelleCollegate[10].OQIns:=Ins920_11;
    //Organismi sindacali
  TabelleCollegate[11].M:=12;
  TabelleCollegate[11].NomeKey:='T920_KEY12';
  TabelleCollegate[11].KeyTotale:='T920_KEYTOT12';
  TabelleCollegate[11].Join:='T0.PROGRESSIVO = PROGRESSIVO12(+)';
  TabelleCollegate[11].Progressivo:='PROGRESSIVO12';
  TabelleCollegate[11].Data[1]:='OS_DATA_INIZIO';
  TabelleCollegate[11].DettaglioPeriodico:='G';
  TabelleCollegate[11].DatiNecessari:='OS_DATA_INIZIO';
  TabelleCollegate[11].OQIns:=Ins920_12;
    //Permessi sindacali
  TabelleCollegate[12].M:=13;
  TabelleCollegate[12].NomeKey:='T920_KEY13';
  TabelleCollegate[12].KeyTotale:='T920_KEYTOT13';
  TabelleCollegate[12].Join:='T0.PROGRESSIVO = PROGRESSIVO13(+)';
  TabelleCollegate[12].Progressivo:='PROGRESSIVO13';
  TabelleCollegate[12].Data[1]:='PS_DATA';
  TabelleCollegate[12].DettaglioPeriodico:='G';
  TabelleCollegate[12].DatiNecessari:='PS_DATA';
  TabelleCollegate[12].OQIns:=Ins920_13;
    //Missioni: indennità km
  TabelleCollegate[13].M:=14;
  TabelleCollegate[13].NomeKey:='T920_KEY14';
  TabelleCollegate[13].KeyTotale:='T920_KEYTOT14';
  TabelleCollegate[13].Join:='T0.PROGRESSIVO = PROGRESSIVO14(+)';
  TabelleCollegate[13].Progressivo:='PROGRESSIVO14';
  TabelleCollegate[13].Data[1]:='MK_MESESCARICO';
  TabelleCollegate[13].DettaglioPeriodico:='M';
  TabelleCollegate[13].DatiNecessari:='MK_MESESCARICO';
  TabelleCollegate[13].DatiDalAl:='MK_MESESCARICO,MK_MESECOMPETENZA,MK_DADATA';
  TabelleCollegate[13].OQIns:=Ins920_14;
    //Incentivi
  TabelleCollegate[14].M:=15;
  TabelleCollegate[14].NomeKey:='T920_KEY15';
  TabelleCollegate[14].KeyTotale:='T920_KEYTOT15';
  TabelleCollegate[14].Join:='T0.PROGRESSIVO = PROGRESSIVO15(+)';
  TabelleCollegate[14].Progressivo:='PROGRESSIVO15';
  TabelleCollegate[14].Data[1]:='QI_DATA';
  TabelleCollegate[14].DettaglioPeriodico:='M';
  TabelleCollegate[14].DatiNecessari:='QI_DATA';
  TabelleCollegate[14].OQIns:=Ins920_15;
    //Missioni: Anticipi
  TabelleCollegate[15].M:=16;
  TabelleCollegate[15].NomeKey:='T920_KEY16';
  TabelleCollegate[15].KeyTotale:='T920_KEYTOT16';
  TabelleCollegate[15].Join:='T0.PROGRESSIVO = PROGRESSIVO16(+)';
  TabelleCollegate[15].Progressivo:='PROGRESSIVO16';
  TabelleCollegate[15].Data[1]:='MA_DATAMISSIONE';
  TabelleCollegate[15].DettaglioPeriodico:='G';
  TabelleCollegate[15].DatiNecessari:='MA_DATAMISSIONE';
  TabelleCollegate[15].OQIns:=Ins920_16;
    //Rischi/Prescrizioni
  TabelleCollegate[16].M:=17;
  TabelleCollegate[16].NomeKey:='T920_KEY17';
  TabelleCollegate[16].KeyTotale:='T920_KEYTOT17';
  TabelleCollegate[16].Join:='T0.PROGRESSIVO = PROGRESSIVO17(+)';
  TabelleCollegate[16].Progressivo:='PROGRESSIVO17';
  TabelleCollegate[16].Data[1]:='RP_DATA_PERIODO';
  TabelleCollegate[16].DettaglioPeriodico:='G';
  TabelleCollegate[16].DatiNecessari:='RP_DATA_PERIODO';
  TabelleCollegate[16].OQIns:=Ins920_17;
    //Incarichi
  TabelleCollegate[17].M:=18;
  TabelleCollegate[17].NomeKey:='T920_KEY18';
  TabelleCollegate[17].KeyTotale:='T920_KEYTOT18';
  TabelleCollegate[17].Join:='T0.PROGRESSIVO = PROGRESSIVO18(+)';
  TabelleCollegate[17].Progressivo:='PROGRESSIVO18';
  TabelleCollegate[17].Data[1]:='IN_DATA_AFFIDAMENTO';
  TabelleCollegate[17].Data[2]:='IN_DATA_SCADENZA';
  TabelleCollegate[17].DettaglioPeriodico:='G';
  TabelleCollegate[17].DatiNecessari:='IN_DATA_AFFIDAMENTO,IN_DATA_SCADENZA';
  TabelleCollegate[17].OQIns:=Ins920_18;
    //Messaggi per il WEB
  TabelleCollegate[18].M:=19;
  TabelleCollegate[18].NomeKey:='T920_KEY19';
  TabelleCollegate[18].KeyTotale:='T920_KEYTOT19';
  TabelleCollegate[18].Join:='T0.PROGRESSIVO = PROGRESSIVO19(+)';
  TabelleCollegate[18].Progressivo:='PROGRESSIVO19';
  TabelleCollegate[18].Data[1]:='MW_DATA';
  TabelleCollegate[18].DettaglioPeriodico:='G';
  TabelleCollegate[18].DatiNecessari:='MW_DATA';
  TabelleCollegate[18].OQIns:=Ins920_19;
    //Iter autorizzativi WEB
  TabelleCollegate[19].M:=20;
  TabelleCollegate[19].NomeKey:='T920_KEY20';
  TabelleCollegate[19].KeyTotale:='T920_KEYTOT20';
  TabelleCollegate[19].Join:='T0.PROGRESSIVO = PROGRESSIVO20(+)';
  TabelleCollegate[19].Progressivo:='PROGRESSIVO20';
  TabelleCollegate[19].Data[1]:='RW_DATA1';
  TabelleCollegate[19].Data[2]:='RW_DATA2';
  TabelleCollegate[19].DettaglioPeriodico:='G';
  TabelleCollegate[19].DatiNecessari:='RW_DATA1,RW_DATA2';
  TabelleCollegate[19].OQIns:=Ins920_20;
    //Carta dei servizi
  TabelleCollegate[20].M:=21;
  TabelleCollegate[20].NomeKey:='T920_KEY21';
  TabelleCollegate[20].KeyTotale:='T920_KEYTOT21';
  TabelleCollegate[20].Join:='T0.PROGRESSIVO = PROGRESSIVO21(+)';
  TabelleCollegate[20].Progressivo:='PROGRESSIVO21';
  TabelleCollegate[20].Data[1]:='CS_DATA';
  TabelleCollegate[20].DettaglioPeriodico:='G';
  TabelleCollegate[20].DatiNecessari:='CS_DATA';
  TabelleCollegate[20].OQIns:=Ins920_21;
    //Valutazioni
  TabelleCollegate[21].M:=22;
  TabelleCollegate[21].NomeKey:='T920_KEY22';
  TabelleCollegate[21].KeyTotale:='T920_KEYTOT22';
  TabelleCollegate[21].Join:='T0.PROGRESSIVO = PROGRESSIVO22(+)';
  TabelleCollegate[21].Progressivo:='PROGRESSIVO22';
  TabelleCollegate[21].Data[1]:='VA_DATA_VALUTAZIONE';
  TabelleCollegate[21].DettaglioPeriodico:='G';
  TabelleCollegate[21].DatiNecessari:='VA_DATA_VALUTAZIONE';
  TabelleCollegate[21].OQIns:=Ins920_22;
    //Inc.: verifiche indennità
  TabelleCollegate[22].M:=23;
  TabelleCollegate[22].NomeKey:='T920_KEY23';
  TabelleCollegate[22].KeyTotale:='T920_KEYTOT23';
  TabelleCollegate[22].Join:='T0.PROGRESSIVO = PROGRESSIVO23(+)';
  TabelleCollegate[22].Progressivo:='PROGRESSIVO23';
  TabelleCollegate[22].Data[1]:='IV_DATA_VERIFICA';
  TabelleCollegate[22].DettaglioPeriodico:='G';
  TabelleCollegate[22].DatiNecessari:='IV_DATA_VERIFICA,IV_COD_TIPO_VERIFICA';
  TabelleCollegate[22].OQIns:=Ins920_23;
    //Inc.: verifiche indennità
  TabelleCollegate[23].M:=24;
  TabelleCollegate[23].NomeKey:='T920_KEY24';
  TabelleCollegate[23].KeyTotale:='T920_KEYTOT24';
  TabelleCollegate[23].Join:='T0.PROGRESSIVO = PROGRESSIVO24(+)';
  TabelleCollegate[23].Progressivo:='PROGRESSIVO24';
  TabelleCollegate[23].Data[1]:='VAP_DATA_VARIAZIONE';
  TabelleCollegate[23].DettaglioPeriodico:='M';
  TabelleCollegate[23].DatiNecessari:='VAP_ANNO_COMPETENZA,VAP_DATA_VARIAZIONE';
  TabelleCollegate[23].OQIns:=Ins920_24;
    //Iter autorizzativi WEB
  TabelleCollegate[24].M:=25;
  TabelleCollegate[24].NomeKey:='T920_KEY25';
  TabelleCollegate[24].KeyTotale:='T920_KEYTOT25';
  TabelleCollegate[24].Join:='T0.PROGRESSIVO = PROGRESSIVO25(+)';
  TabelleCollegate[24].Progressivo:='PROGRESSIVO25';
  TabelleCollegate[24].Data[1]:='IA_DAL';
  TabelleCollegate[24].Data[2]:='IA_AL';
  TabelleCollegate[24].DettaglioPeriodico:='G';
  TabelleCollegate[24].DatiNecessari:='IA_DAL,IA_AL';
  TabelleCollegate[24].OQIns:=Ins920_25;
    //Familiari
  TabelleCollegate[25].M:=26;
  TabelleCollegate[25].NomeKey:='T920_KEY26';
  TabelleCollegate[25].KeyTotale:='T920_KEYTOT26';
  TabelleCollegate[25].Join:='T0.PROGRESSIVO = PROGRESSIVO26(+)';
  TabelleCollegate[25].Progressivo:='PROGRESSIVO26';
  TabelleCollegate[25].Data[1]:='';
  TabelleCollegate[25].DettaglioPeriodico:='';
  TabelleCollegate[25].DatiNecessari:='';
  TabelleCollegate[25].OQIns:=Ins920_26;

  //Gestione campi data per individuare il periodo di validità del dato
  for i:=0 to High(TabelleCollegate) do
    if (TabelleCollegate[i].Data[2] = '') and (TabelleCollegate[i].Data[2] <> TabelleCollegate[i].Data[1]) then
      TabelleCollegate[i].Data[2]:=TabelleCollegate[i].Data[1];
end;

procedure TA077FGeneratoreStampeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT162.Open;

  // Descrizione delle Variazioni di Formato
  SetLength(VariazioniFormato,32);
  VariazioniFormato[0].Dato:='ASSENZEDELMESE';
  VariazioniFormato[0].Colonna:='MISURAASSENZE';
  VariazioniFormato[0].Formati:='G=1,O=2';
  VariazioniFormato[1].Dato:='COMPASSANNOPREC';
  VariazioniFormato[1].Colonna:='MISURAASSENZE';
  VariazioniFormato[1].Formati:='G=1,O=2';
  VariazioniFormato[2].Dato:='COMPASSANNOCORR';
  VariazioniFormato[2].Colonna:='MISURAASSENZE';
  VariazioniFormato[2].Formati:='G=1,O=2';
  VariazioniFormato[3].Dato:='COMPASSTOTALI';
  VariazioniFormato[3].Colonna:='MISURAASSENZE';
  VariazioniFormato[3].Formati:='G=1,O=2';
  VariazioniFormato[4].Dato:='COMPASSTOTALI1';
  VariazioniFormato[4].Colonna:='MISURAASSENZE';
  VariazioniFormato[4].Formati:='G=1,O=2';
  VariazioniFormato[5].Dato:='COMPASSTOTALI2';
  VariazioniFormato[5].Colonna:='MISURAASSENZE';
  VariazioniFormato[5].Formati:='G=1,O=2';
  VariazioniFormato[6].Dato:='COMPASSTOTALI3';
  VariazioniFormato[6].Colonna:='MISURAASSENZE';
  VariazioniFormato[6].Formati:='G=1,O=2';
  VariazioniFormato[7].Dato:='COMPASSTOTALI4';
  VariazioniFormato[7].Colonna:='MISURAASSENZE';
  VariazioniFormato[7].Formati:='G=1,O=2';
  VariazioniFormato[8].Dato:='COMPASSTOTALI5';
  VariazioniFormato[8].Colonna:='MISURAASSENZE';
  VariazioniFormato[8].Formati:='G=1,O=2';
  VariazioniFormato[9].Dato:='COMPASSTOTALI6';
  VariazioniFormato[9].Colonna:='MISURAASSENZE';
  VariazioniFormato[9].Formati:='G=1,O=2';
  VariazioniFormato[10].Dato:='ASSFRUITEANNOPREC';
  VariazioniFormato[10].Colonna:='MISURAASSENZE';
  VariazioniFormato[10].Formati:='G=1,O=2';
  VariazioniFormato[11].Dato:='ASSFRUITEANNOCORR';
  VariazioniFormato[11].Colonna:='MISURAASSENZE';
  VariazioniFormato[11].Formati:='G=1,O=2';
  VariazioniFormato[12].Dato:='ASSENZEFRUITE';
  VariazioniFormato[12].Colonna:='MISURAASSENZE';
  VariazioniFormato[12].Formati:='G=1,O=2';
  VariazioniFormato[13].Dato:='ASSENZEFRUITE1';
  VariazioniFormato[13].Colonna:='MISURAASSENZE';
  VariazioniFormato[13].Formati:='G=1,O=2';
  VariazioniFormato[14].Dato:='ASSENZEFRUITE2';
  VariazioniFormato[14].Colonna:='MISURAASSENZE';
  VariazioniFormato[14].Formati:='G=1,O=2';
  VariazioniFormato[15].Dato:='ASSENZEFRUITE3';
  VariazioniFormato[15].Colonna:='MISURAASSENZE';
  VariazioniFormato[15].Formati:='G=1,O=2';
  VariazioniFormato[16].Dato:='ASSENZEFRUITE4';
  VariazioniFormato[16].Colonna:='MISURAASSENZE';
  VariazioniFormato[16].Formati:='G=1,O=2';
  VariazioniFormato[17].Dato:='ASSENZEFRUITE5';
  VariazioniFormato[17].Colonna:='MISURAASSENZE';
  VariazioniFormato[17].Formati:='G=1,O=2';
  VariazioniFormato[18].Dato:='ASSENZEFRUITE6';
  VariazioniFormato[18].Colonna:='MISURAASSENZE';
  VariazioniFormato[18].Formati:='G=1,O=2';
  VariazioniFormato[19].Dato:='ASSENZERESIDUEANNOPREC';
  VariazioniFormato[19].Colonna:='MISURAASSENZE';
  VariazioniFormato[19].Formati:='G=1,O=2';
  VariazioniFormato[20].Dato:='ASSENZERESIDUEANNOCORR';
  VariazioniFormato[20].Colonna:='MISURAASSENZE';
  VariazioniFormato[20].Formati:='G=1,O=2';
  VariazioniFormato[21].Dato:='ASSENZERESIDUE';
  VariazioniFormato[21].Colonna:='MISURAASSENZE';
  VariazioniFormato[21].Formati:='G=1,O=2';
  VariazioniFormato[22].Dato:='ASSENZERESIDUE1';
  VariazioniFormato[22].Colonna:='MISURAASSENZE';
  VariazioniFormato[22].Formati:='G=1,O=2';
  VariazioniFormato[23].Dato:='ASSENZERESIDUE2';
  VariazioniFormato[23].Colonna:='MISURAASSENZE';
  VariazioniFormato[23].Formati:='G=1,O=2';
  VariazioniFormato[24].Dato:='ASSENZERESIDUE3';
  VariazioniFormato[24].Colonna:='MISURAASSENZE';
  VariazioniFormato[24].Formati:='G=1,O=2';
  VariazioniFormato[25].Dato:='ASSENZERESIDUE4';
  VariazioniFormato[25].Colonna:='MISURAASSENZE';
  VariazioniFormato[25].Formati:='G=1,O=2';
  VariazioniFormato[26].Dato:='ASSENZERESIDUE5';
  VariazioniFormato[26].Colonna:='MISURAASSENZE';
  VariazioniFormato[26].Formati:='G=1,O=2';
  VariazioniFormato[27].Dato:='ASSENZERESIDUE6';
  VariazioniFormato[27].Colonna:='MISURAASSENZE';
  VariazioniFormato[27].Formati:='G=1,O=2';
  VariazioniFormato[28].Dato:='COMPETENZEPARZIALI';
  VariazioniFormato[28].Colonna:='MISURAASSENZE';
  VariazioniFormato[28].Formati:='G=1,O=2';
  VariazioniFormato[29].Dato:='RESIDUOPARZIALE';
  VariazioniFormato[29].Colonna:='MISURAASSENZE';
  VariazioniFormato[29].Formati:='G=1,O=2';
  VariazioniFormato[30].Dato:='COMPETENZEDELPERIODO';
  VariazioniFormato[30].Colonna:='MISURAASSENZE';
  VariazioniFormato[30].Formati:='G=1,O=2';
  VariazioniFormato[31].Dato:='VP_VALORE';
  VariazioniFormato[31].Colonna:='VP_MISURA';
  VariazioniFormato[31].Formati:='N=1,V=1,H=2';

  //Descrizione dei controlli associati alle opzioni avanzate
  SetLength(OpzioniAvanzate,6);
  OpzioniAvanzate[0].Opzione:='REC_SINDACATO_11';
  OpzioniAvanzate[1].Opzione:='REC_SINDACATO_12';
  OpzioniAvanzate[2].Opzione:='REC_SINDACATO_13';
  OpzioniAvanzate[3].Opzione:='CONTEGGI_GG_DALLE';
  OpzioniAvanzate[4].Opzione:='CONTEGGI_GG_ALLE';
  OpzioniAvanzate[5].Opzione:='CONTEGGI_GG_ITER';
end;

function TA077FGeneratoreStampeMW.getListAssenze: TStringList;
begin
  Result:=TStringList.Create;
  Q265.First;
  while not Q265.Eof do
  begin
    Result.Add(Format('%-5s %s',[Q265.FieldByName('CODICE').AsString,Q265.FieldByName('DESCRIZIONE').AsString]));
    Q265.Next;
  end;
end;

function TA077FGeneratoreStampeMW.getListPresenze: TStringList;
begin
  Result:=TStringList.Create;
  Q275.First;
  while not Q275.Eof do
  begin
    Result.Add(Format('%-5s %s',[Q275.FieldByName('CODICE').AsString,Q275.FieldByName('DESCRIZIONE').AsString]));
    Q275.Next;
  end;
end;

function TA077FGeneratoreStampeMW.getListIndPresenza: TStringList;
begin
  Result:=TStringList.Create;
  selT162.First;
  while not selT162.Eof do
  begin
    Result.Add(Format('%-5s %s',[selT162.FieldByName('CODICE').AsString,selT162.FieldByName('DESCRIZIONE').AsString]));
    selT162.Next;
  end;
end;

function TA077FGeneratoreStampeMW.getListRimborsi: TStringList;
begin
  Result:=TStringList.Create;
  selM020.Open;
  while not selM020.Eof do
  begin
    Result.Add(Format('%-5s %s',[selM020.FieldByName('CODICE').AsString,selM020.FieldByName('DESCRIZIONE').AsString]));
    selM020.Next;
  end;
  selM020.Close;
end;

function TA077FGeneratoreStampeMW.getListVociPaghe: TStringList;
begin
  Result:=TStringList.Create;
  seldistT195.Open;
  while not seldistT195.Eof do
  begin
    Result.Add(Format('%-10s',[seldistT195.FieldByName('VOCEPAGHE').AsString]));
    seldistT195.Next;
  end;
  seldistT195.Close;
end;

function TA077FGeneratoreStampeMW.getListOrgSindacali: TStringList;
begin
  Result:=TStringList.Create;
  selT240.Open;
  while not selT240.Eof do
  begin
    Result.Add(Format('%-10s %s',[selT240.FieldByName('CODICE').AsString,selT240.FieldByName('DESCRIZIONE').AsString]));
    selT240.Next;
  end;
  selT240.Close;
end;

function TA077FGeneratoreStampeMW.getListCorsiFormazione(Tutto: Boolean; Anno: Integer): TStringList;
begin
  Result:=TStringList.Create;
  selSG650.Open;
  while not selSG650.Eof do
  begin
    if Tutto or (R180Anno(selSG650.FieldByName('DATA_INIZIO').AsDateTime) = Anno) then
      Result.Add(Format('%-20s %s',[selSG650.FieldByName('CODICE').AsString,selSG650.FieldByName('DESCRIZIONE').AsString]));
    selSG650.Next;
  end;
  selSG650.Close;
end;

function TA077FGeneratoreStampeMW.getListRecapitoSindacato: TStringList;
begin
  Result:=TStringList.Create;
  selT241.Open;
  while not selT241.Eof do
  begin
    Result.Add(selT241.FieldByName('RECAPITO').AsString);
    selT241.Next;
  end;
  selT241.Close;
end;

end.

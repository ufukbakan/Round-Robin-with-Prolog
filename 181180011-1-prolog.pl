% Ufuk Bakan - Gazi University - 181180011 - 2020
% İşlemleri gerçekleştirmek için main. çağırınız
% CS Context switch sayısı
% NCS New Context switch
% BS Bekleme süresi
% NBS New bekleme süresi
% IU ilk liste uzunluğu

% Kuyrukta tek eleman varsa :
birimIslemYap([X],Quantum, CS, BS, IU) :-
  kuyruguGor([X]),
  (
    X > Quantum ->
    Y is X - Quantum, birimIslemYap([Y],Quantum,CS, BS, IU);
    birimIslemYap([],Quantum,CS, BS, IU)
  )
.

% Kuyrukta birden fazla eleman varsa :
% Liste = Tail
birimIslemYap([ListeBasi|Liste], Quantum, CS, BS, IU) :-
  length(Liste, L),
  L > 0,
  NCS is CS + 1,
  kuyruguGor([ListeBasi|Liste]),
  write('Context Switch  var'),nl,
  (
    ListeBasi > Quantum ->
    X is ListeBasi - Quantum, NBS is BS + (Quantum * L) ,sonaEkle(X,Liste,YeniListe), birimIslemYap(YeniListe, Quantum, NCS, NBS, IU);
    NBS is BS + (ListeBasi * L),birimIslemYap(Liste, Quantum, NCS, NBS, IU)
  )
.

% Kuyrukta hiç eleman yoksa :
birimIslemYap([], Quantum, CS, BS, IU) :-
  write('Butun islemler tamamlandi toplam context switch sayisi '),write(CS),nl,
  % OBS Ortalama bekleme süresi
  OBS is BS / IU,
  write('Ortalama bekleme suresi : '), write(OBS)
.

sonaEkle(X,[ ],[X]).
sonaEkle(X,[H|T],[H|Z]) :- sonaEkle(X,T,Z).

kuyruguGor([ListeBasi|Liste]) :-
  format('~w  ',[ListeBasi]),
  kuyruguGor(Liste).

kuyruguGor([]) :-
  write(' <= Siranin sonu'), nl
.

main :-
  Sira = [10.0,3.0,20.0],
  write('Dizi islemlerin kalan surelerini gosterir'), nl,
  write('Quantum degeri 5 olarak belirlenmistir'), nl, 
  length(Sira, L),
  % Sira , quantum , ilk context switch sayisi, ilk bekleme süresi , ilk uzunluk
  birimIslemYap(Sira, 5, 0, 0, L).

create table wyglad_graficzny
(
	id_wygladu serial,
	animacje char(200) not null,
	model int not null,
	CONSTRAINT                  wyglad_pk PRIMARY KEY(id_wygladu)
);
create table statystyki
(
	id_statystyk serial,
	pz int not null,
	pm int not null,
	sila int not null,
	moc_magiczna int not null,
	obrazenia int not null,
	pancerz int not null,
	zwinnosc int not null,
	szczescie int not null,
	CONSTRAINT                  statystyk_pk PRIMARY KEY(id_statystyk)
);
create table bonusy_do_statystyk
(
	id_bonusu serial,
	pz int,
	pm int,
	sila int,
	moc_magiczna int,
	obrazenia double,
	zwinnosc int,
	szczescie int
	CONSTRAINT                  bonusy_pk PRIMARY KEY(id_bonusu)
);
create table przedmiot
(
	id_przedmiot serial,
	nazwa char(50) not null,
	obrazenia int,
	pancerz int,
	bonusy int,
	wyglad_graficzny int,
	CONSTRAINT                  przedmiot_pk PRIMARY KEY(id_przedmiot),
	CONSTRAINT                  bonusy_fk FOREIGN KEY(bonusy)
                                   REFERENCES bonusy_do_statystyk(id_bonusu),
	CONSTRAINT                  wyglad_graficzny_fk FOREIGN KEY(wyglad_graficzny)
                                   REFERENCES wyglad_graficzny(id_wygladu)
);
create table miejsce
(	
	id_miejsca serial,
	lokacja char(50) not null,
	wspolrzedna_x int not null,
	wspolrzedna_y int not null,
	bonus_plus int,
	bonus_minus int,
	wyglad_graficzny int,
	CONSTRAINT                  miejsce_pk PRIMARY KEY(id_miejsca),
	CONSTRAINT                  wyglad_graficzny_fk FOREIGN KEY(wyglad_graficzny)
                                   REFERENCES wyglad_graficzny(id_wygladu)
);
create table klasa
(
	id_klasa serial,
	nazwa char(20) not null,
	umiejetnosci char(200) not null,
	przedmioty char(500),
	CONSTRAINT                  klasa_pk PRIMARY KEY(id_klasa),
	CONSTRAINT                  przedmiot_fk FOREIGN KEY(przedmioty)
                                   REFERENCES przedmiot(id_przedmiot)
);
create table postac
(
	id_postac serial,
	nazwa char(20) not null,
	historia char(500),
	klasa int not null,
	wyglad_graficzny int not null,
	miejsce int not null,
	statystyki int not null,
	walka_z int,
	CONSTRAINT                  postac_pk PRIMARY KEY(id_postac),
	CONSTRAINT                  klasa_fk FOREIGN KEY(klasa)
                                   REFERENCES klasa(id_klasa),
	CONSTRAINT                  wyglad_graficzny_fk FOREIGN KEY(wyglad_graficzny)
                                   REFERENCES wyglad_graficzny(id_wygladu),
	CONSTRAINT                  miejsce_fk FOREIGN KEY(miejsce)
                                   REFERENCES miejsce(id_miejsca),
	CONSTRAINT                  statystyki_fk FOREIGN KEY(statystyki)
                                   REFERENCES statystyki(id_statystyk),
	CONSTRAINT                  walka_fk FOREIGN KEY(walka_z)
                                   REFERENCES przeciwnik(id_przeciwnik)
);

create table przeciwnik
(
	id_przeciwnik serial,
	nazwa char(50) not null,
	umiejetnosci char(200) not null,
	miejsce int not null,
	statystyki int not null,
	wyglad_graficzny int not null,
	walka_z int,
	CONSTRAINT                  przeciwnik_pk PRIMARY KEY(id_przeciwnik),
	CONSTRAINT                  wyglad_graficzny_fk FOREIGN KEY(wyglad_graficzny)
                                   REFERENCES wyglad_graficzny(id_wygladu),
	CONSTRAINT                  miejsce_fk FOREIGN KEY(miejsce)
                                   REFERENCES miejsce(id_miejsca),
	CONSTRAINT                  statystyki_fk FOREIGN KEY(statystyki)
                                   REFERENCES statystyki(id_statystyk),
	CONSTRAINT                  walka_fk FOREIGN KEY(walka_z)
                                   REFERENCES postac(id_postac)
);
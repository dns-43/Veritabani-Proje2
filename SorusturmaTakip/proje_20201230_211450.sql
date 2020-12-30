--
-- PostgreSQL database dump
--

-- Dumped from database version 11.10
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: kisi_kontrol(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kisi_kontrol() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
    BEGIN
    IF LENGTH(NEW.adi) = 0 THEN
        RAISE EXCEPTION 'Ad kısmı boş bıraklamaz .';
    END IF;
 
    RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.kisi_kontrol() OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: iletisim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iletisim (
    iletisimno integer NOT NULL,
    numara character varying(255) NOT NULL,
    kisi_id character(11) NOT NULL,
    aciklama character varying(255) DEFAULT 'CEP'::character varying NOT NULL
);


ALTER TABLE public.iletisim OWNER TO postgres;

--
-- Name: Iletisim_iletisimno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Iletisim_iletisimno_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Iletisim_iletisimno_seq" OWNER TO postgres;

--
-- Name: Iletisim_iletisimno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Iletisim_iletisimno_seq" OWNED BY public.iletisim.iletisimno;


--
-- Name: Mahkeme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Mahkeme" (
    "Mahkemeno" character varying(255) NOT NULL,
    "Mahkeme_Adi" character varying(255) NOT NULL,
    aciklama character varying NOT NULL,
    "Adliyeno" integer
);


ALTER TABLE public."Mahkeme" OWNER TO postgres;

--
-- Name: adliye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adliye (
    adliyeno integer NOT NULL,
    adi character varying NOT NULL
);


ALTER TABLE public.adliye OWNER TO postgres;

--
-- Name: adres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adres (
    tur character varying(13) DEFAULT 'EV'::character varying NOT NULL,
    kisiid character(11) NOT NULL,
    il_id integer DEFAULT 41 NOT NULL,
    ilce_id integer DEFAULT 4101 NOT NULL,
    adres character varying(255),
    adres_no integer NOT NULL
);


ALTER TABLE public.adres OWNER TO postgres;

--
-- Name: adres_adres_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adres_adres_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adres_adres_no_seq OWNER TO postgres;

--
-- Name: adres_adres_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adres_adres_no_seq OWNED BY public.adres.adres_no;


--
-- Name: egmpersonel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.egmpersonel (
    sicil character(6) NOT NULL,
    adi character varying(255) NOT NULL,
    soyadi character varying DEFAULT '255'::character varying NOT NULL
);


ALTER TABLE public.egmpersonel OWNER TO postgres;

--
-- Name: il; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.il (
    ilno integer NOT NULL,
    iladi character varying(255) NOT NULL
);


ALTER TABLE public.il OWNER TO postgres;

--
-- Name: ilce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilce (
    ilceno integer NOT NULL,
    ilceadi character varying(255) NOT NULL,
    il_adi integer
);


ALTER TABLE public.ilce OWNER TO postgres;

--
-- Name: karar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.karar (
    kararno character varying(255) NOT NULL,
    karar character varying NOT NULL,
    aciklama character varying NOT NULL,
    sorusturmano character varying(255)
);


ALTER TABLE public.karar OWNER TO postgres;

--
-- Name: katip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.katip (
    katipno integer NOT NULL,
    adi character varying(255) NOT NULL,
    soyadi character varying NOT NULL,
    aciklama character varying(255) NOT NULL
);


ALTER TABLE public.katip OWNER TO postgres;

--
-- Name: kisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kisi (
    tcno character(11) NOT NULL,
    adi character varying(255) NOT NULL,
    soyadi character varying(255) NOT NULL,
    konum text NOT NULL,
    dtarih date
);


ALTER TABLE public.kisi OWNER TO postgres;

--
-- Name: materyal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materyal (
    materyalno integer DEFAULT nextval('public.adres_adres_no_seq'::regclass) NOT NULL,
    materyaladi character varying(255) NOT NULL,
    "türü" character varying(255) NOT NULL,
    kapasitesi character varying(255) NOT NULL,
    kisino character(11),
    sorusturmano character varying(255)
);


ALTER TABLE public.materyal OWNER TO postgres;

--
-- Name: savcı; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."savcı" (
    savcino character varying(255) NOT NULL,
    adi character varying(255) NOT NULL,
    soyadi character varying(255) NOT NULL,
    konumu character varying(255) NOT NULL,
    aciklama character varying NOT NULL,
    savcilik_id integer NOT NULL,
    katip_no integer NOT NULL
);


ALTER TABLE public."savcı" OWNER TO postgres;

--
-- Name: savcılık; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."savcılık" (
    savcilikno integer NOT NULL,
    savcilik character varying DEFAULT '255'::character varying NOT NULL
);


ALTER TABLE public."savcılık" OWNER TO postgres;

--
-- Name: sorusturma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sorusturma (
    sorusturmano character varying NOT NULL,
    aciklama character varying(255) DEFAULT '255'::character varying NOT NULL,
    dtarih date NOT NULL,
    kisino character(255) NOT NULL,
    savcino character varying(255) NOT NULL,
    egmpersid character(6) NOT NULL,
    savcilikno integer NOT NULL
);


ALTER TABLE public.sorusturma OWNER TO postgres;

--
-- Name: suc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suc (
    sucno character varying(255) NOT NULL,
    suc_adi character varying(255) NOT NULL,
    sorusturma_no character varying NOT NULL
);


ALTER TABLE public.suc OWNER TO postgres;

--
-- Name: adres adres_no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres ALTER COLUMN adres_no SET DEFAULT nextval('public.adres_adres_no_seq'::regclass);


--
-- Name: iletisim iletisimno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisim ALTER COLUMN iletisimno SET DEFAULT nextval('public."Iletisim_iletisimno_seq"'::regclass);


--
-- Data for Name: Mahkeme; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Mahkeme" VALUES
	('1', '1. Sulh Ceza Mahkemesi', '', 3401),
	('10', '3. Ağır Ceza Mahkemesi', '', 3402),
	('9', '2. Ağır Ceza Mahkemesi', '', 3401),
	('8', '1. Ağır Ceza Mahkemesi', '', 4101),
	('7', '3. Sulh Hukuk Mahkemesi', '', 4102),
	('6', '2. Sulh Hukuk Mahkemesi', '', 4103),
	('5', '1. Sulh Hukuk Mahkemesi', '', 4104),
	('4', '4. Sulh Ceza Mahkemesi', '', 5401),
	('3', '3. Sulh Ceza Mahkemesi', '', 5402),
	('2', '2 Sulh Ceza Mahkemesi', '', 5402);


--
-- Data for Name: adliye; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.adliye VALUES
	(4101, 'Kocaeli Adliyesi'),
	(4104, 'Karamürsel Adliyesi'),
	(4102, 'Kocaeli Adliyesi'),
	(4103, 'Gebze Adliyesi'),
	(4105, 'Karamürsel Adliyesi'),
	(4106, 'Gölcük Adliyesi'),
	(4107, 'Kandıra Adliyesi'),
	(4108, 'Kocaeli Adliyesi'),
	(3401, 'İstanbul Anadolu Adliyesi'),
	(3402, 'İstanbul Anadolu Adliyesi'),
	(3403, 'İstanbul Anadolu Adliyesi'),
	(3404, 'İstanbul Anadolu Adliyesi'),
	(3405, 'İstanbul Avrupa Adliyesi'),
	(3406, 'İstanbul Avrupa Adliyesi'),
	(3407, 'İstanbul Avrupa Adliyesi'),
	(3408, 'İstanbul Avrupa Adliyesi'),
	(3409, 'İstanbul Avrupa Adliyesi'),
	(5401, 'Sakarya Adliyesi'),
	(5402, 'Sakarya Adliyesi');


--
-- Data for Name: adres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.adres VALUES
	('EV', '45423445684', 41, 4101, '95 Evler Mahallesi Gir Sokak  Aztek apt.', 9),
	('EV', '10987654322', 41, 4101, 'Yavuz Baki Selim Koşar Sokak . Günkay Apt', 10),
	('EV', '10987654321', 41, 4101, 'Yavuz Mah. Koşar Sokak . Günkay Apt', 1),
	('EV', '12345678912', 41, 4101, '95 Evler Mahallesi Gir Sokak  Aztek apt.', 20),
	('EV', '98765432112', 41, 4101, '95 Evler Mahallesi Gir Sokak  Aztek apt.', 23);


--
-- Data for Name: egmpersonel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.egmpersonel VALUES
	('123456', 'Ahmet ', 'Pektaş'),
	('123457', 'Sinan', 'Kılıç'),
	('123458', 'Kazım', 'Tabo'),
	('123459', 'Latif', 'Doğan'),
	('123460', 'Zeki', 'Erkul');


--
-- Data for Name: il; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.il VALUES
	(41, 'Kocaeli'),
	(42, 'Konya'),
	(6, 'Ankara'),
	(34, 'İstanbul'),
	(54, 'Sakarya'),
	(43, 'Kütahya'),
	(81, 'Düzce');


--
-- Data for Name: ilce; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ilce VALUES
	(3401, 'Tuzla', 34),
	(4102, 'Derince', 41),
	(4103, 'Darıca', 41),
	(4104, 'Gebze', 41),
	(4105, 'Karamürsel', 41),
	(4106, 'Başiskele', 41),
	(4107, 'Kandıra', 41),
	(4108, 'Kartepe', 41),
	(3402, 'Pendik', 34),
	(3403, 'Üsküdar', 34),
	(3404, 'Ümraniye', 34),
	(3405, 'Şişli', 34),
	(3406, 'Fatih', 34),
	(3407, 'Eyüp', 34),
	(3408, 'Beşiktaş', 34),
	(3409, 'Bayrampaşa', 34),
	(3410, 'Beylikdüzü', 34),
	(5401, 'Adapazarı', 54),
	(5402, 'Ferizli', 54),
	(4101, 'İzmit', 41),
	(5403, 'Pamukova', 54),
	(5404, 'Arifiye', 54),
	(5405, 'Hendek', 54),
	(5406, 'Serdivan', 54);


--
-- Data for Name: iletisim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.iletisim VALUES
	(7, '5534356575', '5672341234 ', 'CEP'),
	(8, '5540303671', '45423445684', 'CEP'),
	(9, '5540303717', '10987654322', 'CEP'),
	(3, '5052020618', '10987654321', 'CEP'),
	(11, '5540303671', '12345678912', 'CEP'),
	(13, '5540303671', '98765432112', 'CEP');


--
-- Data for Name: karar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: katip; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.katip VALUES
	(12345, 'Adem', 'Kılıç', 'Katip'),
	(12346, 'Vedat', 'Çakır', 'Katip'),
	(654321, 'Muhammed ', 'Kaşif', 'Katip'),
	(132453, 'Yusuf ', 'Beytaş', 'Katip'),
	(443531, 'Nazım', 'Türk', 'Katip');


--
-- Data for Name: kisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kisi VALUES
	('5672341234 ', 'Recep', 'SARI', 'Müşteki', '1993-10-13'),
	('10987654322', 'Fuat', 'Özdağ', 'Şüpheli', '1981-03-26'),
	('45423445684', 'Mehmet', 'Bostan', 'Şüpheli', '1993-10-09'),
	('12345676512', 'Zafer', 'Kocak', 'Şüpheli', '1994-02-01'),
	('10987654321', 'Mehmet', 'Teker', 'Şüpheli', '1981-03-26'),
	('12345678912', 'Arif', 'Bostan', 'Şüpheli', '1993-10-09'),
	('98765432112', 'Halil', 'Kılınç', 'Şüpheli', '1978-01-12');


--
-- Data for Name: materyal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.materyal VALUES
	(2, 'Sandisk Usb Bellek ', 'USB BELLEK', '32 GB ', '45423445684', '2019/19345 SAKARYA CBS'),
	(3, 'LG D140 Cep Telefonu', 'Cep Telefonu', '32 GB ', '45423445684', '2019/19345 SAKARYA CBS'),
	(13, 'LG D140 Cep Telefonu', 'Cep Telefonu', '32 GB ', '45423445684', '2019/19345 SAKARYA CBS'),
	(14, 'LG D140 Cep Telefonu', 'Cep Telefonu', '32 GB ', '10987654321', '2019/12345 SAKARYA CBS'),
	(15, 'LG D140 Cep Telefonu', 'USB Bellek', '32 GB ', '45423445684', '2019/19345 SAKARYA CBS'),
	(16, 'sd kart', 'Sd Kart', '32 GB ', '45423445684', '2019/19345 SAKARYA CBS'),
	(18, 'USB BELLEK', 'USB Bellek', '64', '45423445684', '2019/19345 SAKARYA CBS'),
	(24, 'CEP TELEFONU', 'Cep Telefonu', '64', '98765432112', '2019/19345 İSTANBUL CBS');


--
-- Data for Name: savcı; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."savcı" VALUES
	('123455', 'Lütfullah ', 'TARHAN', 'Bilişim Savcısı', '', 4101, 12345),
	('123456', 'Akif', 'Aktaş', 'Savcı', '', 4102, 12345),
	('123457', 'Mehmet ', 'Bozdağ', 'Savcı', '', 4103, 132453),
	('123458', 'Vedat', 'Keser', 'Savcı', '', 3401, 132453),
	('123464', 'Muhammed', 'Topsakal', 'Başsavcı', '', 5401, 443531);


--
-- Data for Name: savcılık; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."savcılık" VALUES
	(3401, 'İstanbul Anadolu CBS'),
	(3402, 'İstanbul Anadolu CBS'),
	(3403, 'İstanbul Anadolu CBS'),
	(3404, 'İstanbul Anadolu CBS'),
	(3405, 'İstanbul Avrupa CBS'),
	(3406, 'İstanbul Avrupa CBS'),
	(3407, 'İstanbul Avrupa CBS'),
	(3408, 'İstanbul Avrupa CBS'),
	(3409, 'İstanbul Avrupa CBS'),
	(4101, 'Kocaeli CBS'),
	(4102, 'Kocaeli CBS'),
	(4103, 'Gebze CBS '),
	(4104, 'Karamürsel CBS'),
	(4105, 'Karamürsel CBS'),
	(4106, 'Gölcük CBS'),
	(4107, 'Kandıra CBS'),
	(4108, 'Kocaeli CBS'),
	(5401, 'Sakarya CBS'),
	(5402, 'Sakarya CBS');


--
-- Data for Name: sorusturma; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: suc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: Iletisim_iletisimno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Iletisim_iletisimno_seq"', 13, true);


--
-- Name: adres_adres_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adres_adres_no_seq', 25, true);


--
-- Name: kisi Kisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kisi
    ADD CONSTRAINT "Kisi_pkey" PRIMARY KEY (tcno);


--
-- Name: adres adres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_pkey PRIMARY KEY (adres_no);


--
-- Name: il il_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT il_pkey PRIMARY KEY (ilno);


--
-- Name: egmpersonel personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.egmpersonel
    ADD CONSTRAINT personel_pkey PRIMARY KEY (sicil);


--
-- Name: iletisim unique_Iletisim_iletisimno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisim
    ADD CONSTRAINT "unique_Iletisim_iletisimno" PRIMARY KEY (iletisimno);


--
-- Name: kisi unique_Kisi_tcno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kisi
    ADD CONSTRAINT "unique_Kisi_tcno" UNIQUE (tcno);


--
-- Name: Mahkeme unique_Mahkeme_Mahkemeno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Mahkeme"
    ADD CONSTRAINT "unique_Mahkeme_Mahkemeno" UNIQUE ("Mahkemeno");


--
-- Name: adliye unique_adliye_adliyeno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adliye
    ADD CONSTRAINT unique_adliye_adliyeno PRIMARY KEY (adliyeno);


--
-- Name: il unique_il_ilno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT unique_il_ilno UNIQUE (ilno);


--
-- Name: ilce unique_ilce_ilceno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT unique_ilce_ilceno PRIMARY KEY (ilceno);


--
-- Name: karar unique_karar_field; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karar
    ADD CONSTRAINT unique_karar_field UNIQUE (kararno);


--
-- Name: katip unique_katip_katipno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.katip
    ADD CONSTRAINT unique_katip_katipno PRIMARY KEY (katipno);


--
-- Name: materyal unique_materyal_materyalno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materyal
    ADD CONSTRAINT unique_materyal_materyalno PRIMARY KEY (materyalno);


--
-- Name: egmpersonel unique_personel_sicilno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.egmpersonel
    ADD CONSTRAINT unique_personel_sicilno UNIQUE (sicil);


--
-- Name: savcı unique_savcı_savcino; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."savcı"
    ADD CONSTRAINT "unique_savcı_savcino" PRIMARY KEY (savcino);


--
-- Name: savcılık unique_savcılık_savcilikno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."savcılık"
    ADD CONSTRAINT "unique_savcılık_savcilikno" PRIMARY KEY (savcilikno);


--
-- Name: sorusturma unique_sorusturma_sorusturmano; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sorusturma
    ADD CONSTRAINT unique_sorusturma_sorusturmano PRIMARY KEY (sorusturmano);


--
-- Name: suc unique_suc_sucno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suc
    ADD CONSTRAINT unique_suc_sucno PRIMARY KEY (sucno);


--
-- Name: kisi trigger1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger1 BEFORE INSERT ON public.kisi FOR EACH ROW EXECUTE PROCEDURE public.kisi_kontrol();


--
-- Name: il trigger2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger2 BEFORE DELETE ON public.il FOR EACH ROW EXECUTE PROCEDURE unique_key_recheck();


--
-- Name: Mahkeme Adliye_MahkemeFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Mahkeme"
    ADD CONSTRAINT "Adliye_MahkemeFK" FOREIGN KEY ("Adliyeno") REFERENCES public.adliye(adliyeno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: savcılık Adliye_Savcilik_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."savcılık"
    ADD CONSTRAINT "Adliye_Savcilik_FK" FOREIGN KEY (savcilikno) REFERENCES public.adliye(adliyeno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sorusturma EGMPERS_SORUSTURMA; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sorusturma
    ADD CONSTRAINT "EGMPERS_SORUSTURMA" FOREIGN KEY (egmpersid) REFERENCES public.egmpersonel(sicil) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ilce IL_ILCE_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT "IL_ILCE_FK" FOREIGN KEY (il_adi) REFERENCES public.il(ilno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: savcı Katip_Savci_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."savcı"
    ADD CONSTRAINT "Katip_Savci_FK" FOREIGN KEY (katip_no) REFERENCES public.katip(katipno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: adres KisiAdresFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT "KisiAdresFK" FOREIGN KEY (kisiid) REFERENCES public.kisi(tcno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: iletisim KisiIletisimFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisim
    ADD CONSTRAINT "KisiIletisimFK" FOREIGN KEY (kisi_id) REFERENCES public.kisi(tcno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: materyal Kisi_Materyal_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materyal
    ADD CONSTRAINT "Kisi_Materyal_FK" FOREIGN KEY (kisino) REFERENCES public.kisi(tcno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sorusturma Kisi_Sorusturma_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sorusturma
    ADD CONSTRAINT "Kisi_Sorusturma_FK" FOREIGN KEY (kisino) REFERENCES public.kisi(tcno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sorusturma Savcilik-Sorusturma_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sorusturma
    ADD CONSTRAINT "Savcilik-Sorusturma_FK" FOREIGN KEY (savcilikno) REFERENCES public."savcılık"(savcilikno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: adres ilAdresFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT "ilAdresFK" FOREIGN KEY (il_id) REFERENCES public.il(ilno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: adliye ilceAdliyeFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adliye
    ADD CONSTRAINT "ilceAdliyeFK" FOREIGN KEY (adliyeno) REFERENCES public.ilce(ilceno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: adres ilceAdresFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT "ilceAdresFK" FOREIGN KEY (ilce_id) REFERENCES public.ilce(ilceno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sorusturma savci_Sorusturma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sorusturma
    ADD CONSTRAINT "savci_Sorusturma" FOREIGN KEY (savcino) REFERENCES public."savcı"(savcino) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: savcı savcilik_savci_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."savcı"
    ADD CONSTRAINT "savcilik_savci_FK" FOREIGN KEY (savcilik_id) REFERENCES public."savcılık"(savcilikno) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: karar sorusturma_Karar_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karar
    ADD CONSTRAINT "sorusturma_Karar_FK" FOREIGN KEY (sorusturmano) REFERENCES public.sorusturma(sorusturmano) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: suc sorusturma_Suc_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suc
    ADD CONSTRAINT "sorusturma_Suc_no" FOREIGN KEY (sorusturma_no) REFERENCES public.sorusturma(sorusturmano) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


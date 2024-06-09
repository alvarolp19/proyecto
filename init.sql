
-- Crear base de datos ciber
CREATE DATABASE IF NOT EXISTS ciber;
USE ciber;

-- Crear tabla paises_completos
CREATE TABLE IF NOT EXISTS paises_completos (
  pais CHAR(3) NOT NULL,
  pais_nombre VARCHAR(75) NOT NULL,
  PRIMARY KEY (pais)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Insertar algunos datos en tabla paises_completos
INSERT INTO paises_completos (pais, pais_nombre) VALUES
("afg", "Afghanistan"),
("alb", "Albania"),
("dza", "Algeria"),
("and", "Andorra"),
("ago", "Angola"),
("atg", "Antigua and Barbuda"),
("arg", "Argentina"),
("arm", "Armenia"),
("aus", "Australia"),
("aut", "Austria"),
("aze", "Azerbaijan"),
("bhs", "Bahamas"),
("bhr", "Bahrain"),
("bgd", "Bangladesh"),
("brb", "Barbados"),
("blr", "Belarus"),
("bel", "Belgium"),
("blz", "Belize"),
("ben", "Benin"),
("btn", "Bhutan"),
("bol", "Bolivia, Plurinational State of"),
("bih", "Bosnia and Herzegovina"),
("bwa", "Botswana"),
("bra", "Brazil"),
("brn", "Brunei Darussalam"),
("bgr", "Bulgaria"),
("bfa", "Burkina Faso"),
("bdi", "Burundi"),
("cpv", "Cabo Verde"),
("khm", "Cambodia"),
("cmr", "Cameroon"),
("can", "Canada"),
("caf", "Central African Republic"),
("tcd", "Chad"),
("chl", "Chile"),
("chn", "China"),
("col", "Colombia"),
("com", "Comoros"),
("cog", "Congo"),
("cod", "Congo, Democratic Republic of the"),
("cri", "Costa Rica"),
("hrv", "Croatia"),
("cub", "Cuba"),
("cyp", "Cyprus"),
("cze", "Czechia"),
("dnk", "Denmark"),
("dji", "Djibouti"),
("dma", "Dominica"),
("dom", "Dominican Republic"),
("ecu", "Ecuador"),
("egy", "Egypt"),
("slv", "El Salvador"),
("gnq", "Equatorial Guinea"),
("eri", "Eritrea"),
("est", "Estonia"),
("swz", "Eswatini"),
("eth", "Ethiopia"),
("fji", "Fiji"),
("fin", "Finland"),
("fra", "France"),
("gab", "Gabon"),
("gmb", "Gambia"),
("geo", "Georgia"),
("deu", "Germany"),
("gha", "Ghana"),
("grc", "Greece"),
("grd", "Grenada"),
("gtm", "Guatemala"),
("gin", "Guinea"),
("gnb", "Guinea-Bissau"),
("guy", "Guyana"),
("hti", "Haiti"),
("hnd", "Honduras"),
("hun", "Hungary"),
("isl", "Iceland"),
("ind", "India"),
("idn", "Indonesia"),
("irn", "Iran, Islamic Republic of"),
("irq", "Iraq"),
("irl", "Ireland"),
("isr", "Israel"),
("ita", "Italy"),
("jam", "Jamaica"),
("jpn", "Japan"),
("jor", "Jordan"),
("kaz", "Kazakhstan"),
("ken", "Kenya"),
("kir", "Kiribati"),
("prk", "Korea, Democratic People s Republic of"),
("kor", "Korea, Republic of"),
("kwt", "Kuwait"),
("kgz", "Kyrgyzstan"),
("lao", "Lao People s Democratic Republic"),
("lva", "Latvia"),
("lbn", "Lebanon"),
("lso", "Lesotho"),
("lbr", "Liberia"),
("lby", "Libya"),
("lie", "Liechtenstein"),
("ltu", "Lithuania"),
("lux", "Luxembourg"),
("mdg", "Madagascar"),
("mwi", "Malawi"),
("mys", "Malaysia"),
("mdv", "Maldives"),
("mli", "Mali"),
("mlt", "Malta"),
("mhl", "Marshall Islands"),
("mrt", "Mauritania"),
("mus", "Mauritius"),
("mex", "Mexico"),
("fsm", "Micronesia, Federated States of"),
("mda", "Moldova, Republic of"),
("mco", "Monaco"),
("mng", "Mongolia"),
("mne", "Montenegro"),
("mar", "Morocco"),
("moz", "Mozambique"),
("mmr", "Myanmar"),
("nam", "Namibia"),
("nru", "Nauru"),
("npl", "Nepal"),
("nld", "Netherlands"),
("nzl", "New Zealand"),
("nic", "Nicaragua"),
("ner", "Niger"),
("nga", "Nigeria"),
("mkd", "North Macedonia"),
("nor", "Norway"),
("omn", "Oman"),
("pak", "Pakistan"),
("plw", "Palau"),
("pan", "Panama"),
("png", "Papua New Guinea"),
("pry", "Paraguay"),
("per", "Peru"),
("phl", "Philippines"),
("pol", "Poland"),
("prt", "Portugal"),
("qat", "Qatar"),
("rou", "Romania"),
("rus", "Russian Federation"),
("rwa", "Rwanda"),
("kna", "Saint Kitts and Nevis"),
("lca", "Saint Lucia"),
("vct", "Saint Vincent and the Grenadines"),
("wsm", "Samoa"),
("smr", "San Marino"),
("stp", "Sao Tome and Principe"),
("sau", "Saudi Arabia"),
("sen", "Senegal"),
("srb", "Serbia"),
("syc", "Seychelles"),
("sle", "Sierra Leone"),
("sgp", "Singapore"),
("svk", "Slovakia"),
("svn", "Slovenia"),
("slb", "Solomon Islands"),
("som", "Somalia"),
("zaf", "South Africa"),
("ssd", "South Sudan"),
("esp", "Spain"),
("lka", "Sri Lanka"),
("sdn", "Sudan"),
("sur", "Suriname"),
("swe", "Sweden"),
("che", "Switzerland"),
("syr", "Syrian Arab Republic"),
("tjk", "Tajikistan"),
("tza", "Tanzania, United Republic of"),
("tha", "Thailand"),
("tls", "Timor-Leste"),
("tgo", "Togo"),
("ton", "Tonga"),
("tto", "Trinidad and Tobago"),
("tun", "Tunisia"),
("tur", "Türkiye"),
("tkm", "Turkmenistan"),
("tuv", "Tuvalu"),
("uga", "Uganda"),
("ukr", "Ukraine"),
("are", "United Arab Emirates"),
("gbr", "United Kingdom of Great Britain and Northern Ireland"),
("usa", "United States of America"),
("ury", "Uruguay"),
("uzb", "Uzbekistan"),
("vut", "Vanuatu"),
("ven", "Venezuela, Bolivarian Republic of"),
("vnm", "Viet Nam"),
("yem", "Yemen"),
("zmb", "Zambia"),
("zwe", "Zimbabwe");

-- Crear tabla ciber
CREATE TABLE IF NOT EXISTS ciber (
  id INT NOT NULL AUTO_INCREMENT,
  fecha DATE DEFAULT NULL,
  pais CHAR(3) DEFAULT NULL,
  victima VARCHAR(255) DEFAULT NULL,
  enlace VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (pais) REFERENCES paises_completos(pais) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE DATABASE vuls;
USE vuls;
CREATE TABLE Productos (
    ID_Producto INT NOT NULL AUTO_INCREMENT,
    Nombre_Producto VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (ID_Producto)
);

CREATE TABLE Vulnerabilidades (
  `Vuln_ID` varchar(50) NOT NULL,
  `Producto_ID` int DEFAULT NULL,
  `Resumen` text,
  `Gravedad_CVSS` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Vuln_ID`),
  KEY `Producto_ID` (`Producto_ID`),
  CONSTRAINT `Vulnerabilidades_ibfk_1` FOREIGN KEY (`Producto_ID`) REFERENCES `Productos` (`ID_Producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE DATABASE IF NOT EXISTS ramsome;
USE ramsome;
DROP TABLE IF EXISTS `Actores`;
CREATE TABLE `Actores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO Actores (nombre, url) VALUES

('0Mega', 'http://omegalock5zxwbhswbisc42o2q2i54vdulyvtqqbudqousisjgc7j7yd.onion/'),

('3Am', 'http://threeamkelxicjsaf2czjyz2lc4q3ngqkxhhlexyfcp2o6raw4rphyad.onion'),

('8Base', 'http://basemmnnqwxevlymli5bs36o5ynti55xojzvn246spahniugwkff2pad.onion/'),

('Abrahams_Ax', 'http://abrahamm32umasogaqojib3ey2w2nwoafffrguq43tsyke4s3fz3w4yd.onion/'),

('Abyss-Data', 'http://3ev4metjirohtdpshsqlkrqcmxq6zu3d7obrdhglpy5jpbr7whmlfgqd.onion'),

('Agl0Bgvycg', 'http://hitleransomware.cf'),

('Akira', 'https://akiral2iz6a7qgd3ayp3l6yub7xx2uep76idk3u2kollpj5z3z636bad.onion/'),

('Ako', 'http://kwvhrdibgmmpkhkidrby4mccwqpds5za6uo2thcw5gz75qncv7rbhyad.onion'),

('Alphv', 'http://alphvmmm27o3abo3r2mlmjrpdmzle3rykajqc5xsj7j7ejksbpsa36ad.onion'),

('Apos', 'https://apos.blog'),

('Arcus Media', 'http://arcuufpr5xxbbkin4mlidt7itmr6znlppk63jbtkeguuhszmc5g7qdyd.onion'),

('Arvinclub', 'http://arvinc7prj6ln5wpd6yydfqulsyepoc7aowngpznbn3lrap2aib6teid.onion/'),

('Atomsilo', 'http://mhdehvkomeabau7gsetnsrhkfign4jgnx3wajth5yb5h6kvzbd72wlqd.onion'),

('Avaddon', 'http://avaddongun7rngel.onion'),

('Avos', 'http://avos2fuj6olp6x36.onion'),

('Avoslocker', 'http://avosqxh72b5ia23dl5fgwcpndkctuzqvh2iefk5imp3pi5gfhel5klad.onion/'),

('Aztroteam', 'http://anewset3pcya3xvk73hj7yunuamutxxsm5sohkdi32blhmql55tvgqad.onion'),

('Babuk-Locker', 'http://nq4zyac4ukl4tykmidbzgdlvaboqeqsemkp4t35bzvjeve6zm2lqcjid.onion/#section-3'),

('Babyduck', 'http://babydovegkmhbontykziyq7qivwzy33mu4ukqefe4mqpiiwd3wibnjqd.onion'),

('Bianlian', 'http://bianlianlbc5an4kgnay3opdemgcryg2kpfcbgczopmm3dnbz3uaunad.onion/'),

('Black Suit', 'http://weg7sdx54bevnvulapqu6bpzwztryeflq3s23tegbmnhkbpqz637f2yd.onion'),

('Blackbasta', 'https://bastad5huzwkepdixedg2gekg7jk22ato24zyllp6lnjx7wdtyctgvyd.onion'),

('Blackbyte', 'http://53d5skw4ypzku4bfq2tk2mr3xh5yqrzss25sooiubmjz67lb3gdivcad.onion/'),

('Blackmatter', 'http://blackmax7su6mbwtcyo3xwtpfxpm356jjqrs34y4crcytpw7mifuedyd.onion/'),

('Blackout', 'http://black3gnkizshuynieigw6ejgpblb53mpasftzd6pydqpmq2vn2xf6yd.onion'),

('Blackshadow', 'http://544corkfh5hwhtn4.onion'),

('Blacktor', 'http://bl%40ckt0r:bl%40ckt0r@bl4cktorpms2gybrcyt52aakcxt6yn37byb65uama5cimhifcscnqkid.onion/0x00/data-breach.html'),

('Bluesky', 'http://ccpyeuptrlatb2piua4ukhnhi7lrxgerrcrj4p2b5uhbzqm2xgdjaqid.onion'),

('Bonacigroup', 'http://bonacifryrxr4siz6ptvokuihdzmjzpveruklxumflz5thmkgauty2qd.onion'),

('C3Rb3R', 'http://j3qxmk6g5sk3zw62i2yhjnwmhm55rfz47fdyfkhaithlpelfjdokdxad.onion/'),

('Cactus', 'https://cactus5dqnqkppa5ayckiyk6dttpqwczdqphv5mxh4dkk5ct544q5aad.onion/'),

('Cheers', 'http://rwiajgajdr4kzlnrj5zwebbukpcbrjhupjmk6gufxv6tg7myx34iocad.onion/'),

('Ciphbit', 'http://ciphbitqyg26jor7eeo6xieyq7reouctefrompp6ogvhqjba7uo4xdid.onion/'),

('Cloak', 'http://cloak7jpvcb73rtx2ff7kaw2kholu7bdiivxpzbhlny4ybz75dpxckqd.onion'),

('Clop', 'http://santat7kpllt6iyvqbr7q4amdv6dzrh6paatvyrzl7ry3zm72zigf4ad.onion/'),

('Clop Torrents', 'http://toznnag5o3ambca56s2yacteu7q7x2avrfherzmz4nmujrjuib4iusad.onion/'),

('Conti', 'http://continewsnv5otx5kaoje7krkto2qbu3gtqef22mnr7eaxw3y6ncz3ad.onion/'),

('Cooming', 'http://z6mikrtphid5fmn52nbcbg25tj57sowlm3oc25g563yvsfmygkcxqbyd.onion'),

('Crosslock', 'http://crosslock5cwfljbw4v37zuzq4talxxhyavjm2lufmjwgbpfjdsh56yd.onion/'),

('Crylock', 'http://d57uremugxjrafyg.onion'),

('Cryptbb', 'http://crypuglupv3bsqnbt5ruu5lgwrwoaojscwhuoccbmbzmcidft5kiccqd.onion'),

('Cryptnet', 'http://cryptr3fmuv4di5uiczofjuypopr63x2gltlsvhur2ump4ebru2xd3yd.onion'),

('Cuba', 'http://cuba4ikm4jakjgmkezytyawtdgr2xymvy6nvzgw5cglswg3si76icnqd.onion/'),

('Cyclops', 'http://nt3rrzq5hcyznvdkpslvqbbc2jqecqrinhi5jtwoae2x7psqtcb6dcad.onion/'),

('Daixin', 'http://7ukmkdtyxdkdivtjad57klqnd3kdsmq6tp45rrsxqnu76zzv3jvitlqd.onion/'),

('Dan0N', 'http://2c7nd54guzi6xhjyqrj5kdkrq2ngm2u3e6oy4nfhn3wm3r54ul2utiqd.onion/'),

('Dark Power', 'http://powerj7kmpzkdhjg4szvcxxgktgk36ezpjxvtosylrpey7svpmrjyuyd.onion/'),

('Darkangel', 'https://wemo2ysyeq6km2nqhcrz63dkdhez3j25yw2nvn7xba2z4h7v7gyrfgid.onion/'),

('Darkbit01', 'http://iw6v2p3cruy7tqfup3yl4dgt4pfibfa3ai4zgnu5df2q3hus3lm7c7ad.onion'),

('Darkrace', 'http://wkrlpub5k52rjigwxfm6m7ogid55kamgc5azxlq7zjgaopv33tgx2sqd.onion/'),

('Darkside', 'http://darksidc3iux462n6yunevoag52ntvwp6wulaz3zirkmh4cnz6hhj7id.onion'),

('Darkvault', 'http://mdhby62yvvg6sd5jmx5gsyucs7ynb5j45lvvdh4dsymg43puitu7tfid.onion'),

('Dataleak', 'http://woqjumaahi662ka26jzxyx7fznbp4kg3bsjar4b52tqkxgm2pylcjlad.onion/'),

('Diavol', 'https://7ypnbv3snejqmgce4kbewwvym4cm5j6lkzf2hra2hyhtsvwjaxwipkyd.onion'),

('Donex', 'http://g3h3klsev3eiofxhykmtenmdpi67wzmaixredk5pjuttbx7okcfkftqd.onion'),

('Donutleaks', 'https://sbc2zv2qnz5vubwtx3aobfpkeao6l4igjegm3xx7tk5suqhjkp5jxtqd.onion/'),

('Doppelpaymer', 'http://hpoo4dosa3x4ognfxpqcrjwnsigvslm7kv6hvmhh2yqczaxy3j6qnwad.onion/'),

('Dragonforce', 'http://z3wqggtxft7id3ibr7srivv5gjof5fwg76slewnzwwakjuf3nlhukdid.onion/blog'),

('Dunghill', 'http://p66slxmtum2ox4jpayco6ai3qfehd5urgrs4oximjzklxcol264driqd.onion/index.html'),

('Ech0Raix', 'http://veqlxhq7ub5qze3qy56zx2cig2e6tzsgxdspkubwbayqije6oatma6id.onion'),

('Embargo', 'http://embargobe3n5okxyzqphpmk3moinoap2snz5k6765mvtkk7hhi544jid.onion'),

('Endurance', 'http://h44jyyfomcbnnw5dha7zgwgkvpzbzbdyx2onu4fxaa5smxrgbjgq7had.onion/'),

('Entropy', 'http://leaksv7sroztl377bbohzl42i3ddlfsxopcb6355zc7olzigedm5agad.onion/posts'),

('Ep918', 'http://dg5fyig37abmivryrxlordrczn6d6r5wzcfe2msuo5mbbu2exnu46fid.onion'),

('Eraleign (Apt73)', 'http://eraleignews.com/'),

('Everest', 'http://ransomocmou6mnbquqz44ewosbkjk3o5qjsl3orawojexfook2j7esad.onion/'),

('Exorcist', 'http://7iulpt5i6whht6zo2r52f7vptxtjxs3vfcdxxazllikrtqpupn4epnqd.onion'),

('Freecivilian', 'http://gcbejm2rcjftouqbxuhimj5oroouqcuxb2my4raxqa7efkz5bd5464id.onion/'),

('Fsociety', 'http://flock4cvoeqm4c62gyohvmncx6ck2e7ugvyqgyxqtrumklhd5ptwzpqd.onion/'),

('Fsteam', 'http://hkk62og3s2tce2gipcdxg3m27z4b62mrmml6ugctzdxs25o26q3a4mid.onion/'),

('Grief', 'http://griefcameifmv4hfr3auozmovz5yi6m3h3dwbuqw7baomfxoxz4qteid.onion/'),

('Groove', 'http://ws3dh6av66sjbxxkjpw5ao3wqzmtejnkzheswm4dz5rrwvular7xvkqd.onion/'),

('Hades', 'http://ixltdyumdlthrtgx.onion'),

('Haron', 'http://ft4zr2jzlqoyob7yg4fcpwyt37hox3ajajqnfkdvbfrkjioyunmqnpad.onion/login.php'),

('Hellogookie', 'http://gookie256cvccntvenyxrvn7ht73bs6ss3oj2ocfkjt5y6vq6gfi2tad.onion/'),

('Hellokitty', 'http://3r6n77mpe737w4sbxxxrpc5phbluv6xhtdl5ujpnlvmck5tc7blq2rqd.onion'),

('Hive', 'http://hiveleakdbtnp76ulyhi52eag6c6tyc3xw7ez7iqy6wc34gd2nekazyd.onion/'),

('Hotarus', 'http://r6d636w47ncnaukrpvlhmtdbvbeltc6enfcuuow3jclpmyga7cz374qd.onion'),

('Hunters', 'https://hunters55rdxciehoqzwv7vgyv6nt37tbwax2reroyzxhou7my5ejyid.onion'),

('Icefire', 'http://kf6x3mjeqljqxjznaw65jixin7dpcunfxbbakwuitizytcpzn4iy5bad.onion/board/leak_list/'),

('Inc Ransom', 'http://incblog7vmuq7rktic73r4ha4j757m3ptym37tyvifzp2roedyyzzxid.onion'),

('Insane Ransomware', 'http://nv5lbsrr4rxmewzmpe25nnalowe4ga7ki6yfvit3wlpu7dfc36pyh4ad.onion/'),

('Jo Of Satan', 'http://jos666vxenlqp4xpnsxehovnaumi4c3q4bmvhpgdyz7bsk3ho3caokad.onion/'),

('Justice_Blade', 'https://justice-blade.io'),

('Karakurt', 'https://3f7nxkjway3d223j27lyad7v5cgmyaifesycvmwq7i7cbs23lb6llryd.onion/'),

('Karma', 'http://3nvzqyo6l4wkrzumzu5aod7zbosq4ipgf7ifgj3hsvbcr5vcasordvqd.onion'),

('Kelvin Security', 'https://kelvinsecteamcyber.wixsite.com/my-site/items'),

('Killsec', 'http://kill432ltnkqvaqntbalnsgojqqs2wz4lhnamrqjg66tq6fuvcztilyd.onion/'),

('Knight', 'http://knight3xppu263m7g4ag3xlit2qxpryjwueobh7vjdc3zrscqlfu3pqd.onion/'),

('La Piovra', 'http://et22fibzuzfyzgurm35sttm52qbzvdgzy5qhzy46a3gmkrrht3lec5ad.onion/'),

('Lambda', 'http://nn5ua7gc7jkllpoztymtfcu64yjm7znlsriq3a6v5kw7l6jvirnczyyd.onion'),

('Lapsus$', 'https://t.me/minsaudebr'),

('Lilith', 'http://yeuajcizwytgmrntijhxphs6wn5txp2prs6rpndafbsapek3zd4ubcid.onion/'),

('Lockbit', 'http://lockbitkodidilol.onion'),

('Lockbit3', 'http://lockbit435xk3ki62yun7z5nhwz6jyjdp2c64j5vge536if2eny3gtid.onion'),

('Lolnek', 'http://mmeeiix2ejdwkmseycljetmpiwebdvgjts75c63camjofn2cjdoulzqd.onion'),

('Lorenz', 'http://lorenzmlwpzgxq736jzseuterytjueszsvznuibanxomlpkyxk6ksoyd.onion/'),

('Losttrust', 'http://hscr6cjzhgoybibuzn2xud7u4crehuoo4ykw3swut7m7irde74hdfzyd.onion/'),

('Lulzsec Muslims', 'http://dfi7ynmrugokn4fgvpbz5unt4d6k2i5abyez7wnoxxa2ifaw6s5puzqd.onion/'),

('Lv', 'http://rbvuetuneohce3ouxjlbxtimyyxokb4btncxjbo44fbgxqy7tskinwad.onion/'),

('Malas', 'http://malas2urovbyyavjzaezkt5ohljvyd5lt7vv7mnsgbf2y4bwlh72doqd.onion/posts/'),

('Malek Team', 'https://malekteam.ac'),

('Mallox', 'http://wtyafjyhwqrgo4a45wdvvwhen3cx4euie73qvlhkhvlrexljoyuklaad.onion'),

('Maze', 'http://xfr3txoorcyy7tikjgj5dk3rvo3vsrpyaxnclyohkbfp3h277ap4tiad.onion'),

('Mbc', 'http://xembshruusobgbvxg4tcjs3jpdnks6xrr6nbokfxadcnlc53yxir22ad.onion'),

('Medusa', 'http://xfv4jzckytb4g3ckwemcny3ihv4i5p4lqzdpi624cxisu35my5fwi5qd.onion'),

('Meow', 'http://meow6xanhzfci2gbkn3lmbqq7xjjufskkdfocqdngt3ltvzgqpsg5mid.onion/'),

('Metaencryptor', 'http://metacrptmytukkj7ajwjovdpjqzd7esg5v3sg344uzhigagpezcqlpyd.onion/'),

('Midas', 'http://midasbkic5eyfox4dhnijkzc7v7e4hpmsb2qgux7diqbpna4up4rtdad.onion/blog.php'),

('Mogilevich', 'http://dkgn45pinr7nwvdaehemcrpgcjqf4fooit3c4gjw6dhzrp443ctvnoad.onion'),

('Moisha', 'http://moishddxqnpdxpababec6exozpl2yr7idfhdldiz5525ao25bmasxhid.onion'),

('Money Message', 'http://blogvl7tjyjvsfthobttze52w36wwiz34hrfcmorgvdzb6hikucb7aqd.onion'),

('Monte', 'http://monteoamwxlutyovf7oxeviwjlbu3vbgdmkncecl2ydteqncrmcv67yd.onion/'),

('Monti', 'http://4s4lnfeujzo67fy2jebz2dxskez2gsqj2jeb35m75ktufxensdicqxad.onion/'),

('Mount-Locker', 'http://mountnewsokhwilx.onion'),

('Mydata', 'http://mydatae2d63il5oaxxangwnid5loq2qmtsol2ozr6vtb7yfm5ypzo6id.onion/blog'),

('Mydecryptor', 'http://58b87e60649ccc808ac8mstiejnj.5s4ixqul2enwxrqv.onion'),

('N3Tworm', 'http://n3twormruynhn3oetmxvasum2miix2jgg56xskdoyihra4wthvlgyeyd.onion'),

('Nefilim', 'http://hxt254aygrsziejn.onion'),

('Nemty', 'http://zjoxyw5mkacojk5ptn2iprkivg5clow72mjkyk5ttubzxprjjnwapkad.onion'),

('Netwalker', 'http://rnfdsgm6wb6j6su5txkekw4u4y47kp2eatvu7d6xhyn5cs4lt4pdrqqd.onion'),

('Nevada', 'http://nevcorps5cvivjf6i2gm4uia7cxng5ploqny2rgrinctazjlnqr2yiyd.onion/'),

('Nightsky', 'http://gg5ryfgogainisskdvh4y373ap3b2mxafcibeh2lvq5x7fx76ygcosad.onion'),

('Noescape', 'http://noescaperjh3gg6oy7rck57fiefyuzmj7kmvojxgvlmwd5pdzizrb7ad.onion/login'),

('Nokoyawa', 'http://lirncvjfmdhv6samxvvlohfqx7jklfxoxj7xn3fh7qeabs3taemdsdqd.onion'),

('Noname', 'http://noname2j6zkgnt7ftxsjju5tfd3s45s4i3egq5bqtl72kgum4ldc6qyd.onion'),

('Onepercent', 'http://5mvifa3xq5m7sou3xzaajfz7h6eserp5fnkwotohns5pgbb5oxty3zad.onion'),

('Pandora', 'http://vbfqeh5nugm6r2u2qvghsdxm3fotf5wbxb5ltv6vw77vus5frdpuaiid.onion/'),

('Pay2Key', 'http://pay2key2zkg7arp3kv3cuugdaqwuesifnbofun4j6yjdw5ry7zw2asid.onion/'),

('Payloadbin', 'http://vbmisqjshn4yblehk2vbnil53tlqklxsdaztgphcilto3vdj4geao5qd.onion/'),

('Play', 'http://k7kg3jqxang3wh7hnmaiokchk7qoebupfgoik6rha6mjpzwupwtj25yd.onion'),

('Prolock', 'http://msaoyrayohnp32tcgwcanhjouetb5k54aekgnwg7dcvtgtecpumrxpqd.onion'),

('Prometheus', 'http://promethw27cbrcot.onion/blog/'),

('Pysa', 'http://pysa2bitc5ldeyfak4seeruqymqs4sj5wt5qkcq7aoyg4h2acqieywad.onion/partners.html'),

('Qilin', 'http://ozsxj4hwxub7gio347ac7tyqqozvfioty37skqilzo2oqfs4cw2mgtyd.onion/'),

('Qiulong', 'http://62brsjf2w77ihz5paods33cdgqnon54gjns5nmag3hmqv6fcwamtkmad.onion/'),

('Qlocker', 'http://gvka2m4qt5fod2fltkjmdk4gxh5oxemhpgmnmtjptms6fkgfzdd62tad.onion'),

('Quantum', 'http://quantum445bh3gzuyilxdzs5xdepf3b7lkcupswvkryf3n7hgzpxebid.onion/'),

('Ra Group', 'http://raworldw32b2qxevn3gp63pvibgixr4v75z62etlptg3u3pmajwra4ad.onion'),

('Rabbit Hole', 'http://z5jixbfejdu5wtxd2baliu6hwzgcitlspnttr7c2eopl5ccfcjrhkqid.onion'),

('Ragnarlocker', 'http://rgleaktxuey67yrgspmhvtnrqtgogur35lwdrup4d3igtbm3pupc4lyd.onion/'),

('Ragnarok', 'http://wobpitin77vdsdiswr43duntv6eqw4rvphedutpaxycjdie6gg3binad.onion'),

('Ramp', 'http://rampjcdlqvgkoz5oywutpo6ggl7g6tvddysustfl6qzhr5osr24xxqqd.onion'),

('Rancoz', 'http://ze677xuzard4lx4iul2yzf5ks4gqqzoulgj5u4n5n4bbbsxjbfr7eayd.onion/'),

('Ransom Corp', 'http://sewo2yliwvgca3abz565nsnnx3khi6x7t5ccpbvvg6wgce4bk2jagiad.onion/'),

('Ransomcartel', 'http://u67aylig7i6l657wxmp274eoilaowhp3boljowa6bli63rxyzfzsbtyd.onion/'),

('Ransomed', 'https://ransomed.vc/'),

('Ransomexx', 'http://rnsm777cdsjrsdlbs4v5qoeppu3px6sb2igmh53jzrx7ipcrbjz5b2ad.onion/'),

('Ransomhouse', 'http://zohlm7ahjwegcedoz7lrdrti7bvpofymcayotp744qhx6gjmxbuo2yid.onion/'),

('Ransomhub', 'http://ransomxifxwc5eteopdobynonjctkxxvap77yqifu2emfbecgbqdw6qd.onion/'),

('Ransomware Blog', 'http://z6wkgghtoawog5noty5nxulmmt2zs7c3yvwr22v4czbffdoly2kl4uad.onion'),

('Ranzy', 'http://37rckgo66iydpvgpwve7b2el5q2zhjw4tv4lmyewufnpx4lhkekxkoqd.onion'),

('Raznatovic', 'http://f6amq3izzsgtna4vw24rpyhy3ofwazlgex2zqdssavevvkklmtudxjad.onion/'),

('Red Ransomware', 'http://33zo6hifw4usofzdnz74fm2zmhd3zsknog5jboqdgblcbwrmpcqzzbid.onion/'),

('Redalert', 'http://blog2hkbm6gogpv2b3uytzi3bj5d5zmc4asbybumjkhuqhas355janyd.onion/'),

('Relic', 'http://relic5zqwemjnu4veilml6prgyedj6phs7de3udhicuq53z37klxm6qd.onion'),

('Revil', 'http://dnpscnbaix6nkwvystl3yxglz7nteicqrou3t75tpcc5532cztc46qyd.onion/'),

('Rhysida', 'http://rhysidafohrhyy2aszi7bm32tnjat5xri65fopcxkdfxhi4tidsg7cad.onion/'),

('Robinhood', 'https://robinhoodleaks.tumblr.com'),

('Rook', 'http://gamol6n6p2p4c3ad7gxmx3ur7wwdwlywebo2azv3vv5qlmjmole2zbyd.onion'),

('Royal', 'http://royal2xthig3ou5hd7zsliqagy6yygk2cdelaxtni2fyad6dpmpxedid.onion'),

('Rransom', 'http://t2tqvp4pctcr7vxhgz5yd5x4ino5tw7jzs3whbntxirhp32djhi7q3id.onion'),

('Sabbath', 'http://54bb47h.blog'),

('Shadow', 'http://lc65fb3wrvox6xlyn4hklwjcojau55diqxxylqs4qsfng23ftzijnxad.onion'),

('Siegedsec', 'http://nv5p2mmpctvyqdyyi5zwh4gnifq2uxdx4etvnmaheqlrw6ordrjwxryd.onion/'),

('Slug', 'http://3ytm3d25hfzvbylkxiwyqmpvzys5of7l4pbosm7ol7czlkplgukjq6yd.onion'),

('Snatch', 'https://snatchnews.top/'),

('Solidbit', 'http://solidb2jco63vbhx4sfimnqmwhtdjk4jbbgq7a24cmzzkfse4rduxgid.onion/login'),

('Space Bears', 'http://5butbkrljkaorg5maepuca25oma7eiwo6a2rlhvkblb4v6mf3ki2ovid.onion/'),

('Sparta', 'http://zj2ex44e2b2xi43m2txk4uwi3l55aglsarre7repw7rkfwpj54j46iqd.onion'),

('Spook', 'http://spookuhvfyxzph54ikjfwf2mwmxt572krpom7reyayrmxbkizbvkpaid.onion/blog/'),

('Stormous', 'http://3slz4povugieoi3tw7sblxoowxhbzxeju427cffsst5fo2tizepwatid.onion'),

('Suncrypt', 'http://x2miyuiwpib2imjr5ykyjngdu7v6vprkkhjltrk4qafymtawey4qzwid.onion/'),

('Synack', 'http://xqkz2rmrqkeqf6sjbrb47jfwnqxcd4o2zvaxxzrpbh2piknms37rw2ad.onion/'),

('Team Underground', 'http://ehehqyhw3iev2vfso4vqs7kcrzltfebe5vbimq62p2ja7pslczs3q6qd.onion/auth/login'),

('Trigona', 'http://6n5tfadusp4sarzuxntz34q4ohspiaya2mc6aw6uhlusfqfsdomavyyd.onion'),

('Trisec', 'http://orfc3joknhrzscdbuxajypgrvlcawtuagbj7f44ugbosuvavg3dc3zid.onion/victim.html#'),

('U-Bomb', 'http://contiuevxdgdhn3zl2kubpajtfgqq4ssj2ipv6ujw7fwhggev3rk6hqd.onion'),

('Unknown', 'http://tdoe2fiiamwkiadhx2a4dfq56ztlqhzl2vckgwmjtoanfaya4kqvvvyd.onion'),

('Unsafe', 'http://unsafeipw6wbkzzmj7yqp7bz6j7ivzynggmwxsm6u2wwfmfqrxqrrhyd.onion/'),

('V Is Vendetta', 'http://test.cuba4ikm4jakjgmkezytyawtdgr2xymvy6nvzgw5cglswg3si76icnqd.onion'),

('Vfokx', 'http://vfokxcdzjbpehgit223vzdzwte47l3zcqtafj34qrr26htjo4uf3obid.onion'),

('Vicesociety', 'http://vsociethok6sbprvevl4dlwbqrzyhxcxaqpvcqt5belwvsuxaxsutyad.onion'),

('Vsop', 'http://mrdxtxy6vqeqbmb4rvbvueh2kukb3e3mhu3wdothqn7242gztxyzycid.onion/'),

('Werewolves', 'https://weerwolven.biz/en/'),

('Wiper Leak', 'https://discord.com/invite/jjZQdDNnG'),

('Xinglocker', 'http://xingnewj6m4qytljhfwemngm7r7rogrindbq7wrfeepejgxc3bwci7qd.onion/'),

('Xinof', 'http://wj3b2wtj7u2bzup75tzhnso56bin6bnvsxcbwbfcuvzpc4vcixbywlid.onion'),

('Yanluowang', 'http://jukswsxbh3jsxuddvidrjdvwuohtsy4kxg2axbppiyclomt2qciyfoad.onion/'),

('Zeon', 'http://zeonrefpbompx6rwdqa5hxgtp2cxgfmoymlli3azoanisze33pp3x3yd.onion'),

('Zero Tolerance Gang (Ztg)', 'http://zhuobnfsddn2myfxxdqtpxk367dqnntjf3kq7mrzdgienfxjyllq4rqd.onion/');

DROP TABLE IF EXISTS `Incidentes`;
CREATE TABLE `Incidentes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `victima` varchar(255) NOT NULL,
  `actor_id` int DEFAULT NULL,
  `Pais_Victima` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `actor_id` (`actor_id`),
  CONSTRAINT `Incidentes_ibfk_1` FOREIGN KEY (`actor_id`) REFERENCES `Actores` (`id`)
);

CREATE DATABASE IF NOT EXISTS exploit;
USE exploit;
CREATE TABLE `exploit` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Fecha` date DEFAULT NULL,
  `Titulo` varchar(255) DEFAULT NULL,
  `Tipo` varchar(50) DEFAULT NULL,
  `Plataforma` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
);

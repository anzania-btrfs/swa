# Vipimo Rasmi vya Lugha ya Swa

Hati hii ni marejeo rasmi ya lugha ya Swa. Kila kanuni hapa
imejaribiwa kwenye mnyororo wa mkusanyaji (mbegu na mnyororo wa
kujikusanya wa .swa) au imeandikwa wazi kama kikomo (tazama
`hati/mipaka.md`). Toleo hili linalenga Swa 1.0.

Uthibitisho kamili wa 2026-08-27 (kesi ~487 zilizokusanywa na
kuendeshwa kwenye minyororo yote miwili) umeandikwa kwenye
`hati/uthibitisho-wa-lugha.md` — ambapo kipimo kinapinga kanuni ya
hati hii, kipimo ndicho cha kusadikiwa. Sehemu zilizobainishwa hapa
chini ("kilichopimwa") zinaonyesha mahali ambapo kipimo
kilipata tofauti na ahadi ya hati hii.

## 1. Muundo wa Kimsingi

Programu ya Swa ni mfuatano wa tangazo la kiwango cha juu:

- Tangazo la kazi (`N32 jumlisha(N32 a, N32 b) { ... }`)
- Tangazo la muundo (`muundo Nukta { N32 x; N32 y; };`)
- Tangazo la kigezo cha ulimwengu (`N32 KIKOMO = 0;` na safu za
  ulimwengu `N8 bafa[1024];`)
- Tangazo la utegemezi (`husisha { faili.swa }`) — hakuna
  mkusanyaji anayesoma faili lililotajwa kwa sasa; faili lazima
  ziunganishwe kwanza (cat) — au kiungo cha C (`husisha C::stdio`)

Sehemu ya kuingia ni kazi `main`. Katika hali ya `--exe`, sahihi ni
`N32 main()` au `N32 main(N32 argc, N8** argv)`.

Kila faili huchanganuliwa kwa mpangilio wa juu-chini; wito wa mbele
unaruhusiwa (kazi inaweza kuitwa kabla ya kutangazwa).

## 2. Leksia

### 2.1 Vitambulisho

Vitambulisho huanza na herufi (a-z, A-Z) au `_`, na vinaendelea kwa
herufi, tarakimu, au `_`. Majina yote ya lugha, maktaba, na maoni ni
Kiswahili kwa mkongwe.

### 2.2 Maneno Muhimu

`muundo`, `rudisha`, `kama`, `sivyo`, `wakati`, `kwa`, `vunja`,
`endelea`, `chagua`, `hali`, `husisha`, `achilia`.

Maneno muhimu hayawezi kutumika kama majina ya vitambulisho.
`tenga` si neno muhimu — ni kazi ya kawaida ya maktaba (sehemu 10):
`tenga(ukubwa(N32))` huweka kipande cha baiti `ukubwa(N32)`.
Aina za nambari haziko kwenye orodha hii — hutambuliwa kisintaksia
kwa herufi kubwa: `[N|A|D|B|W]` ikifuatiwa na tarakimu (mf. `N32`,
`D64`, `W0`). Dereva wa Rust (majaribio) una maneno muhimu ya ziada
(`fanya`, `muungano`, `kutoka`, `badili`, `nakili`, `ukubwa`, `nenda`)
ambayo hayako kwenye mkusanyaji wa uzalishaji.

### 2.3 Halisi

- Nambari kamili: mfuatano wa tarakimu. Aina yake ya chaguo-msingi ni
  N32 ikiwa inatoshea ndani ya 32-bit signed; nje ya hapo ni N64.
  Kilichopimwa (2026-08-27, hati/uthibitisho-wa-lugha.md): mnyororo
  wa .swa unashughulikia halisi za [2^31, 2^63) kwenye kigezo na
  ulimwengu; halisi >= 2^63 zinakatwa KIMYA hadi biti 32 kwa minyororo
  yote miwili; halisi kubwa kama hoja ya wito inavunjika (ukataji au
  kosa lisilo sahihi); halisi ÷ halisi yenye N64 inaanguka (FPE).
  Kikomo cha zamani "2147483648 inageuka -2147483648" kinahusu mbegu
  (angalia `hati/mipaka.md` sehemu ya 5).
- Mfuatano: `"habari"` — baiti za N8 zikifuatiwa na 0. Utorokaji:
  `\n` na `\\` zinafanya kazi kwenye minyororo yote miwili; `\t` na
  `\"` zinafanya kazi kwenye mbegu lakini mnyororo wa uzalishaji
  unachapisha alama halisi (5c 74, 5c 22) — kilichopimwa 2026-08-27.
- Desimali: `21.5` — D64. Hesabu, ulinganisho na ukanushaji NDANI ya
  ulimwengu wa D64 zinafanya kazi kwenye minyororo yote miwili,
  ikijumuisha wito wa kazi (mbegu inatumia ABI ya uhamisho wa GP —
  kilichopimwa 2026-08-27; kikomo cha zamani cha "ABI ya xmm kwenye
  mbegu" kimeondolewa, `hati/mipaka.md` 4c). KILA mpaka kati ya D64
  na nambari kamili umevunjika kwa minyororo yote miwili: kurudisha
  D64 kwenye kazi ya N32, ugawaji D64 hadi N32, operesheni
  mchanganyiko (`1 + 2.5`), ulinganisho mchanganyiko (`2.5 < 3`), na
  upakiaji wa ulimwengu wa D64 — jibu la takataka. D32 imevunjika
  (poromoko kwenye wito wa kazi).

### 2.4 Maoni

`//` hadi mwisho wa mstari. Vizuizi `/* ... */` vinafanya kazi
kwenye mnyororo wa uzalishaji (upachikaji unaruhusiwa kwa vitendo,
kinyume cha maelekezo ya awali); mbegu inakataa vizuizi vya maoni
na inaanguka katikati ya usemi. Kilichopimwa 2026-08-27,
hati/uthibitisho-wa-lugha.md.

### 2.5 Ishara

`+ - * / % << >> < > <= >= == != && || & | = ? : ( ) { } [ ]
-> * & , ;`

Kilichopimwa (2026-08-27): `!` na `~` zinakataliwa kwa minyororo
yote miwili (mbegu: "herufi isiyojulikana"; uzalishaji: kosa la
mchanganuzi) — ahadi za sehemu ya 3 (matokeo ya `!` ni 1 au 0) na
ya orodha hii hazishikiki. `^`
inachanganuliwa na mnyororo wa uzalishaji lakini usemi wa kulia
unatupwa kimya (jibu baya); mbegu inakataa. Viendeshaji vya kiwanja
`+= -= *= /= %=` vinafanya kazi kwenye uzalishaji pekee; `&= |= ^=
<<= >>=` vinakubaliwa na kuwa NO-OP kimya kwenye uzalishaji.

## 3. Aina

| Aina | Maelezo |
|---|---|
| `N8` | Nambari kamili yenye ishara, baiti 1 |
| `N16` | Nambari kamili yenye ishara, baiti 2 |
| `N32` | Nambari kamili yenye ishara, baiti 4 |
| `N64` | Nambari kamili yenye ishara, baiti 8 |
| `W0` | Bila thamani (void) — kwa kazi tu. Kilichopimwa 2026-08-27: inakubaliwa kimya kama kigezo chenye thamani (5) kwa minyororo yote miwili — uvunjaji wa kanuni hii |
| `D64` | Desimali, baiti 8 — **kikomo, angalia 2.3** |
| `B1` | Boolean — ya ndani; matokeo ya ulinganisho na mantiki |
| `T*` | Kielekezi kwa aina T |
| `T[n]` | Safu ya vitu n vya aina T |
| `muundo` | Muundo uliotangazwa na mtumiaji |

Familia za nambari ni N (kamili yenye ishara), A (asili/bila ishara),
D (desimali), B (boolean/biti), na W (upana wa mashine; W0 = void).
Upana unaosaidiwa na kufanya kazi kwa usahihi ni 8, 16, 32 na 64
pekee (D32/D64 kwa desimali). Kilichopimwa (2026-08-27): upana
mwingine wowote (N128, A128, D80, A3, N7, n.k.) unakubaliwa kimya
na mnyororo wa uzalishaji kwa semantiki zisizo za upana huo (jibu
baya kwa thamani zinazohitaji zaidi ya biti 64) na unaangusha
mkusanyaji wa mbegu. Hakuna neno muhimu la "tupu" au halisi za
"kweli"/"uongo" — W0 hutumika kwa bila-thamani na 1/0 kwa ukweli.

Matokeo ya `==`, `!=`, `<`, `>`, `<=`, `>=`, `&&`, `||` ni thamani
ya 1 (kweli) au 0 (si kweli). Kiambishi `!` hakijatekelezwa kwenye
mkusanyaji wowote kati ya wawili (kilichopimwa 2026-08-27).

## 4. Usemi na Utangulizi

Utangulizi wa ishara ni ule wa C (kutoka juu hadi chini):

| Kina | Ishara |
|---|---|
| 12 | `*` `/` `%` |
| 11 | `+` `-` |
| 10 | `<<` `>>` |
| 9 | `<` `>` `<=` `>=` |
| 8 | `==` `!=` |
| 7 | `&` |
| 6 | `^` |
| 5 | `|` |
| 4 | `&&` |
| 3 | `||` |
| 2 | `?:` (ternary) |
| 1 | `=` (ugawi) |

Mabano hubadilisha utangulizi. Chaguo la ternary `sharti ? kweli :
uwongo` linasaidiwa; upande wa uwongo wa ternary haushiki ugawi
(`a ? b : c = d` ni `(a ? b : c) = d`). Ugawi ni wa ushirika wa
kulia (`a = b = c` ni `a = (b = c)`); viendeshaji vingine vyote
vya binary ni vya ushirika wa kushoto.

Mifano: `4 | 2 & 1` ni `4 | (2 & 1)` = 4, `12 & 10 | 3` ni
`(12 & 10) | 3` = 11, `a = 1 && 0` inagawia a = 0,
`a = 2 == 2` inagawia a = 1, `x = 1 ? 2 : 3` inagawia x = 2.

Kilichopimwa (2026-08-31): jedwali hili linashikiliwa na minyororo
yote miwili (mbegu na mnyororo wa .swa) — tofauti ya zamani kati
ya minyororo (mbegu ilikuwa na `&&` `||` `&` `|` `^` katika
kiwango kimoja na `=` pamoja na `==`) imefungwa kwa kufuata
utangulizi wa C kwenye mbegu. Pia: `<<`/`>>` upande wa KULIA wa
`< > <= >=` haubaliwi kwenye minyororo yote miwili (`1 < 2 << 1`
hutoa kosa la mchanganuzi) hata ingawa jedwali la juu linaweka
uhamishaji juu ya ulinganisho; `2 << 1 < 4` inafanya kazi.
`^` inakataliwa na mbegu na inarudisha operanda ya kushoto pekee
kwenye mnyororo wa uzalishaji (jibu baya — angalia 2.5).

### 4.1 Mantiki ya fupi-hali (short-circuit)

`&&` na `||` zinatathmini kwa fupi-hali KATIKA MBEGU NA MNYORORO WA
.SWA:

- `a && b`: `b` haitathminiwi ikiwa `a` ni 0. Matokeo: 1 ikiwa zote
  mbili si 0, sivyo 0.
- `a || b`: `b` haitathminiwi ikiwa `a` si 0. Matokeo: 1 ikiwa
  yoyote si 0, sivyo 0.

Hii inaruhusu `j >= 0 && a[j] == x` bila kusoma nje ya mipaka.
Rekebisho la 2026-08: mbegu ilikuwa inatathmini pande zote mbili
(kinyume na uzalishaji.swa) — imewianishwa; majaribio ya kurejesha
ni `jaribio_mbegu_mzunguko_mfupi`.

### 4.2 Hesabu ya kielekezi

- `&x` — anwani ya kigezo au sehemu ya muundo.
- `*p` — nyoosha: thamani iliyoko kwenye anwani p.
- `p->sehemu` — sehemu ya muundo kupitia kielekezi.
- `a[i]` — safu au kielekezi: `*(a + i * ukubwa_wa_kipengele)`.
- Usemi wa `safu` pekee hutathminiwa kama kielekezi kwa kipengele
  chake cha kwanza.

Kilichopimwa (2026-08-27): faharisi `a[i]` inafanya kazi kwa safu
za N na kwa kielekezi; lakini safu za MIUNDO zinaanguka (SEGV) kwa
minyororo yote miwili, na `*(p + n)` haikuzwi kwa ukubwa wa
kipengele (ni hesabu ya BAITI) — `*(p + 3)` kwenye N32* inasoma
baiti 3 baada ya p, si kipengele cha 3. `*(safu + 1)` (kuoza kwa
safu) inatoa 0 kwenye uzalishaji na inaanguka kwenye mbegu.

## 5. Tangazo la Kazi

```
<aina> <jina>(<vigezo>) { <mwili> }
```

- Vigezo: `N32 a`, `N32* p`, `Orodha* o` (muundo kwa kielekezi au kwa
  thamani).
- `rudisha <usemi>;` kwa kazi yenye thamani; `rudisha;` kwa W0.
- Wito wa kujirudia na wito wa mbele unasaidiwa.

## 6. Taarifa

### 6.1 Tangazo la kigezo

`N32 x = 5;` — ndani ya block. Kianzilishi ni cha hiari
(`N32 x;` inaruhusiwa) lakini thamani ya kigezo kisichoanzishwa ni
ISYOFANULIWA (kumbukumbu ya rafu isiyoanzishwa) — usiisome kabla ya
kuigawa.

### 6.2 Ugawi

`x = usemi;` — ugawi ni usemi (matokeo yake ni thamani iliyogawiwa).

### 6.3 Kama/sivyo

```
kama (sharti) { ... }
sivyo { ... }              // hiari

// Tawi-jingine (else-if) huandikwa kwa kuingiza kama ndani ya sivyo:
kama (sharti1) { ... }
sivyo {
    kama (sharti2) { ... }
    sivyo { ... }
}
```

### 6.4 Wakati

```
wakati (sharti) { ... }
```

### 6.5 Kwa (for)

```
kwa (kianzilishi; sharti; hatua) { ... }
```

Sehemu zote tatu ni za hiari. **Semantiki ya `endelea`:** inaruka
kwenye HATUA (ya tatu), si kwenye sharti — semantiki ya C, katika
mbegu NA mnyororo wa .swa (uliowiana 2026-08; angalia mipaka.md 4b).

Kilichopimwa (2026-08-27): `endelea` kama TAARIFA YA MWISHO ya
mwili wa `kwa` inavunja mnyororo wa uzalishaji — taarifa zote baada
ya kitanzi hazitekelezwi kamwe (jibu baya la kimya); mbegu ni
sahihi. Kesi hii ni kando ya majaribio ya kurejesha yaliyopo;
angalia hati/uthibitisho-wa-lugha.md 4.2.

### 6.6 Chagua (switch)

```
chagua (usemi) {
    hali 1: ... ;
    hali 2: ... ;
    sivyo: ... ;
}
```

Kilichopimwa (2026-08-27): mbegu inakataa `chagua` kwa muundo
(kosa la mchanganuzi). Mnyororo wa uzalishaji unafanya kazi kwa
hali za nambari halisi ndogo; lebo hasi (`hali -3`), lebo za N64
kubwa (> 2^31) na lebo za usemi au kigezo zinakubaliwa LAKINI
hazilingani kamwe (lebo inakuwa 0 kwenye kizazi) — jibu baya la
kimya; lebo maradufu: ya kwanza inashinda bila kosa; `kama` +
`sivyo` ndani ya mkono wa `chagua` na bloku `{ }` ndani ya mkono
zinakataliwa na uzalishaji.

### 6.7 Vunja na endelea

- `vunja;` — toka nje ya mzunguko wa ndani (wakati au kwa).
- `endelea;` — ruka hadi mwisho wa mwili na uendelee.

## 7. Miundo

```
muundo Nukta {
    N32 x;
    N32 y;
};
```

- Upatikanaji wa sehemu: `p.x` (kwa thamani) na `p->x` (kwa
  kielekezi).
- Miundo inaweza KUREJESHWA kwa thamani (sret) kwenye minyororo
  yote miwili. KUPITISHWA kwa thamani kumepimwa 2026-08-27: mbegu
  inarudisha takataka; mnyororo wa uzalishaji unafanya kazi kwa
  miundo ya baiti <= 8 pekee — zaidi ya hapo inarudisha sehemu ya
  kwanza pekee (jibu baya). Safu za miundo zinaanguka (SEGV) kwa
  minyororo yote miwili, na ugawi wa muundo `b = a;` ni takataka
  (mbegu) au SEGV (uzalishaji).
- Hakuna urithi, hakuna miundo ya kijiuzi.

## 8. Utegemezi wa faili (husisha)

- `husisha { faili.swa }` — tangazo la utegemezi. Kilichopimwa
  (2026-08-27, hati/uthibitisho-wa-lugha.md): HAKUNA mkusanyaji
  (mbegu WALA mnyororo wa .swa) anayesoma faili lililotajwa —
  mstari unarukwa na mchanganuzi. Kiungo kinatoshelezwa kwa
  KUUNGANISHA (cat) pekee: faili lazima ziunganishwe kwanza
  (mf. `cat msingi/kumbukumbu.swa program.swa`). Wito wa kazi
  isiyofafanuliwa unalia kwa sauti kwenye mnyororo wa uzalishaji
  (`Hitilafu: kazi haijafafanuliwa: <jina>`); mbegu inakataa kimya
  katika kesi kadhaa. Ahadi ya awali kwamba "mkusanyaji wa .swa
  hulichakata faili lililotajwa" haishikiki — angalia
  `hati/mipaka.md` 8.
- `husisha C::stdio` — kiungo cha C: hakiathiri mchanganuzi; jina la
  kumbukumbu la C limeandikwa kwenye kitu kilichotolewa.

## 9. Kazi za Ndani (builtins)

- `wito_wa_mfumo(N64 namba, N64 a1, ..., N64 a6)` — simu ya syscall
  ya Linux moja kwa moja. ABI: rax=namba, rdi, rsi, rdx, r10, r8, r9.
  INAFANYA KAZI (kilichopimwa 2026-08-27).
- `tekeleza(N8* kazi, N32 argc, N8** argv, N32 ofseti)` na
  `anwani_ya_kazi(N8* jina)` — kilichopimwa (2026-08-27): HAZIPO
  kwenye minyororo yote miwili kama kazi za lugha; wito wake
  unakataliwa ("kazi haijafafanuliwa"). Ahadi hii imeondolewa kwenye
  vipimo hadi itakapotekelezwa.

## 10. Maktaba ya Kawaida (msingi/)

| Faili | Kazi muhimu |
|---|---|
| `kumbukumbu.swa` | nakili, weka_sifuri, linganisha_kumbukumbu, tenga/achilia (arena), sys_soma/sys_andika/sys_fungua/sys_funga, andika, soma_mstari |
| `mfuatano.swa` | urefu_wa_mfuatano, linganisha_mfuatano, nakili_mfuatano, unganisha_mfuatano, tafuta_herufi, tafuta_mfuatano, kata_nafasi, nambari_kwa_mfuatano, mfuatano_hadi_n32/n64 |
| `hesabu.swa` | hesabu_kamili/kubwa, hesabu_ndogo/dogo, neneo_n32/n64, gcd_hesabu, pow_kamili, isqrt_hesabu, fibonacci_hesabu |
| `orodha.swa` | Orodha (inafanya kazi kwa uwezo uliotengwa mapema; UKUAJI haufanyi kazi — kilichopimwa 2026-08-27: orodha_ongeza zaidi ya uwezo inaanguka SEGV kwa minyororo yote miwili, mzizi ni faharisi hasi katika badili): orodha_mpya, orodha_ongeza, orodha_pata, orodha_futa_mwisho, orodha_urefu, orodha_huru |
| `mpangilio.swa` | pangilia_n32, pangilia_n32_kushuka, pangilia_n64, pangilia_n64_kushuka |
| `ramani.swa` | Ramani ya jina hadi thamani (inafanya kazi kwenye uzalishaji; kwenye mbegu weka ni no-op — jibu baya, kilichopimwa 2026-08-27) |

Kila kazi imejitosheleza; maktaba inaweza kuunganishwa kwa mkono
(`cat`) kwa matumizi na mbegu.

## 11. Mipaka ya 1.0

Tazama `hati/mipaka.md` kwa orodha kamili yenye viwango vya ukali.
Muhtasari: ABI ya wito wa kazi za D64 imefungwa kwenye minyororo
yote miwili (kilichopimwa 2026-08-27); mpaka wa D64 na nambari
kamili umevunjika, D32 imevunjika, halisi >= 2^63 zinakatwa kimya,
upana usio wa 8/16/32/64 unakubaliwa kimya, na `husisha { faili }`
hauingizi faili popote — angalia `hati/mipaka.md` na
`hati/uthibitisho-wa-lugha.md`. Mwisho wa LLVM wa dereva wa Rust ni
wa MAJARIBIO (mnyororo wa uzalishaji ni mbegu/exe pekee), na upeo
wa tokeni 262,144 unalia kwa sauti.

## 12. Uthibitisho

Kila kanuni katika hati hii ina mwenzake kwenye majaribio ya
ujumuishaji (`majaribio/integration.rs`) au kwenye mnyororo wa
kujikusanya (fixpoint: stage2-exe == stage3-exe sawa kwa baiti).
Majaribio yote: 146 ya maktaba + 80 ya ujumuishaji + 1 ya nyaraka.

Kumbuka kilichopimwa (2026-08-27): fixpoint inathibitisha
kujikusanya, si usahihi wa semantiki. Uthibitisho kamili wa tabia
ya lugha (kesi ~487 zilizokusanywa na kuendeshwa kwenye minyororo
yote miwili) umeandikwa kwenye `hati/uthibitisho-wa-lugha.md`;
kanuni kadhaa za hati hii hazishikiki (desimali kwenye mpaka wa
nambari kamili, `!`, `~`, `^`, ukuaji wa Orodha, `husisha`,
`anwani_ya_kazi`/`tekeleza`, upana usio wa 8/16/32/64).

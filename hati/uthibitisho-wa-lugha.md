# Uthibitisho wa Lugha ya Swa

Rekodi rasmi ya uzingatiaji wa vipimo — kila matokeo hapa yalipimwa
kwa kukusanya na kuendesha programu halisi kwenye minyororo yote
miwili ya mkusanyaji. Hakuna kitu kilichokisiwa.

Tarehe ya kipimo: 2026-08-27.

Minyororo iliyopimwa:

- mbegu — `msingi/mbegu.bin`, mkusanyaji wa bootstrap (mzizi).
- uzalishaji — stage1, iliyojengwa kutoka `msingi/*.swa` kupitia
  mbegu (mnyororo wa kujikusanya; fixpoint stage2-exe == stage3-exe
  sawa kwa baiti inashikilia).

Hali ya hazina wakati wa kipimo: tawi main, commit a1831d3.

## 1. Uainishaji

Kila kesi inaainishwa mojawapo ya nne:

- **inapita** (SAWA): inakusanya, inaendesha, na jibu lake ni sahihi
  (msimbo wa kutoka na pato vinalingana na matarajio).
- **jibu baya** (JIBU-BAYA): inakusanya na kuendesha bila kosa, lakini
  jibu si sahihi — kimyakimya. Programu inaonekana imefanikiwa na
  inatoa jibu lingine.
- **huanguka** (HUANGUKA): inakusanya lakini inaanguka — wakati wa
  kukusanya (mkusanyaji mwenyewe) au wakati wa kuendesha (SEGV 139,
  FPE 136, n.k.).
- **imekataliwa** (IMEKATALIWA): inakataa kukusanya kwa msimbo wa
  kutoka usio sifuri. Mnyororo wa uzalishaji huandika ujumbe kwenye
  stderr; mbegu huandika kwenye stdout (mahali pa ELF) — na katika
  kesi kadhaa mbegu inakataa KIMYA (msimbo 1, hakuna ujumbe).

Jibu baya ni mbaya kuliko kukataliwa. Ukataaji ni sauti: mwandishi
anajua lugha haikubali msimbo wake na anaweza kuchukua njia nyingine.
Jibu baya ni kimya: mkusanyaji anakubali programu, anaizalisha kwa
muonekano kamili, na jibu lake ni potofu — mdudu anaingia kwenye
programu zilizojengwa bila ishara yoyote. Ukataaji unagharimu muda
wa kukusanya; jibu baya linaweza kugharimu data au programu
zilizotumwa. Sehemu ya 4 inaorodhesha kila jibu baya lililopimwa,
kwa kipimo cha chini, kilichoonekana, na kinachotarajiwa.

Poromoko la mkusanyaji lenyewe kwenye chanzo halali linachukuliwa
kuwa mbaya zaidi kuliko poromoko la programu: mkusanyaji lazima
asikatee, asikatwe kimya, wala asianguke kwa ingizo lolote.

Msimbo wa kutoka wa programu hupimwa kwa mod 256 (baiti 8). SEGV ni
139, FPE ni 136. Thamani "0" inaweza kuficha thamani inayogawanyika
kwa 256; pale ambapo ilikuwa muhimu, tabia imethibitishwa kwa
uchunguzi wa mashine (od/objdump).

Bootstrap ya mnyororo ni mafanikio halisi: kwanza (baiti za mkono,
393) hadi mbegu hadi stage1-exe hadi stage2-exe == stage3-exe, bila
lugha nyingine popote. Fixpoint hiyo inashikilia. Lakini fixpoint
inathibitisha kujikusanya, si usahihi wa semantiki: mkusanyaji
anaweza kujijenga yenyewe na bado kuwa na makosa kwenye mipaka ya
lugha. Uthibitisho huu ulipima tabia halisi kwenye kesi ~487 na
kupata kwamba nyaraka zilizopo ziliahidi mengi yasiyoshikika.
Rekodi hii inasema kilichopimwa, bila kupamba.

## 2. Jinsi ya kuzalisha ukaguzi

Mkusanyaji wa uzalishaji hujengwa kutoka chanzo cha .swa kupitia
mbegu (mnyororo wa kujikusanya):

```bash
cd /home/kandemark/Projects/compilers/swa
cat msingi/{kumbukumbu,mfuatano,msomaji,msambazaji,mteremko,mkaguzi,uzalishaji,orodha,ramani,stage1}.swa > /tmp/swa-uthibitisho/zima.swa
msingi/mbegu.bin --exe /tmp/swa-uthibitisho/zima.swa > /tmp/swa-uthibitisho/stage1.bin
chmod +x /tmp/swa-uthibitisho/stage1.bin
```

Kila kesi inakusanywa na kuendeshwa kwenye minyororo yote miwili:

```bash
msingi/mbegu.bin --exe kesi.swa > matokeo.bin 2> makosa.txt
chmod +x matokeo.bin
./matokeo.bin; echo $?

/tmp/swa-uthibitisho/stage1.bin --exe kesi.swa > matokeo.bin 2> makosa.txt
chmod +x matokeo.bin
./matokeo.bin; echo $?
```

Faili za chanzo na matokeo mabichi zimehifadhiwa kwenye
`/tmp/swa-uthibitisho/`:

- `majaribio/` — kesi 195 za mfumo wa aina; matokeo mabichi
  `mbegu.csv` na `uzalishaji.csv` (mzunguko wa pili: `mbegu2.csv`
  na `uzalishaji2.csv`).
- `kesi/` — kesi za taarifa, udhibiti wa mwendo na viendeshaji
  (endesha_mwenyewe.sh hujaribu kwa minyororo yote miwili).
- `chanzo/` — kesi 162 za miundo, kumbukumbu na maktaba
  (jaribu.sh hujumlisha moduli za msingi na kesi, hukusanya kwa
  minyororo yote miwili, huendesha na kulinganisha).

Jumla ya kesi zilizopimwa: 195 (mfumo wa aina) + ~130 (udhibiti) +
162 (miundo na maktaba).

## 3. Jedwali za uzingatiaji

### 3.1 Mfumo wa aina

| Kipengele | Mbegu | Uzalishaji | Inavyotarajiwa (hati) | Hali |
|---|---|---|---|---|
| N8, N16, N32 ndani na ulimwengu: hesabu, hasi, kufurika kwa mod | inapita | inapita | aina za baiti 1, 2, 4 | inapita |
| N64 ndani, thamani [2^31, 2^63): `N64 x = 4294967300; x % 4294967296` | huanguka (FPE 136) | inapita (4) | N64 kamili kwenye mnyororo wa .swa | mbegu huanguka; uzalishaji unapita |
| N64, thamani >= 2^63: `N64 x = 18446744073709551615; x + 1` | jibu baya (0; x = 4294967295, mov eax, 0xFFFFFFFF) | jibu baya (0; ukataji uleule) | N64 kamili | jibu baya (ukataji wa kimya) |
| N64 ulimwengu, ugawanyo, masali | inapita | inapita | semantiki ya C | inapita |
| A8/A16/A32/A64 (bila ishara) | huanguka (mkusanyaji SEGV 139) | inapita (isipokuwa mgawanyo wenye biti ya juu) | familia A | mbegu huanguka kwenye chanzo halali |
| Mgawanyo/masali bila ishara wenye biti ya juu (A/B/W) | huanguka (mkusanyaji SEGV) | huanguka (FPE 136) | jibu sahihi | huanguka (cdq/cqo kabla ya div) |
| B1 kama kigezo, parameta, matokeo ya ulinganisho | huanguka (SEGV/FPE) | inapita | B1 ya ndani | mbegu huanguka; uzalishaji unapita |
| B8/B16/B32/B64 | huanguka (mkusanyaji SEGV) | inapita (isipokuwa mgawanyo wenye biti ya juu) | familia B | mbegu huanguka |
| W0 kama kigezo chenye thamani: `W0 x = 5` | inakubali kimya (5) | inakubali kimya (5) | W0 ni kwa kazi tu | hati imevunjika — inapaswa kukataliwa |
| W8/W16/W32/W64 | huanguka (mkusanyaji SEGV) | inapita (isipokuwa mgawanyo wenye biti ya juu) | familia W | mbegu huanguka |
| D64 ndani ya ulimwengu wa D64: hesabu, ulinganisho, ukanushaji | inapita | inapita | hesabu za kuelea | inapita |
| D64 katika kazi (parameta na kurudisha): `mbili(2.5) == 3.5` | inapita (ABI ya uhamisho wa GP) | inapita (ABI ya xmm) | mipaka 4c ilisema mbegu inakataa | inapita kwa zote mbili — ahadi ya mipaka 4c imekosea |
| D64 hadi N32 kwenye rudisha/ugawaji: `rudisha 21.5` | jibu baya (0) | jibu baya (0) | 21 (kukata hadi sifuri) | jibu baya |
| Mchanganyiko wa D64 na nambari kamili: `(1 + 2.5) * 2` | jibu baya (6) | jibu baya (6) | 7 | jibu baya |
| D64 ulimwengu (upakiaji): `G == 3.5` na G = 2.5 | jibu baya (1) | jibu baya (1) | 0 | jibu baya (mov rax badala ya movsd) |
| D64 ugawaji upya: `x = 0.0; x = 2.5; x == 2.5` | jibu baya (0) | inapita (1) | 1 | mbegu jibu baya |
| D32 (kigezo, hesabu, kazi) | huanguka (SEGV/FPE) | jibu baya (4) au huanguka (SEGV) | D32 | mbegu huanguka; uzalishaji jibu baya/huanguka |
| D64 % int, D64 << int | jibu baya (takataka) | jibu baya (takataka) | inapaswa kukataliwa kwa sauti | jibu baya — inakubaliwa kimya |
| Halisi ndogo na hasi (N32) | inapita | inapita | hesabu za N32 | inapita |
| Halisi [2^31, 2^63) kwenye kigezo/ulimwengu | jibu baya (shift 32-bit) au huanguka (FPE) | inapita | mipaka 5 | uzalishaji unapita; mbegu jibu baya/huanguka |
| Halisi >= 2^63 | jibu baya (ukataji) | jibu baya (ukataji) | thamani kamili | jibu baya |
| Halisi kubwa kama hoja ya wito | jibu baya (ukataji) | imekataliwa kwa kosa lisilo sahihi | hoja ya N64 | uzalishaji imekataliwa kwa makosa; mbegu jibu baya |
| Halisi ÷ halisi yenye N64: `4294967296 / 4294967296` | huanguka (FPE 136) | huanguka (FPE 136) | 1 | huanguka (njia ya 32-bit, enc = 0) |
| Halisi za radiksi 0x, 0o, 0b: `0x10` | jibu baya (0) | jibu baya (10) | 16 au kukataliwa kwa sauti | jibu baya (hufasiriwa kama desimali) |
| Upanuzi N8 hadi N32 hadi N64; ukataji kwa mod | inapita (FPE kwa N64) | inapita | upanuzi/ukataji | inapita kwa uzalishaji |
| Shift za N64 kwenye kigezo: `x << 32` | jibu baya (1; shift 32-bit) | inapita (0) | mabadiliko ya 64-bit | mbegu jibu baya |
| Ulinganisho na mantiki hutoa 1/0; mzunguko mfupi wa && na || | inapita | inapita | hati 2.2/3 | inapita |
| Kiambishi `!` (kanusha mantiki) | imekataliwa (herufi isiyojulikana) | imekataliwa (KOSA) | hati 2.2/2.5 inaahidi | imekataliwa — hati imevunjika |
| `~` (kanusha biti) | imekataliwa | imekataliwa | hati 2.5 inaorodhesha | imekataliwa — hati imevunjika |
| Ukali wa mkaguzi wa aina: `N32 x = 2.5` | hakuna mkaguzi | makosa ni onyo; mkusanyaji anaendelea | kosa la aina linazuia kukusanywa | jibu baya la mfumo |
| Upana usio wa 8/16/32/64 (N128, A128, D80, A3, N7) | huanguka (mkusanyaji SEGV) | inakubali kimya, semantiki si za upana huo | "upana wowote wa tarakimu" (hati 3) | uzalishaji jibu baya; mbegu huanguka |
| Kazi tupu yenye mwili usio na taarifa: `N32 f() { }` | inapita | imekataliwa (kazi haijafafanuliwa) | kazi halali (hati 5) | uzalishaji imekataliwa kwa makosa |
| N64 hasi: `N64 x = -90` | jibu baya (4294967206) | jibu baya (4294967206) | -90 | jibu baya (upanuzi wa sifuri) |
| Ukanushaji wa N64: `0 - 10000000000` | jibu baya (2884901888) | jibu baya (2884901888) | -10000000000 | jibu baya (hesabu 32-bit) |
| ukubwa(aina): ukubwa(N32), ukubwa(N8), ukubwa(N64) | jibu baya (zote 8) | inapita (4, 1, 8) | ukubwa halisi | mbegu jibu baya |
| ukubwa(kigezo) | jibu baya (daima 8) | jibu baya (daima 4) | ukubwa halisi | jibu baya |
| Halisi za herufi: `'a'` | imekataliwa kimya | jibu baya (0) | thamani ya herufi (104) | uzalishaji jibu baya; mbegu imekataliwa kimya |

### 3.2 Taarifa, udhibiti wa mwendo na viendeshaji

| Kipengele | Mbegu | Uzalishaji | Inavyotarajiwa (hati) | Hali |
|---|---|---|---|---|
| muundo msingi (sehemu, upachikaji, `->`, `&p.x`) | inapita | inapita | muundo | inapita |
| Safu ya miundo `safu[i].x` | huanguka (SEGV 139) | huanguka (SEGV 139) | aina halali (hati 4.2/7) | huanguka — hakuna safu ya miundo inayofanya kazi |
| `(*p).x` | huanguka (SEGV 139) | inapita | mshale + nyoosha | mbegu huanguka |
| `**q` (kielekezi cha kielekezi) | huanguka (SEGV 139) | inapita | hati 4.2 kwa upanuzi | mbegu huanguka |
| Muundo kwa thamani (hoja), baiti <= 8 | jibu baya (takataka) | inapita | hati 7 | mbegu jibu baya |
| Muundo kwa thamani, zaidi ya baiti 8 | jibu baya (takataka) | jibu baya (sehemu ya kwanza pekee) | hati 7 | jibu baya |
| Muundo kurudishwa kwa thamani (sret) | inapita | inapita | sret | inapita |
| sret inayopitishwa kwa kazi nyingine | jibu baya (takataka) | inapita | sret | mbegu jibu baya |
| Ugawi wa muundo `b = a;` | jibu baya (takataka) | huanguka (SEGV 139) | nakala | zote mbili mbovu |
| kama/sivyo (rahisi, mlolongo, viota, masharti yasiyo ya boolean, mwili tupu) | inapita | inapita | hati 6.3 | inapita |
| wakati, kwa, vunja, endelea (misingi) | inapita | inapita | hati 6.4/6.5/6.7 | inapita |
| endelea kama taarifa ya MWISHO ya mwili wa kwa | inapita | jibu baya (taarifa baada ya kitanzi hazitekelezwi) | semantiki ya C (mipaka 4b) | uzalishaji jibu baya |
| vunja/endelea nje ya kitanzi | inapuuzwa kimya | onyo lakini binary bado inatolewa | C: kosa la kukusanya | jibu baya |
| chagua msingi (mikono, sivyo, viota, selecta ya usemi, kuteremka kwa muundo) | imekataliwa (kosa la mchanganuzi) | inapita | hati 6.6 | uzalishaji unapita; mbegu imekataliwa kwa muundo |
| Lebo hasi za hali: `hali -3` | imekataliwa | jibu baya (lebo inalinganishwa kama 0) | hali -3 inalingana na -3 pekee | uzalishaji jibu baya |
| Lebo za N64 > 2^31: `hali 5000000000` | imekataliwa | jibu baya (lebo inakuwa 0; kamwe hailingani) | mipaka 5 | uzalishaji jibu baya |
| Lebo za usemi/kigezo: `hali a + 1` | imekataliwa | jibu baya (inakubaliwa, kamwe hailingani) | lazima kukataliwa | uzalishaji jibu baya |
| hali maradufu | imekataliwa | ya kwanza inashinda kimya | C: kosa la kukusanya | uzalishaji jibu baya kidogo |
| kama+sivyo ndani ya mkono wa chagua; bloku `{ }` ndani ya mkono | imekataliwa | imekataliwa (KOSA) | hati 6.6 | uzalishaji imekataliwa |
| vunja ndani ya chagua ndani ya kitanzi (inavunja kitanzi, si mkono) | imekataliwa | inapita | semantiki ya C | uzalishaji unapita |
| + - * / % kwa N32; ugawanyo hasi (semantiki ya C) | inapita | inapita | hati 4 | inapita |
| Ugawanyo/modulo kwa sifuri | huanguka (FPE 136) | huanguka (FPE 136) | hati kimya (C: UB) | huanguka (kama C) |
| &, |, <<, >> kwa N32 | inapita | inapita | hati 2.5/4 | inapita |
| `^` (XOR): `6 ^ 3` | imekataliwa | jibu baya (usemi wa kulia unatupwa kimya) | hati 2.5/4 inaahidi | uzalishaji jibu baya |
| +=, -=, *=, /=, %= | imekataliwa (uwekaji usiotumika) | inapita (C-kama) | si ya hati | uzalishaji unapita |
| &=, |=, ^=, <<=, >>= | imekataliwa | jibu baya (NO-OP kimya) | si ya hati | uzalishaji jibu baya |
| ++, -- | imekataliwa | imekataliwa | si ya hati | imekataliwa (sawa) |
| Ternary (pamoja na ushirika wa kulia) | inapita | inapita | hati 4 | inapita |
| Ternary dhidi ya ugawi: `x = 1 ? 2 : 3` | jibu baya (x = 1) | inapita (x = 2) | hati kimya | mbegu jibu baya |
| Ugawi wa mnyororo `a = b = c` | imekataliwa | inapita (ushirika wa kulia) | hati 6.2 kwa upanuzi | uzalishaji unapita |
| Ugawi kwa wito `pata() = 7` | imekataliwa | jibu baya (inaandika anwani isiyo na maana) | lazima ikataliwe | uzalishaji jibu baya |
| `&` anwani, `*` nyoosha, `p[i]` (faharisi) | inapita (isipokuwa `**`) | inapita | hati 4.2 | inapita (tazama miundo) |
| `*(p + n)` bila ukuzaji wa kipengele: `*(p + 3)` | jibu baya (0) | jibu baya (0) | hesabu ya baiti (haijaelezwa waziwazi) | jibu baya kwa mwandishi anayetegemea C |
| `*(safu + 1)` (kuoza kwa safu) | huanguka (SEGV 139) | jibu baya (0) | hati 4.2 | zote mbili mbovu |
| Utangulizi: mbegu inafuata jedwali la hati 4 (`4 | 2 & 1` hutoa 0; `a = 1 && 0` hutoa a = 1) | inapita dhidi ya hati | jibu baya dhidi ya hati (4; a = 0 — C-kama) | jedwali la hati 4 | uzalishaji unakubaliana na C, si na hati |
| `a < b << c` (hamisha upande wa kulia wa ulinganisho) | inapita | imekataliwa (KOSA) | hati 4 inaruhusu (kina 4 > 3) | uzalishaji imekataliwa |
| `1 << 2 + 1` (jumlisha inafunga nguvu kuliko hamisha) | inapita | inapita | hati 4 | inapita (tofauti na C kwa makusudi) |
| Maoni ya `//` | inapita (isipokuwa mwisho wa faili bila \n) | inapita (sawa) | hati 2.4 | inapita |
| Maoni ya `/* */` | imekataliwa (huanguka katikati ya usemi) | inapita (upachikaji unaruhusiwa) | hati 2.4 inaahidi vizuizi, inakataza upachikaji | mbegu imekataliwa; uzalishaji unasaidia zaidi ya hati |
| Utorokaji wa mfuatano: `\n`, `\\` | inapita | inapita | hati 2.3 | inapita |
| Utorokaji wa mfuatano: `\t`, `\"` | inapita | jibu baya (alama halisi 5c 74, 5c 22) | hati 2.3 inaahidi | uzalishaji jibu baya |
| Utorokaji usio wa hati: `\0`, `\x41`, `\r`, `\a` | jibu baya (inatupa `\`) | jibu baya (alama halisi) | si ya hati | jibu baya kwa zote mbili, kwa njia tofauti |
| Mfuatano karibu `"a" "b"` | jibu baya (wa pili anatupwa) | jibu baya (wa pili anatupwa) | C: inaunganisha | jibu baya |
| Usawa wa mfuatano `==` | inalinganisha anwani (literali mbili hazilingani) | literali zinaunganishwa kwenye dimbwi moja (zinalingana) | hati 3: == ni namba/anwani | tofauti kati ya minyororo |
| andika: %d %s %c chanya, hoja hadi 6 | inapita | inapita | maktaba | inapita |
| andika: %d hasi na %d za N64 | jibu baya (4294967254; 705032704) | inapita | %d yenye ishara | mbegu jibu baya |
| andika: %% | jibu baya (imemezwa) | jibu baya (imemezwa) | kawaida ya C: inaonyesha % | jibu baya |
| andika: %u %x %f %l %n | jibu baya (zimemezwa kimya) | jibu baya (zimemezwa kimya) | si za hati | jibu baya |
| andika: hoja ya 7 | jibu baya (inarudia ya 6) | inapita | maktaba | mbegu jibu baya |
| main haipo | imekataliwa (main haipo) | binary inaanguka (SEGV 139) | hati 1 | uzalishaji huanguka |
| `sivyo` bila `kama` | imekataliwa | mkusanyaji wenyewe huanguka (SEGV 139) | kosa la sauti | uzalishaji huanguka (mkusanyaji) |
| W0 ndani ya usemi | jibu baya (takataka 251) | imekataliwa | W0 ni kwa kazi tu | mbegu jibu baya |
| Kurudia, wito wa mbele, wito ndani ya wito, main(N32, N8**) | inapita | inapita | hati 1/5 | inapita |
| Ulimwengu wenye thamani; safu ya ulimwengu | inapita | inapita | hati 1.1 | inapita |
| Ulimwengu wa N64 = 4294967296 | huanguka (FPE 136) | inapita | mipaka 5 | mbegu huanguka (kilichoandikwa) |

### 3.3 Miundo, vielekezi, safu, kazi na kumbukumbu

| Kipengele | Mbegu | Uzalishaji | Inavyotarajiwa (hati) | Hali |
|---|---|---|---|---|
| Tangazo la muundo, sehemu kwa kigezo cha ndani, upachikaji | inapita | inapita | muundo | inapita |
| `->` kwa kielekezi cha muundo; `&p.x` | inapita | inapita | mshale | inapita |
| Muundo kwenye arena (tenga + `->`) | inapita | inapita | heap | inapita |
| Muundo kwa thamani kama hoja (baiti <= 8) | jibu baya (takataka 72, 200, 232...) | inapita (12, 17, 43) | hati 7 | mbegu jibu baya |
| Muundo kwa thamani (sehemu 3-5, 12-20 baiti) | jibu baya (takataka) | jibu baya (1; lazima 6/10, 15) | hati 7 | jibu baya |
| Muundo kurudishwa kwa thamani (sret) | inapita (30, 6) | inapita (30, 6) | sret | inapita |
| sret inayopitishwa kwa kazi nyingine | jibu baya (takataka 193) | inapita (33) | sret | mbegu jibu baya |
| Safu ya miundo (ndani na ulimwengu) | huanguka (SEGV 139) | huanguka (SEGV 139) | hati 4.2/7 | huanguka |
| `&nukta[1]` (anwani ya kipengele cha muundo) | huanguka (SEGV 139) | huanguka (SEGV 139) | anwani halali | huanguka |
| Ugawi wa muundo `b = a;` | jibu baya (takataka) | huanguka (SEGV 139) | nakala | zote mbili mbovu |
| ukubwa(Muundo) | imekataliwa kimya (0 kama hoja) | inapita (8) | ukubwa halisi | mbegu imekataliwa kimya |
| Kigezo cha muundo cha ulimwengu | imekataliwa kimya | huanguka (SEGV 139) | muundo wa ulimwengu | zote mbili mbovu |
| `&x`, `*p`, `*p = ...`, `p[i]`, `q - p` (baiti), `kama (p == 0)`, kurudisha kielekezi | inapita | inapita | vielekezi | inapita |
| `p + k` ni kwa BAITI, si kwa kipengele | inapita (baiti) | inapita (baiti) | hati 4.2 inaeleza `a[i] = *(a + i*ukubwa)` | inafanya kazi kwa baiti — haijaelezwa waziwazi |
| Nyoosha NULL | huanguka (SEGV 139) | huanguka (SEGV 139) | hakuna kinga inayoahidiwa | huanguka (kama C) |
| anwani_ya_kazi / tekeleza | imekataliwa kimya | imekataliwa (kazi haijafafanuliwa) | hati 9 inaahidi | hazipo kwenye minyororo yote miwili |
| Safu za ndani na ulimwengu, faharisi, safu kama hoja, mfuatano halisi | inapita | inapita | safu | inapita |
| Kianzilishi cha safu: `N32 g[3] = {1,2,3}`; `N8 s[4] = "abc"` | imekataliwa kimya | jibu baya (kimepuzwa; 0) | 6; 97 | uzalishaji jibu baya |
| Safu ya pande mbili | imekataliwa kimya | imekataliwa (KOSA) | haijaelezwa | imekataliwa |
| Faharisi hasi `p[-1]` | huanguka (SEGV 139) | huanguka (SEGV 139) | kipengele cha kabla | huanguka (upanuzi wa sifuri; mzizi wa badili na ukuaji wa Orodha) |
| Hoja 0-9 (rejesta za GP na rafu) | inapita | inapita | ABI | inapita |
| Hoja 10 | imekataliwa kimya | inapita (55) | hakuna kikomo kilichoandikwa | mbegu imekataliwa kimya |
| Hoja za D64 na kurudisha D64 | inapita (uhamisho wa GP) | inapita (xmm) | mipaka 4c ilisema mbegu inakataa | inapita kwa zote mbili |
| D64 ikichanganywa na N32: `5.5 * 2` | jibu baya (0) | jibu baya (0) | 11 | jibu baya |
| Halisi kubwa kama hoja ya kazi: `pata(4294967296)` | jibu baya (ukataji) | imekataliwa kwa ufisadi (jina la param isiyohusika) | 1 | uzalishaji imekataliwa kwa makosa; mbegu jibu baya |
| Mwili mtupu wa kazi ya W0 | inapita (0) | imekataliwa (kazi haijafafanuliwa) | 0 | uzalishaji imekataliwa kwa makosa |
| N64 hasi: `N64 x = -90` | jibu baya (4294967206) | jibu baya (4294967206) | -90 | jibu baya |
| Ukanushaji wa N64: `0 - 10000000000` | jibu baya (2884901888) | jibu baya (2884901888) | -10000000000 | jibu baya |
| Kujirudia (factorial 10, pande mbili) | inapita | inapita | kurudia | inapita |
| Kujirudia kirefu (10000-20000) | inapita | inapita | si ya hati | inapita |
| Kujirudia kirefu (30000+) | inapita (hadi 100000) | huanguka (SEGV 139, ~20k-30k) | si ya hati | uzalishaji huanguka (kikomo cha rafu kisichoelezwa) |
| tenga, achilia (arena; hakuna matumizi tena) | inapita | inapita | hati 10 | inapita |
| badili (realloc) | huanguka (SEGV 139) | huanguka (SEGV 139) | 5 | huanguka |
| Orodha inayokua (orodha_ongeza zaidi ya uwezo) | huanguka (SEGV 139) | huanguka (SEGV 139) | 15 (hati 10: safu inayokua) | huanguka — Orodha haikui kamwe |

### 3.4 Maktaba ya kawaida (msingi/)

| Kipengele | Mbegu | Uzalishaji | Inavyotarajiwa (hati) | Hali |
|---|---|---|---|---|
| kumbukumbu: nakili, weka_sifuri, linganisha_kumbukumbu | inapita | inapita | — | inapita |
| kumbukumbu: andika (%d %s %c \n), andika_n64, andika_mfuatano, andika_herufi, andika_sehemu, andika_stderr | inapita (isipokuwa %d hasi, %%, hoja 7) | inapita (isipokuwa %%) | — | inapita kwa kiasi (tazama 3.2) |
| kumbukumbu: sys_soma, sys_andika, sys_fungua, sys_funga, soma_mstari (faili halisi) | inapita | inapita | wito_wa_mfumo | inapita |
| kumbukumbu: tenga, achilia (no-op), ukubwa(N32) | inapita (ukubwa(N32) = 8) | inapita (4) | hati 10 | mbegu jibu baya kwa ukubwa |
| kumbukumbu: badili | huanguka (SEGV 139) | huanguka (SEGV 139) | realloc | huanguka |
| kumbukumbu: ukubwa(Muundo) | imekataliwa kimya (0 kama hoja) | inapita (8) | ukubwa halisi | mbegu imekataliwa kimya |
| mfuatano: urefu, linganisha, nakili, unganisha | inapita | inapita | — | inapita |
| mfuatano: tafuta_mfuatano, kata_nafasi, geuza, anza_kwa, isha_kwa, kompyuta_linganisha, heshi, linganisha_n | inapita* | inapita* | — | inapita kwa kiasi (herufi halisi zinavunja matumizi — tazama 3.1) |
| mfuatano: tafuta_herufi, tafuta_herufi_mwisho, idadi_ya_herufi, herufi_ya_juu, herufi_ya_chini | imekataliwa kimya (herufi halisi) | jibu baya (herufi halisi = 0) | — | zote mbili mbovu |
| mfuatano: nambari_kwa_mfuatano, nambari_kwa_mfuatano_heksa, mfuatano_hadi_n32, nambari hasi | inapita | inapita | — | inapita |
| mfuatano: mfuatano_hadi_n64 (kulinganisha dhidi ya halisi kubwa) | jibu baya (mipaka 5) | inapita | — | mbegu jibu baya |
| mfuatano: nambari_kwa_mfuatano_n64 (thamani > 2^31) | jibu baya (1286608618) | jibu baya (4912) | 9876543210 | jibu baya |
| hesabu: hesabu_kamili/ndogo, hesabu_kubwa/dogo, neneo_n32, gcd, pow_kamili, isqrt, fibonacci, kipengele, ni_kuu, lcm, pow_mod | inapita | inapita | — | inapita |
| hesabu: neneo_n64(-90) | jibu baya (0) | jibu baya (0) | 1 | jibu baya (N64 hasi — tazama 3.3) |
| hesabu: halisi > 2^31 kama hoja | jibu baya (kikomo cha mbegu) | imekataliwa (ufisadi) | — | zote mbili mbovu |
| orodha: orodha_mpya, orodha_ongeza (bila kukua), orodha_pata, orodha_futa_mwisho, orodha_urefu, orodha_huru | inapita (6) | inapita (6) | hati 10 | inapita |
| orodha: orodha_ongeza INAPOKUA (badili) | huanguka (SEGV 139) | huanguka (SEGV 139) | ukuaji (hati 10) | huanguka — Orodha haikui |
| mpangilio: pangilia_n32, pangilia_n32_kushuka, pangilia_n64, pangilia_n64_kushuka | inapita | inapita | — | inapita |
| ramani: ramani_mpya, ramani_weka, ramani_pata, ramani_ina, ramani_futa, ramani_huru | jibu baya (weka ni no-op; 2/5) | inapita (5/5) | hati 10 | mbegu jibu baya |
| faili, nasibu, wakati (faili_fungua, nasibu_n32, wakati_sasa, n.k.) | imekataliwa kimya (rc=1, hakuna ujumbe) | imekataliwa kwa sauti | zinahitaji libc (mnyororo wa Rust pekee) | hazifanyi kazi kwenye mnyororo asilia; mbegu inakataa kimya |

## 4. Jibu baya zote (majibu potofu ya kimya)

Mpangilio: kwa eneo, kisha kwa uzito. Kila kipimo ni cha chini
kabisa; "kilichoonekana" ni cha minyororo yote miwili isipokuwa
ilivyobainishwa. Msimbo wa kutoka ni mod 256.

### 4.1 Mfumo wa aina na hesabu

**1. D64 hadi nambari kamili: ubadilishaji haupo (J1, zote mbili)**

Kila tokeo la D64 linalorudi kwenye kazi ya N32, au linalogawiwa
kwa N32, linarudisha rejesta eax bila kuguswa (hakuna cvttsd2si).
Mfumo mzima wa desimali ni kipofu upande wa int: matokeo ni ya
bahati.

```swa
N32 main() { rudisha 21.5; }
```

- Kilichoonekana: mbegu 0, uzalishaji 0. Kinachotarajiwa: 21
  (kukata hadi sifuri).
- Pia: `rudisha (1.5 + 2.25) * 4;` hutoa 4 (lazima 15);
  `rudisha 5.0 / 2.0;` hutoa 0 (lazima 2);
  `rudisha -2.5 * 2;` hutoa 2 (lazima 251);
  `D64 x = 2.5; N32 y = x;` hutoa 0 (lazima 2);
  `N32 x = 2.5;` hutoa 0 (lazima 2).

**2. Mchanganyiko wa desimali na nambari kamili: operesheni inaharibika (J2, zote mbili)**

Operesheni ya int na D64 haiwezi kubadilisha int hadi double
(hakuna cvtsi2sd); matokeo yanategemea rejesta za zamani na rafu.

```swa
N32 main() { rudisha (1 + 2.5) * 2; }
```

- Kilichoonekana: 6 (zote mbili). Kinachotarajiwa: 7.
- Pia: `(3 + 2.5) * 2` hutoa 10 (lazima 11); `2.5 < 3` hutoa 0 (lazima 1);
  `1 > 2.5` hutoa 1 (lazima 0); `3 == 3.0` hutoa 0 (lazima 1);
  `0 == 2.5` hutoa 1 (lazima 0); `n > 2.5` ni 1 KILA wakati kwa n = 1..5
  — n haishiriki kabisa; `D64 a = 5.5 * 2; kama (a == 11.0)` hutoa
  1 badala ya 11.

**3. Halisi >= 2^63 inakatwa kimya hadi biti 32 (J3, zote mbili)**

`changanua_primary` inaangalia `v > 2147483647` kwa ulinganisho
WENYE ISHARA: 2^63+ inaonekana hasi na haijawekwa alama ya N64 —
inatoka kama `mov eax, imm32`. Uthibitisho wa mashine:
`N64 x = 18446744073709551615` inatengeneza `mov eax, 0xFFFFFFFF`
(baiti 4) halafu `mov [rbp-8], rax`.

```swa
N32 main() { A64 x = 18446744073709551615; rudisha x / 4294967296; }
```

- Kilichoonekana: 0 (uzalishaji; mbegu inaanguka kabla).
  Kinachotarajiwa: 255. (Kwa `N64 x = 18446744073709551615; x + 1`
  matokeo 0 yanafanana kwa bahati — thamani halisi ya x ni
  4294967295, si 2^64-1, kwa disassembly.)

**4. Halisi kubwa kama hoja ya wito (J4, uzalishaji)**

`ast_tiga` inabebwa mizigo miwili: alama ya "N64 literal" NA kiungo
cha mnyororo wa hoja. Hoja ya mwisho yenye halisi kubwa inafungua
kiungo hadi nodi ya takataka; hoja ya katikati inapoteza alama
yake (inakatwa hadi biti 32).

```swa
N64 jumlisha(N64 a, N64 b) { rudisha a + b; }
N32 main() { rudisha jumlisha(4294967296, 5) % 256; }
```

- Kilichoonekana (uzalishaji): 36. Kinachotarajiwa: 5.
- Kwa hoja ya mwisho: `mbili(4294967296)` inakataliwa kwa kosa
  lisilo sahihi ("kitambulisho kisichojulikani: x" — jina la
  parameta yenyewe). Mbegu: inakubali kwa ukataji.

**5. Upakiaji wa ulimwengu wa D64 umevunjika (J7, zote mbili)**

Ulimwengu wa D64 unapakiwa kwa `mov rax, [G]` (kamili) badala ya
`movsd xmm0, [G]`. Katika ulinganisho, thamani ya kushoto haifiki
xmm0 kamwe — ulinganisho unajilinganisha na upande wa kulia.
(Kianzio chenyewe ni sahihi: baiti za 2.5 ziko kwenye .data.)

```swa
D64 G = 2.5; N32 main() { rudisha G == 3.5; }
```

- Kilichoonekana: 1 (zote mbili). Kinachotarajiwa: 0 (G ni 2.5).
- Pia: `G == 1.0` hutoa 1 (lazima 0); `G * 2` hutoa 0 (lazima 5);
  `D64 x = G; x == 2.5` hutoa 0 (lazima 1).

**6. Halisi za radiksi 0x/0o/0b zinakubaliwa na kuhesabiwa kimakosa (J8)**

Mchanganuzi wa uzalishaji unaruka herufi 2 za kiambishi na kusoma
salio kama DESIMALI; mbegu inasoma 0. Hati haijataja radiksi —
hii ni kukubali kimya kwa kitu kisichojaribiwa, lakini msomaji
ana msimbo wa radiksi ulioachwa nusu.

```swa
N32 main() { rudisha 0x10; }
```

- Kilichoonekana: mbegu 0, uzalishaji 10. Kinachotarajiwa: 16 (au
  kukataliwa kwa sauti).
- Pia: `0o17` hutoa 17 (lazima 15); `0b101` hutoa 101 (lazima 5);
  `0x1F` hutoa 1; `0xFF` hutoa 0; `0x10 + 0x1F` hutoa 11 (lazima 47).

**7. Makosa ya mkaguzi wa aina si ya kufa (J10, uzalishaji — jibu baya la mfumo)**

`mkaguzi_makosa` inachapishwa kama "; ONYO: makosa 1, inaendelea"
na mkusanyaji UNAENDELEA. Kila kosa la aina (kianzio kisicholingana,
ugawaji, hoja, kurudisha) linatoa msimbo wenye tabia isiyofafanuliwa.
Hii ndiyo sababu ya kimfumo ya J1, J2 na nyingine: hakuna kesi
iliyopimwa ya "kukataliwa kwa sauti" kwa kosa la aina kwenye
mnyororo wa uzalishaji.

```swa
N32 main() { N32 x = 2.5; rudisha x; }
```

- Kilichoonekana (uzalishaji): kosa limechapishwa ("aina ya kianzio
  hailingani") LAKINI mkusanyaji ametoa programu, inayorudisha 0.
  Kinachotarajiwa: imekataliwa (kosa la aina linapaswa kuzuia) au
  jibu sahihi 2.

**8. Shift za N64 kwenye mbegu ni 32-bit (J14, mbegu)**

Mabadiliko yote ya mbegu hutumia `shl/sar eax, cl` — biti za juu
zinapotea.

```swa
N32 main() { N64 x = 1; rudisha x << 32; }
```

- Kilichoonekana (mbegu): 1. Kinachotarajiwa: 0.
- Pia: `N64 x = 2147483648; x >> 25` hutoa 192 (lazima 64). Uzalishaji
  ni sahihi kwa vigezo (0 na 64).

**9. Ugawaji upya wa D64 kwenye mbegu umevunjika (J15, mbegu)**

```swa
N32 main() { D64 x = 0.0; x = 2.5; rudisha x == 2.5; }
```

- Kilichoonekana (mbegu): 0. Kinachotarajiwa: 1. Uzalishaji: 1
  (sahihi). Pia `x = x + 1.5; x == 2.5` hutoa mbegu 0, uzalishaji 1.

**10. Upana usiotekelezwa unakubaliwa kimya na uzalishaji (J16)**

Hati 3 inaahidi "upana wowote wa tarakimu", lakini upana usio wa
8/16/32/64 unakubaliwa kimya na kufanya kazi kwa bahati kwa thamani
ndogo: N128 inapewa eneo la baiti 16 lakini inapakiwa/kuhifadhiwa
kama 64; A3/N7 zinatibiwa kama kielekezi kupitia hila ya
`(upana/4)*4 != upana`; D80 inatibiwa kama D64 yenye eneo la
baiti 10. Kwa thamani zinazohitaji zaidi ya biti 64, matokeo
yatakuwa potofu kimya.

```swa
N32 main() { N128 x = 5; rudisha x; }
```

- Kilichoonekana: mbegu SEGV; uzalishaji 5. Kinachotarajiwa:
  kukataliwa kwa sauti au semantiki halisi za 128-bit.
- Pia: `D80 x = 1.5` hutoa uzalishaji 0 (lazima 1).

**11. ukubwa(aina) na ukubwa(kigezo) (zote mbili)**

```swa
N32 main() { rudisha ukubwa(N32); }
```

- Kilichoonekana: mbegu 8, uzalishaji 4. Kinachotarajiwa: 4.
- Kwa kigezo: mbegu inarudisha 8 kwa kila aina; uzalishaji
  inarudisha 4 kwa kila kigezo (N64, kielekezi, safu). Hii
  inavunja matumizi yaliyoandikwa `tenga(ukubwa(N32))` kwenye mbegu
  (hati 10): inagawa baiti 8 badala ya 4.

**12. D64 % int na D64 << int zinakubaliwa kimya (zote mbili)**

```swa
N32 main() { rudisha 5.5 % 2; }
```

- Kilichoonekana: 0 na 2 (matokeo ya bahati) kwa zote mbili.
  Kinachotarajiwa: kukataliwa kwa sauti — operesheni hizi
  hazijafafanuliwa kwa desimali.

**13. Nambari hasi za N64 na ukanushaji wa N64 (zote mbili)**

`N64 x = -90;` inatoa 4294967206 (0xFFFFFFA6 — upanuzi wa sifuri,
si wa ishara); `0 - 10000000000` inatoa 2884901888 (hesabu ya
32-bit). Matokeo ya moja kwa moja: `neneo_n64(-90)` hairudishi 1
kamwe, na `nambari_kwa_mfuatano_n64` ya thamani hasi/kubwa
imevunjika.

**14. Halisi za herufi 'a' (uzalishaji)**

```swa
N32 main() { N8 c = 'h'; rudisha c; }
```

- Kilichoonekana (uzalishaji): 0. Kinachotarajiwa: 104. Hii
  inavunja kazi zote za maktaba zinazotumia herufi halisi
  (tafuta_herufi, idadi_ya_herufi, herufi_ya_juu, herufi_ya_chini).
  Mbegu: imekataliwa kimya.

**15. W0 kama kigezo chenye thamani (zote mbili — kinyume cha hati)**

`W0 x = 5;` (ndani na ulimwengu) inakubaliwa kimya na kurudisha 5.
Hati 3 inasema W0 ni "kwa kazi tu". Hii inapaswa kukataliwa kwa
sauti.

### 4.2 Taarifa, udhibiti wa mwendo na viendeshaji

**16. `endelea` kama taarifa ya mwisho ya mwili wa `kwa` (uzalishaji)**

Mwendo wa `endelea` wa mwisho unaharibu mwili mzima wa kazi:
taarifa zote baada ya kitanzi hazitekelezwi kamwe.

```swa
N32 main() {
    N32 s = 0;
    N32 i;
    kwa (i = 0; i < 3; i = i + 1) {
        s = s + 1;
        endelea;
    }
    andika("s=%d i=%d\n", s, i);
    rudisha 0;
}
```

- Kilichoonekana (uzalishaji): msimbo wa kutoka 124; andika
  haichapishi chochote — taarifa zote baada ya kitanzi
  hazitekelezwi. Mbegu: pato "s=3 i=3" sahihi, msimbo wa kutoka 0.
- Kinachotarajiwa: pato "s=3 i=3", msimbo wa kutoka 0. Mipaka 4b
  inasema semantiki ya C imewianishwa kwenye minyororo yote miwili
  — si kweli kwa kesi hii.

**17. `^` (XOR) inakata usemi kimya (uzalishaji)**

Mkusanyaji anapokea `^`, anakubali, na kutupa kila kitu baada yake
— binary sahihi-ya-muonekano yenye jibu lisilo sahihi.

```swa
N32 main() { N32 x = 6 ^ 3; rudisha x - 5; }
```

- Kilichoonekana (uzalishaji): 1 (x = 6 — sehemu baada ya `^`
  imetupwa). Kinachotarajiwa: 0 (x = 5). Mbegu inakataa kwa sauti;
  hati 2.5 na 4 zinaahidi `^`.

**18. Viendeshaji vya kiwanja vya biti `&= |= ^= <<= >>=` ni NO-OP kimya (uzalishaji)**

```swa
N32 main() { N32 a = 12; a &= 10; rudisha a - 8; }
```

- Kilichoonekana (uzalishaji): 4 (a haijabadilika). Kinachotarajiwa:
  0 (a = 8). Kila moja ya &= |= ^= <<= >>= inafanana: inakusanywa,
  inaendesha, HAIFANYI LO LOTE. Mbegu inakataa kwa sauti. Hati
  haitoi ahadi — lakini ukubali wa kimya ni hatari zaidi kuliko
  kukataa.

**19. Lebo hasi za `hali` zinalinganishwa kama 0 (uzalishaji)**

```swa
N32 main() {
    N32 s = 0; N32 t = 0;
    chagua (0) { hali -3: s = 5; hali 0: t = 6; }
    rudisha s * 100 + t - 500;
}
```

- Kilichoonekana (uzalishaji): 0 (s = 5, t = 0) — selecta 0
  inalingana na `hali -3` na kuendesha mwili wake; `hali 0`
  haifikiwi. `chagua (-3) { hali -3: ... }` hailingani kamwe (251).
- Kinachotarajiwa: -3 inalingana na -3 pekee; 0 inalingana na 0
  pekee. Sababu: lebo isiyo AST_NAMBARI (hasi ni usemi wa
  toa-unari) inakuwa thamani 0 kwenye kizazi.

**20. Lebo za `hali` za N64 > 2^31 hazilingani kamwe (uzalishaji)**

```swa
N32 main() {
    N64 x = 5000000000; N32 s = 0;
    chagua (x) { hali 5000000000: s = 77; sivyo: s = 88; }
    rudisha s - 77;
}
```

- Kilichoonekana (uzalishaji): 11 (s = 88). Kinachotarajiwa: 0
  (s = 77). Lebo ya N64 inakuwa 0 kwenye kizazi. Mipaka 5 inasema
  mnyororo wa .swa unashughulikia N64 kikamilifu — si kwenye
  `chagua`.

**21. Lebo za usemi na kigezo kwenye `hali` zinakubaliwa lakini hazilingani (uzalishaji)**

```swa
N32 main() {
    N32 a = 1; N32 s = 0;
    chagua (2) { hali a + 1: s = 42; sivyo: s = 0; }
    rudisha s - 42;
}
```

- Kilichoonekana (uzalishaji): 214 (s = 0). Kinachotarajiwa: 0
  (s = 42). C inakataa lebo zisizo za kudumu kwa sauti; Swa
  inapaswa kufanya vivyo hivyo.

**22. `hali` maradufu: ya kwanza inashinda kimya (uzalishaji)**

Lebo mbili zenye thamani ileile zinakubaliwa; ya kwanza ndiyo
inayotekelezwa, bila kosa. C inakataa kwa sauti.

**23. Ugawi kwa wito wa kazi `pata() = 7` (uzalishaji)**

```swa
N32 pata() { rudisha 1; }
N32 main() { pata() = 7; rudisha 0; }
```

- Kilichoonekana (uzalishaji): inakusanywa kimya; andiko la 7
  linaenda anwani isiyo na maana (kwa bahati haikuanguka).
  Kinachotarajiwa: kukataliwa kwa sauti (upande wa kushoto wa
  ugawi lazima uwe lvalue).

**24. `%d` hasi na `%d` za N64 kwenye mbegu**

`andika("%d\n", -42)` inachapisha 4294967254 (isiyo na ishara
32-bit); `andika("%d\n", 5000000000)` inachapisha 705032704.
Kizazi cha wito cha mbegu hakienezi ishara ya hoja za N32.
Uzalishaji ni sahihi.

**25. `%%` na viashiria visivyojulikana vya muundo (zote mbili)**

`andika("asilimia:%% mwisho\n")` inachapisha "asilimia: mwisho"
(%% imemezwa, hakuna %). `%u %x %f %l %n` zote zinamezwa kimya
bila pato. Hati haitoi ahadi — lakini umeza wa kimya unaficha
makosa ya muundo.

**26. `*(p + n)`: hakuna ukuzaji wa kipengele (zote mbili)**

```swa
N32 safu[4]; safu[0]=10; safu[1]=11; safu[2]=12; safu[3]=13;
N32* p = safu; rudisha *(p + 3) - 13;
```

- Kilichoonekana: 243 (*(p + 3) = 0) kwa zote mbili; *(p + 1) = 0;
  q = p + 2 inatoa 0. Kinachotarajiwa: 0 (*(p + 3) = 13).
- `p[2]` inafanya kazi kwa sababu faharisi inazidisha ndani, lakini
  `p + n` ni nyongeza ya BAITI (sahihi kwa N8* pekee). Hati 4.2
  inaeleza `a[i]` kwa ukuzaji; upande wa `*(p+n)` haijaelezwa
  popote — watumiaji wanaotegemea C watapata jibu la kimya
  lisilo sahihi.

**27. `*(safu + 1)`: kuoza kwa safu (uzalishaji 0; mbegu huanguka)**

```swa
N32 safu[4]; safu[1] = 7; N32 main() { rudisha *(safu + 1) - 7; }
```

- Kilichoonekana: uzalishaji 249 (*(safu+1) = 0); mbegu SEGV 139.
  Kinachotarajiwa: 0 (safu inapaswa kuoza kuwa kielekezi, hati 4.2).

**28. Utorokaji usio wa hati (zote mbili, kwa njia tofauti)**

- `\0`: mbegu inatoa NUL halisi; uzalishaji inachapisha `\0`
  halisi (5c 30).
- `\x41`: mbegu inatupa `\` na kuacha "x41"; uzalishaji
  inachapisha `\x41` halisi.
- `\r`, `\a`: mbegu inatupa `\` na kuacha herufi; uzalishaji
  inachapisha halisi.

Hati 2.3 inaahidi `\n \t \\ \"` pekee; zilizobaki hazina ahadi —
lakini tabia ni tofauti kati ya minyororo na ni ya kimya katika
zote mbili.

**29. Mfuatano karibu `"a" "b"` (zote mbili)**

Pato: "a" — wa pili anatupwa kimya, hakuna kosa. C inaunganisha;
Swa inapaswa kukataa au kuunganisha.

**30. W0 ndani ya usemi (mbegu)**

`N32 y = piga();` ambapo piga ni W0: mbegu inakusanya na kurudisha
takataka (251) kimya. Uzalishaji unakataa (kwa ujumbe
unachanganya: "kazi haijafafanuliwa: piga" — kazi IKO).

**31. `vunja`/`endelea` nje ya kitanzi (zote mbili)**

`vunja;` kwenye main: mbegu inapuuzwa kimya; uzalishaji analalamika
("kosa: vunja nje ya kitanzi") lakini bado anatoa binary. Inapaswa
kukataliwa kwa sauti (C inakataa).

**32. Hoja ya 7 ya `andika` (mbegu)**

`andika` yenye hoja 7 inachapisha hoja ya 6 tena kama ya 7 —
kikomo cha ABI ya mbegu kisichoelezwa. Uzalishaji ni sahihi.

**33. Ternary dhidi ya ugawi (mbegu)**

`N32 x = 1 ? 2 : 3;` — mbegu inafasiri kama `(x = 1) ? 2 : 3` na
kuacha x = 1 (ugawi unafunga nguvu kuliko ternary, kama jedwali la
hati 4: = kwenye kina 2); uzalishaji ni C-kama (x = 2). Hati
haijataja ternary dhidi ya ugawi — lakini minyororo miwili
inafikia matokeo tofauti kwa msimbo uleule.

### 4.3 Miundo, kumbukumbu na maktaba

**34. Muundo kwa thamani kwenye mbegu (takataka)**

```swa
muundo Nukta { N32 x; N32 y; };
N32 pata_x(Nukta p) { rudisha p.x; }
N32 main() { Nukta n; n.x = 12; rudisha pata_x(n); }
```

- Kilichoonekana (mbegu): takataka isiyo na uhakika — 200, 232,
  184, 72 kwenye utekelezaji mbalimbali (72 iliripotiwa awali,
  imethibitishwa). Kinachotarajiwa: 12. Uzalishaji: 12 (sahihi).

**35. Muundo kwa thamani zaidi ya baiti 8 kwenye uzalishaji**

Muundo wa sehemu 3-5 (12-20 baiti) kama hoja: uzalishaji unarudisha
thamani ya sehemu ya kwanza pekee — kimya.

```swa
muundo Tatu { N32 a; N32 b; N32 c; };
N32 jumla(Tatu p) { rudisha p.a + p.b + p.c; }
```

- Kilichoonekana (uzalishaji): 1. Kinachotarajiwa: 6 (au kukataliwa
  kwa sauti). Pia: sehemu 4 hutoa 1 (lazima 10); sehemu 5 hutoa 1 (lazima
  15); N64 x2 hutoa 10 (lazima 30).

**36. Muundo wa sret kupitishwa kwa kazi nyingine (mbegu)**

Muundo uliokamilishwa (sret) unaopitishwa kwa thamani kwa kazi
nyingine unarudisha takataka (193) kwenye mbegu; uzalishaji ni
sahihi (33).

**37. Kianzilishi cha safu kimepuzwa kimya (uzalishaji)**

```swa
N32 g_safu[3] = {1, 2, 3};
N32 main() { rudisha g_safu[0] + g_safu[1] + g_safu[2]; }
```

- Kilichoonekana (uzalishaji): 0 — kianzilishi KIMEPUZWA kimya,
  hakuna kosa, safu inasalia sifuri. Kinachotarajiwa: 6. Pia
  `N8 s[4] = "abc"` hutoa 0 (lazima 97). Mbegu inakataa kimya (rc=1,
  hakuna ujumbe).

**38. nambari_kwa_mfuatano_n64 kwa thamani > 2^31 (zote mbili)**

`nambari_kwa_mfuatano_n64(9876543210)` — mbegu inatoa
"1286608618" (hoja imekatwa 32-bit); uzalishaji inatoa "4912"
(kosa la usimamizi wa hoja ya N64 kubwa, aina ileile ya 4.4).
Kinachotarajiwa: "9876543210".

**39. mfuatano_hadi_n64 dhidi ya halisi kubwa (mbegu)**

`mfuatano_hadi_n64("9876543210")` inarudisha 9876543210 (kazi
yenyewe ni sahihi) lakini `u == 9876543210` ni UONGO kwa sababu
halisi inakatwa hadi 32-bit (1286608618). Uzalishaji ni sahihi.
Kikomo kilichoandikwa kwenye mipaka 5, lakini kinamaanisha kazi
hii haiwezi kuthibitishwa kwenye mbegu.

**40. neneo_n64(-90) (zote mbili)**

`neneo_n64(-90)` inarudisha 0 badala ya 1 kwa zote mbili — N64
hasi zina upanuzi wa sifuri (tazama 4.1.13). Kazi ya hesabu
iliyoorodheshwa kwenye hati 10 imevunjika.

**41. ramani kwenye mbegu: weka ni no-op (mbegu)**

`ramani_weka` inarudi mara moja: r->uwezo na r->idadi zinasomeka
0xFFFFFFFF kwa sababu `ukubwa(Ramani)` kama hoja ya kazi kwenye
mbegu inarudisha 0 — muundo wa baiti 8, na sehemu za uwezo/idadi
zinaingiliana na safu ya funguo iliyojazwa -1. Weka_pata 2/5,
ina_futa 2/5. Uzalishaji: 5/5 sahihi.

**42. Ugawi wa muundo `b = a;` (zote mbili)**

```swa
muundo Nukta { N32 x; N32 y; };
N32 main() {
    Nukta a; a.x = 8; a.y = 9;
    Nukta b; b = a;
    rudisha b.x + b.y;
}
```

- Kilichoonekana: mbegu 200 (takataka); uzalishaji SEGV 139
  (chanzo cha nakili ni mzigo wa thamani badala ya LEA — nakala
  inaanzia kwenye anwani iliyomo KWENYE muundo, si kwenye muundo
  yenyewe). Kinachotarajiwa: 17.

## 5. Poromoko (HUANGUKA)

| Kipengele | Mbegu | Uzalishaji | Maelezo |
|---|---|---|---|
| Safu ya miundo `safu[i].x`; `&safu[1]` | SEGV 139 | SEGV 139 | kipengele cha msingi cha hati 4.2/7; kizazi kinasoma thamani kama kielekezi badala ya kutoa anwani (mov badala ya lea) |
| Ugawi wa muundo `b = a;` | takataka (jibu baya) | SEGV 139 | nakili huanzia kwenye anwani iliyomo kwenye muundo |
| Faharisi hasi `p[-1]`, `p[bi - 8]` | SEGV 139 | SEGV 139 | upanuzi wa sifuri (0xfffffff8) badala ya upanuzi wa ishara; hii ndiyo inayovunja badili na ukuaji wa Orodha |
| badili (realloc) | SEGV 139 | SEGV 139 | hakuna badili inayofanya kazi |
| Orodha inapokua (orodha_ongeza) | SEGV 139 | SEGV 139 | hati 10 inaahidi "safu inayokua" — haikui kamwe |
| Kazi za D32 (parameta/kurudisha) | FPE 136 | SEGV 139 | ABI ya D32 kwenye wito imevunjika kwa zote mbili; hoja inapotea (imethibitishwa kwa disassembly) |
| Mgawanyo/masali bila ishara wenye biti ya juu (A/B/W) | mkusanyaji SEGV 139 | FPE 136 | `uzalishaji_gawanya` inatumia cdq/cqo (upanuzi WA ISHARA) kabla ya div — edx:eax inafurika |
| Halisi ÷ halisi yenye N64 | FPE 136 | FPE 136 | njia ya 32-bit (enc = 0); kigawanya 0 (kosa la kugawanya) |
| N64 za mbegu kwenye halisi kubwa | FPE 136 | inapita | kikomo kilichoandikwa kwenye mipaka 5 |
| Mkusanyaji wa mbegu kwenye familia A/B/W, B1, upana usio wa kawaida | SEGV 139 (MKUSANYAJI) | inapita/jibu baya | poromoko la mkusanyaji kwenye chanzo halali — halikubaliki kamwe |
| main haipo | imekataliwa | SEGV 139 (binary) | uzalishaji anatoa binary yenye rc=0 ambayo inaanguka |
| `sivyo` bila `kama` | imekataliwa | SEGV 139 (MKUSANYAJI) | mkusanyaji wa uzalishaji anaanguka kwa ingizo baya |
| Nyoosha NULL | SEGV 139 | SEGV 139 | kama C; hakuna kinga inayoahidiwa |
| Kujirudia kirefu (30000+) | inapita (hadi 100000) | SEGV 139 (~20k-30k) | kikomo cha rafu kisichoelezwa kwenye uzalishaji |
| Kigezo cha muundo cha ulimwengu | imekataliwa kimya | SEGV 139 | nafasi ya ulimwengu kwa miundo haipo |
| Maoni ya `/* */` katikati ya usemi | SEGV 139 | inapita | mbegu inaanguka kwenye chanzo halali |
| `(*p).x`, `**q`, `*(safu + 1)` kwenye mbegu | SEGV 139 | inapita/jibu baya | kikomo cha mbegu — uzalishaji ni sahihi kwa sehemu |
| Ugawanyo/modulo kwa sifuri | FPE 136 | FPE 136 | kama C (tabia isiyofafanuliwa); hakuna kinga inayoahidiwa |
| Ulimwengu N64 = 4294967296 | FPE 136 | inapita | mipaka 5 |

## 6. Ukataaji unaokiuka hati (IMEKATALIWA)

| Kipengele | Mbegu | Uzalishaji | Hati inayoahidi |
|---|---|---|---|
| `!` (kanusha mantiki) | imekataliwa | imekataliwa | 2.2/3 (matokeo ni 1 au 0); 2.5 (ishara) |
| `~` (kanusha biti) | imekataliwa | imekataliwa | 2.5 (ishara) |
| `husisha { faili.swa }` | imekataliwa (kazi haijafafanuliwa) | imekataliwa (kazi haijafafanuliwa) | 8: mkusanyaji wa .swa hulichakata faili lililotajwa — hakuna mnyororo unaosoma faili |
| Kazi yenye mwili tupu `N32 f() { }` | inapita | imekataliwa (kazi haijafafanuliwa) | 5: mwili wowote wa taarifa |
| `a < b << c` (hamisha upande wa kulia wa linganisho) | inapita | imekataliwa (KOSA) | 4: utangulizi unaoruhusu (kina 4 > 3) |
| `kama` + `sivyo` ndani ya mkono wa `chagua` | imekataliwa | imekataliwa (KOSA) | 6.6: "..." inajumuisha taarifa |
| Bloku `{ }` ndani ya mkono wa `chagua` | imekataliwa | imekataliwa (KOSA) | 6.6 |
| `chagua` kwa ujumla | imekataliwa (kosa la mchanganuzi) | inapita | 6.6 |
| Maoni ya `/* */` | imekataliwa (SEGV katikati ya usemi) | inapita | 2.4: vizuizi vya maoni |
| `//` mwishoni mwa faili bila mstari mpya | imekataliwa | imekataliwa | 2.4: maoni ya mstari |
| Halisi za herufi `'a'` | imekataliwa KIMYA | jibu baya (0) | si ya hati — lakini ukataaji wa mbegu ni kimya |
| Safu ya pande mbili | imekataliwa KIMYA | imekataliwa (KOSA) | haijaelezwa |
| Vitangazo vingi `N32 a, b, c;` | imekataliwa | inapita | 6.1 inaonyesha kigezo kimoja |
| Kazi yenye hoja 10 | imekataliwa KIMYA | inapita | hakuna kikomo kilichoandikwa |
| Kianzilishi cha safu | imekataliwa KIMYA | jibu baya (kimepuzwa) | si ya hati — lakini ukataaji wa mbegu ni kimya |
| Halisi kubwa kama hoja ya wito | jibu baya (ukataji) | imekataliwa kwa kosa LISILO SAHIHI | mipaka 5: N64 kamili |

## 7. Ambapo minyororo miwili inatofautiana

Kwa lugha inayojijenga, tofauti kati ya minyororo ni tatizo la
usahihi lenyewe: mkusanyaji unajijenga kwa chanzo kile kile, lakini
tabia ya lugha inabadilika kulingana na mnyororo uliotumika. Programu
inayofanya kazi kwenye mnyororo mmoja inaweza kutoa jibu lingine (au
kuanguka) kwenye mwingine — na hakuna kosa linalotangaza hilo.

| Kipengele | Mbegu | Uzalishaji |
|---|---|---|
| Utangulizi wa viendeshaji | inafuata jedwali la hati 4 (= kwenye kina 2; & na | na && na || kwenye kina 1) | C-kama (= iko chini ya ternary na &&; & ina kiwango chake) |
| `4 | 2 & 1` | 0 (kwa hati) | 4 (C: & inafunga nguvu) |
| `a = 1 && 0` | a = 1 (kwa hati) | a = 0 (C) |
| `a = 2 == 2` | a = 2 (kwa hati) | a = 1 (C) |
| `a = 0 || 3` | imekataliwa (mnyororo) | a = 1 (C) |
| `x = 1 ? 2 : 3` | x = 1 (ugawi inafunga nguvu) | x = 2 (C) |
| +=, -=, mnyororo wa ugawi | imekataliwa | inapita (C-kama) |
| `^` | imekataliwa | jibu baya (inakata usemi) |
| &=, |=, <<=, >>= | imekataliwa | jibu baya (NO-OP) |
| Shift za N64 | 32-bit (jibu baya) | 64-bit (sahihi) |
| Ugawaji upya wa D64 | jibu baya | inapita |
| ukubwa(aina) | 8 kwa kila aina | sahihi (4, 1, 8) |
| ukubwa(kigezo) | 8 kwa kila kigezo | 4 kwa kila kigezo |
| Muundo kwa thamani (baiti <= 8) | takataka | inapita |
| `(*p).x`, `**q` | SEGV 139 | inapita |
| `chagua` | imekataliwa kwa muundo | inapita kwa misingi |
| main haipo | imekataliwa kwa sauti | binary inaanguka |
| %d hasi na N64 | jibu baya | inapita |
| Hoja ya 7 ya andika | inarudia ya 6 | inapita |
| endelea mwisho wa mwili wa kwa | inapita | jibu baya (mwili umeharibika) |
| Ulimwengu N64 = 4294967296 | FPE 136 | inapita |
| Usawa wa mfuatano `==` | inalinganisha anwani (literali mbili hazilingani) | literali zinaunganishwa kwenye dimbwi moja (zinalingana) |
| Kujirudia kirefu (30000+) | inapita (hadi 100000) | SEGV 139 |
| `sivyo` bila `kama` | imekataliwa | mkusanyaji SEGV 139 |
| Maoni ya `/* */` | imekataliwa (SEGV katikati ya usemi) | inapita (upachikaji unaruhusiwa) |
| Utorokaji `\t`, `\"` | inapita | alama halisi |
| Kianzilishi cha safu | imekataliwa kimya | jibu baya (kimepuzwa) |
| Halisi za herufi | imekataliwa kimya | jibu baya (0) |
| Kigezo cha muundo cha ulimwengu | imekataliwa kimya | SEGV 139 |
| Halisi kubwa kama hoja | jibu baya (ukataji) | imekataliwa kwa ufisadi |
| ramani | jibu baya (weka ni no-op) | inapita (5/5) |
| mfuatano_hadi_n64 dhidi ya halisi kubwa | jibu baya | inapita |
| ukubwa(Muundo) | imekataliwa kimya (0) | inapita (8) |
| Muundo kama hoja ya 7 (rafu) | takataka | inapita |
| Mkaguzi wa aina | hakuna | makosa ni onyo; mkusanyaji anaendelea |
| Moduli za libc (faili, nasibu, wakati) | imekataliwa kimya | imekataliwa kwa sauti |

Mwelekeo unaorudiwa: uzalishaji ni wa RUHUSA ZAIDI kuliko mbegu
kwenye sehemu nyingi — na katika kila kesi, ruhusa mpya inaambatana
na jibu baya la kimya au poromoko. Ruhusa pekee iliyo na thamani
halisi ni ile ya miundo kwa thamani (baiti <= 8), `(*p).x`, `**q`
na %d hasi, ambapo uzalishaji ni sahihi. Ruhusa mpya yoyote lazima
iwe na jaribio la ujumuishaji linaloendesha binary yenyewe, si
kukusanywa tu.

## 8. Ahadi za hati ambazo hazishikiki

1. Hati 2.3 ("Desimali inafanya kazi kwenye minyororo YOTE —
   hesabu za kuelea, ulinganisho, na ukanushaji"): kweli NDANI ya
   ulimwengu wa D64 pekee. Kila mpaka kati ya D64 na nambari
   kamili (kurudisha, kugawa, kuchanganya, kulinganisha) hutoa
   jibu la takataka (4.1.1, 4.1.2, 4.1.5).
2. Hati 2.3 (utorokaji `\t` na `\"`): uzalishaji unachapisha
   alama halisi (3.2).
3. Hati 2.4 ("/* ... */ kwa vizuizi"; "maoni ya kijiuzi
   hayaruhusiwi"): mbegu inakataa vizuizi (na huanguka katikati
   ya usemi); uzalishaji unaruhusu upachikaji — kinyume cha hati.
4. Hati 2.5 na 3 (`!`, `~`, `^` ni ishara; matokeo ya `!` ni
   1/0): `!` na `~` hazijatekelezwa popote; `^` inakata usemi
   kimya kwenye uzalishaji (4.2.17, 6).
5. Hati 3 (W0 — "kwa kazi tu"): inakubaliwa kama kigezo chenye
   thamani kwa minyororo yote miwili (4.1.15).
6. Hati 3 ("kila familia ikifuatiwa na upana wowote wa tarakimu"):
   upana 8/16/32/64 pekee ndio halisi; N128/D80/A128 zinafanya
   kazi kwa bahati kwa thamani ndogo na kwa semantiki za uongo
   (4.1.10).
7. Hati 2.3 ("aina ya chaguo-msingi ni N32 ikiwa inatoshea ndani
   ya 32-bit signed; nje ya hapo ni N64"): 2147483648 ina tabia
   ya N32 kwenye mabadiliko ya shift na kama hoja ya wito; halisi
   >= 2^63 zinakatwa kimya hadi biti 32 (4.1.3, 4.1.4).
8. Hati 4 (jedwali la utangulizi): linashikiliwa na mbegu;
   uzalishaji ni C-kama (3.2, sehemu ya 7).
9. Hati 4.2 (`a[i] = *(a + i * ukubwa_wa_kipengele)`; "usemi wa
   safu pekee hutathminiwa kama kielekezi"): safu za miundo
   zinaanguka SEGV kwa zote mbili; `*(p + n)` haikuzwi; `*(safu+1)`
   ni 0 au SEGV (3.3, 4.2.26-27).
10. Hati 5 (kazi ya mwili tupu): imekataliwa kwa makosa kwenye
    uzalishaji (3.1).
11. Hati 6.5 na mipaka 4b (endelea inaruka HATUA — semantiki ya
    C, minyororo yote miwili): endelea kama taarifa ya mwisho ya
    mwili wa `kwa` inaharibu mwili mzima kwenye uzalishaji
    (4.2.16).
12. Hati 6.6 (`chagua`): mbegu inakataa kwa muundo; uzalishaji
    unafanya kazi kwa hali za nambari ndogo pekee — lebo hasi,
    N64 kubwa na usemi hazilingani kamwe (4.2.19-21).
13. Hati 7 ("Miundo inaweza kupitishwa kwa thamani"): mbegu
    inarudisha takataka; uzalishaji unapoteza baiti zaidi ya 8
    (4.3.34-35). Pamoja na 4.2: safu za miundo zinaanguka
    (5).
14. Hati 8 ("mkusanyaji wa .swa hulichakata faili lililotajwa"):
    hakuna mnyororo unaosoma faili la `husisha { }`; kiungo
    kinatoshelezwa kwa cat pekee (6).
15. Hati 9 (`tekeleza`, `anwani_ya_kazi`): hazipo kwenye minyororo
    yote miwili; `wito_wa_mfumo` inafanya kazi (3.3).
16. Hati 10 ("Orodha — safu inayokua"): ukuaji unaanguka SEGV
    kwenye zote mbili — Orodha haikui kamwe (3.3, 3.4, 5).
17. Hati 10 ("Ramani ya jina hadi thamani"): inafanya kazi kwenye
    uzalishaji pekee; kwenye mbegu weka ni no-op (4.3.41).
18. Hati 10 (`tenga(ukubwa(N32))`): mbegu inagawa baiti 8 badala
    ya 4 (4.1.11).
19. Hati 12 ("Kila kanuni katika hati hii imejaribiwa"): kanuni
    ya desimali imevunjika kwenye mpaka wa int; kanuni ya `!`
    imevunjika kabisa; fixpoint inathibitisha kujikusanya, si
    usahihi wa semantiki.
20. Mipaka 1 ("ingizo baya linalia kwa sauti"): mbegu inakataa
    KIMYA (msimbo 1, hakuna ujumbe) kwa: kigezo cha ulimwengu cha
    muundo, kianzilishi cha safu, safu ya pande mbili, halisi za
    herufi, kazi yenye hoja 10, ukubwa(Muundo), moduli za libc.
21. Mipaka 4c ("mbegu haina ABI ya xmm; program za mbegu zenye
    kazi za D64 zinalia kwa sauti"): SI KWELI — mbegu inatekeleza
    wito wa kazi za D64 kwa usahihi (3.1). Mipaka 4c imerekebishwa
    pamoja na rekodi hii.
22. Mipaka 5 ("mnyororo wa .swa unachanganua maneno halisi hadi
    N64 kamili"): kweli kwa [2^31, 2^63) pekee; halisi >= 2^63
    zinakatwa kimya, halisi kubwa kama hoja zinafisidi uzalishaji,
    na halisi ÷ halisi inaanguka (4.1.3-4, 5).
23. Mipaka 8 ("toa_exe inachapisha kazi haijafafanuliwa na kutoka
    kwa msimbo 1"): kweli kwa uzalishaji; mbegu inakataa kimya
    katika kesi kadhaa (6, sehemu ya 8, kipengee 20).

## 9. Muhtasari

Kinachofanya kazi kwa minyororo yote miwili, kilichopimwa: kama/
sivyo kwa kila muundo, wakati, kwa, vunja na endelea (isipokuwa
endelea-mwisho wa uzalishaji), hesabu na ulinganisho za N32,
mzunguko mfupi wa && na ||, ternary, ugawi msingi, kurudia na wito
wa mbele, miundo kwa mshale na kwa sret, N64 katika vigezo na
ulimwengu (kwenye uzalishaji), D64 ndani ya ulimwengu wake (pamoja
na wito wa kazi — kinyume cha mipaka 4c), tenga/achilia, maoni ya
`//`, mfuatano msingi, andika %d/%s/%c kwa thamani chanya, na
maktaba muhimu (kumbukumbu, mfuatano msingi, hesabu, mpangilio,
orodha bila kukua).

Makosa makubwa ya kimya (jibu baya), kwa mpangilio wa uzito:
mpaka mzima wa D64 na nambari kamili (4.1.1, 4.1.2, 4.1.5), ukataji
wa halisi >= 2^63 (4.1.3), hoja za wito zenye halisi kubwa
(4.1.4), makosa ya mkaguzi yasiyo ya kufa (4.1.7), lebo za chagua
za hasi/N64/usemi (4.2.19-21), `^` na viendeshaji vya kiwanja vya
biti (4.2.17-18), `*(p + n)` bila ukuzaji (4.2.26), kianzilishi
cha safu (4.3.37), N64 hasi na ukanushaji (4.1.13), ukubwa
(4.1.11), nambari_kwa_mfuatano_n64 (4.3.38), ramani kwenye mbegu
(4.3.41), na endelea-mwisho wa uzalishaji (4.2.16).

Poromoko kubwa: safu za miundo (zote mbili), faharisi hasi/badili/
ukuaji wa Orodha (zote mbili), D32 (zote mbili), mkusanyaji wa
mbegu kwenye familia A/B/W na upana usio wa kawaida, mkusanyaji wa
uzalishaji kwenye `sivyo` bila `kama`, na main isiyopo (uzalishaji).

Ukataaji unaokiuka hati: `!`, `~`, `husisha { faili }`, kazi tupu,
`a < b << c`, `chagua` kwenye mbegu, `/* */` kwenye mbegu.

Tofauti kubwa kati ya minyororo: utangulizi wa viendeshaji (mbegu
inafuata hati; uzalishaji ni C-kama) na ruhusa za uzalishaji
zinazoambatana na jibu baya au poromoko (sehemu ya 7).

Jibu la mwisho kwa mwandishi wa Swa: usiamini hati mpaka
kipimo kithibitishe; usiamini ruhusa ya mkusanyaji — jibu baya
linasafiri kimya hadi kwenye programu zilizotumwa. Rejesho kuu la
mfumo ni ukali wa mkaguzi (4.1.7): hadi kosa la aina likatwe kwa
sauti, jibu baya la kila aina litaendelea kuwa kimya.

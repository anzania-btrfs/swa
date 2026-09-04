# SWA — Lugha ya Kupanga ya Kiswahili

**Swa** ni lugha ya kupanga yenye sintaksia kamili ya Kiswahili. Hakuna neno
la Kiingereza linatumika katika sintaksia yake. Inakusanya moja kwa moja hadi
msimbo wa mashine — `uzalishaji.swa` inatoa ELF binary moja kwa moja bila
LLVM, bila Rust, bila assembler, na bila kiunganishi cha nje (x86-64 Linux).
Dereva wa zamani wa Rust/LLVM (njia ya majaribio) umehamishwa hadi hazina
ya kumbukumbu: [lugha-swa/swa-dereva](https://github.com/lugha-swa/swa-dereva).

Makao rasmi: **[lugha-swa](https://github.com/lugha-swa)**

## Mfano

```swa
husisha C::stdio

W0 salamu(N8* jina) {
    andika("Habari, %s!\n", jina);
}

W0 hesabu_na_onyesha(N32 a, N32 b) {
    N32 jumla = a + b;
    N32 tofauti = a - b;
    andika("%d + %d = %d\n", a, b, jumla);
    andika("%d - %d = %d\n", a, b, tofauti);
}

salamu("Dunia");
hesabu_na_onyesha(15, 7);
```

## Mifano Zaidi

### Vigezo na Aina

```swa
N32 umri = 25;
N64 idadi_ya_watu = 8000000000;
D64 wastani = 3.14;
B1 imewashwa = 1;
N8 herufi = 65;             // halisi za herufi ('A') hazijatekelezwa bado
```

### Mtiririko wa Udhibiti

```swa
// Kama/Sivyo
N32 kadirifu(N32 x) {
    kama (x > 0) {
        rudisha 1;
    } sivyo {
        kama (x < 0) {
            rudisha -1;
        } sivyo {
            rudisha 0;
        }
    }
}

// Wakati (kitanzi)
W0 hesabu_hadi(N32 n) {
    N32 i = 0;
    wakati (i < n) {
        andika("%d\n", i);
        i = i + 1;
    }
}

// Chagua (switch)
N32 siku_kwa_namba(N32 n) {
    chagua (n) {
        hali 1: rudisha 100;
        hali 2: rudisha 200;
        hali 3: rudisha 300;
        sivyo: rudisha 0;
    }
}
```

### Miundo

```swa
muundo Nukta {
    N32 x;
    N32 y;
};

N32 pata_x(Nukta* p) {      // muundo kwa thamani: mbegu inarudisha
    rudisha p->x;           // takataka (uthibitisho 2026-08-27)
}

W0 weka_x(Nukta* p, N32 v) {
    p->x = v;
}
```

### Safu na Kumbukumbu

```swa
N8 bafa[1024];              // safu ya ulimwengu
N32 namba[5];               // vianzilishi vya safu bado havijatekelezwa

W0 andika_bafa() {
    bafa[0] = 65;           // andika kwenye safu
    namba[0] = 7;
    N32 ya_kwanza = namba[0];
}

// Kumbukumbu ya moja kwa moja
W0 mfano_kumbukumbu() {
    N32* p = tenga(4);      // tenga kumbukumbu (idadi ya baiti)
    *p = 42;                // andika thamani
    achilia(p);             // achilia kumbukumbu
}
```

### Miito na Urejeshaji

```swa
// Tangazo la mbele
W0 mkuu() {
    msaidizi(42);
}

W0 msaidizi(N32 x) {
    andika("Thamani: %d\n", x);
}

// Kujirudia
N32 kitanzi(N32 n) {
    kama (n <= 0) { rudisha 0; }
    rudisha 1 + kitanzi(n - 1);
}
```

## Vipengele

- **Maneno muhimu 13** ya Kiswahili -- hakuna Kiingereza katika sintaksia.
  Aina za nambari hutambuliwa kisintaksia kwa herufi kubwa (familia za
  N/A/D/B/W), si kama maneno muhimu.
- **Kujitegemea (100%)** -- mnyororo wa kujikusanya umefungwa kabisa:
  baiti za mkono → mbegu → stage1-exe → stage2-exe == stage3-exe
  (mnyororo wa uzalishaji; uthabiti wa makosa ni mhimili tofauti —
  angalia hati/mipaka.md)
- **Kizalishaji kimoja**: asilia (x86-64 ELF moja kwa moja — mnyororo wa
  uzalishaji). LLVM ilikuwa ya majaribio pekee na sasa iko kwenye hazina
  ya kumbukumbu (lugha-swa/swa-dereva).
- **Familia 5 za nambari** — N, A, D, B, W (upana halisi 8/16/32/64;
  upana mwingine haujaungwa mkono — angalia hati/uthibitisho-wa-lugha.md)
- **Kumbukumbu ya moja kwa moja** -- tenga, achilia, hakuna ukusanyaji taka
- **Majaribio**: 304/304 kwenye mnyororo wa Swa pekee (mbegu na stage1),
  fixpoint stage2 == stage3 sawa kwa baiti, na msuluhishi wa husisha 17/17.
  Uthibitisho kamili wa lugha: **hati/uthibitisho-wa-lugha.md** — jedwali
  za uzingatiaji, jibu baya zote kwa kipimo chake, na poromoko zote.

## Muundo wa Mradi

| Njia | Maelezo |
|---|---|
| `msingi/maktaba/` | Maktaba ya msingi ya kujitegemea kwa Swa |
| `msingi/maktaba/kumbukumbu.swa` | Shughuli za kumbukumbu |
| `msingi/maktaba/mfuatano.swa` | Shughuli za mifuatano |
| `msingi/maktaba/orodha.swa` | Safu inayobadilika |
| `msingi/maktaba/ramani.swa` | Jedwali la hashi |
| `msingi/mkusanyaji/` | Mkusanyaji wa kujitegemea wa Swa — bomba zima |
| `msingi/mkusanyaji/msomaji.swa` | Msomaji (lexer) — kamili |
| `msingi/mkusanyaji/msambazaji.swa` | Mchanganuzi (parser) — kamili, nodi 48 za AST |
| `msingi/mkusanyaji/mkaguzi.swa` | Mkaguzi wa kisemantiki — kamili (aina, hoja, ugawaji) |
| `msingi/mkusanyaji/mteremko.swa` | Kiteremshi cha AST→IR — huitwa kwa uthibitishaji wa muundo; codegen asilia hutumia AST moja kwa moja |
| `msingi/mkusanyaji/uzalishaji.swa` | Kizalishe asilia cha x86-64 — kamili (aina zote, sret, alloca) |
| `gharama/` | Zana za ujenzi na majaribio |

## Kujenga

**Mahitaji:** hakuna. Mnyororo wa kujikusanya una pengo la bootstrap la
0%: baiti za mkono (`msingi/kwanza.bin`, 393) → mbegu → stage1-exe →
stage2-exe == stage3-exe (sawa kwa baiti). Hakuna gcc, hakuna ld,
hakuna clang, hakuna libc popote kwenye mnyororo wa uzalishaji.

```sh
bash gharama/jenga-kwanza.sh      # hujenga mbegu kutoka baiti za mkono
bash gharama/jaribu-mnyororo.sh   # mnyororo mzima + majaribio 304
```

## Matumizi

```sh
# Kusanya faili ya Swa (binary moja kwa moja)
./mbegu --exe programu.swa

# Au kwa stage1 ya kujitegemea
./stage1 --exe programu.swa
```

## Hatua ya Bootstrap

Mkusanyaji wa Swa unajikusanya yenyewe kupitia hatua mbili:

1. **stage1.swa** -- kiendeshi kinachopakia maktaba ya `msingi/` na kuchakata faili yoyote ya `.swa`
2. **msingi/** -- msomaji, mchanganuzi, kiteremshi, na mkaguzi zilizoandikwa kwa Swa yenyewe

Lengo limefikiwa: mnyororo wa kujikusanya unajitegemea kabisa — kutoka baiti
za mkono hadi mkusanyaji kamili wa Swa, bila lugha nyingine popote.

## Hali ya Mradi

| Kipimo | Thamani |
|--------|---------|
| **Majaribio** | 304/304 [PASS] mnyororo wa Swa; uthibitisho kamili wa lugha: hati/uthibitisho-wa-lugha.md |
| **Kujikusanya** | Inapita [PASS] — fixpoint sawa kwa baiti |
| **Mchanganuzi wa Swa** | Kamili [DONE] |
| **Mkaguzi wa Swa** | Kamili [DONE] — aina, hoja, ugawaji, W0 zinakataliwa kwa sauti |
| **Kiteremshi cha Swa** | Kamili [DONE] |
| **Kizalishe asilia cha x86-64** | Kamili [DONE] |
| **Usambazaji wa aina** | Familia 5 (N/A/D/B/W); upana halisi 8/16/32/64 pekee |
| **Vielekezi vya kazi** | Kamili [DONE] — `&jina`, wito kupitia kigezo |
| **Mfumo wa moduli** | Kamili [DONE] — husisha ni kiungo halisi ndani ya mkusanyaji |
| **Sret (struct return)** | Imetekelezwa [DONE] |
| **Uhuru wa jumla** | **100% (0% bootstrap gap)** |

## Ramani

Angalia **[hati/ramani.md](hati/ramani.md)** kwa mpango kamili.

| Hatua | Maelezo | Hali |
|-------|---------|------|
| 0 | Mkusanyaji wa bootstrap wa Rust | Imekamilika |
| 1 | Kujikusanya kwa msingi | Imekamilika |
| 2 | Mkusanyaji kamili wa kujikusanya | Imekamilika |
| 3 | Ondoa utegemezi wa Rust | Imekamilika |
| 4 | Ondoa utegemezi wa LLVM | Imekamilika (mnyororo wa uzalishaji; LLVM imebaki majaribio) |
| 5 | Lugha kamili ya mifumo | Baadaye |

## Jumuiya

Tunawakaribisha wachangiaji wote! Hata kama hujui Kiswahili, unaweza kuchangia
kwa kujifunza lugha yetu tukufu na kusaidia kujenga mkusanyaji wa kwanza wa
Kiswahili duniani.

- **[CONTRIBUTING.md](CONTRIBUTING.md)** -- Jinsi ya kuchangia
- **[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)** -- Kanuni za maadili
- **[SECURITY.md](SECURITY.md)** -- Sera ya usalama
- **[SUPPORT.md](SUPPORT.md)** -- Kupata msaada
- **[hati/ramani.md](hati/ramani.md)** -- Ramani ya mradi
- **[hati/mipaka.md](hati/mipaka.md)** -- Mipaka inayojulikana (kwa ukali)
- **[hati/ukaguzi-bafa.md](hati/ukaguzi-bafa.md)** -- Ukaguzi wa bafa za ukubwa thabiti
- **[GitHub Discussions](https://github.com/lugha-swa/swa/discussions)** -- Majadiliano
- **[GitHub Issues](https://github.com/lugha-swa/swa/issues)** -- Ripoti za hitilafu na maombi ya vipengele

### Kwa Waanzishaji

Tafuta lebo [`good-first-issue`](https://github.com/lugha-swa/swa/labels/good-first-issue).
Masuala haya yameandaliwa mahsusi kwa wachangiaji wapya!

## Leseni

Mradi huu una leseni mbili:

- [Apache 2.0](LICENSE-APACHE)
- [MIT](LICENSE-MIT)

kwa chaguo lako.

## Mchango

Michango inakaribishwa. Tafadhali tumia:

1. Tenga tawi la kipengele (`feat/jina` au `kurekebisha/jina`)
2. Fanya mabadiliko yako
3. Wasilisha ombi la kuvuta (pull request)
4. Hakikisha majaribio yote yanapita

Tawi kuu (`main`) linalindwa. Mabadiliko yote huingia kupitia ombi la kuvuta.

---
*Imetengenezwa Afrika ya Mashariki*

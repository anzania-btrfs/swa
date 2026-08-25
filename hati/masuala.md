# Masuala Yanayobaki — Mkusanyaji wa Kujikusanya wa Kiswahili

Hati hii inafuatilia masuala yaliyo wazi na ramani ya kazi. Mipaka
inayojulikana imeandikwa kwa undani kwenye `hati/mipaka.md`.

## Masuala yaliyo wazi

### 1. D64 kwenye wito wa kazi wa mbegu

Mbegu haijatekeleza ABI ya xmm0-xmm7 kwa wito wa kazi. Program za mbegu
zenye kazi za D64 (hoja au kurejesha kwa desimali) zinalia kwa sauti
(`Hitilafu: D64 kwenye wito`). Mnyororo wa .swa (stage1+) una ABI kamili.
Angalia `hati/mipaka.md` 4c.

### 2. Maneno halisi ni 32-bit

Literal `2147483648` inatafsiriwa kama `-2147483648` (biti zinahifadhiwa,
ishara inaenea). Thamani kubwa zaidi ya 32-bit lazima zijengwe wakati wa
utekelezaji. Inatokea kwa usawa kwenye mbegu na dereva wa Rust.
Angalia `hati/mipaka.md` 5.

### 3. Mbegu haiwi `husisha { faili.swa }`

Mbegu haichambuzi faili lililotajwa — faili lazima ziunganishwe kwanza
(`cat`). Mnyororo wa .swa (stage1+) unaunga viungo vya ndani.
Angalia `hati/mipaka.md` 8.

### 4. Kizuizi cha BSS kwenye Windows

BSS kubwa kuliko ~47KB inaanguka kwenye uanzishaji — maalum kwa Windows.
Linux ELF ni safi. Haijatatuliwa.

### 5. Mwisho wa LLVM ni wa majaribio

O0 (FastISel) inakataa kazi yenye vizuizi zaidi ya 40; majaribio hutumia
O1. Mnyororo wa uzalishaji ni mbegu/exe pekee. Angalia `hati/mipaka.md` 6.

## Ramani ya Kazi

| Kipaumbele | Kazi | Ukubwa | Hali |
|-----------|------|--------|------|
| 1 | ABI ya xmm0-xmm7 kwa wito wa D64 kwenye mbegu | kubwa | wazi |
| 2 | Maneno halisi 64-bit | wastani | wazi |
| 3 | Viungo vya ndani (`husisha`) kwenye mbegu | wastani | wazi |
| 4 | Mwisho wa LLVM kuwa wa kuaminika (si majaribio) | kubwa | wazi |
| 5 | Malengo zaidi (ARM64, RISC-V) | kubwa | wazi |

## Kilichorekebishwa (Agosti 2026)

- **Mbegu — hesabu za baiti 8**: hitilafu ya FPE kwenye hesabu za N64
  ilikuwa na mizizi minne (.load_n64 haikuwa na jmp, hesabu za 32-bit pekee,
  hifadhi ya 32-bit pekee, na kazi_ret_aina iliyowekwa 0). Zote zimetatuliwa
  na mbegu imegandishwa upya.
- **Literal kamili kama hoja**: literal (k.m. 1000) ilikuwa inapitishwa kama
  desimali kwenye wito wa kazi. Imerekebishwa.
- **Sintaksia**: maneno `kamasivyo` na `sivyo kama` yameondolewa — tawi-jingine
  huandikwa kwa kuingiza `kama` ndani ya `sivyo`. Dereva wa Rust na mchanganuzi
  wa kujikusanya zimewianishwa.
- **D64 kwenye wito**: mbegu sasa inakataa kwa sauti (zamani ilikubali kimya).

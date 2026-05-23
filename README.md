# Areas Index

`areas-index.sh`, bulundugu dizindeki ana klasor adlarini sade bir Markdown indeksine yazan ve gerekirse bu indeks degisikligini commit eden kucuk bir Bash aracidir.

Bu proje ozellikle GitHub'da kirik link olusmamasi icin README linki uretmez. Lokalde bir klasorun icinde `README.md` olsa bile indeks dosyasinda sadece ana klasor basligi gosterilir.

## Turkce

### Ne Yapar?

Script kendi bulundugu dizini ana dizin kabul eder ve bu dizindeki ana klasorleri listeler.

Her ana klasor icin sadece Markdown basligi yazar:

```md
### klasor-adi
```

Indeks yeniden olusturuldugunda dosya gercekten degistiyse script sadece `areas-index.md` icin commit olusturur. Klasor listesi ayniysa commit olusturmaz.

### Ne Yapmaz?

- README linki vermez.
- `README: yok` satiri yazmaz.
- Alt klasorleri listelemez.
- Klasor icindeki dosyalari listelemez.
- Dosya sayisi hesaplamaz.
- Bos commit olusturmaz.
- `areas-index.md` disindaki dosyalari commit etmez.
- Git veya `.gitignore` hazirlik islemi yapmaz.
- Mevcut klasorleri silmez, tasimaz veya yeniden adlandirmaz.

### Dosyalar

| Dosya | Aciklama |
| --- | --- |
| `areas-index.sh` | Ana script. Indeksi gosterir, yeniden olusturur ve gerekirse indeks commit'i atar. |
| `areas-index.md` | Script tarafindan uretilen ana klasor listesi. |
| `README.md` | Bu proje dokumani. |

### Kullanim

```bash
./areas-index.sh
```

Menu:

| Secim | Islem |
| --- | --- |
| `1` | `areas-index.md` dosyasinin son halini gosterir. Dosya yoksa once olusturur. |
| `2` | `areas-index.md` dosyasini yeniden olusturur. Degisiklik varsa `Update areas folder index` commit'i atar. |
| `3` | Cikis yapar. |

### Cikti Formati

```md
# Areas Ana Klasor Indeksi

## Icindekiler

- [Ana Klasorler](#ana-klasorler)
  - [proje-adi](#proje-adi)

## Ana Klasorler

### proje-adi
```

---

## English

### What It Does

`areas-index.sh` creates a simple Markdown index of the top-level folder names next to the script and commits that index when it actually changes.

For each top-level folder, it writes only a Markdown heading:

```md
### folder-name
```

It intentionally does not create README links. This avoids broken GitHub links when a README file exists locally but is not pushed to the repository.

When the index is regenerated, the script commits only `areas-index.md` if the file really changed. If the folder list is the same, it does not create a commit.

### What It Does Not Do

- It does not link to README files.
- It does not write `README: yok`.
- It does not list nested folders.
- It does not list files inside folders.
- It does not count files.
- It does not create empty commits.
- It does not commit files other than `areas-index.md`.
- It does not run Git or `.gitignore` setup.
- It does not delete, move, or rename existing folders.

### Files

| File | Description |
| --- | --- |
| `areas-index.sh` | Main script. Shows or regenerates the index and commits it when needed. |
| `areas-index.md` | Generated list of top-level folders. |
| `README.md` | This project documentation. |

### Usage

```bash
./areas-index.sh
```

Menu:

| Option | Action |
| --- | --- |
| `1` | Shows the latest `areas-index.md`. If it does not exist, it creates it first. |
| `2` | Regenerates `areas-index.md`. If it changed, creates an `Update areas folder index` commit. |
| `3` | Exits. |

# Areas Index

`areas-index.sh`, bulundugu dizindeki ana klasorleri sade bir Markdown indeksine yazan kucuk bir Bash aracidir.

Indeksin amaci ayrinti kalabaligi yapmak degil, ana klasorleri tek ekranda gostermek ve her klasorde varsa `README.md` dosyasina hizli link vermektir. Alt klasorler, dosya listeleri, Git hazirligi ve klasor agaci ciktisi bu akis icinde yer almaz.

## Turkce

### Ne Yapar?

Script calistigi kendi dizinini ana dizin kabul eder ve sadece bu dizindeki ana klasorleri listeler.

Her ana klasor icin:

- klasor adini baslik olarak yazar;
- `README.md` varsa ona link verir;
- `readme.md` gibi farkli harf kullanimlarini eslesme kabul etmez;
- `README.md` yoksa `README: yok` yazar.

### Ne Yapmaz?

- Alt klasorleri listelemez.
- Klasor icindeki dosyalari listelemez.
- Dosya sayisi veya Markdown sayisi hesaplamaz.
- Git init calistirmaz.
- `.gitignore` olusturmaz veya guncellemez.
- Klasor agaci gostermez.
- Mevcut klasorleri silmez, tasimaz veya yeniden adlandirmaz.

### Git Ignore Kurali

Bu repoda genel kural olarak ana dizindeki proje klasorleri Git disinda tutulur. Linklerin calisabilmesi icin yalnizca buyuk harfle yazilmis `README.md` dosyalari Git'e dahil edilir.

```gitignore
*
!*/
!areas-index.sh
!areas-index.md
!README.md
!**/README.md
```

Bu kural `readme.md`, `Readme.md` veya baska harf bicimlerini dahil etmez.

### Dosyalar

| Dosya | Aciklama |
| --- | --- |
| `areas-index.sh` | Ana script. Menuden indeks gosterme ve yeniden olusturma islemlerini yapar. |
| `areas-index.md` | Script tarafindan uretilen ana klasor indeksi. |
| `README.md` | Bu proje dokumani. |

### Kullanim

```bash
./areas-index.sh
```

Menu:

| Secim | Islem |
| --- | --- |
| `1` | `areas-index.md` dosyasinin son halini gosterir. Dosya yoksa once olusturur. |
| `2` | `areas-index.md` dosyasini yeniden olusturur. |
| `3` | Cikis yapar. |

### Cikti Formati

Uretilen `areas-index.md` dosyasi su mantikla olusur:

```md
## Ana Klasorler

### proje-adi

- README: [./proje-adi/README.md](./proje-adi/README.md)

### baska-proje

- README: yok
```

Bu yapi sayesinde indeks dosyasi temiz kalir ve her projenin kendi aciklamasi varsa dogrudan o projenin README dosyasina gidilir.

---

## English

### What It Does

`areas-index.sh` is a small Bash tool that creates a simple Markdown index for the top-level folders next to the script.

For each top-level folder, it:

- writes the folder name as a heading;
- links to `README.md` when it exists;
- treats other casing such as `readme.md` as no match;
- writes `README: yok` when `README.md` is not found.

### What It Does Not Do

- It does not list nested folders.
- It does not list files inside each folder.
- It does not count files or Markdown documents.
- It does not run Git setup.
- It does not create or update `.gitignore`.
- It does not print a folder tree.
- It does not delete, move, or rename existing folders.

### Git Ignore Rule

The repository keeps project folders ignored by default. Only files named exactly `README.md` are allowed back into Git so the index links can be tracked and opened reliably.

```gitignore
*
!*/
!areas-index.sh
!areas-index.md
!README.md
!**/README.md
```

This rule does not include `readme.md`, `Readme.md`, or any other casing.

### Files

| File | Description |
| --- | --- |
| `areas-index.sh` | Main script. Shows the menu, prints the index, and regenerates the index. |
| `areas-index.md` | Generated Markdown index of top-level folders. |
| `README.md` | This project documentation. |

### Usage

```bash
./areas-index.sh
```

Menu:

| Option | Action |
| --- | --- |
| `1` | Shows the latest `areas-index.md`. If it does not exist, it creates it first. |
| `2` | Regenerates `areas-index.md`. |
| `3` | Exits. |

### Output Format

The generated `areas-index.md` follows this shape:

```md
## Ana Klasorler

### project-name

- README: [./project-name/README.md](./project-name/README.md)

### another-project

- README: yok
```

This keeps the main index compact while letting each project explain itself through its own README file.

# Areas Index

`areas-index.sh`, bulundugu dizindeki ana klasorleri tarayan ve bunlari okunabilir bir Markdown indeksine yazan tek dosyalik bir Bash aracidir.

Bu repo, `/mnt/local/areas` gibi cok sayida proje, medya dosyasi, not ve deneme klasoru bulunan bir ana dizini daha kolay anlamak icin kullanilir. Script klasorleri silmez, tasimaz veya yeniden adlandirmaz; sadece mevcut durumu listeler, `areas-index.md` dosyasini gunceller ve istege bagli olarak Git/.gitignore hazirligi yapar.

## Turkce

### Amac

Bu proje, ana calisma dizinindeki klasorleri tek bir Markdown dosyasinda toplamak icin hazirlandi. Boylece hangi klasorde ne oldugunu dosya gezmeden gorebilir, eski projeleri, video/icerik klasorlerini, notlari ve uygulama denemelerini hizlica tarayabilirsin.

Olusturulan indeks dosyasi:

- ana klasorleri listeler;
- her klasor icin dosya, alt klasor ve Markdown sayisini gosterir;
- ilk seviye icerigi dosya/klasor olarak ayirir;
- ciktiyi `areas-index.md` dosyasina yazar.

### Dosyalar

| Dosya | Gorev |
| --- | --- |
| `areas-index.sh` | Ana Bash script'i. Menuyu calistirir, indeks uretir, Git hazirlar ve klasor agacini gosterir. |
| `areas-index.md` | Script tarafindan uretilen guncel ana klasor indeksi. |
| `README.md` | Projenin amacini ve kullanimini anlatan dokuman. |
| `.gitignore` | Gecici/editor dosyalarini Git disinda tutar. |

### Kullanim

Script'i bulundugu dizinden calistir:

```bash
./areas-index.sh
```

Calistirdiginda interaktif menu acilir:

| Secim | Islem |
| --- | --- |
| `1` | `areas-index.md` dosyasinin son halini ekrana basar. Dosya yoksa once olusturur. |
| `2` | Ana klasor indeksini yeniden olusturur. |
| `3` | Bu dizinde Git deposu yoksa `git init` calistirir ve `.gitignore` dosyasini hazirlar. |
| `4` | Klasor agacini gosterir. `tree` varsa onu, yoksa `find` kullanir. |
| `5` | Indeks olusturma, Git hazirlama, README kontrolu ve indeks gosterme adimlarini birlikte calistirir. |
| `6` | Menuden cikar. |

### Calisma Mantigi

Script kendi konumunu proje koku kabul eder:

```bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```

Bu sayede hangi dizinden cagirirsan cagir, indeks her zaman script'in bulundugu klasor icin uretilir. Cikti dosyasi sabittir:

```bash
areas-index.md
```

Indeks olusturulurken sadece ana seviyedeki klasorler taranir. `.git` klasoru ana listeye dahil edilmez. Her klasor icin yalnizca ilk seviye icerik gosterilir; bu sayede cikti kisa, okunabilir ve hizli kalir.

### Notlar

- Script mevcut klasorleri silmez veya tasimaz.
- `areas-index.md` uretilebilir bir dosyadir; klasorler degistikce yeniden olusturulabilir.
- Klasor adlari ve icerikler mevcut disk durumundan okunur.
- Git hazirligi sadece bu ana dizin icindir; alt klasorlerdeki ayri Git repolarina mudahale etmez.

---

## English

### Purpose

This project is a small Bash-based indexer for a busy workspace folder. It scans the top-level directories next to `areas-index.sh` and writes a readable Markdown overview to `areas-index.md`.

It is useful when one main folder contains many projects, content folders, notes, media files, experiments, and archived work. Instead of opening every folder manually, you can regenerate the index and quickly see what exists at the first level.

The generated index:

- lists top-level folders;
- shows file, folder, and Markdown counts for each folder;
- lists first-level entries as files or folders;
- writes the result to `areas-index.md`.

### Files

| File | Role |
| --- | --- |
| `areas-index.sh` | Main Bash script. Runs the menu, generates the index, prepares Git, and shows the folder tree. |
| `areas-index.md` | Generated Markdown index of the current top-level folders. |
| `README.md` | Project documentation and usage guide. |
| `.gitignore` | Keeps temporary/editor files out of Git. |

### Usage

Run the script from this folder:

```bash
./areas-index.sh
```

The script opens an interactive menu:

| Option | Action |
| --- | --- |
| `1` | Prints the latest `areas-index.md` content. If the file does not exist, it creates it first. |
| `2` | Regenerates the folder index. |
| `3` | Initializes Git if needed and writes the `.gitignore` file. |
| `4` | Shows the folder tree. Uses `tree` when available, otherwise falls back to `find`. |
| `5` | Runs the full workflow: generate index, prepare Git, check README, then show the index. |
| `6` | Exits the menu. |

### How It Works

The script treats its own directory as the project root:

```bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```

Because of that, it always indexes the folder where the script lives, even if you launch it from another working directory. The output file is always:

```bash
areas-index.md
```

The scan is intentionally shallow. It reads only top-level folders and first-level entries inside them. This keeps the Markdown output fast, compact, and easy to review.

### Notes

- The script does not delete, move, or rename existing folders.
- `areas-index.md` is generated output and can be refreshed whenever the workspace changes.
- Folder names and contents are read from the current filesystem state.
- Git setup applies only to this main folder and does not manage nested Git repositories.

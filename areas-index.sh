#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INDEX_FILE="$ROOT_DIR/areas-index.md"

cd "$ROOT_DIR"

print_line() {
  printf '%s\n' "$1"
}

pause() {
  printf '\nDevam etmek icin Enter... '
  read -r _
}

markdown_anchor() {
  local text="$1"

  text="${text,,}"
  text="${text// /-}"
  text="$(printf '%s' "$text" | tr -cd '[:alnum:]_.-')"

  printf '%s' "$text"
}

generate_index() {
  {
    print_line "# Areas Ana Klasor Indeksi"
    print_line ""
    print_line "Bu dosya, bulundugu dizindeki ana klasorleri listeler. Klasorde README.md varsa ilgili linki gosterir."
    print_line ""
    print_line "- Dizin: \`$ROOT_DIR\`"
    print_line "- Olusturma zamani: \`$(date '+%Y-%m-%d %H:%M:%S %Z')\`"
    print_line ""

    mapfile -t folders < <(find "$ROOT_DIR" -maxdepth 1 -type d ! -path "$ROOT_DIR" ! -name '.git' | sort)

    print_line "## Icindekiler"
    print_line ""
    print_line "- [Ana Klasorler](#ana-klasorler)"

    if ((${#folders[@]} > 0)); then
      local toc_folder toc_name toc_anchor
      for toc_folder in "${folders[@]}"; do
        toc_name="$(basename "$toc_folder")"
        toc_anchor="$(markdown_anchor "$toc_name")"
        print_line "  - [$toc_name](#$toc_anchor)"
      done
    fi

    print_line ""
    print_line "## Ana Klasorler"
    print_line ""

    if ((${#folders[@]} == 0)); then
      print_line "Bu dizinde henuz ana klasor yok."
    else
      local folder name
      for folder in "${folders[@]}"; do
        name="$(basename "$folder")"
        print_line "### $name"
        print_line ""
        if [[ -f "$folder/README.md" ]]; then
          print_line "- README: [./$name/README.md](./$name/README.md)"
        elif [[ -f "$folder/readme.md" ]]; then
          print_line "- README: [./$name/readme.md](./$name/readme.md)"
        else
          print_line "- README: yok"
        fi
        print_line ""
      done
    fi
  } > "$INDEX_FILE"

  print_line "Indeks olusturuldu: $INDEX_FILE"
}

show_index() {
  if [[ ! -f "$INDEX_FILE" ]]; then
    generate_index
  fi

  print_line ""
  print_line "----- $INDEX_FILE -----"
  cat "$INDEX_FILE"
  print_line "----- indeks sonu -----"
}

menu() {
  while true; do
    clear || true
    print_line "Areas main folder structure"
    print_line "Dizin: $ROOT_DIR"
    print_line ""
    print_line "1) Indeks son halini goster"
    print_line "2) Indeksi yeniden olustur"
    print_line "3) Cikis"
    print_line ""
    printf 'Secim: '
    read -r choice

    case "$choice" in
      1) show_index; pause ;;
      2) generate_index; pause ;;
      3) print_line "Cikis."; exit 0 ;;
      *) print_line "Gecersiz secim: $choice"; pause ;;
    esac
  done
}

menu

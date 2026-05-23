#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INDEX_FILE="$ROOT_DIR/areas-main-folder-structure.index.md"
README_FILE="$ROOT_DIR/README.md"
IGNORE_FILE="$ROOT_DIR/.gitignore"

cd "$ROOT_DIR"

print_line() {
  printf '%s\n' "$1"
}

pause() {
  printf '\nDevam etmek icin Enter... '
  read -r _
}

folder_summary() {
  local dir="$1"
  local file_count folder_count md_count

  file_count="$(find "$dir" -maxdepth 1 -type f | wc -l | tr -d ' ')"
  folder_count="$(find "$dir" -maxdepth 1 -type d ! -path "$dir" | wc -l | tr -d ' ')"
  md_count="$(find "$dir" -maxdepth 1 -type f -name '*.md' | wc -l | tr -d ' ')"

  printf '  - Dosya: %s, klasor: %s, markdown: %s\n' "$file_count" "$folder_count" "$md_count"
}

generate_index() {
  {
    print_line "# Areas Ana Klasor Indeksi"
    print_line ""
    print_line "Bu dosya, bulundugu dizindeki ana klasorleri ve temel iceriklerini listeler."
    print_line ""
    print_line "- Dizin: \`$ROOT_DIR\`"
    print_line "- Olusturma zamani: \`$(date '+%Y-%m-%d %H:%M:%S %Z')\`"
    print_line ""
    print_line "## Ana Klasorler"
    print_line ""

    mapfile -t folders < <(find "$ROOT_DIR" -maxdepth 1 -type d ! -path "$ROOT_DIR" ! -name '.git' | sort)

    if ((${#folders[@]} == 0)); then
      print_line "Bu dizinde henuz ana klasor yok."
    else
      local folder name
      for folder in "${folders[@]}"; do
        name="$(basename "$folder")"
        print_line "### $name"
        print_line ""
        print_line "- Yol: \`./$name\`"
        folder_summary "$folder"
        print_line "- Ilk seviye icerik:"

        mapfile -t entries < <(find "$folder" -maxdepth 1 ! -path "$folder" | sort)
        if ((${#entries[@]} == 0)); then
          print_line "  - Bos klasor"
        else
          local entry base kind
          for entry in "${entries[@]}"; do
            base="$(basename "$entry")"
            if [[ -d "$entry" ]]; then
              kind="klasor"
            else
              kind="dosya"
            fi
            print_line "  - \`$base\` ($kind)"
          done
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

setup_git() {
  if [[ ! -d "$ROOT_DIR/.git" ]]; then
    git init
  fi

  cat > "$IGNORE_FILE" <<'EOF'
# Bu dizindeki uretilebilir ve gecici dosyalar
.DS_Store
Thumbs.db
*.tmp
*.temp
*.log

# Editor / sistem dosyalari
.idea/
.vscode/
EOF

  print_line "Git hazirlandi."
  print_line ".gitignore guncellendi: $IGNORE_FILE"
  git -c safe.directory="$ROOT_DIR" status --short
}

show_tree() {
  print_line ""
  print_line "Bulundugu dizin: $ROOT_DIR"
  print_line ""

  if command -v tree >/dev/null 2>&1; then
    tree -a -L 2 -I '.git'
  else
    find "$ROOT_DIR" -maxdepth 2 ! -path "$ROOT_DIR/.git*" | sort | sed "s#^$ROOT_DIR#.#"
  fi
}

ensure_readme() {
  if [[ -f "$ROOT_DIR/areas-main-folder-structure.md" && ! -f "$README_FILE" ]]; then
    mv "$ROOT_DIR/areas-main-folder-structure.md" "$README_FILE"
    print_line "areas-main-folder-structure.md artik README.md oldu."
  elif [[ -f "$README_FILE" ]]; then
    print_line "README.md zaten var."
  else
    print_line "README.md icin kaynak dosya bulunamadi."
  fi
}

run_all() {
  generate_index
  setup_git
  ensure_readme
  show_index
}

menu() {
  while true; do
    clear || true
    print_line "Areas main folder structure"
    print_line "Dizin: $ROOT_DIR"
    print_line ""
    print_line "1) Indeks son halini goster"
    print_line "2) Indeksi yeniden olustur"
    print_line "3) Git ve .gitignore hazirla"
    print_line "4) Klasor agacini goster"
    print_line "5) Tum islemleri calistir"
    print_line "6) Cikis"
    print_line ""
    printf 'Secim: '
    read -r choice

    case "$choice" in
      1) show_index; pause ;;
      2) generate_index; pause ;;
      3) setup_git; pause ;;
      4) show_tree; pause ;;
      5) run_all; pause ;;
      6) print_line "Cikis."; exit 0 ;;
      *) print_line "Gecersiz secim: $choice"; pause ;;
    esac
  done
}

menu

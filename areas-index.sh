#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INDEX_FILE="$ROOT_DIR/areas-index.md"
INDEX_REL="areas-index.md"

cd "$ROOT_DIR"

print_line() {
  printf '%s\n' "$1"
}

pause() {
  printf '\nPress Enter to continue... '
  read -r _
}

folder_modified_at() {
  local folder="$1"
  stat -c '%y' "$folder" | cut -d'.' -f1
}

generate_index() {
  local tmp_file
  tmp_file="$(mktemp)"

  {
    print_line "# Areas Index"
    print_line ""
    print_line "Path: \`$ROOT_DIR\`"
    print_line ""

    mapfile -t folders < <(find "$ROOT_DIR" -maxdepth 1 -type d ! -path "$ROOT_DIR" ! -name '.git' | sort)

    if ((${#folders[@]} == 0)); then
      print_line "No folders."
    else
      local folder name modified_at number
      number=1
      for folder in "${folders[@]}"; do
        name="$(basename "$folder")"
        modified_at="$(folder_modified_at "$folder")"
        print_line "$number. $name"
        print_line "   Last updated: $modified_at"
        print_line ""
        ((number++))
      done
    fi
  } > "$tmp_file"

  if [[ -f "$INDEX_FILE" ]] && cmp -s "$tmp_file" "$INDEX_FILE"; then
    rm -f "$tmp_file"
    print_line "Index is current: $INDEX_FILE"
    return 1
  fi

  mv "$tmp_file" "$INDEX_FILE"

  print_line "Index updated: $INDEX_FILE"
  return 0
}

commit_index_if_changed() {
  git -c safe.directory="$ROOT_DIR" add "$INDEX_REL"

  if git -c safe.directory="$ROOT_DIR" diff --cached --quiet -- "$INDEX_REL"; then
    print_line "No commit: index did not change."
    return 0
  fi

  git -c safe.directory="$ROOT_DIR" commit -m "Update areas folder index" -- "$INDEX_REL"
  print_line "Commit created: Update areas folder index"
}

update_index() {
  if generate_index; then
    commit_index_if_changed
  else
    print_line "No commit: no changes."
  fi
}

show_index() {
  if [[ ! -f "$INDEX_FILE" ]]; then
    generate_index
  fi

  print_line ""
  print_line "----- $INDEX_FILE -----"
  cat "$INDEX_FILE"
  print_line "----- end -----"
}

menu() {
  while true; do
    clear || true
    print_line "Areas Index"
    print_line "Path: $ROOT_DIR"
    print_line ""
    print_line "1) Show index"
    print_line "2) Update index"
    print_line "3) Exit"
    print_line ""
    printf 'Choice: '
    read -r choice

    case "$choice" in
      1) show_index; pause ;;
      2) update_index; pause ;;
      3) print_line "Exit."; exit 0 ;;
      *) print_line "Invalid choice: $choice"; pause ;;
    esac
  done
}

menu

#!/usr/bin/env bash
# Importa las capturas del vault de Obsidian a docs/assets/img/ y renombra
# espacios -> guion bajo (lo que esperan los .md).
# Uso:  ./import_images.sh "/c/Users/tu_usuario/ruta/al/vault/adjuntos"
set -euo pipefail
SRC="${1:?Pasa la ruta de la carpeta de adjuntos de Obsidian como argumento}"
DEST="docs/assets/img"
mkdir -p "$DEST"
find "$SRC" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.gif' \) \
  -exec cp -n {} "$DEST"/ \;
cd "$DEST"
for f in *\ *; do
  [ -e "$f" ] || continue
  mv -n -- "$f" "${f// /_}"
done
echo "Imágenes importadas y renombradas en $DEST"

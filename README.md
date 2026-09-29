# Scarlgyx Cybersecurity

Writeups, notas y herramientas de ciberseguridad ofensiva. Construido con
[MkDocs Material](https://squidfunk.github.io/mkdocs-material/).

## Ver el sitio en local

```bash
python -m venv .venv
source .venv/Scripts/activate    # Linux/Mac: source .venv/bin/activate
pip install -r requirements.txt
mkdocs serve                     # http://127.0.0.1:8000
```

## Publicar en GitHub Pages

```bash
mkdocs gh-deploy
```

## Estructura

```
docs/
├── index.md              Portada
├── writeups/             Hack The Box, TryHackMe, VulnHub, Dockerlabs, Over The Wire
├── certs/                eJPT
├── notes/                SMB, SNMP…
├── scripts/              Herramientas propias
└── assets/img/           Capturas de pantalla
```

El orden y los nombres del menú se controlan con los archivos `.pages`
(plugin awesome-pages). Las páginas nuevas aparecen solas al añadirlas.

## Imágenes

Todas en `docs/assets/img/` con guiones bajos (`Pasted_image_20250101.png`).
Impórtalas desde Obsidian con `import_images.sh`.

#!/usr/bin/env bash
# Upload the website to the OVH hosting over FTP (no SSH on the free offer).
#   cd site && ./deploy.sh
# Asks for the FTP password (Espace client OVH → Hébergements → FTP-SSH → mot de passe).
# Uploads every file of this folder into www/, creating folders as needed.
set -euo pipefail
HOST="ftp.cluster129.hosting.ovh.net"
USER="allopaw"
cd "$(dirname "$0")"
read -r -s -p "Mot de passe FTP de $USER : " PASS; echo
find . -type f ! -name 'deploy.sh' ! -path './.git/*' | sed 's#^\./##' | while read -r f; do
  printf '  %s\n' "$f"
  curl --silent --show-error --ftp-create-dirs -T "$f" "ftp://$HOST/www/$f" --user "$USER:$PASS"
done
echo "Terminé. Vérifiez : https://allopaw.cluster129.hosting.ovh.net/ (puis https://allopatrick.fr/ quand le DNS est prêt)."

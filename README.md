# Inception

**System Administration Docker Exercise**  
Version: 3

## Projektin kuvaus

Tämä projekti toteuttaa pienen Docker-infrastruktuurin, jossa on kolme palvelua:
- **NGINX** (vain TLSv1.2/1.3, portti 443)
- **WordPress + PHP-FPM**
- **MariaDB**

Kaikki palvelut pyörivät omissa konteissaan, ja tiedot tallennetaan volyymeihin. Palvelut kommunikoivat Docker-verkon kautta.

## Hakemistorakenne

```
Inception/
├── Makefile
├── secrets/           # Salasanat ja tunnukset (ei gitissä)
├── srcs/
│   ├── .env           # Ympäristömuuttujat (ei gitissä)
│   ├── docker-compose.yml
│   └── requirements/
│       ├── mariadb/
│       ├── nginx/
│       └── wordpress/
└── .gitignore
```

## Käyttöönotto

1. **Kloonaa repo:**
   ```bash
   git clone git@github.com:djelacik/Inception.git
   cd Inception
   ```

2. **Lisää domain hosts-tiedostoon:**
   ```bash
   echo "127.0.0.1 <login>.42.fr" | sudo tee -a /etc/hosts
   ```

3. **Luo data-hakemistot:**
   ```bash
   sudo mkdir -p /home/<login>/data/{wordpress,mariadb}
   sudo chown -R <login>:<login> /home/<login>/data
   ```

4. **Lisää .env ja secrets-tiedostot (ei gitissä):**
   - Kopioi mallipohjat ja täytä omilla arvoilla.
   - Älä lisää näitä git-repoon.

5. **Käynnistä palvelut:**
   ```bash
   make
   ```

6. **Avaa selaimessa:**
   - https://<login>.42.fr

## Ympäristömuuttujat ja salaisuudet

- `.env` sisältää kaikki tarvittavat muuttujat (domain, db, wp).
- `secrets/` sisältää salasanat ja tunnukset.
- **Älä lisää näitä git-repoon!**  
  Lisää `.env` ja `secrets/*` .gitignoreen.

## Makefile-komennot

- `make` / `make build` — Rakentaa ja käynnistää kontit
- `make up` — Käynnistää kontit
- `make down` — Sammuttaa kontit
- `make restart` — Uudelleenkäynnistää kontit
- `make clean` — Poistaa kontit ja imaget
- `make fclean` — Poistaa myös datavolyymin
- `make logs` — Näyttää konttien lokit

## Turvallisuus

- Salasanat ja tunnukset vain secrets-hakemistossa
- Ei salasanoja Dockerfileissä
- Vain TLSv1.2/1.3 käytössä
- Ei host-verkkoa, linkkejä tai tail-hackeja
- Kontit restarttaa automaattisesti

## Arviointia varten

- Poista `.env` ja `secrets/*` gitistä:
  ```bash
  git rm --cached srcs/.env
  git rm --cached secrets/*
  echo "srcs/.env" >> .gitignore
  echo "secrets/*" >> .gitignore
  git add .gitignore
  git commit -m "Remove secrets and env from git for evaluation"
  git push
  ```

- Varmista, että kaikki toimii puhtaalla VM:llä yllä olevilla ohjeilla.

## Lisäominaisuudet (bonus)

- Voit lisätä esim. Redis, Adminer, FTP, staattinen sivu, monitorointi jne.

---

**Onnea arviointiin ja julkaisuun!**

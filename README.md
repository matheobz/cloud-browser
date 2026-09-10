# cloud-browser

> Tu veux juste l'utiliser ? Lis le [GUIDE](GUIDE.md), pas a pas, sans jargon.

Un Chromium complet qui tourne dans un GitHub Codespace, accessible depuis un onglet de ton navigateur.
Le trafic web sort du serveur GitHub, pas de ton reseau local.

Machine 2 coeurs pour preserver le quota gratuit (120 core hours/mois).

## Lancer une session

1. Sur GitHub, depuis ce repo : **Code > Codespaces > Create codespace on main**.
2. Attends la fin du demarrage. Le conteneur `chromium` est lance automatiquement et
   l'onglet du port **3000** s'ouvre tout seul.
3. Si l'onglet ne s'ouvre pas : panneau **Ports** > port 3000 > icone globe (*Open in Browser*).

Le port 3000 reste **Private** : seul ton compte GitHub y accede. Ne le passe jamais en Public.

## Reglages a faire une fois

- **Timeout d'inactivite** : https://github.com/settings/codespaces > *Default idle timeout* > **240 minutes**.
  Sinon le codespace s'arrete au bout de 30 min.
- **Arrete le codespace apres usage** : menu *Codespaces* > `...` > **Stop codespace**.
  Le temps facture court tant que la machine tourne, meme si tu ne l'utilises pas.

## Profil et scripts

Le conteneur est reutilise a chaque redemarrage du codespace : cookies, sessions et
historique sont conserves.

- `./scripts/logs.sh` : logs du conteneur en direct.
- `./scripts/reset-browser.sh` : repart d'un profil vierge (supprime et recree le conteneur).

## Depannage

**Ecran noir, deconnexions, page qui ne charge pas**

Regarde d'abord les logs : `./scripts/logs.sh`.
Si le probleme persiste, bascule sur l'interface HTTPS du port 3001 (l'image expose 3000 en HTTP
et 3001 en HTTPS) :

- dans le `docker run`, ajoute `-p 3001:3001` ;
- dans `.devcontainer/devcontainer.json`, mets `"forwardPorts": [3001]` et
  `"portsAttributes"` sur `"3001"` avec `"protocol": "https"`.

**Onglets Chromium qui crashent**

Ajoute `--security-opt seccomp=unconfined` au `docker run` (dans `postStartCommand` et dans
`scripts/reset-browser.sh`), puis `./scripts/reset-browser.sh`.

**Avant de figer la config**

Verifie les ports et variables d'environnement actuels de l'image dans la doc linuxserver.io :
https://docs.linuxserver.io/images/docker-chromium/

**Le conteneur n'existe plus apres un rebuild**

Un *Rebuild container* recree le codespace : le profil Chromium est perdu, c'est normal.
Le conteneur est recree vide au demarrage suivant.

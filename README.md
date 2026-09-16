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

### Ou lancer les commandes

Trois niveaux sont empiles, ne les confonds pas :

1. **Le codespace** : la machine Linux avec VS Code. C'est ici que vit ce repo et que
   tournent `git` et les scripts. Terminal : menu *Terminal > New Terminal*.
2. **Le conteneur `chromium`** : lance par le codespace, il contient le navigateur.
   Tu n'as normalement jamais besoin d'y entrer.
3. **Chromium** : ce que tu vois dans l'onglet du port 3000.

Toutes les commandes de ce README se lancent au **niveau 1**, dans le terminal VS Code
du codespace. Jamais dans Chromium.

## Piloter un autre PC depuis ce navigateur

Ce Chromium peut servir de rebond vers un service de bureau a distance (Chrome Remote
Desktop ou autre) quand le poste d'ou tu pars bloque ces sites. La chaine devient :
poste de depart > codespace > Chromium > bureau a distance > PC cible.

Pour appliquer un changement de config (clavier, options du conteneur), depuis le
terminal VS Code du codespace :

```bash
git fetch origin <branche>
git checkout <branche>
./scripts/reset-browser.sh
```

Le conteneur est recree : le profil Chromium est perdu, il faut se reconnecter aux comptes.

Deux limites a connaitre :

- **Le clavier.** La disposition du conteneur (`KEYBOARD`) doit correspondre a celle du
  PC cible, sinon les touches sortent decalees. Voir la section Depannage.
- **La latence.** Tu additionnes deux trajets reseau et deux encodages video. Compte
  100 ms au mieux, et baisser la qualite de l'image n'y changera rien : c'est du temps
  de trajet, pas du calcul. Verifie au moins que le codespace est proche de toi avec
  `curl -s ipinfo.io` : en Europe c'est optimal, aux Etats-Unis tu ajoutes deux
  traversees de l'Atlantique. La region se change sur
  https://github.com/settings/codespaces et ne vaut que pour les **nouveaux** codespaces.

## Depannage

**Ecran noir, deconnexions, page qui ne charge pas**

Regarde d'abord les logs : `./scripts/logs.sh`.
Si le probleme persiste, bascule sur l'interface HTTPS du port 3001 (l'image expose 3000 en HTTP
et 3001 en HTTPS) :

- dans le `docker run`, ajoute `-p 3001:3001` ;
- dans `.devcontainer/devcontainer.json`, mets `"forwardPorts": [3001]` et
  `"portsAttributes"` sur `"3001"` avec `"protocol": "https"`.

**Clavier QWERTY quand tu pilotes une autre machine (bureau a distance)**

Le conteneur demarre avec la disposition clavier definie par `KEYBOARD` (ici `fr-fr-azerty`).

Taper directement dans Chromium fonctionne quelle que soit cette valeur : KasmVNC transmet
des caracteres. Mais un client de bureau a distance ouvert dans Chromium transmet des
*positions* de touches, et ces positions viennent de la disposition du conteneur. Si elle
ne correspond pas a celle de la machine pilotee, les touches sortent decalees (a/q, z/w...).

La variable n'est lue qu'a la creation du conteneur. Apres l'avoir changee, lance
`./scripts/reset-browser.sh` : le profil Chromium est perdu, il faut se reconnecter aux comptes.

Valeurs possibles dans la doc linuxserver.io (`de-de-qwertz`, `it-it-qwerty`, ...).

**Onglets Chromium qui crashent**

Ajoute `--security-opt seccomp=unconfined` au `docker run` (dans `postStartCommand` et dans
`scripts/reset-browser.sh`), puis `./scripts/reset-browser.sh`.

**Avant de figer la config**

Verifie les ports et variables d'environnement actuels de l'image dans la doc linuxserver.io :
https://docs.linuxserver.io/images/docker-chromium/

**Le conteneur n'existe plus apres un rebuild**

Un *Rebuild container* recree le codespace : le profil Chromium est perdu, c'est normal.
Le conteneur est recree vide au demarrage suivant.

# Guide : ton navigateur dans le cloud en 10 minutes

Ce repo te donne un **Chromium complet qui tourne sur un serveur GitHub**, que tu pilotes
depuis un onglet de ton navigateur habituel. Le trafic web sort du serveur, pas de ton
poste ni de ton reseau. C'est gratuit dans la limite du quota GitHub (voir plus bas).

Chacun lance **son propre** navigateur, sur **son propre** compte GitHub. Personne ne voit
le navigateur des autres. Tu n'as rien a installer sur ton poste.

---

## 1. Prerequis (une seule fois)

### a. Un compte GitHub

Gratuit : https://github.com/signup

### b. Regler le timeout d'inactivite

Par defaut, GitHub eteint ton navigateur cloud apres **30 minutes** sans interaction.
Passe-le au maximum :

1. Va sur https://github.com/settings/codespaces
2. Section **Default idle timeout** → mets **240** minutes → **Save**

---

## 2. Lancer le navigateur (premiere fois)

1. Ouvre https://github.com/matheobz/cloud-browser
2. Clique le bouton vert **Code** → onglet **Codespaces** → **Create codespace on claude/remote-browser-codespaces-m7yfkt**
3. Une fenetre VS Code s'ouvre dans ton navigateur avec "Setting up your codespace".
   **Attends 5 a 8 minutes** : GitHub installe Docker puis telecharge l'image Chromium (~1 Go).
4. Quand c'est pret, un nouvel onglet s'ouvre tout seul avec Chromium dedans.

Si l'onglet ne s'ouvre pas : dans la fenetre VS Code, en bas, clique l'onglet **Ports**,
puis clique sur l'adresse en face de la ligne **Chromium (3000)** (ou l'icone globe).

Tu te retrouves avec Chromium plein ecran. Utilise-le comme un navigateur normal.

---

## 3. Les fois suivantes

Ne recree pas un codespace a chaque fois, tu perdrais tes cookies et ton historique.

1. Va sur https://github.com/codespaces
2. Clique sur ton codespace `cloud-browser` → il demarre en ~30 secondes
3. L'onglet Chromium s'ouvre (ou onglet **Ports** → adresse du 3000)

Ton profil (sessions ouvertes, historique, favoris) est conserve d'une fois sur l'autre.

---

## 4. Quand tu as fini : ETEINDRE

C'est l'etape la plus importante. Le compteur de quota tourne **tant que le codespace est
allume**, meme si tu ne l'utilises pas.

1. Va sur https://github.com/codespaces
2. A droite de ton codespace, clique **…** → **Stop codespace**

(Fermer l'onglet ne suffit pas. Sans "Stop", il tourne jusqu'au timeout de 4 h.)

---

## 5. Le quota : combien de temps j'ai ?

Compte GitHub gratuit = **120 core-heures par mois**. La machine utilise 2 coeurs, donc
**60 heures de navigateur allume par mois**, soit environ 2 h par jour. Le compteur se
remet a zero chaque mois.

Suivre ta conso : https://github.com/settings/billing/summary → section **Codespaces**.

Quota epuise ? Deux options :
- attendre le reset mensuel ;
- ou accepter de payer le depassement : **0,18 $/h**. Pour ca, Settings → Billing →
  **Spending limits** → Codespaces → mets par exemple 5 $ (= ~28 h de rab). Par defaut la
  limite est a 0 $ : sans la changer toi-meme, tu ne seras **jamais** facture.

Ne cree pas un deuxieme compte GitHub pour contourner : c'est interdit par leurs conditions
et ils ferment les doublons.

---

## 6. Problemes courants

**J'ai ferme Chromium par erreur (croix de la fenetre)**
Rafraichis l'onglet du port 3000. Si tu vois un bureau vide : clic droit sur le fond →
Chromium. Sinon, dans le terminal VS Code (menu ☰ → Terminal → New Terminal) :
`docker restart chromium`. Ton profil est conserve.

**Ecran noir, page blanche ou "connexion refusee"**
Le conteneur n'a pas fini de demarrer. Attends 30 s et rafraichis. Toujours rien ?
Terminal VS Code → `./scripts/logs.sh` : tu dois voir `[ls.io-init] done.` a la fin.

**Bandeau jaune "recovery mode" dans VS Code**
Le conteneur ne s'est pas construit. Terminal → `git pull`, puis `Ctrl+Shift+P` →
**Codespaces: Rebuild Container**. Attends 5-8 min.
Si ca persiste, envoie la sortie de cette commande a Matheo :
`grep -niE "error|fail" /workspaces/.codespaces/.persistedshare/creation.log | tail -20`

**Ca s'eteint pendant que je l'utilise**
Verifie que le timeout est bien a 240 min (section 1b). L'inactivite est mesuree cote
VS Code : garde l'onglet VS Code du codespace ouvert en arriere-plan pendant que tu navigues.

**Je veux repartir d'un profil vierge (tout effacer)**
Terminal VS Code → `./scripts/reset-browser.sh`

**Les onglets Chromium plantent**
Voir la section depannage du [README](README.md) (option `seccomp=unconfined`).

---

## 7. Securite

- Le port 3000 est **prive** : seul ton compte GitHub, connecte, peut y acceder. Ne le
  passe jamais en **Public** dans l'onglet Ports.
- Ce navigateur tourne sur les serveurs GitHub (Microsoft). Ne l'utilise pas pour des
  donnees clients sensibles.
- Un **Rebuild Container** ou une suppression du codespace efface le profil Chromium.
  Ne laisse rien d'irremplacable dedans.

---

## 8. Je veux ma propre copie du repo (optionnel)

Pas necessaire pour l'utiliser. Utile seulement si tu veux modifier la config
(timezone, port HTTPS, etc.) :

1. Sur https://github.com/matheobz/cloud-browser → bouton **Fork** en haut a droite
2. Cree ton codespace depuis **ton** fork (memes etapes qu'en section 2)

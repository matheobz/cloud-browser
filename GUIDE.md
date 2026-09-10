# Ton navigateur dans le cloud

Un Chromium qui tourne chez GitHub, que tu utilises depuis un onglet de ton navigateur.
Gratuit, rien a installer. Chacun a le sien.

## Une seule fois

1. Cree un compte GitHub si tu n'en as pas : https://github.com/signup
2. Va sur https://github.com/settings/codespaces → **Default idle timeout** → mets **240** → Save
   (sinon ca s'eteint au bout de 30 min)

## Premier lancement

1. Ouvre https://github.com/matheobz/cloud-browser
2. Bouton vert **Code** → onglet **Codespaces** → **Create codespace on claude/remote-browser-codespaces-m7yfkt**
3. Attends 5 a 8 minutes (une fenetre VS Code s'affiche, laisse-la faire)
4. Un onglet avec Chromium s'ouvre tout seul

S'il ne s'ouvre pas : en bas de la fenetre VS Code, onglet **Ports** → clique l'adresse sur la ligne **Chromium**.

## Les fois suivantes

Va sur https://github.com/codespaces → clique sur `cloud-browser`. Ca demarre en 30 s,
tes cookies et ton historique sont conserves.

## Quand tu as fini

https://github.com/codespaces → **…** a droite de `cloud-browser` → **Stop codespace**

Sans ca, il tourne jusqu'a 4 h dans le vide et consomme ton quota.

## Quota

**60 heures par mois** de navigateur allume, remis a zero chaque mois.
Suivi : https://github.com/settings/billing/summary

Tu ne seras jamais facture sans l'avoir demande.

## Si ca bug

- **Page blanche ou erreur** : attends 30 s, rafraichis.
- **Tu as ferme Chromium par erreur** : rafraichis l'onglet.
- **Autre** : demande a Matheo.

Ne passe jamais le port en **Public** dans l'onglet Ports.

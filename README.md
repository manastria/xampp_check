# Dépannage de Xampp

## Exécution du Script de Vérification XAMPP (`xampp_check.ps1`)

Le script permet de vérifier si XAMPP est correctement installé et configuré sur votre ordinateur. Il vérifie également si les ports nécessaires sont disponibles. Si le script détecte des problèmes, il vous guidera pour les résoudre.

### **Étape 1 : Copier le Script dans le Répertoire Racine de XAMPP**
Avant tout, vous devez copier le fichier `xampp_check.ps1` dans le répertoire racine de votre installation XAMPP. Par exemple, si XAMPP est installé dans `C:\xampp`, c'est dans ce dossier que le fichier doit être copié.

### **Étape 2 : Exécuter le Script en tant qu'Administrateur**
Pour exécuter le script `xampp_check.ps1`, vous devez le faire en tant qu'administrateur. Voici la méthode la plus simple pour y parvenir :

1. **Ouvrir PowerShell en tant qu'Administrateur :**
   - Cliquez sur le bouton de recherche de la barre des tâches Windows (la loupe ou la barre de recherche à côté du bouton Windows).
   - Tapez `PowerShell`.
   - Dans les résultats de recherche, faites un clic droit sur `Windows PowerShell`.
   - Choisissez `Exécuter en tant qu'administrateur`.
   - Une fenêtre PowerShell s'ouvrira, possiblement vous demandant de confirmer que vous souhaitez autoriser cette application à apporter des modifications à votre appareil. Cliquez sur `Oui`.

2. **Naviguer vers le Répertoire de XAMPP :**
   - Une fois dans PowerShell, naviguez vers le répertoire où vous avez copié le script. Si XAMPP est installé dans `C:\xampp`, tapez la commande suivante et appuyez sur Entrée :
     ```
     cd C:\xampp
     ```

3. **Exécuter le Script :**
   - Maintenant, tapez la commande suivante pour exécuter le script et appuyez sur Entrée :
     ```
     .\xampp_check.ps1
     ```
   - Le script s'exécutera et effectuera les vérifications nécessaires.

### ⚠️ Notes Importantes
- Assurez-vous que vous avez les droits d'administrateur sur votre ordinateur pour pouvoir exécuter PowerShell en tant qu'administrateur.
- Suivez attentivement les instructions affichées par le script.

Si vous rencontrez des difficultés ou des erreurs lors de l'exécution du script, n'hésitez pas à demander de l'aide à votre enseignant.


## Gestion des Sauvegardes et Restauration de MySQL avec XAMPP

### Sauvegarde des Bases de Données avec `mysqldump`

1. **Ouverture de l'Invite de Commande** : Ouvrez l'invite de commande dans le dossier où XAMPP est installé.

2. **Exécution de `mysqldump`** : Utilisez l'outil `mysqldump` pour créer une sauvegarde de toutes vos bases de données. Tapez la commande suivante :

   ```cmd
   mysql\bin\mysqldump.exe -u [username] -p --all-databases > [nom_fichier_de_sauvegarde].sql
   ```

   - Remplacez `[username]` par votre nom d'utilisateur MySQL.
   - `[nom_fichier_de_sauvegarde].sql` est le nom que vous souhaitez donner à votre fichier de sauvegarde.

   Après avoir entré cette commande, vous serez invité à saisir votre mot de passe MySQL.

3. **Importance de la Sauvegarde** : Il est crucial de faire des sauvegardes régulières. Ne pas le faire peut entraîner la perte de vos précieuses données en cas de problème.

### Réinitialisation de MySQL en cas de Corruption

Si votre base de données MySQL est corrompue, suivez ces étapes pour la réinitialiser :

1. **Arrêt de MySQL** : Assurez-vous que MySQL est arrêté. Dans XAMPP, arrêtez MySQL via le panneau de contrôle.

2. **Suppression des Fichiers** : Accédez au dossier `mysql\data\` dans votre installation XAMPP et supprimez les fichiers suivants :
   - `ib_logfile0` et `ib_logfile1` : Ces fichiers enregistrent les transactions InnoDB.
   - `ibdata1` : Ce fichier contient les données et les index des tables InnoDB.

3. **Redémarrage de MySQL** : Redémarrez MySQL via le panneau de contrôle XAMPP. MySQL recréera automatiquement les fichiers supprimés.

### Restauration des Données

Une fois MySQL réinitialisé, vous pouvez restaurer vos bases de données :

1. **Commande de Restauration** : Pour restaurer vos bases de données à partir de la sauvegarde, utilisez :

   ```cmd
   mysql\bin\mysql.exe -u [username] -p < [nom_fichier_de_sauvegarde].sql
   ```

   - Remplacez `[username]` par votre nom d'utilisateur MySQL.
   - `[nom_fichier_de_sauvegarde].sql` est le nom de votre fichier de sauvegarde.

2. **Vérification** : Connectez-vous à MySQL pour vous assurer que vos bases de données ont été restaurées correctement.

### ⚠️ Notes Importantes

- **Sauvegarde Régulière** : N'oubliez pas de sauvegarder régulièrement vos bases de données. C'est votre responsabilité !
- **Prudence avec les Fichiers de Données** : Manipuler les fichiers de données MySQL est une opération délicate. Comprenez bien les étapes avant de les effectuer.
- **Vérifiez vos Sauvegardes** : Assurez-vous que vos sauvegardes sont complètes et peuvent être restaurées correctement.

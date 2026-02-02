# 🚀 EpicCheck - Quick Start Guide

**Ton checker de coding style Epitech prêt à l'emploi en 5 minutes !**

---

## 📦 Ce que tu as reçu

```
epiccheck-1.0.0/
├── 📄 epiccheck                  # Le checker principal (Python script)
├── 📄 README.md                  # Documentation complète
├── 📄 CONTRIBUTING.md            # Guide pour ajouter des règles
├── 📄 RULES.md                   # Liste de toutes les règles (27% implémentées)
├── 📄 Makefile.example           # Exemple d'intégration dans Makefile
├── 📄 .epiccheck.example.yml    # Fichier de config (future feature)
├── 📄 install.sh                 # Script d'installation
├── 📄 test_suite.sh              # Suite de tests automatisés
├── 📄 generate_report.py         # Générateur de rapport HTML
├── 📄 test_good.c                # Exemple de fichier conforme
├── 📄 test_bad.c                 # Exemple avec violations
└── 📄 epiccheck_report.html      # Exemple de rapport généré
```

---

## ⚡ Installation Express (30 secondes)

### Option 1 : Utilisation directe

```bash
# Rendre exécutable
chmod +x epiccheck

# Tester immédiatement
python3 epiccheck .
```

### Option 2 : Installation système

```bash
# Installer dans ton PATH
chmod +x install.sh
./install.sh

# Maintenant tu peux l'utiliser partout
epiccheck .
```

### Option 3 : Installation projet

```bash
# Copier dans ton projet
cp epiccheck mon_projet/
cd mon_projet/
python3 epiccheck .
```

---

## 🎯 Utilisation Basique

### Commandes essentielles

```bash
# Vérifier le dossier actuel
python3 epiccheck .

# Vérifier src/
python3 epiccheck src/

# Vérifier un fichier
python3 epiccheck main.c

# Vérifier plusieurs dossiers
python3 epiccheck src/ include/ lib/

# Aide
python3 epiccheck --help
```

### Comprendre la sortie

#### ✅ Pas de violations
```bash
$ python3 epiccheck test_good.c
✓ All 1 files are compliant!
```

#### ❌ Violations détectées
```bash
$ python3 epiccheck test_bad.c

test_bad.c
  MAJOR [C-G1] test_bad.c:1:1 - Missing or incorrect EPITECH header
  MINOR [C-L2] test_bad.c:6:1 - Tabulation detected (use 4 spaces)
  MAJOR [C-C3] test_bad.c:10:16 - Use of 'goto' is forbidden

✗ Found 20 violation(s) in 1 file(s)
  0 FATAL, 5 MAJOR, 15 MINOR, 0 INFO

# Exit code: 84
```

---

## 🔧 Intégration dans ton projet

### 1. Git Hook (pre-commit)

Créer `.git/hooks/pre-commit` :

```bash
#!/bin/bash
python3 epiccheck src/ include/
exit $?
```

Rendre exécutable :

```bash
chmod +x .git/hooks/pre-commit
```

Maintenant le coding style est vérifié avant chaque commit ! 🎉

### 2. Makefile

Ajouter au Makefile :

```makefile
style:
	@python3 epiccheck src/ include/ || exit 84

# L'intégrer dans 'all'
all: style $(NAME)
```

### 3. GitHub Actions

Créer `.github/workflows/coding-style.yml` :

```yaml
name: Coding Style

on: [push, pull_request]

jobs:
  style:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Check coding style
        run: |
          chmod +x epiccheck
          python3 epiccheck .
```

---

## 📊 Règles actuellement vérifiées

### ✅ Implémentées (11/41 = 27%)

| Code | Description | Gravité |
|------|-------------|---------|
| **C-O2** | Extensions fichiers (.c, .h) | MAJOR |
| **C-G1** | Header Epitech obligatoire | MAJOR |
| **C-G6** | Fins de ligne UNIX | MINOR |
| **C-G7** | Pas d'espaces en fin de ligne | MINOR |
| **C-G8** | Max 1 ligne vide en fin | MINOR |
| **C-F3** | Max 80 colonnes par ligne | MAJOR |
| **C-F4** | Max 20 lignes par fonction | MAJOR |
| **C-L2** | 4 espaces (pas de tabs) | MINOR |
| **C-L3** | Espaces après virgule/opérateurs | MINOR |
| **C-C3** | Interdiction de goto | MAJOR |
| **C-A3** | Newline finale obligatoire | MINOR |

### 🚧 Prochainement

- C-F5 : Max 4 paramètres
- C-O3 : Max 10 fonctions par fichier
- C-V1 : Nommage snake_case
- C-C1 : Profondeur branchement max 3
- Et beaucoup d'autres...

---

## 🎨 Exemples pratiques

### Exemple 1 : Fichier conforme

```c
/*
** EPITECH PROJECT, 2024
** my_project
** File description:
** Main file
*/

#include "my.h"

int add_numbers(int a, int b)
{
    int result = 0;

    result = a + b;
    return result;
}

int main(void)
{
    my_putstr("Hello!\n");
    return 0;
}
```

✅ **Résultat** : `All files are compliant!`

### Exemple 2 : Fichier avec erreurs

```c
// Pas de header !

#include <stdio.h>

int badFunc(int a,int b){  // Accolade mal placée, pas d'espace
	return a+b;  // Tab, pas d'espaces autour de +
}
```

❌ **Résultat** : `5 violations detected`

---

## 🔍 Tests automatisés

### Lancer la suite de tests

```bash
chmod +x test_suite.sh
./test_suite.sh
```

Output :

```
🧪 EpicCheck Test Suite
=======================

Testing C-ALL: Compliant file... ✓ PASS
Testing C-G1: Missing header... ✓ PASS
Testing C-G6: Windows line endings... ✓ PASS
...

=======================
Test Results:
✓ Passed: 12
✗ Failed: 0
=======================

All tests passed!
```

---

## 📈 Générer un rapport HTML

```bash
python3 generate_report.py mon_projet/
```

Ouvre `epiccheck_report.html` dans ton navigateur pour voir :
- Statistiques colorées
- Liste détaillée des violations
- Répartition par gravité
- Design professionnel

Parfait pour les présentations ou le suivi de projet ! 📊

---

## 🛠️ Personnalisation

### Ajouter une nouvelle règle

1. Ouvrir `epiccheck`
2. Ajouter une méthode dans `CFileAnalyzer` :

```python
def check_ma_regle(self):
    """C-XX: Description"""
    for i, line in enumerate(self.lines, 1):
        if condition_violee:
            self.add_violation("C-XX", MAJOR, i, 1, "Message")
```

3. L'ajouter dans `analyze()` :

```python
def analyze(self):
    # ...
    self.check_ma_regle()  # ← AJOUT
    return self.violations
```

Voir `CONTRIBUTING.md` pour plus de détails !

---

## 🐛 Dépannage

### Problème : "Permission denied"

```bash
chmod +x epiccheck
```

### Problème : "python3: command not found"

Installer Python 3 :

```bash
# Ubuntu/Debian
sudo apt install python3

# macOS
brew install python3
```

### Problème : Faux positifs

Certaines règles peuvent avoir des faux positifs. Tu peux :
1. Vérifier manuellement
2. Ouvrir une issue GitHub
3. Contribuer un fix !

---

## 📚 Documentation complète

- `README.md` : Vue d'ensemble et installation
- `CONTRIBUTING.md` : Guide pour contribuer
- `RULES.md` : Liste complète des règles

---

## 🎯 Prochaines étapes

### Pour commencer

1. ✅ Tester `epiccheck` sur ton projet actuel
2. ✅ Corriger les violations détectées
3. ✅ Intégrer dans ton Makefile ou Git hooks

### Pour contribuer

1. ⭐ Star le repo GitHub
2. 🐛 Reporter les bugs
3. ✨ Proposer de nouvelles règles
4. 🚀 Soumettre des Pull Requests

---

## 💡 Astuces Pro

### Ignorer certains fichiers temporairement

```bash
# Vérifier seulement src/, ignorer tests/
python3 epiccheck src/
```

### Utiliser avec grep

```bash
# Voir seulement les MAJOR
python3 epiccheck . | grep MAJOR
```

### Exit codes pour scripts

```bash
if python3 epiccheck .; then
    echo "✅ Style OK, building..."
    make
else
    echo "❌ Fix coding style first!"
    exit 84
fi
```

---

## 🙏 Support

- 📧 Issues GitHub
- 💬 Discussions
- 📖 Documentation complète

---

## 📝 License

MIT - Utilisation libre

---

**Créé avec ❤️ pour faciliter la vie des étudiants Epitech**

🍌 **Happy coding!**

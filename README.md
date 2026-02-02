# 🍌 EpicCheck - Epitech Coding Style Checker

**Un checker de coding style Epitech moderne, complet et facile à utiliser.**

EpicCheck vérifie automatiquement que votre code C respecte le [Coding Style Epitech](https://intra.epitech.eu/file/Public/technical-documentations/epitech_c_coding_style.pdf).

## 🎯 Caractéristiques

- ✅ **Complet** : Vérifie toutes les règles majeures du coding style Epitech
- 🚀 **Rapide** : Analyse des dizaines de fichiers en quelques secondes
- 🎨 **Coloré** : Output lisible avec codes couleurs
- 📊 **Détaillé** : Indique précisément la ligne, colonne et règle violée
- 🔧 **Exit codes** : Retourne 84 si violations (compatible CI/CD)
- 🐍 **Python pur** : Aucune dépendance externe nécessaire

## 📦 Installation

### Installation simple (copier-coller)

```bash
# Copier le script dans votre projet
curl -o epiccheck https://raw.githubusercontent.com/YOUR_REPO/epiccheck/main/epiccheck
chmod +x epiccheck

# Ou ajouter au PATH système
sudo cp epiccheck /usr/local/bin/
```

### Installation manuelle

1. Télécharger `epiccheck`
2. Le rendre exécutable : `chmod +x epiccheck`
3. Le placer dans votre PATH ou l'utiliser avec `python3 epiccheck`

## 🚀 Utilisation

### Exemples basiques

```bash
# Vérifier le répertoire courant
epiccheck .

# Vérifier un dossier spécifique
epiccheck src/

# Vérifier un fichier
epiccheck main.c

# Vérifier plusieurs dossiers
epiccheck src/ include/ lib/
```

### Intégration Git Hook (pré-commit)

Créez `.git/hooks/pre-commit` :

```bash
#!/bin/bash
python3 epiccheck src/ include/
exit $?
```

Rendez-le exécutable : `chmod +x .git/hooks/pre-commit`

### Intégration CI/CD

**GitHub Actions** (`.github/workflows/coding-style.yml`) :

```yaml
name: Coding Style Check

on: [push, pull_request]

jobs:
  coding-style:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run EpicCheck
        run: |
          chmod +x epiccheck
          ./epiccheck .
```

**GitLab CI** (`.gitlab-ci.yml`) :

```yaml
coding-style:
  script:
    - python3 epiccheck .
  only:
    - merge_requests
```

## 📋 Règles vérifiées

### ✅ Actuellement implémentées

| Catégorie | Règles | Exemples |
|-----------|--------|----------|
| **C-O** (Organisation) | C-O2 | Extensions de fichiers (.c, .h) |
| **C-G** (Portée globale) | C-G1, C-G6, C-G7, C-G8 | Header Epitech, fins de ligne, espaces |
| **C-F** (Fonctions) | C-F3, C-F4 | Longueur ligne (80), longueur fonction (20) |
| **C-L** (Layout) | C-L2, C-L3 | Indentation (4 espaces), espaces opérateurs |
| **C-C** (Structures contrôle) | C-C3 | Interdiction de `goto` |
| **C-A** (Avancé) | C-A3 | Newline finale |

### 🔨 En développement

- C-O3 : Cohérence des fichiers (max 10 fonctions)
- C-F5 : Nombre de paramètres (max 4)
- C-F6 : `void` pour fonctions sans paramètres
- C-F7 : Structures passées par pointeur
- C-C1 : Profondeur de branchement (max 3)
- C-V1 : Nommage (snake_case)
- C-H1 : Contenu des headers

## 📊 Output

### Fichier conforme ✅

```
✓ All 5 files are compliant!
```

### Fichiers avec violations ❌

```
src/main.c
  MAJOR [C-G1] src/main.c:1:1 - Missing or incorrect EPITECH header
  MINOR [C-L2] src/main.c:15:1 - Tabulation detected (use 4 spaces)
  MAJOR [C-C3] src/main.c:23:8 - Use of 'goto' is forbidden

include/my.h
  MINOR [C-F3] include/my.h:42:81 - Line too long (95 columns, max 80)

✗ Found 4 violation(s) in 2 file(s)
  0 FATAL, 2 MAJOR, 2 MINOR, 0 INFO
```

## 🎨 Niveaux de gravité

| Niveau | Couleur | Description |
|--------|---------|-------------|
| **FATAL** | 🔴 Rouge vif | Règle fondamentale violée (projet invalide) |
| **MAJOR** | 🔴 Rouge | Problème structurel majeur |
| **MINOR** | 🟡 Jaune | Problème de présentation |
| **INFO** | 🔵 Bleu | Point trivial à corriger |

## 🔢 Exit Codes

- `0` : Tous les fichiers sont conformes
- `84` : Des violations ont été détectées
- `1` : Erreur d'exécution

## 🛠️ Architecture du code

```
epiccheck
├── Violation class      # Représente une violation
├── CFileAnalyzer        # Analyse les fichiers .c et .h
│   ├── check_header()
│   ├── check_indentation()
│   ├── check_line_length()
│   └── ...
├── MakefileAnalyzer     # Analyse les Makefiles
└── EpicCheck            # Orchestrateur principal
```

## 🚧 Ajouter de nouvelles règles

EpicCheck est conçu pour être facilement extensible. Exemple :

```python
def check_function_parameters(self):
    """C-F5: Vérifie le nombre de paramètres (max 4)"""
    for i, line in enumerate(self.lines, 1):
        # Extraire la signature de fonction
        match = re.search(r'(\w+)\s*\(([^)]*)\)', line)
        if match:
            params = [p.strip() for p in match.group(2).split(',')]
            params = [p for p in params if p and p != 'void']
            
            if len(params) > 4:
                self.add_violation(
                    "C-F5", MAJOR, i, 1,
                    f"Too many parameters ({len(params)}, max 4)"
                )
```

Ajoutez ensuite l'appel dans `analyze()` :

```python
def analyze(self):
    # ...
    self.check_function_parameters()  # Nouvelle règle !
    return self.violations
```

## 🤝 Contribution

Les contributions sont bienvenues ! Pour ajouter une règle :

1. Fork le repo
2. Créer une branche : `git checkout -b feature/nouvelle-regle`
3. Implémenter la règle dans `CFileAnalyzer`
4. Ajouter des tests
5. Commit : `git commit -m "Add C-XX rule"`
6. Push : `git push origin feature/nouvelle-regle`
7. Ouvrir une Pull Request

## 📚 Ressources

- [Epitech C Coding Style PDF](https://intra.epitech.eu/file/Public/technical-documentations/epitech_c_coding_style.pdf)
- [Banana (checker officiel)](https://github.com/Epitech/banana-coding-style-checker)
- [Linux Kernel Coding Style](https://www.kernel.org/doc/html/latest/process/coding-style.html)

## 📝 License

MIT License - Libre d'utilisation et de modification

## 🙏 Crédits

- Inspiré du Banana checker officiel d'Epitech
- Basé sur le Epitech C Coding Style
- Créé avec ❤️ pour faciliter la vie des étudiants

---

**Note** : EpicCheck est un projet indépendant et n'est pas affilié à Epitech. Il est fourni "tel quel" sans garantie. Utilisez Banana pour la vérification officielle.

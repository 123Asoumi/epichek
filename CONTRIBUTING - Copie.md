# 🛠️ EpicCheck - Guide de Développement

Ce guide explique comment contribuer à EpicCheck et ajouter de nouvelles règles.

## 📋 Table des matières

1. [Architecture](#architecture)
2. [Ajouter une nouvelle règle](#ajouter-une-nouvelle-règle)
3. [Tester une règle](#tester-une-règle)
4. [Bonnes pratiques](#bonnes-pratiques)
5. [Debugging](#debugging)

## 🏗️ Architecture

### Structure du code

```
epiccheck
├── Violation          # Classe représentant une violation
├── CFileAnalyzer      # Analyseur pour fichiers .c et .h
├── MakefileAnalyzer   # Analyseur pour Makefiles
└── EpicCheck          # Orchestrateur principal
```

### Flux d'exécution

```
1. EpicCheck.run()
   ↓
2. check_path() pour chaque chemin
   ↓
3. Sélection de l'analyseur approprié
   ↓
4. analyzer.analyze()
   ↓
5. Appel de toutes les méthodes check_*()
   ↓
6. Ajout des violations à la liste
   ↓
7. Affichage des résultats
   ↓
8. Exit code (0 ou 84)
```

## ➕ Ajouter une nouvelle règle

### Étape 1: Identifier la règle

Consultez le PDF du coding style Epitech et identifiez :
- **Code de la règle** (ex: C-F5)
- **Catégorie** (C-O, C-G, C-F, C-L, C-C, C-V, C-H, C-A)
- **Gravité** (FATAL, MAJOR, MINOR, INFO)
- **Description** exacte de ce qui est interdit/requis

### Étape 2: Créer la méthode check_*

Dans `CFileAnalyzer`, ajoutez une nouvelle méthode :

```python
def check_ma_nouvelle_regle(self):
    """C-XX: Description courte de la règle"""
    
    for i, line in enumerate(self.lines, 1):
        # Votre logique de vérification ici
        
        if condition_violee:
            self.add_violation(
                "C-XX",                    # Code de la règle
                MAJOR,                     # Gravité
                i,                         # Numéro de ligne
                position_dans_ligne,       # Colonne
                "Message d'erreur clair"   # Description
            )
```

### Étape 3: Activer la règle

Dans la méthode `analyze()` de `CFileAnalyzer`, ajoutez l'appel :

```python
def analyze(self) -> List[Violation]:
    """Lance toutes les vérifications"""
    self.check_header()
    self.check_file_extension()
    # ... autres règles ...
    self.check_ma_nouvelle_regle()  # ← AJOUT ICI
    
    return self.violations
```

## 📝 Exemples de règles

### Exemple 1: C-F5 - Maximum 4 paramètres

```python
def check_function_parameters(self):
    """C-F5: Vérifie le nombre de paramètres (max 4)"""
    
    for i, line in enumerate(self.lines, 1):
        # Regex pour capturer les fonctions
        match = re.search(r'(\w+)\s*\(([^)]*)\)', line)
        
        if match:
            func_name = match.group(1)
            params_str = match.group(2)
            
            # Ignorer les déclarations sans paramètres
            if not params_str.strip() or params_str.strip() == 'void':
                continue
            
            # Compter les paramètres
            params = [p.strip() for p in params_str.split(',')]
            params = [p for p in params if p]  # Enlever les vides
            
            if len(params) > 4:
                self.add_violation(
                    "C-F5", MAJOR, i, 1,
                    f"Function '{func_name}' has {len(params)} parameters (max 4)"
                )
```

### Exemple 2: C-V1 - Nommage snake_case

```python
def check_naming_convention(self):
    """C-V1: Vérifie le nommage (snake_case)"""
    
    for i, line in enumerate(self.lines, 1):
        # Trouver les déclarations de fonctions
        match = re.search(r'\b([a-z_]\w+)\s*\(', line)
        
        if match:
            func_name = match.group(1)
            
            # Vérifier snake_case : minuscules, chiffres, underscores
            if not re.match(r'^[a-z][a-z0-9_]*$', func_name):
                self.add_violation(
                    "C-V1", MINOR, i, match.start(1) + 1,
                    f"Function '{func_name}' doesn't follow snake_case"
                )
```

### Exemple 3: C-F6 - void pour fonctions sans paramètres

```python
def check_void_parameter(self):
    """C-F6: Les fonctions sans params doivent prendre void"""
    
    for i, line in enumerate(self.lines, 1):
        # Chercher fonctions avec parenthèses vides
        match = re.search(r'(\w+)\s*\(\s*\)', line)
        
        if match and not self.is_in_comment(i):
            func_name = match.group(1)
            
            # Ignorer main() qui peut être vide
            if func_name != 'main':
                self.add_violation(
                    "C-F6", MINOR, i, match.start() + 1,
                    f"Function '{func_name}' should take 'void' as parameter"
                )
```

### Exemple 4: C-O3 - Max 10 fonctions par fichier

```python
def check_functions_per_file(self):
    """C-O3: Max 10 fonctions par fichier"""
    
    functions = self.extract_functions()
    
    if len(functions) > 10:
        self.add_violation(
            "C-O3", MAJOR, 1, 1,
            f"Too many functions in file ({len(functions)}, max 10)"
        )
```

## 🧪 Tester une règle

### Créer un fichier de test

```c
// test_c_f5.c - Test pour C-F5 (max 4 params)

/*
** EPITECH PROJECT, 2024
** Test
** File description:
** Test C-F5 rule
*/

// ❌ Cette fonction devrait déclencher C-F5
int too_many_params(int a, int b, int c, int d, int e)
{
    return a + b + c + d + e;
}

// ✅ Celle-ci est OK
int correct_params(int a, int b, int c, int d)
{
    return a + b + c + d;
}
```

### Tester manuellement

```bash
python3 epiccheck test_c_f5.c
```

### Ajouter au test_suite.sh

```bash
cat > "$TEST_DIR/too_many_params.c" << 'EOF'
/*
** EPITECH PROJECT, 2024
** Test
** File description:
** Too many params test
*/

int bad(int a, int b, int c, int d, int e)
{
    return 0;
}
EOF

test_rule "C-F5: Too many parameters" 84 "$TEST_DIR/too_many_params.c"
```

## 📐 Bonnes pratiques

### 1. Messages d'erreur clairs

❌ **Mauvais** :
```python
"Violation detected"
```

✅ **Bon** :
```python
f"Function '{func_name}' has {count} parameters (max 4)"
```

### 2. Précision de la position

Toujours indiquer :
- Le **numéro de ligne** exact
- La **colonne** si possible (position du début de l'erreur)

```python
self.add_violation(
    "C-XX", MAJOR,
    i,                    # Ligne
    match.start() + 1,    # Colonne (début du match)
    "Message"
)
```

### 3. Gérer les faux positifs

```python
# Ignorer les commentaires
if self.is_in_comment(i):
    continue

# Ignorer les strings
if '"' in line or "'" in line:
    # Logique plus fine ici
    pass
```

### 4. Performance

Pour les règles complexes, optimisez :

```python
# ❌ Lent - compile regex à chaque ligne
for line in self.lines:
    if re.search(r'complex_pattern', line):
        pass

# ✅ Rapide - compile une fois
PATTERN = re.compile(r'complex_pattern')
for line in self.lines:
    if PATTERN.search(line):
        pass
```

## 🐛 Debugging

### Afficher des informations de debug

```python
def check_ma_regle(self):
    """..."""
    
    for i, line in enumerate(self.lines, 1):
        # Debug: afficher la ligne traitée
        # print(f"DEBUG L{i}: {line}")
        
        if condition:
            self.add_violation(...)
```

### Tester une seule règle

Commentez les autres dans `analyze()` :

```python
def analyze(self):
    # self.check_header()
    # self.check_indentation()
    self.check_ma_nouvelle_regle()  # Tester seulement celle-ci
    return self.violations
```

### Utiliser un débogueur Python

```bash
python3 -m pdb epiccheck test.c
```

Commandes utiles :
- `n` : next (ligne suivante)
- `s` : step (entrer dans fonction)
- `c` : continue
- `p variable` : afficher variable
- `l` : voir le code autour

## 📊 Catégories de règles

| Préfixe | Catégorie | Exemples |
|---------|-----------|----------|
| **C-O** | Organisation fichiers | C-O1, C-O2, C-O3, C-O4 |
| **C-G** | Portée globale | C-G1, C-G2, C-G3, C-G4, C-G5... |
| **C-F** | Fonctions | C-F1, C-F2, C-F3, C-F4, C-F5... |
| **C-L** | Layout | C-L1, C-L2, C-L3, C-L4, C-L5, C-L6 |
| **C-C** | Structures contrôle | C-C1, C-C2, C-C3 |
| **C-V** | Variables/types | C-V1, C-V2, C-V3 |
| **C-H** | Headers | C-H1, C-H2, C-H3 |
| **C-A** | Avancé | C-A1, C-A2, C-A3, C-A4 |

## 🎯 Roadmap

### Règles prioritaires à implémenter

- [ ] **C-F5** : Max 4 paramètres
- [ ] **C-F6** : void pour fonctions sans params
- [ ] **C-F7** : Structures par pointeur
- [ ] **C-O3** : Max 10 fonctions par fichier
- [ ] **C-V1** : Nommage snake_case
- [ ] **C-C1** : Profondeur branchement max 3
- [ ] **C-H2** : Include guards
- [ ] **C-L4** : Position accolades
- [ ] **C-L5** : Déclarations au début
- [ ] **C-L6** : Ligne vide après déclarations

### Fonctionnalités avancées

- [ ] Support fichier config `.epiccheck.yml`
- [ ] Mode `--fix` pour corrections auto
- [ ] Export JSON des violations
- [ ] Intégration VS Code
- [ ] Cache pour accélérer les re-checks

## 🤝 Pull Request Checklist

Avant de soumettre une PR :

- [ ] La règle est correctement implémentée
- [ ] Des tests ont été ajoutés
- [ ] La documentation est à jour
- [ ] Le code suit PEP 8
- [ ] Tous les tests passent
- [ ] Les messages d'erreur sont clairs

## 📚 Ressources

- [Epitech Coding Style PDF](https://intra.epitech.eu/file/Public/technical-documentations/epitech_c_coding_style.pdf)
- [Regex Python](https://docs.python.org/3/library/re.html)
- [AST Python](https://docs.python.org/3/library/ast.html)
- [PEP 8](https://pep8.org/)

---

**Besoin d'aide ?** Ouvrez une issue sur GitHub ou contactez les mainteneurs ! 🚀

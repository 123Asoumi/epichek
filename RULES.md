# 📊 EpicCheck - Règles Implémentées

Ce document liste toutes les règles du Epitech C Coding Style et leur statut d'implémentation dans EpicCheck.

## Légende

- ✅ **Implémenté** - La règle est vérifiée
- 🚧 **En cours** - Implémentation partielle
- ⏳ **Prévu** - Sera implémenté prochainement
- ❌ **Non implémenté** - Pas encore fait

---

## C-O - Organisation des fichiers

| Règle | Statut | Description | Gravité |
|-------|--------|-------------|---------|
| C-O1 | ⏳ | Contenu du dépôt (pas de .o, .a, ~) | MAJOR |
| C-O2 | ✅ | Extension des fichiers (.c, .h seulement) | MAJOR |
| C-O3 | ⏳ | Cohérence des fichiers (max 10 fonctions) | MAJOR |
| C-O4 | ⏳ | Nommage fichiers/dossiers (snake_case) | MINOR |

**Implémenté : 1/4 (25%)**

---

## C-G - Portée globale

| Règle | Statut | Description | Gravité |
|-------|--------|-------------|---------|
| C-G1 | ✅ | Header de fichier (EPITECH PROJECT) | MAJOR |
| C-G2 | ⏳ | Séparation des fonctions (1 ligne vide) | MINOR |
| C-G3 | ⏳ | Indentation des directives preprocesseur | MINOR |
| C-G4 | ⏳ | Variables globales (à éviter) | MAJOR |
| C-G5 | ⏳ | Directives include (seulement .h) | MINOR |
| C-G6 | ✅ | Fins de ligne (UNIX \\n, pas de \\) | MINOR |
| C-G7 | ✅ | Espaces en fin de ligne (interdits) | MINOR |
| C-G8 | ✅ | Lignes vides début/fin (max 1 à la fin) | MINOR |
| C-G9 | ⏳ | Valeurs constantes (à définir) | INFO |
| C-G10 | ⏳ | Assembleur inline (interdit) | MAJOR |

**Implémenté : 4/10 (40%)**

---

## C-F - Fonctions

| Règle | Statut | Description | Gravité |
|-------|--------|-------------|---------|
| C-F1 | ⏳ | Cohérence des fonctions (une responsabilité) | MAJOR |
| C-F2 | ⏳ | Nommage des fonctions (verbe, snake_case) | MINOR |
| C-F3 | ✅ | Nombre de colonnes (max 80) | MAJOR |
| C-F4 | ✅ | Nombre de lignes (max 20 par fonction) | MAJOR |
| C-F5 | ⏳ | Nombre de paramètres (max 4) | MAJOR |
| C-F6 | ⏳ | Fonctions sans params (doivent prendre void) | MINOR |
| C-F7 | ⏳ | Structures en paramètres (par pointeur) | MAJOR |
| C-F8 | ⏳ | Commentaires dans fonction (interdits) | MINOR |

**Implémenté : 2/8 (25%)**

---

## C-L - Mise en page (layout)

| Règle | Statut | Description | Gravité |
|-------|--------|-------------|---------|
| C-L1 | ⏳ | Contenu d'une ligne (1 statement) | MAJOR |
| C-L2 | ✅ | Indentation (4 espaces, pas de tabs) | MINOR |
| C-L3 | ✅ | Espaces (après virgule, autour opérateurs) | MINOR |
| C-L4 | ⏳ | Accolades (position) | MINOR |
| C-L5 | ⏳ | Déclarations variables (au début) | MINOR |
| C-L6 | ⏳ | Lignes vides (1 après déclarations) | MINOR |

**Implémenté : 2/6 (33%)**

---

## C-C - Structures de contrôle

| Règle | Statut | Description | Gravité |
|-------|--------|-------------|---------|
| C-C1 | ⏳ | Branchements conditionnels (profondeur max 3) | MAJOR |
| C-C2 | ⏳ | Opérateurs ternaires (usage simple) | MINOR |
| C-C3 | ✅ | goto (interdit) | MAJOR |

**Implémenté : 1/3 (33%)**

---

## C-V - Variables et types

| Règle | Statut | Description | Gravité |
|-------|--------|-------------|---------|
| C-V1 | ⏳ | Nommage identifiants (snake_case, UPPER_SNAKE_CASE) | MINOR |
| C-V2 | ⏳ | Structures (cohérentes et petites) | MAJOR |
| C-V3 | ⏳ | Pointeurs (astérisque collé à droite) | MINOR |

**Implémenté : 0/3 (0%)**

---

## C-H - Fichiers header

| Règle | Statut | Description | Gravité |
|-------|--------|-------------|---------|
| C-H1 | ⏳ | Contenu (prototypes, types, etc.) | MAJOR |
| C-H2 | ⏳ | Include guard (#ifndef/#define/#endif) | MAJOR |
| C-H3 | ⏳ | Macros (1 statement, 1 ligne) | MAJOR |

**Implémenté : 0/3 (0%)**

---

## C-A - Avancé

| Règle | Statut | Description | Gravité |
|-------|--------|-------------|---------|
| C-A1 | ⏳ | Pointeurs constants (const) | MINOR |
| C-A2 | ⏳ | Typage (types précis) | MINOR |
| C-A3 | ✅ | Retour à la ligne final (obligatoire) | MINOR |
| C-A4 | ⏳ | static (pour portée limitée) | MINOR |

**Implémenté : 1/4 (25%)**

---

## 📈 Statistiques globales

### Par catégorie

| Catégorie | Implémenté | Total | % |
|-----------|------------|-------|---|
| C-O (Organisation) | 1 | 4 | 25% |
| C-G (Global) | 4 | 10 | 40% |
| C-F (Fonctions) | 2 | 8 | 25% |
| C-L (Layout) | 2 | 6 | 33% |
| C-C (Contrôle) | 1 | 3 | 33% |
| C-V (Variables) | 0 | 3 | 0% |
| C-H (Headers) | 0 | 3 | 0% |
| C-A (Avancé) | 1 | 4 | 25% |
| **TOTAL** | **11** | **41** | **27%** |

### Par gravité

| Gravité | Règles implémentées |
|---------|---------------------|
| FATAL | 0 |
| MAJOR | 4 (C-G1, C-F3, C-F4, C-C3) |
| MINOR | 7 (C-O2, C-G6, C-G7, C-G8, C-L2, C-L3, C-A3) |
| INFO | 0 |

---

## 🎯 Priorités d'implémentation

### 🔥 Haute priorité (impact majeur)

Ces règles sont fréquemment violées et ont un impact important :

1. **C-F5** - Max 4 paramètres (MAJOR)
2. **C-O3** - Max 10 fonctions par fichier (MAJOR)
3. **C-V1** - Nommage snake_case (MINOR mais très fréquent)
4. **C-L1** - 1 statement par ligne (MAJOR)
5. **C-C1** - Profondeur branchement max 3 (MAJOR)

### ⚡ Priorité moyenne

6. **C-F6** - void pour fonctions sans params (MINOR)
7. **C-F7** - Structures par pointeur (MAJOR)
8. **C-L4** - Position accolades (MINOR mais visible)
9. **C-L5** - Déclarations au début (MINOR)
10. **C-H2** - Include guards (MAJOR)

### 📋 Basse priorité (moins fréquent)

11. **C-G4** - Variables globales
12. **C-A1** - Pointeurs const
13. **C-A2** - Typage précis
14. **C-H3** - Macros simples

---

## 🚀 Roadmap

### Version 1.1 (prochaine)
- [ ] C-F5 : Max 4 paramètres
- [ ] C-O3 : Max 10 fonctions par fichier
- [ ] C-V1 : Nommage snake_case
- [ ] C-L1 : 1 statement par ligne

### Version 1.2
- [ ] C-C1 : Profondeur branchement
- [ ] C-F6 : void pour fonctions vides
- [ ] C-L4 : Position accolades
- [ ] C-H2 : Include guards

### Version 2.0 (future)
- [ ] Support fichier config
- [ ] Mode auto-fix
- [ ] Export JSON
- [ ] Plugin VS Code
- [ ] Toutes les règles restantes

---

## 📝 Notes d'implémentation

### Règles complexes

Certaines règles sont difficiles à implémenter de façon fiable sans un parser C complet :

- **C-F1** (cohérence fonctions) - nécessite analyse sémantique
- **C-V2** (cohérence structures) - nécessite compréhension du domaine
- **C-G4** (variables globales) - difficile de différencier const de var

### Approche recommandée

Pour ces règles complexes, nous recommandons une approche en deux phases :

1. **Phase 1** : Détection basique (regex + heuristiques)
2. **Phase 2** : Parser AST complet (avec pycparser ou clang)

---

## 🔗 Références

- [PDF Coding Style Epitech](https://intra.epitech.eu/file/Public/technical-documentations/epitech_c_coding_style.pdf)
- [Banana (checker officiel)](https://github.com/Epitech/banana-coding-style-checker)
- [EpicCheck GitHub](https://github.com/YOUR_REPO/epiccheck)

---

**Dernière mise à jour** : Février 2024
**Version** : 1.0.0

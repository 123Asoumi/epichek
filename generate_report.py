#!/usr/bin/env python3
"""
EpicCheck HTML Report Generator
Génère un rapport HTML des violations de coding style
"""

import sys
import json
import subprocess
from datetime import datetime
from pathlib import Path

HTML_TEMPLATE = """<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EpicCheck Report - {project_name}</title>
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}
        
        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
            min-height: 100vh;
        }}
        
        .container {{
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
        }}
        
        .header {{
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }}
        
        .header h1 {{
            font-size: 2.5em;
            margin-bottom: 10px;
        }}
        
        .header .emoji {{
            font-size: 3em;
        }}
        
        .summary {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            padding: 30px;
            background: #f8f9fa;
        }}
        
        .stat-card {{
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }}
        
        .stat-card .number {{
            font-size: 3em;
            font-weight: bold;
            margin: 10px 0;
        }}
        
        .stat-card .label {{
            color: #666;
            font-size: 0.9em;
            text-transform: uppercase;
        }}
        
        .stat-card.success .number {{ color: #28a745; }}
        .stat-card.danger .number {{ color: #dc3545; }}
        .stat-card.warning .number {{ color: #ffc107; }}
        .stat-card.info .number {{ color: #17a2b8; }}
        
        .content {{
            padding: 30px;
        }}
        
        .file-section {{
            margin-bottom: 30px;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            overflow: hidden;
        }}
        
        .file-header {{
            background: #343a40;
            color: white;
            padding: 15px 20px;
            font-family: 'Courier New', monospace;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }}
        
        .violation {{
            padding: 15px 20px;
            border-bottom: 1px solid #dee2e6;
            display: flex;
            gap: 15px;
            align-items: flex-start;
        }}
        
        .violation:last-child {{
            border-bottom: none;
        }}
        
        .violation:hover {{
            background: #f8f9fa;
        }}
        
        .severity-badge {{
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
            font-size: 0.8em;
            min-width: 70px;
            text-align: center;
        }}
        
        .severity-FATAL {{
            background: #dc3545;
            color: white;
        }}
        
        .severity-MAJOR {{
            background: #fd7e14;
            color: white;
        }}
        
        .severity-MINOR {{
            background: #ffc107;
            color: black;
        }}
        
        .severity-INFO {{
            background: #17a2b8;
            color: white;
        }}
        
        .violation-details {{
            flex: 1;
        }}
        
        .violation-location {{
            color: #6c757d;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            margin-bottom: 5px;
        }}
        
        .violation-message {{
            color: #212529;
        }}
        
        .rule-code {{
            background: #e9ecef;
            padding: 2px 6px;
            border-radius: 3px;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            color: #495057;
        }}
        
        .footer {{
            background: #f8f9fa;
            padding: 20px;
            text-align: center;
            color: #6c757d;
            border-top: 1px solid #dee2e6;
        }}
        
        .no-violations {{
            text-align: center;
            padding: 60px 20px;
            color: #28a745;
        }}
        
        .no-violations .emoji {{
            font-size: 5em;
            margin-bottom: 20px;
        }}
        
        .no-violations h2 {{
            font-size: 2em;
            margin-bottom: 10px;
        }}
        
        @media print {{
            body {{
                background: white;
                padding: 0;
            }}
            
            .container {{
                box-shadow: none;
            }}
        }}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="emoji">🍌</div>
            <h1>EpicCheck Report</h1>
            <p>{project_name}</p>
            <p style="opacity: 0.8; margin-top: 10px;">{date}</p>
        </div>
        
        <div class="summary">
            <div class="stat-card {status_class}">
                <div class="label">Statut</div>
                <div class="number">{status_emoji}</div>
                <div class="label">{status_text}</div>
            </div>
            
            <div class="stat-card">
                <div class="label">Fichiers vérifiés</div>
                <div class="number">{files_checked}</div>
            </div>
            
            <div class="stat-card danger">
                <div class="label">Violations</div>
                <div class="number">{total_violations}</div>
            </div>
            
            <div class="stat-card danger">
                <div class="label">Fatal</div>
                <div class="number">{fatal_count}</div>
            </div>
            
            <div class="stat-card warning">
                <div class="label">Major</div>
                <div class="number">{major_count}</div>
            </div>
            
            <div class="stat-card warning">
                <div class="label">Minor</div>
                <div class="number">{minor_count}</div>
            </div>
            
            <div class="stat-card info">
                <div class="label">Info</div>
                <div class="number">{info_count}</div>
            </div>
        </div>
        
        <div class="content">
            {violations_html}
        </div>
        
        <div class="footer">
            <p>Généré par EpicCheck v1.0.0</p>
            <p style="margin-top: 5px;">
                <a href="https://github.com/YOUR_REPO/epiccheck" style="color: #667eea;">
                    github.com/YOUR_REPO/epiccheck
                </a>
            </p>
        </div>
    </div>
</body>
</html>
"""

def generate_report(project_path: str, output_file: str = "epiccheck_report.html"):
    """Génère un rapport HTML des violations"""
    
    # Lancer epiccheck et capturer la sortie
    print("🔍 Analyse du projet...")
    result = subprocess.run(
        ["python3", "epiccheck", project_path],
        capture_output=True,
        text=True
    )
    
    # Parser la sortie (version simplifiée - à améliorer)
    output = result.stdout
    
    # Extraire les statistiques (parsing basique)
    fatal = output.count("FATAL")
    major = output.count("MAJOR")
    minor = output.count("MINOR")
    info = output.count("INFO")
    total = fatal + major + minor + info
    
    # Déterminer le statut
    if total == 0:
        status_class = "success"
        status_emoji = "✅"
        status_text = "Conforme"
    else:
        status_class = "danger"
        status_emoji = "❌"
        status_text = "Non conforme"
    
    # Générer le HTML des violations
    if total == 0:
        violations_html = """
        <div class="no-violations">
            <div class="emoji">🎉</div>
            <h2>Aucune violation détectée !</h2>
            <p>Votre code respecte le Epitech C Coding Style.</p>
        </div>
        """
    else:
        # TODO: Parser proprement les violations et générer le HTML
        violations_html = f"""
        <div class="file-section">
            <div class="file-header">
                <span>Violations détectées</span>
                <span>{total} violation(s)</span>
            </div>
            <div class="violation">
                <div class="violation-details">
                    <p>Voir la sortie console pour les détails complets.</p>
                    <pre style="background: #f8f9fa; padding: 15px; border-radius: 5px; overflow-x: auto;">
{output}
                    </pre>
                </div>
            </div>
        </div>
        """
    
    # Générer le rapport
    html = HTML_TEMPLATE.format(
        project_name=Path(project_path).name,
        date=datetime.now().strftime("%d/%m/%Y à %H:%M"),
        status_class=status_class,
        status_emoji=status_emoji,
        status_text=status_text,
        files_checked="?",  # TODO: extraire du output
        total_violations=total,
        fatal_count=fatal,
        major_count=major,
        minor_count=minor,
        info_count=info,
        violations_html=violations_html
    )
    
    # Écrire le fichier
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(html)
    
    print(f"✅ Rapport généré : {output_file}")
    return output_file

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 generate_report.py <project_path> [output_file]")
        sys.exit(1)
    
    project = sys.argv[1]
    output = sys.argv[2] if len(sys.argv) > 2 else "epiccheck_report.html"
    
    generate_report(project, output)

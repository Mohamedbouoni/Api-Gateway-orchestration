# Diagram source code for `rapport_stage.pdf`

Regenerable **Mermaid** (`.mmd`) and **PlantUML** (`.puml`) sources for technical figures in the report.  
**Screenshots and logos** are not generated from code — keep the PNGs in `rapport_stage_extracted_images/images/`.

## Export all regenerable diagrams

```powershell
cd rapport_diagram_sources
.\scripts\export-all.ps1
```

Outputs go to `output/png/` with the **same filenames** as in `main.tex` / `main_copy.tex` (copy into `rapport_stage_extracted_images/images/` if needed).

Requirements: **Node.js** (`npx @mermaid-js/mermaid-cli`), **Java** (for PlantUML; the script auto-downloads `tools/plantuml.jar` on first run if `plantuml` is not on PATH).

Copy regenerated PNGs into the report tree:

```powershell
.\scripts\copy-to-report-images.ps1
```

## Index

| Report image | Source | Type |
|--------------|--------|------|
| `sprint1_sequence.png` | `mermaid/sprint1_sequence.mmd` | Mermaid |
| `sprint3_sequence.png` | `mermaid/sprint3_sequence.mmd` | Mermaid |
| `sprint4_sequence.png` | `mermaid/sprint4_sequence.mmd` | Mermaid |
| `end_to_end_orchestration.png` | `mermaid/end_to_end_orchestration.mmd` | Mermaid |
| `Sequence_diagramm.png` | `mermaid/Sequence_diagramm.mmd` | Mermaid |
| `endUser_diagramm.png` | `mermaid/endUser_diagramm.mmd` | Mermaid |
| `admin_sequence_diagramm.png` | `mermaid/admin_sequence_diagramm.mmd` | Mermaid |
| `plugin_pipeline_styled.png` | `mermaid/plugin_pipeline_styled.mmd` | Mermaid |
| `cicd_pipeline.png` | `mermaid/cicd_pipeline.mmd` | Mermaid |
| `k8s_architecture_styled.png` | `mermaid/k8s_architecture_styled.mmd` | Mermaid |
| `architecture_platform.png` | `mermaid/architecture_platform.mmd` | Mermaid |
| `digramme_generale.png` | `mermaid/digramme_generale.mmd` | Mermaid |
| `sprint_velocity.png` | `mermaid/sprint_velocity.mmd` | Mermaid |
| `centrelized.png` | `mermaid/centrelized.mmd` | Mermaid |
| `problem_vs_solution.png` | `mermaid/problem_vs_solution.mmd` | Mermaid |
| `sprint2_class.png` | `plantuml/sprint2_class.puml` | PlantUML |
| `ldm_sprint2.png` | `plantuml/ldm_sprint2.puml` | PlantUML |
| See `static/STATIC_ASSETS.md` | — | PNG only (screenshots, logos, UI) |

## Folder layout

```
rapport_diagram_sources/
  mermaid/          # 15 .mmd sources
  plantuml/         # 2 .puml sources (class + LDM)
  scripts/          # export-all.ps1, copy-to-report-images.ps1
  output/png/       # generated PNGs (git-ignored size; re-run export)
  static/           # list of non-code figures
  tools/            # plantuml.jar (auto-downloaded)
```

## Also in repo

- `../docs/use-case-diagrams/` — three detailed use-case PNGs (not in `main.tex` by default).
- `../ai_orchestration_pipeline.svg` — alternate pipeline sketch (not wired to LaTeX).

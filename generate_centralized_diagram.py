import os
from PIL import Image, ImageDraw, ImageFont

# Canvas parameters
W, H = 1400, 720
background_color = (248, 250, 252) # #f8fafc slate-50

# Create image canvas
img = Image.new("RGBA", (W, H), background_color)
draw = ImageDraw.Draw(img)

# Try loading standard system fonts
try:
    font_title = ImageFont.truetype("arial.ttf", 24)
    font_subtitle = ImageFont.truetype("arial.ttf", 14)
    font_header = ImageFont.truetype("arialbd.ttf", 14)
    font_bold = ImageFont.truetype("arialbd.ttf", 11)
    font_regular = ImageFont.truetype("arial.ttf", 10)
    font_bold_sm = ImageFont.truetype("arialbd.ttf", 9)
    font_arrow = ImageFont.truetype("arialbd.ttf", 10)
except Exception:
    font_title = font_subtitle = font_header = font_bold = font_regular = font_bold_sm = font_arrow = ImageFont.load_default()

# 1. Header block (Centered white card with a subtle border)
title_text = "Deterministic Enterprise AI Orchestration Platform"
subtitle_text = "Zero-Trust Security Perimeter & Multi-Tenant Control Plane"

try:
    title_w = draw.textlength(title_text, font=font_title)
    subtitle_w = draw.textlength(subtitle_text, font=font_subtitle)
except Exception:
    title_w = 520
    subtitle_w = 400

title_x = (W - title_w) // 2
subtitle_x = (W - subtitle_w) // 2

draw.rounded_rectangle([(30, 20), (W-30, 100)], radius=12, fill=(255, 255, 255), outline=(226, 232, 240), width=2)
draw.text((title_x, 30), title_text, fill=(15, 23, 42), font=font_title) # Dark slate
draw.text((subtitle_x, 66), subtitle_text, fill=(100, 116, 139), font=font_subtitle) # Slate-500

# Helper to paste a logo inside a box
def paste_logo(logo_path, cx, cy, max_size=32):
    if os.path.exists(logo_path):
        try:
            logo = Image.open(logo_path).convert("RGBA")
            logo.thumbnail((max_size, max_size))
            lx = cx - logo.width // 2
            ly = cy - logo.height // 2
            mask = logo.split()[3] if len(logo.split()) == 4 else None
            img.paste(logo, (lx, ly), mask)
        except Exception as e:
            print(f"Error rendering logo {logo_path}: {e}")

# Helper to draw a modern column card
def draw_column_card(x, y, w, h, title, ns_label, bg_color, border_color, text_color):
    # Dotted or solid namespace outline
    draw.rounded_rectangle([(x, y), (x+w, y+h)], radius=16, fill=(255, 255, 255), outline=border_color, width=2)
    # Header card inside
    draw.rounded_rectangle([(x+2, y+2), (x+w-2, y+50)], radius=14, fill=bg_color)
    # Title text
    draw.text((x + 16, y + 12), title, fill=text_color, font=font_header)
    draw.text((x + 16, y + 32), ns_label, fill=(100, 116, 139), font=font_regular)

# Helper to draw sub-components inside layers
def draw_sub_box(x, y, w, h, label, subtext="", logo_path=None, has_border=True):
    fill_color = (255, 255, 255)
    border_color = (226, 232, 240) if has_border else (255, 255, 255)
    draw.rounded_rectangle([(x, y), (x+w, y+h)], radius=10, fill=fill_color, outline=border_color, width=1)
    
    # Paste logo if exists
    text_offset = 16
    if logo_path:
        paste_logo(logo_path, x + 24, y + h//2, max_size=24)
        text_offset = 46
        
    # Text labels
    if subtext:
        draw.text((x + text_offset, y + h//2 - 12), label, fill=(15, 23, 42), font=font_bold)
        draw.text((x + text_offset, y + h//2 + 2), subtext, fill=(100, 116, 139), font=font_regular)
    else:
        draw.text((x + text_offset, y + h//2 - 6), label, fill=(15, 23, 42), font=font_bold)

# Helper to draw flow arrows
def draw_flow_arrow(x1, y1, x2, y2, label):
    # Draw arrow line
    draw.line([(x1, y1), (x2, y2)], fill=(30, 41, 59), width=2)
    # Draw arrow head
    draw.polygon([(x2, y2), (x2-8, y2-5), (x2-8, y2+5)], fill=(30, 41, 59))
    # Text label background and text
    try:
        lw = draw.textlength(label, font=font_arrow)
    except Exception:
        lw = len(label) * 6
    cx = (x1 + x2) // 2
    cy = (y1 + y2) // 2
    draw.rectangle([(cx - lw//2 - 4, cy - 8), (cx + lw//2 + 4, cy + 8)], fill=(248, 250, 252))
    draw.text((cx - lw//2, cy - 6), label, fill=(30, 41, 59), font=font_arrow)

# ----------------- LAYER DRAWING -----------------

# Y coordinates for all columns
col_y = 130
col_h = 550
col_w = 230

# Column 1: Client Layer
c1_x = 30
draw_column_card(c1_x, col_y, col_w, col_h, "Client Layer", "User Space (Frontend)", (220, 252, 231), (110, 231, 183), (6, 95, 70)) # Green
draw_sub_box(c1_x + 15, col_y + 70, col_w - 30, 80, "React Frontend", "SPA Client Portal", "images/logos/react.png")
draw_sub_box(c1_x + 15, col_y + 170, col_w - 30, 60, "AI Chat UI", "SSE Token Streams")
draw_sub_box(c1_x + 15, col_y + 250, col_w - 30, 60, "Usage Panel", "Real-time Dashboard")
draw_sub_box(c1_x + 15, col_y + 330, col_w - 30, 190, "Frontend Capabilities", "\n• Real-time Redactions\n• SSE Token Streaming\n• JWT Token Management\n• Dynamic Quota Display\n• Admin Audit Logs\n• Security Policy Indicators", has_border=False)

# Column 2: Edge Security (Kong)
c2_x = 310
draw_column_card(c2_x, col_y, col_w, col_h, "Edge Security", "namespace: ai-gateway", (255, 237, 213), (253, 186, 116), (154, 52, 18)) # Orange
draw_sub_box(c2_x + 15, col_y + 70, col_w - 30, 80, "Kong API Gateway", "High-Speed Router", "images/logos/Kong.png")
draw_sub_box(c2_x + 15, col_y + 170, col_w - 30, 60, "ModSecurity WAF", "OWASP Ruleset")
draw_sub_box(c2_x + 15, col_y + 250, col_w - 30, 60, "JWT Plugin", "Keycloak OIDC Verification")
draw_sub_box(c2_x + 15, col_y + 330, col_w - 30, 60, "OPA Policy Plugin", "Rego Decision Cache")
draw_sub_box(c2_x + 15, col_y + 410, col_w - 30, 60, "Rate Limiting", "Redis-backed Quota Check")

# Column 3: Core Orchestrator (FastAPI)
c3_x = 590
draw_column_card(c3_x, col_y, col_w + 10, col_h, "Orchestration Engine", "namespace: ai-application", (219, 234, 254), (147, 197, 253), (30, 64, 175)) # Blue
draw_sub_box(c3_x + 15, col_y + 70, col_w - 20, 80, "FastAPI Orchestrator", "Async Control Plane", "images/logos/fastapi.png")
draw_sub_box(c3_x + 15, col_y + 165, col_w - 20, 50, "Intent Classifier", "DistilBERT Model")
draw_sub_box(c3_x + 15, col_y + 225, col_w - 20, 50, "PII Inbound Inspector", "Microsoft Presidio Patterns")
draw_sub_box(c3_x + 15, col_y + 285, col_w - 20, 50, "Output Guard", "Real-Time Redaction Engine")
draw_sub_box(c3_x + 15, col_y + 345, col_w - 20, 50, "Dynamic Routing", "Multi-model intent matching")
draw_sub_box(c3_x + 15, col_y + 405, col_w - 20, 50, "Quota Enforcement", "Atomic Redis counters")
draw_sub_box(c3_x + 15, col_y + 465, col_w - 20, 50, "Prompt Injection Shield", "Local heuristic scanner")

# Column 4: Data & Execution
c4_x = 880
draw_column_card(c4_x, col_y, col_w, col_h, "Execution & Data", "namespace: ai-data / execution", (243, 232, 255), (216, 180, 254), (107, 33, 168)) # Purple
draw_sub_box(c4_x + 15, col_y + 70, col_w - 30, 80, "PostgreSQL 15", "RLS Isolation & Sovereign Audits", "images/logos/postgresql.png")
draw_sub_box(c4_x + 15, col_y + 170, col_w - 30, 80, "Redis Data Store", "Atomic Quotas & Intent Cache", "images/logos/redis.png")
draw_sub_box(c4_x + 15, col_y + 270, col_w - 30, 80, "Ollama LLM Runtime", "Local Private Inference", "images/logos/pytorch.png") # PyTorch representing ML runtimes
draw_sub_box(c4_x + 15, col_y + 370, col_w - 30, 150, "Data & AI Safety", "\n• Row-Level Security (RLS)\n• Encrypted DB Credentials\n• Zero SaaS Leakage\n• Local Air-Gapped Models\n• Automated Log Purging\n• Decoupled Storage Pools", has_border=False)

# Column 5: Access & Observability
c5_x = 1140
draw_column_card(c5_x, col_y, col_w, col_h, "Access & Monitoring", "namespace: ai-monitoring / IDP", (207, 250, 254), (103, 232, 249), (21, 94, 117)) # Teal
draw_sub_box(c5_x + 15, col_y + 70, col_w - 30, 80, "Keycloak SSO", "OAuth 2.0 PKCE", "images/logos/keycloak.png")
draw_sub_box(c5_x + 15, col_y + 170, col_w - 30, 80, "Prometheus Server", "Real-Time Metric Scraper", "images/logos/prometheus.png")
draw_sub_box(c5_x + 15, col_y + 270, col_w - 30, 80, "Grafana Dashboards", "Compliance Dashboards", "images/logos/grafana.png")
draw_sub_box(c5_x + 15, col_y + 370, col_w - 30, 150, "Platform Ops Capabilities", "\n• Centralized Identity IAM\n• SSO / Federated Auth\n• Request Latency Scraping\n• Compliance Dashboards\n• Token Quota Analytics\n• WAF Attack Incident Maps", has_border=False)


# ----------------- FLOW ARROWS -----------------

draw_flow_arrow(c1_x + col_w, col_y + 110, c2_x, col_y + 110, "HTTPS (JWT)")
draw_flow_arrow(c2_x + col_w, col_y + 110, c3_x, col_y + 110, "Proxied Req")
draw_flow_arrow(c3_x + col_w + 10, col_y + 110, c4_x, col_y + 110, "Infer/Store")

# Draw feedback/control links (dashed/dotted fine lines)
# Keycloak validation check
draw.line([(c2_x + 15, col_y + 280), (c5_x + 15, col_y + 110)], fill=(148, 163, 184), width=1)
# Observability scraping
draw.line([(c3_x + col_w - 10, col_y + 90), (c5_x + 15, col_y + 210)], fill=(148, 163, 184), width=1)


# Save the final horizontal image
os.makedirs("images", exist_ok=True)
img.save("images/centrelized.png", "PNG")
# Save a copy to the brain folder for chat rendering
brain_dir = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be"
img.save(os.path.join(brain_dir, "centrelized.png"), "PNG")
print("SUCCESS: Generated beautiful high-fidelity horizontal architecture diagram PNG at images/centrelized.png!")

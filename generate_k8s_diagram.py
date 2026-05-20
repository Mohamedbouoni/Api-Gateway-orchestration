import os
from PIL import Image, ImageDraw, ImageFont

# Canvas parameters
W, H = 1300, 950
background_color = (241, 245, 249) # #f1f5f9 slate-100

# Create image canvas
img = Image.new("RGBA", (W, H), background_color)
draw = ImageDraw.Draw(img)

# Try loading standard system fonts
try:
    font_title = ImageFont.truetype("arial.ttf", 24)
    font_subtitle = ImageFont.truetype("arial.ttf", 14)
    font_ns = ImageFont.truetype("arialbd.ttf", 14)
    font_deploy = ImageFont.truetype("arialbd.ttf", 10)
    font_pod = ImageFont.truetype("arialbd.ttf", 9)
    font_port = ImageFont.truetype("arial.ttf", 8)
    font_svc_hdr = ImageFont.truetype("arialbd.ttf", 9)
    font_svc_lbl = ImageFont.truetype("arialbd.ttf", 10)
    font_ext = ImageFont.truetype("arialbd.ttf", 11)
except Exception:
    # Fallback to default
    font_title = font_subtitle = font_ns = font_deploy = font_pod = font_port = font_svc_hdr = font_svc_lbl = font_ext = ImageFont.load_default()

# Header block (Centered white card with a subtle border)
title_text = "Kubernetes Enterprise Topology Map"
subtitle_text = "Horizontal Pod Autoscaling & Secure Namespace Segregation"

# Calculate centered coordinates using draw.textlength()
try:
    title_w = draw.textlength(title_text, font=font_title)
    subtitle_w = draw.textlength(subtitle_text, font=font_subtitle)
except Exception:
    # Safe fallback if textlength is not supported
    title_w = 480
    subtitle_w = 400

title_x = (W - title_w) // 2
subtitle_x = (W - subtitle_w) // 2

# Draw the white card outline and centered text
draw.rounded_rectangle([(20, 20), (W-20, 100)], radius=12, fill=(255, 255, 255), outline=(226, 232, 240), width=2)
draw.text((title_x, 30), title_text, fill=(15, 23, 42), font=font_title) # Dark slate text
draw.text((subtitle_x, 66), subtitle_text, fill=(100, 116, 139), font=font_subtitle) # Slate text

# Helper function to draw a pod
def draw_pod(x, y, name, logo_path, port):
    # Pod border & white body
    draw.rounded_rectangle([(x, y), (x+54, y+80)], radius=12, fill=(255, 255, 255), outline=(203, 213, 225), width=1)
    
    # Load and paste logo
    if os.path.exists(logo_path):
        try:
            logo = Image.open(logo_path).convert("RGBA")
            logo.thumbnail((26, 26))
            # Center logo
            lx = x + (54 - logo.width) // 2
            ly = y + 8
            # Extract alpha channel to use as transparency mask
            mask = logo.split()[3] if len(logo.split()) == 4 else None
            img.paste(logo, (lx, ly), mask)
        except Exception as e:
            print(f"Error rendering logo {logo_path}: {e}")
            
    # Pod Label
    draw.text((x + 12, y + 42), name, fill=(100, 116, 139), font=font_pod)
    
    # Port Pill
    draw.rounded_rectangle([(x+6, y+58), (x+48, y+72)], radius=4, fill=(2, 132, 199))
    draw.text((x + 16, y + 60), port, fill=(255, 255, 255), font=font_port)

# Helper function to draw a deployment box
def draw_deploy(x, y, w, h, title, color):
    # Deployment container
    draw.rounded_rectangle([(x, y), (x+w, y+h)], radius=12, fill=(248, 250, 252), outline=(226, 232, 240), width=2)
    # Circle indicator
    draw.ellipse([(x+12, y+13), (x+20, y+21)], fill=color)
    # Title
    draw.text((x+26, y+11), title, fill=(71, 85, 105), font=font_deploy)

# Helper function to draw a service box
def draw_svc(x, y, w, h, name, type_lbl, port, fill_color, border_color, text_color):
    draw.rounded_rectangle([(x, y), (x+w, y+h)], radius=8, fill=fill_color, outline=border_color, width=2)
    # Port pill
    draw.rounded_rectangle([(x+12, y+10), (x+56, y+22)], radius=4, fill=border_color)
    draw.text((x+22, y+12), port, fill=(255, 255, 255), font=font_port)
    # Service labels
    draw.text((x+12, y+28), type_lbl, fill=text_color, font=font_svc_hdr)
    draw.text((x+12, y+40), name, fill=(51, 65, 85), font=font_svc_lbl)

# Draw Namespace Box helper
def draw_namespace(x, y, w, h, name, title_color):
    # Outer dashed-like outline (drawn solid for crispness, or fine double-outline)
    draw.rounded_rectangle([(x, y), (x+w, y+h)], radius=16, fill=(255, 255, 255), outline=(148, 163, 184), width=2)
    # Title label overlay
    draw.rectangle([(x+24, y-10), (x+200, y+10)], fill=(255, 255, 255))
    draw.text((x+28, y-8), f"Namespace: {name}", fill=title_color, font=font_ns)

# 1. Namespace: ai-gateway (Top-Left)
draw_namespace(20, 130, 600, 350, "ai-gateway", (37, 99, 235))
# DEPLOY: kong-gateway
draw_deploy(40, 160, 260, 120, "DEPLOY: kong-gateway", (37, 99, 235))
draw_pod(60, 190, "POD-1", "images/logos/Kong.png", "8000")
draw_pod(140, 190, "POD-2", "images/logos/Kong.png", "8000")
draw_pod(220, 190, "POD-3", "images/logos/Kong.png", "8000")
# DEPLOY: opa-governance
draw_deploy(320, 160, 260, 120, "DEPLOY: opa-governance", (79, 70, 229))
draw_pod(360, 190, "POD-1", "images/logos/opa.png", "8181")
draw_pod(460, 190, "POD-2", "images/logos/opa.png", "8181")
# Services
draw_svc(40, 300, 260, 60, "svc/kong-ingress", "NodePort Service", "8000", (240, 249, 255), (56, 189, 248), (2, 132, 199))
draw_svc(320, 300, 260, 60, "svc/opa-decision", "ClusterIP Service", "8181", (238, 242, 255), (129, 140, 248), (79, 70, 229))


# 2. Namespace: ai-application (Top-Right)
draw_namespace(660, 130, 620, 350, "ai-application", (5, 150, 105))
# DEPLOY: react-frontend
draw_deploy(680, 160, 260, 120, "DEPLOY: react-frontend", (16, 185, 129))
draw_pod(720, 190, "POD-1", "images/logos/react.png", "5173")
draw_pod(820, 190, "POD-2", "images/logos/react.png", "5173")
# DEPLOY: fastapi-orchestrator
draw_deploy(980, 160, 260, 120, "DEPLOY: fastapi-orchestrator", (20, 184, 166))
draw_pod(1000, 190, "POD-1", "images/logos/fastapi.png", "3000")
draw_pod(1080, 190, "POD-2", "images/logos/fastapi.png", "3000")
draw_pod(1160, 190, "POD-3", "images/logos/fastapi.png", "3000")
# Services
draw_svc(680, 300, 260, 60, "svc/web-ui", "ClusterIP Service", "5173", (240, 253, 244), (52, 211, 153), (5, 150, 105))
draw_svc(980, 300, 260, 60, "svc/orchestrator-backend", "ClusterIP Service", "3000", (240, 253, 250), (45, 212, 191), (13, 148, 136))


# 3. Namespace: ai-data (Bottom-Left)
draw_namespace(20, 500, 600, 310, "ai-data", (147, 51, 234))
# STATEFULSET: postgres-sovereign
draw_deploy(40, 530, 260, 120, "STATEFULSET: postgres-sovereign", (168, 85, 247))
draw_pod(140, 560, "POD-0", "images/logos/postgresql.png", "5432")
# DEPLOY: redis-cache-quota
draw_deploy(320, 530, 260, 120, "DEPLOY: redis-cache-quota", (236, 72, 153))
draw_pod(420, 560, "POD-1", "images/logos/redis.png", "6379")
# Services
draw_svc(40, 670, 260, 60, "svc/db-persistent", "ClusterIP Service", "5432", (250, 245, 255), (192, 132, 252), (147, 51, 234))
draw_svc(320, 670, 260, 60, "svc/redis-cache", "ClusterIP Service", "6379", (253, 244, 245), (244, 114, 182), (219, 39, 119))


# 4. Namespace: ai-monitoring (Bottom-Right)
draw_namespace(660, 500, 620, 310, "ai-monitoring", (234, 88, 12))
# DEPLOY: prometheus-tsdb
draw_deploy(680, 530, 260, 120, "DEPLOY: prometheus-tsdb", (249, 115, 22))
draw_pod(780, 560, "POD-1", "images/logos/prometheus.png", "9090")
# DEPLOY: grafana-visuals
draw_deploy(980, 530, 260, 120, "DEPLOY: grafana-visuals", (234, 179, 8))
draw_pod(1080, 560, "POD-1", "images/logos/grafana.png", "3000")
# Services
draw_svc(680, 670, 260, 60, "svc/prometheus-server", "ClusterIP Service", "9090", (255, 247, 237), (253, 186, 116), (234, 88, 12))
draw_svc(980, 670, 260, 60, "svc/grafana-dashboard", "NodePort Service", "3000", (254, 252, 232), (253, 224, 71), (202, 138, 4))


# Bottom external block: Docker Shared Keycloak Server
draw.rounded_rectangle([(20, 830), (W-20, 920)], radius=12, fill=(255, 255, 255), outline=(226, 232, 240), width=2)

# Paste Docker Logo if possible
docker_logo_path = "images/logos/docker.png"
if not os.path.exists(docker_logo_path):
    # Try downloading it quickly or using a placeholder
    try:
        import urllib.request
        urllib.request.urlretrieve("https://cdn.jsdelivr.net/gh/devicons/devicon/icons/docker/docker-original.png", docker_logo_path)
    except Exception:
        pass

if os.path.exists(docker_logo_path):
    try:
        docker = Image.open(docker_logo_path).convert("RGBA")
        docker.thumbnail((45, 45))
        img.paste(docker, (40, 842), docker)
    except Exception:
        pass

draw.text((100, 845), "External Shared Services Layer", fill=(30, 41, 59), font=font_ext)
draw.text((100, 868), "Dockerized Identity Provider on Host Network Bridge", fill=(100, 116, 139), font=font_subtitle)

# Keycloak Logo
keycloak_logo_path = "images/logos/keycloak.png"
if os.path.exists(keycloak_logo_path):
    try:
        kc = Image.open(keycloak_logo_path).convert("RGBA")
        # Resize to fit nicely
        kc.thumbnail((120, 36))
        img.paste(kc, (W - 320, 842), kc)
    except Exception:
        pass

draw.rounded_rectangle([(W - 170, 845), (W - 80, 865)], radius=4, fill=(100, 116, 139))
draw.text((W - 158, 849), "PORT 8080", fill=(255, 255, 255), font=font_port)
draw.text((W - 170, 875), "Keycloak IAM Server", fill=(30, 41, 59), font=font_subtitle)

# Save the final image
os.makedirs("images", exist_ok=True)
img.save("images/k8s_architecture_styled.png", "PNG")
# Save a copy to the brain folder for chat rendering
brain_dir = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be"
img.save(os.path.join(brain_dir, "k8s_architecture_styled.png"), "PNG")
print("SUCCESS: Generated beautiful high-fidelity Kubernetes multi-namespace architecture diagram PNG!")

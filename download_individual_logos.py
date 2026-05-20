import urllib.request
import ssl
import os

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

logo_urls = {
    "react.png": [
        "https://raw.githubusercontent.com/Marwin1991/profile-technology-icons/main/icons/react.png"
    ],
    "vite.png": [
        "https://raw.githubusercontent.com/Marwin1991/profile-technology-icons/main/icons/vite.png"
    ],
    "huggingface.png": [
        "https://raw.githubusercontent.com/huggingface/notebooks/main/assets/huggingface_logo-noborder.png",
        "https://raw.githubusercontent.com/Marwin1991/profile-technology-icons/main/icons/huggingface.png"
    ],
    "pytorch.png": [
        "https://raw.githubusercontent.com/Marwin1991/profile-technology-icons/main/icons/pytorch.png"
    ],
    "presidio.png": [
        "https://raw.githubusercontent.com/microsoft/presidio/main/docs/assets/presidio-logo-color.png"
    ],
    "kubernetes.png": [
        "https://raw.githubusercontent.com/Marwin1991/profile-technology-icons/main/icons/kubernetes.png"
    ],
    "helm.png": [
        "https://raw.githubusercontent.com/cncf/artwork/main/projects/helm/icon/color/helm-icon-color.png"
    ],
    "prometheus.png": [
        "https://raw.githubusercontent.com/Marwin1991/profile-technology-icons/main/icons/prometheus.png"
    ],
    "grafana.png": [
        "https://raw.githubusercontent.com/Marwin1991/profile-technology-icons/main/icons/grafana.png"
    ]
}

os.makedirs("images/logos", exist_ok=True)
brain_dir = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be"

for filename, urls in logo_urls.items():
    downloaded = False
    for url in urls:
        try:
            req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
            with urllib.request.urlopen(req, context=ctx) as response:
                data = response.read()
                # Save to project folder
                with open(f"images/logos/{filename}", 'wb') as f:
                    f.write(data)
                # Save to brain folder
                with open(os.path.join(brain_dir, filename), 'wb') as f:
                    f.write(data)
                print(f"Successfully downloaded {filename} from {url}")
                downloaded = True
                break
        except Exception as e:
            print(f"Failed to download {filename} from {url}: {e}")
            
    if not downloaded:
        # Create a tiny 1x1 fallback pixel if download fails completely to prevent LaTeX compilation errors
        print(f"WARNING: All fallback URLs failed for {filename}, creating a fallback logo.")
        fallback_data = b'\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x02\x00\x00\x00\x90wS\xde\x00\x00\x00\x0cIDATx\x9cc\xbc\xfd\xff\x7f\x00\x05\xfe\x02\xfe\x15c\xae\xa2\x00\x00\x00\x00IEND\xaeB`\x82'
        with open(f"images/logos/{filename}", 'wb') as f:
            f.write(fallback_data)
        with open(os.path.join(brain_dir, filename), 'wb') as f:
            f.write(fallback_data)

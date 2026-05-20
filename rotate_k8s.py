from PIL import Image
import os

img_path = "images/k8s_architecture_styled.png"
brain_dir = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be"

if os.path.exists(img_path):
    img = Image.open(img_path)
    
    # 1. Rotate 90 degrees counter-clockwise (Standard)
    ccw_img = img.rotate(90, expand=True)
    ccw_img.save(img_path) # Overwrite original with CCW rotated version
    ccw_img.save(os.path.join(brain_dir, "k8s_architecture_styled_ccw.png"))
    
    # 2. Rotate 90 degrees clockwise (Alternative)
    cw_img = img.rotate(270, expand=True)
    cw_img.save("images/k8s_architecture_styled_clockwise.png")
    cw_img.save(os.path.join(brain_dir, "k8s_architecture_styled_cw.png"))
    
    print("SUCCESS: Rotated the Kubernetes Topology Diagram 90 degrees and saved both versions!")
else:
    print(f"Error: {img_path} not found!")

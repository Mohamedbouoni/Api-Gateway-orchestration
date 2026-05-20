import os
import glob
from PIL import Image

temp_dir = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be\\.tempmediaStorage"
img_path = "images/centrelized_archetecture.png"
brain_dir = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be"

# Method 1: Check if file already exists in images/
if os.path.exists(img_path):
    print(f"Found existing file at {img_path}! Rotating...")
    img = Image.open(img_path)
else:
    # Method 2: Get the most recent PNG file in tempmediaStorage
    print("Not found in images. Scanning tempmediaStorage for the latest upload...")
    png_files = glob.glob(os.path.join(temp_dir, "*.png"))
    if not png_files:
        print("No PNG files found in tempmediaStorage!")
        exit(1)
    # Sort by modification time
    latest_file = max(png_files, key=os.path.getmtime)
    print(f"Latest file found: {latest_file} ({os.path.getsize(latest_file)} bytes)")
    img = Image.open(latest_file)

# Rotate 90 degrees counter-clockwise (Standard)
ccw_img = img.rotate(90, expand=True)
os.makedirs("images", exist_ok=True)
ccw_img.save(img_path)
ccw_img.save(os.path.join(brain_dir, "centrelized_archetecture_ccw.png"))

# Also save clockwise alternative
cw_img = img.rotate(270, expand=True)
cw_img.save("images/centrelized_archetecture_clockwise.png")
cw_img.save(os.path.join(brain_dir, "centrelized_archetecture_cw.png"))

print("SUCCESS: Rotated the centrelized_archetecture diagram 90 degrees and saved both versions!")

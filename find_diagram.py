import os
from PIL import Image

temp_dir = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be\\.tempmediaStorage"

if os.path.exists(temp_dir):
    files = [f for f in os.listdir(temp_dir) if f.endswith(".png")]
    print(f"Found {len(files)} png files in tempmediaStorage:")
    for f in sorted(files):
        path = os.path.join(temp_dir, f)
        try:
            with Image.open(path) as img:
                print(f"File: {f} | Size: {os.path.getsize(path)} bytes | Dimensions: {img.width}x{img.height}")
        except Exception as e:
            print(f"Error reading {f}: {e}")
else:
    print("Temp directory does not exist!")

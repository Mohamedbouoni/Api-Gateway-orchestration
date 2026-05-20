from PIL import Image
import os

# The exact original horizontal diagram uploaded by the user today (May 18)
original_path = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be\\.tempmediaStorage\\media_edbdd7ca-9567-4098-a9ef-2d673abdb7be_1779137832286.png"
brain_dir = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be"

if os.path.exists(original_path):
    img = Image.open(original_path)
    
    # 1. Rotate 90 degrees counter-clockwise (Standard)
    ccw_img = img.rotate(90, expand=True)
    ccw_img.save("images/centrelized.png") # Overwrite with correct rotated version
    ccw_img.save(os.path.join(brain_dir, "centrelized_ccw.png"))
    
    # 2. Rotate 90 degrees clockwise (Alternative)
    cw_img = img.rotate(270, expand=True)
    cw_img.save("images/centrelized_clockwise.png")
    cw_img.save(os.path.join(brain_dir, "centrelized_cw.png"))
    
    print("SUCCESS: Rotated the correct original horizontal diagram 90 degrees and saved both versions!")
else:
    print(f"Error: Correct original image not found at {original_path}!")

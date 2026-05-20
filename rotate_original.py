from PIL import Image
import os

original_path = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be\\.tempmediaStorage\\media_edbdd7ca-9567-4098-a9ef-2d673abdb7be_1778935285423.png"
img_path = "images/centrelized.png"

if os.path.exists(original_path):
    img = Image.open(original_path)
    # Rotate 90 degrees counter-clockwise (which is 90)
    rotated_img = img.rotate(90, expand=True)
    rotated_img.save(img_path)
    
    # Save a copy for chat rendering
    brain_dir = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be"
    rotated_img.save(os.path.join(brain_dir, "centrelized.png"))
    print("SUCCESS: Rotated the original architecture diagram 90 degrees counter-clockwise!")
else:
    print(f"Error: Original image not found at {original_path}!")

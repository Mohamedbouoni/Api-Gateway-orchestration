from PIL import Image
import os

img_path = "images/centrelized.png"
if os.path.exists(img_path):
    img = Image.open(img_path)
    # Rotate 90 degrees counter-clockwise (270 for clockwise). Let's do 270 degrees (clockwise) as it's standard for landscape reading in books
    rotated_img = img.rotate(270, expand=True)
    rotated_img.save(img_path)
    
    # Save a copy for chat rendering
    brain_dir = "C:\\Users\\USER\\.gemini\\antigravity\\brain\\edbdd7ca-9567-4098-a9ef-2d673abdb7be"
    rotated_img.save(os.path.join(brain_dir, "centrelized.png"))
    print("SUCCESS: Rotated the architecture diagram 90 degrees clockwise!")
else:
    print("Error: images/centrelized.png not found!")

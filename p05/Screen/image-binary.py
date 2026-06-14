from PIL import Image

def image_to_binary_file(image_path, output_txt_path):
    # 1. Open the original source image
    raw_img = Image.open(image_path)
    
    # 2. Convert to strict 1-bit black/white using an integer 0 to disable dithering
    # This works perfectly across ALL old and new versions of Pillow/PIL
    img_bw = raw_img.convert('1', dither=0)
    
    # 3. Resize it to match your 512x256 target hardware resolution
    img = img_bw.resize((512, 256))
    
    
    with open(output_txt_path, 'w') as f:
        for y in range(256):
            row_bits = ""
            for x in range(512):
                # Pixel value is 0 (black) or 255 (white). 
                # We map 255 -> '1' and 0 -> '0'
                pixel = img.getpixel((x, y))
                row_bits += '1' if pixel > 0 else '0'
            
            # 2. Break the 512-bit row into 32 segments of 16-bit words
            words = [row_bits[i:i+16] for i in range(0, 512, 16)]
            
            # 3. Write them to the file (one 16-bit word per line)
            for word in words:
                f.write(word + '\n')

# How to use:
# 1. Download a great picture of Luffy (like his iconic silhouette or Gear 5)
# 2. Save it as 'luffy.png' in the same folder as this script
# 3. Run the script to generate 'luffy_memory.txt'
image_to_binary_file('luffy.png', 'screen.txt')
print("Successfully generated screen.txt!")
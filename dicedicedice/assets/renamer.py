import os
import glob
import re
def rename_images(folder_path, prefix, start_number=1):
    """
    Rename all images in the specified folder with the given prefix and a sequential number.

    Parameters:
    folder_path (str): The path to the folder containing the images.
    prefix (str): The prefix for the new filenames.
    start_number (int): The starting number for the sequential naming. Default is 1.

    Returns:
    None
    """
    # List of image file extensions to look for
    image_extensions = ['*.jpg', '*.jpeg', '*.png', '*.gif', '*.bmp', '*.tiff']

    # Get a list of all image files in the folder
    image_files = []
    for ext in image_extensions:
        image_files.extend(glob.glob(os.path.join(folder_path, ext)))

    def natural_sort_key(s):
        return [int(text) if text.isdigit() else text.lower() for text in re.split('([0-9]+)', s)]

    # Sort the list using the natural sort key
    image_files.sort(key=natural_sort_key)

    # Rename each file
    for i, file_path in enumerate(image_files, start=start_number):
        # Replace backslashes with forward slashes in the file path
        file_path = file_path.replace('\\', '/')
        # Print the modified file path
        print("'assets/"+file_path+"'"+',')

# Example usage
dice = "d20"
folder_path = dice
prefix = dice
rename_images(folder_path, prefix)

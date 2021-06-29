import cv2

import numpy as np

import matplotlib.pyplot as plt


def getObjects(path):

    # Importing the image and preprocessing the image
    img = cv2.imread(path)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    img = cv2.resize(img, (512,512))

    # Updating the pixels which have a value greater than the minimum with 255 and the others with 0.\
    # Essentially, making a binary representation of the image.
    _, thresh = cv2.threshold(img, np.min(img)+10, 255, cv2.THRESH_BINARY_INV)

    # Locating the continuous closed regions where there is positive gradient across the normal.
    contours, hierarchy = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    objects = str(len(contours))
    
    return thresh, int(objects)

# Processing Image 1
thresh, objects = getObjects('Image-1.jpg')
plt.imshow(thresh)

print("Number of objects = ", objects)


# Processing Image 2
thresh, objects = getObjects('Image-2.jpg')
plt.imshow(thresh)

print("Number of objects = ", objects)
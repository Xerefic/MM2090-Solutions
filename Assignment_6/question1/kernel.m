img = imread("Original.jpg");
imshow(img)

alpha = 1.5;
beta = 0.2*255;
gamma = 1.2;

bright = min(img+beta,255);
contrast = min(img*alpha,255);
correct = min((img/255).^gamma * 255, 255);
invert = 255-img;

imwrite(bright, "Brightened.jpg");
imwrite(contrast, "Contrast.jpg");
imwrite(correct, "Corrected.jpg");
imwrite(invert, "Inverted.jpg");

mod = 255-min( ((alpha*img+beta)/255).^gamma * 255, 255);
imwrite(mod, "Altered.jpg");

detect = [-1,-1,-1;-1,8,-1;-1,-1,-1];

edge = mod;
edge(:,:,1) = conv2(img(:,:,1), detect, "same");
edge(:,:,2) = conv2(img(:,:,2), detect, "same");
edge(:,:,3) = conv2(img(:,:,3), detect, "same");
imwrite(edge, "Detected.jpg");

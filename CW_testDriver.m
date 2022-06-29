%Read the image file
Image = imread('StackNinja1.bmp');

%Call the function to extract nuclei
[BW, Gray] = extractNuclei(Image);

% Show the binary image 
figure;
imshowpair(Gray, Image, 'Montage');
title('Comparison of Extracted Nuclei(Grayscale) Brightness Distribution Vs Original Image');

%Show comparison of original image versus the grayscale image
figure;
imshow(BW);
title('Extracted Regions of Indentified Nuclei');
%%
%Read the image file
Image = imread('StackNinja2.bmp');

%Call the function to extract nuclei
[BW, Gray] = extractNuclei(Image);

% Show the binary image 
figure;
imshowpair(Gray, Image, 'Montage');
title('Comparison of Extracted Nuclei(Grayscale) Brightness Distribution Vs Original Image');

%Show comparison of original image versus the grayscale image
figure;
imshow(BW);
title('Extracted Regions of Indentified Nuclei');
%%
%Read the image file
Image = imread('StackNinja3.bmp');

%Call the function to extract nuclei
[BW, Gray] = extractNuclei(Image);

% Show the binary image 
figure;
imshowpair(Gray, Image, 'Montage');
title('Comparison of Extracted Nuclei(Grayscale) Brightness Distribution Vs Original Image');

%Show comparison of original image versus the grayscale image
figure;
imshow(BW);
title('Extracted Regions of Indentified Nuclei');


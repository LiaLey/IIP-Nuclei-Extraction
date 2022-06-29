function [ExtractedBW, ExtractedGrayscale] = extractNuclei(Image)

%Extract Green colour channel
ImageN = Image(:,:,2);

%Extract Red colour channel
ImageW = Image(:,:,1);

%Enhance image contrast for both nuclei and wall
ImageG = adapthisteq(ImageN);
ImageWall = adapthisteq(ImageW);

%Opening on the contrasted image
se = strel('disk',5);
Graynuclei = imopen(ImageG,se);

%Dilating the cell wall to make it clearer
wed = strel('line',3,4);
GrayWall = imdilate(ImageWall, wed);

%Sharpening the cell wall

h = fspecial('gaussian',3,3.5);
specialfil = imfilter(GrayWall, h, 'replicate');
unsharp_mask = GrayWall - specialfil;
GrayWall = GrayWall + 4*unsharp_mask;
GrayWall = medfilt2(GrayWall);

%imshow(GrayWall);

%Detect edge with the opened image
edgeImage = edge(Graynuclei,'canny');
edgeImage = edgeImage*255;
edgeImage = uint8(edgeImage);

%imshow(edgeImage);

%Increase brightness of the grayscale image if the ori image is too dim
if mean2(ImageN) <= 15
    Graynuclei = Graynuclei*3;
else
    Graynuclei = Graynuclei*2;
end

%Subtract the bright image with the edge and cell wall to visualise the edge boundaries
Graynuclei = Graynuclei*2 - edgeImage - GrayWall;

%Perform opening 
se = strel('disk',3);
Graynuclei = imopen(Graynuclei,se);

%Thresholding to remove some of the outlying pixels from the red channel in
%the background since it isnt zero but has a pixel value of around 20-30
[r, c] = size(Graynuclei);
for x = 1:r
    for y = 1:c
        if Graynuclei(x,y) <= 25
            Graynuclei(x,y) = 0;
        end
    end
end

%Thresholding and conversion to bw binary
T = adaptthresh(Graynuclei, 'Statistic', 'gaussian');
BW = imbinarize(Graynuclei,T);


ExtractedBW = BW;
ExtractedGrayscale = Graynuclei;

%Count the connected components (nuclei)
cc = bwconncomp(BW);
num = cc.NumObjects;
fprintf('Approx. Number of Nuclei: %d\n', num);
disp(cc);

%Display statistics for each connected components in terms of area,
%circularity and perimenter
stats = regionprops('table', BW, 'Area', 'Circularity', 'Perimeter');
disp(stats);


%Histograms showing the distributions of Area and Circularity
figure;
subplot(1,2,1);
area = stats.Area;
histogram(area);
title('Area Distribution (size)');
xlabel('Area');
ylabel('No.of nuclei');

subplot(1,2,2);
circularity = stats.Circularity;
histogram(circularity);
title('Circularity Distribution');
xlabel('Circularity (1.0 for perfect circle)');
ylabel('No.of nuclei');







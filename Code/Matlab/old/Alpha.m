% adc is get from a text files generated by psoc
% adc is an double array of size 3 [3] 
% pixels is an string array of size 3 [3] 
% 
% case (adc[0])
%       in between 0 and range for dark : pixels[0] = 'b1.jpg';
%     in between range for dark and range for gray1 : pixels[0] = 'G11.jpg';
%     in between  range for gray1 and range for gray2 : pixels[0] = 'G22.jpg';
%     in between  range for gray2 and range for white : pixels[0] = 'w11.jpg';
%     endcase
%     
%     case (adc[1])
%      in between 0 and range for dark : pixels[1] = 'b1.jpg';
%     in between range for dark and range for gray1 : pixels[1] = 'G11.jpg';
%     in between  range for gray1 and range for gray2 : pixels[1] = 'G22.jpg';
%     in between  range for gray2 and range for white : pixels[1] = 'w11.jpg';
%     endcase
%     
%     case (adc[2])
%     in between 0 and range for dark : pixels[2] = 'b1.jpg';
%     in between range for dark and range for gray1 : pixels[2] = 'G11.jpg';
%     in between  range for gray1 and range for gray2 : pixels[2] = 'G22.jpg';
%     in between  range for gray2 and range for white : pixels[2] = 'w11.jpg';
%     endcase
%     
%      case (adc[4])
%     in between 0 and range for dark : pixels[4] = 'b1.jpg';
%     in between range for dark and range for gray1 : pixels[3] = 'G11.jpg';
%     in between  range for gray1 and range for gray2 : pixels[3] = 'G22.jpg';
%     in between  range for gray2 and range for white : pixels[3] = 'w11.jpg';
%     endcase
%     
%     now we can assign our images
%     image1 = imread(pixels[0])
%     image2 = imread(pixels[1])
%     image3 = imread(pixels[2])
%     image4 = imread(pixels[3])
%     
% now use code below

%%
% Create a serial object
s = serial("COM1");

% Set the baud rate and other properties
set(s, 'BaudRate', 9600);

% Open the serial port
fopen(s);

% Open the text file for writing
fid = fopen('data.txt', 'w');

% Read data from the serial port and write it to the text file
while 1
    line = fgets(s);
    if isempty(line)
        break;
    end
    fprintf(fid, '%s', line);
end

% Close the serial port
fclose(s);

% Close the text file
fclose(fid);

% Delete the serial object
delete(s);


%%

% Read images
image1 = imread('b1.jpg');
image2 = imread('G11.jpg');
image3 = imread('G22.jpg');
image4 = imread('w11.jpg');

% Determine size of images
[m1, n1, p1] = size(image1);
[m2, n2, p2] = size(image2);
[m3, n3, p3] = size(image3);
[m4, n4, p4] = size(image4);
% Determine height and width of images
height = max([m1, m2, m3,m4]);
width = n1 + n2 + n3 + n4;

% Create a single image to hold all three images
combinedImage = zeros(height, width, 'uint8');

% Copy first image
combinedImage(1:m1, 1:n1, :) = image1;

% Copy second image
combinedImage(1:m2, n1+1:n1+n2, :) = image2;

% Copy third image
combinedImage(1:m3, n1+n2+1:n1+n2+n3, :) = image3;

% Copy fourth image
combinedImage(1:m4, n1+n2+n3+1:n1+n2+n3+n4, :) = image4;

% Display combined image
imshow(combinedImage);

%% 
% Read image file
image23 = imread('g1.jpeg');

% Display image
imshow(image23);


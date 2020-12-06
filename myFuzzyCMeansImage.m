function myFuzzyCMeansImage(imageFile, k)

%Reading imagefile into function
mri = imread(imageFile);

%Casting to double (unneeded but interesting to perform separately)
mriDouble=im2double(mri);

%Saving the image vector array proportions for row and column ; Calculating
%... value for the final reshape value of row x col used to initialize img
%... for future calculations
reshape_value_one = size(mriDouble,1);
reshape_value_two = size(mriDouble,2);
reshape_value_final = reshape_value_one*reshape_value_two;
mriDouble = reshape(mriDouble,reshape_value_final,3);

%Perform function call of fcm with mriDouble and user input val for k ;
%... Calculates coordinates for the center of every cluster as well as 
%... membership values for every data point in U
[centers, U] = fcm(mriDouble, k)

%Create an index that is k by row x col that is populated by zero values
index = zeros(k, reshape_value_final);

%Identify and select only the max values of every column of data (one data
%... point, k membership values) and save that to maxU below
maxU = max(U);

%Classifying data points to their cluster based on maxU value
for i = 1:k
    %Saves the points that belong to the ith cluster to temp
    temp = find(U(i,:) == maxU);
    %Save the points in temp to index at row i by 1 through length(temp) ; 
    %... meaning that for the ith row of index vector, values that are
    %... present in the array are added to the index vector. All other vals
    %... remain zero
    index(i, [1:length(temp)]) = temp;
end

%Show original image for reference
s1 = subplot(4,4,1);
imshow(reshape(mriDouble, reshape_value_one, reshape_value_two, 3));
pause;
delete(s1);

%Grab values from the index that are non-zero and display them on separate
%... subplots
for i = 1:k
    num = nnz(index(i,:));
    sublist = zeros(reshape_value_final,3);
    subpositions = index(i, 1:num);
    sublist(subpositions, :) = mriDouble(subpositions, :);
    subimg = reshape(sublist, reshape_value_one, reshape_value_two, 3);
    subplot(4,4, i);
    imshow(subimg);
    %str = sprintf('Pixel Count: %d', num);
    %title(str)
end

%prompt user to select cluster that contains the tumor cluster
prompt = 'Please enter the cluster that contains the tumourous region (1-k): ';
c = input(prompt);

%Calculate the same data calculated in previous for loop for use in a new
%... figure
fin_num = nnz(index(c,:));
fin_sub = zeros(reshape_value_final,3);
fin_subpos = index(c, 1:fin_num);
fin_sub(fin_subpos, :) = mriDouble(fin_subpos, :);
fin_subimg = reshape(fin_sub, reshape_value_one, reshape_value_two, 3);
gray_fin_subimg = rgb2gray(fin_subimg);

%Display the tumor cluster in a new figure and create a user defined
%... rectangle for use when calculating pixels located in the tumor (more 
%... accurate results are determined this way)
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(4,4,1);
imshow(gray_fin_subimg);
%title('Select top left and bottom right coordinates of tumor region: ');

%Reads in user defined mouse clicks to identify a rectangular object that
%... will bind the tumor. Performs calculations on the user defined section
%... to more accurately calculate the pixel count of the tumor within the
%... image cluster. Then displays the results
% [x, y] = ginput(2);
% x = round(x);
% y = round(y);
% width = x(2,1) - x(1,1);
% height = y(2,1) - y(1,1);
% bbox = [x(1,1) y(1,1) width height];
% pixelVal = [];
% for s = y(1,1):y(2,1)
%     for t = x(1,1):x(2,1)
%         pixelVal = [pixelVal gray_fin_subimg(s, t)];
%     end
% end
% non_zero_vals = nnz(pixelVal);
% str = string(non_zero_vals);
% rectangle('Position', bbox, 'EdgeColor', 'r'), title(str)
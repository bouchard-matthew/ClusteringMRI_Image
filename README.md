# ClusteringMRI_Image
Using FuzzyCMeans Clustering Algorithm to Segment MRI Image to Identify Tumor Region

Usage:
  myFuzzyCMeansImage(MRI_Image, k)
  
  k = number of clusters
  MRI_Image = Color MRI Image (256 x 256 x 3)
  
Execution:
    On execution, the function will calculate the clusters present in the original image
  based on user input and display the original image for visual reference. After, the
  user can strike the return key in the command line of Matlab to continue the execution 
  of the script. The clusters are then displayed in 4 x 4 x i (user defined k value) for use 
  in declaring the cluster that contains the tumorous region. The user is then able
  to select the cluster with the tumor region by declaring the cluster region that 
  contains the tumor region in the command line. This results in the display of the tumor
  cluster with which the user is able to define bounds for which the tumor is located. 
  The bounding box is then iterated through pixel by pixel to count the number of pixels
  that the tumor encompasses. The title of the image is updated with the mentioned number 
  of pixels.

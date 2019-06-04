# Image Recoloring Based on Object Color Distributions
*[Mahmoud Afifi](https://sites.google.com/view/mafifi)*<sup>1</sup>, *[Brian Price](https://www.brianpricephd.com/)*<sup>2</sup>, *[Scott Cohen](https://research.adobe.com/person/scott-cohen/)*<sup>2</sup>, and *[Michael S. Brown](http://www.cse.yorku.ca/~mbrown/)*<sup>1</sup>
<br></br><sup>1</sup>York University  <sup>2</sup>Adobe Research
<br></br>[Project page](http://cvil.eecs.yorku.ca/projects/public_html/image_recoloring)

![main figure](http://cvil.eecs.yorku.ca/projects/public_html/image_recoloring/img/figure.jpg)


### Quick start
1. Run install_p1
2. Run install_p2
3. Go to the `demo` directory and copy your input images to `input_images` directory
4. Run `demo_recoloring`
5. The recolored images will be in the `recolored_images` directory and the generated semantic masks will be in `output_masks` directory. 
6. Run `demo_GUI` for our interactive GUI version.


### Manual installation
1. Install [RefineNet](https://github.com/guosheng/refinenet) for semantic segmentation.
2. Download the trained model for ADE20k dataset. In our experiments, we used the [ResNet-152 model](https://drive.google.com/drive/folders/1UGhqllXOn_qmDhx_3C9aKCoilZGgycFf).
3. Create a directory and name it `SS_CNN`. This directory should contain the `RefineNet` direcotry after installing [RefineNet](https://github.com/guosheng/refinenet) and [MatConvNet](http://www.vlfeat.org/matconvnet/) (prerequisite for RefineNet). For example, the read me file of RefineNet should be located in the following path `SS_CNN/RefineNet/README.md`
4. Use the following matlab code to add paths for our sub-directories:
 ```
        current = pwd;
        addpath([current '/colour-transfer-master']);
        addpath([current '/cp']);
        addpath([current '/emd']);
        addpath([current '/getMask']);
        addpath([current '/recoloring']);
        addpath([current '/general']);
        savepath
```
5. Compile mex files for the Earth Mover's Distance (EMD) files located in the `emd` directory. Use the following Matlab code:
```
        mex EMD1.cpp
        mex EMD2.cpp
        mex EMD3.cpp
```
Be sure that you select MinGW for C++ Mex file compiling. To change it, use the following Matlab command: 
```
        mex -setup C++
```
6. Download [Scene Parsing dataset](http://sceneparsing.csail.mit.edu/) (we only use the training set which includes training images/semantic masks). The dataset should be located in the following path `../ADEChallengeData2016` (assuming you are located in the root directory of our source code). For example, we should be able to read the first training image `ADE_train_00000001.jpg` and its semantic mask by writing the following Matlab code:
```
        I = imread(fullfile('..','ADEChallengeData2016','images','training','ADE_train_00000001.jpg'));
        M = imread(fullfile('..','ADEChallengeData2016','annotations','training','ADE_train_00000001.png'));
```
7. Download our pre-computed data that include the distribution of object color distributions (DoD) from [here](https://ln.sync.com/dl/d47b76bb0/vshj9d85-gny78wxi-3k2m53mp-943h84k6) (also, is available [here](https://drive.google.com/open?id=1zaHi7zDZXiQBwxfedFLM7nuHEHMZ0g-p)). Make sure that you locate the DoD data in the following path `../data/DoD_data` (assuming you are located in the root directory of our source code). For example, we should be able to load the first cluster data by writing the following Matlab code:
```
        load(fullfile('..','data','DoD_data','airplane_clust_1.mat'));
```

### GUI
![GUI Figure](https://drive.google.com/uc?export=view&id=1g7PCa2tT41TXiktsLosDzRmJR3wIbnyG)
Try our GUI version which includes the following features:
1. <b>Semantic mask adjustment:</b> You can adjust the semantic mask in an interactive way (semi-automated and manual adjustments are provided). 
2. <b> Selecting primary object:</b> You can select the primary object to get different results. 

To test it, run `demo_GUI` from the `demo` directory. 



### Publication
Mahmoud Afifi, Brian Price, Scott Cohen, and Michael S. Brown, Image Recoloring Based on Object Color Distributions, Eurographics 2019 - Short Papers, 2019

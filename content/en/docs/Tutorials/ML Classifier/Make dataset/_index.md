---
title: "Make dataset"
description: "Step 01 is to create a dataset"
author: Gary Dalton ([@gfdalton](https://twitter.com/gfdalton))
resources:
- src: "handsigns.png"
  title: "Handsigns for 1, 2, and, 3"
  params:
    byline: ""
slug: ""
image: ""
keywords: ""
date: 2022-06-02
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
weight: 20
---

Making the image dataset is tedious but important. High quality datasets are essential for building a highly performant models. For this tutorial we will use 300 hand sign image files. One hundred for each of rank 1, 2, and 3.

{{< imgproc handsigns Resize "400x" >}}
Example handsigns for 1, 2, and 3.
{{< /imgproc >}}

## Image information

Each image will be a jpg file with a color resolution of 256 x 256. Each image will be labeled with the appropriate rank. In our case we allow only 1 rank per image. Labels are used to help identify components in your data which you want to train your model to identify in datasets that are not labeled.

## Obtaining images

Set your camera to a low resolution (it will still be higher than 256x256) and a 1 to 1 aspect ratio. The aspect ratio gives a square image file. Take photos of the ranking handsigns. These photos should cover a wide range of image angles, hand positions, lighting conditions, different hands, various backgrounds, and varied additional context.

I take my photos on my smartphone and have them auto-upload into Google Photos. From there, I select the set of images and download to my computer as a zip file. Then I delete the images from my phone and Google Photos, to conserve memory.

Create a folder, _../datasets/rank_, and unzip the images to this folder. Now use the _Images_ library in julia to resize or otherwise transform the images.

## Sizing images

With all of the images in the denoted folder, use the following Julia snippet to resize them.

    using Images
    using FileIO
    using Glob

    img_path = "D:/datasets/rank"
    filelist = glob("*.jpg", img_path)

    for item in filelist
        img = load(item)
        img = imresize(img, (256,256))
        save(item, img)
    end

The original files are still available in the zip file but now all of the files have been resized.

## Labeling images

I use [Label Studio](https://labelstud.io/) or alternatively, [CVAT](https://cvat.org/). These are both open source project and there are others you can choose from.

### Install and run Label Studio under Anaconda

* `conda create --name labelimg pip`
* `conda activate labelimg`
* `conda install -c anaconda urllib3`
* `pip install label-studio`
* `label-studio start`

### Label Studio

The previous command should have stated a new browser window into the Label Studio interface. Now create an account and create a new project named Ranks. Once you have created the project, you import the image files into the project. Now open the project and select settings.

We need to set the Labeling interface, so select that tab and browse templates. The template we require is Computer Vision > Object Detection with Bounding Boxes. As you can see, many different templates are available. Now remove the original label choices and add _One, Two, Three, Four, and Five_.

Back up to _Projects / Ranks_ and click _Label All Tasks_. It should now step through the available unlabeled images. Choose the correct label and create a bounding box around the appropriate area in the image, click save. do this until all images are labeled.

### Complete the labeling step

Finally, export a JSON file to our data directory. We will use this file later. Your image data set is now ready for usage.

Log out of and close Label Studio,

* `CTRL-c`
* `conda deactivate`

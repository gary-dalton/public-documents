---
title: "ML Classifier"
description: "A simple classifier to get started in machine learning."
author: Gary Dalton
resources:
- src: "handsigns.png"
  title: "Handsigns for 1, 2, and, 3"
  params:
    byline: ""
slug: ""
image: ""
keywords: ""
date: 2022-06-01
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
weight: 10
---

This simple classifier is an example of a supervised learning model. This means that it learns from a set of labeled images in order to make predictions on new unlabeled images.

The objective of this tutorial is to build a simple image classifier that pulls a rank number of 1, 2, or 3 from a hand sign in a photo. Every step will be covered, including creation of the set of images for learning.

{{< imgproc handsigns Resize "400x" >}}
Handsigns for 1, 2, and 3.
{{< /imgproc >}}

All of the code used for this project will be maintained in the file, handsign-class.jl. This is a Julia language file.

https://web.stanford.edu/class/cs224u/2021/

https://colab.research.google.com/github/deepmind/educational/blob/master/colabs/summer_schools/intro_to_regression.ipynb

https://juliaimages.org/stable/install/

https://datasciencejuliahackers.com/image-classification.html

https://towardsdatascience.com/a-primer-on-computer-vision-with-julia-2c7068a35b32

https://www.kaggle.com/competitions/street-view-getting-started-with-julia/overview/julia-tutorial

https://openai.com/dall-e-2/


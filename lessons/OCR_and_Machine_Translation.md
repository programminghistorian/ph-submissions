---
title: OCR and Machine Translation
collection: lessons
layout: lesson
slug: OCR-and-Machine-Translation
date: LEAVE BLANK
authors: Andrew Akhlaghi
reviewers: LEAVE BLANK
editors: Anna-Maria Sichani
review-ticket: LEAVE BLANK
difficulty: LEAVE BLANK
activity: LEAVE BLANK
topics: LEAVE BLANK
abstract: LEAVE BLANK
---


{% include toc.html %}


# Introduction
This is an article about converting images of text in one language into text files in another language. Perhaps you have wondered, why can Facebook recognize my face but my PDF of a 17th 
century Persian manuscript is not text-searchable? Or maybe a particularly bold student might have asked you, why should I learn a foreign language when Google Translate exists? Indeed, 
[optical character recognition (OCR)](https://en.wikipedia.org/wiki/Optical_character_recognition) and [machine translation](https://en.wikipedia.org/wiki/Machine_translation) APIs (like Google Translate and Bing) promise a world where any text can be translated into any language. This tutorial will give 
you a good idea of how far (or close?) we are to that point. By the end, you will be able to see for yourself that while both OCR and machine translation are imperfect, they can significantly 
expand scholarship, especially in the hands of people who already have an intermediate knowledge of the source and target languages. 

Lesson Goals
--------------
Create a BASH script that:
1. Combines OCR and translation API tools
2. Prompts user to input a folder
3. Loops the OCR and translation tools over all images in a folder


# Setup

## Command Line and BASH 
If you are already comfortable in BASH go ahead and skip to the Acquire the Data step. This tutorial uses the [BASH scripting language](https://en.wikipedia.org/wiki/Bash_(Unix_shell)). If you
are not comfortable with BASH, please take a moment to review the Programming Historian [tutorial](https://programminghistorian.org/en/lessons/intro-to-bash). BASH comes installed on Linux and Mac 
operating systems. The linked Programming Historian tutorial contains instructions for how Windows users can use an emulator to use BASH.

Now it is time for out first command. Open Terminal and enter the command `cd Desktop` to move to the Desktop. Here is where we will do our work.   

## Acquire the Data
For this tutorial, you will use two documents. Download example one [here](https://digitalarchive.wilsoncenter.org/document/120500) and example two 
[here](https://digitalarchive.wilsoncenter.org/document/119105). These documents are part of the Wilson Center Digital Archive's collection on Iran-Soviet relations and are originally from the are from Azerbaijan State Archive of Political Parties and Social Movements. Both documents primarily address the [Iran Crisis of 1946](https://en.wikipedia.org/wiki/Iran_crisis_of_1946). Each document comes with an original scan of the archival document and an English translation. 

Save them both in a new folder on your Desktop. From now on, I will refer to the two article as example one and example two. 
For this exercise, I've chosen two typical Russian language archival documents. Example one has a lot of noise. As you can see, there is writing in different fonts and sizes, as well as errant markings and visible damage to the document. Also, the image is skewed. This is called "noise." While we cannot remove noise all together, we can minimize it by preprocessing the image.
 
## Image Processing 
The most important factor to OCR accuracy is the quality of the image you are using. Once the photo is taken, you cannot increase the resolution. Further, once you have decreased
the resolution of an image, you cannot restore it. This is why you should keep an access and an archive copy of each image. Ideally the archive copy will be a TIFF file, 
because other file formats (notablly JPG) compress the data in such a way that some of the original picture is lost. There's good reason for this. JPG files are MUCH smaller than
TIFF files. This is not neccessarily a problem. If you are working with typewritten documents that are clearly readable, do not worry about this. Your phone's camera 
should be fine. If you work with older, damaged, or handwritten documents, you may need the extra resolution in your pictures. When taking a picture of a document, make
sure you have enough light or the flash is on. Also, avoid taking the photo at a skewed angle. That is, the document should appear straight in the picture. 

There are steps we can take to optimize the image for OCR. The first thing we will need to do is install a free command line tool called ImageMagick. 

### Mac instructions
Mac users will need to install a package manager called Homebrew. The instructions can be found 
[here](https://brew.sh/). 
On MacOS, the instillation requires two simple commands. 
```brew install imagemagick```
```brew install ghostscript``` 

### Windows Instillation 
The Windows instructions for ImageMagick can be found [here](http://imagemagick.sourceforge.net/http/www/windows.html).  


With ImageMagick installed, we can now convert our file from PDF to TIFF, as well as make some changes to the file that may help with OCR. Tesseract will only take image files (JPG, TIFF, PNG),
so PDFs must be converted. The following line will convert the image and make the image easier to OCR:

```convert -density 300 INPUT_FILENAME -depth 8 -strip -background white -alpha off OUTPUT_FILENAME.tiff```

The command does several things. Density and depth both make sure the file has the appropriate DPI for [Tesseract](https://github.com/tesseract-ocr/tesseract/blob/master/README.md). Google maintains Tesseract as free software and released it under the Apache License, Version 2.0 and has an excellent out of the box character recognition rate. However, precprocessing can significantly increase Tesseract's character recognition rate. Strip, background, and alpha make sure that the file has the right background. Most importantly, command converts the PDF into a TIFF image file. If you are not using a PDF, you should still use the above commands to ensure the image is ready for OCR. Your image may also have other problems. For example, they may be askew or have uneven brightness. Fortunately, [ImageMagick](https://imagemagick.org/index.php) is a powerful tool that and help you clean image files. For an idea of other ImageMagick options that help OCR, see this helpful [script](http://www.fmwconcepts.com/imagemagick/textcleaner/index.php). Because OCR is a command line tool, you can write a script that will preprocess all of your images (hundreds or thousands) in a single command.     

# OCR
Tesseeract 4.1 is the best open-source, out-of-the-box OCR program available. Tesseract support over 100 different languages. If you have a particularly difficult or unique script (caligraphy or other handwriting) it might be worth training
your own OCR algorithm. For those of us who deal with type written script, what we want is a program that will recognize a several similar fonts and correclty identify imperfect letters. 
Tesseract 4.1 is just that. Google has already trained an algorithm for dozens of languages. Below are the commands to install Tesseract as well as the Russian language package, which will be 
needed for the rest of the lesson. 
```sudo port install tesseract```
```sudo port install tesseract-rus```

The commands for Tesseract are relatively simple. Just type:
```tesseract INPUT_FILENAME OUTPUT_FILENAME -l rus```
Our output is a plain text file. 

# Translation  
[Translate Shell](https://www.soimort.org/translate-shell/#translate-shell) is a freeware program that allows you to access Google Translate, Bing Translator, Yandex.Translate, and Apertium from the command line. The program allows you to access
the API (application programming interface) to these websites. That means you can use them from the command line and not through a web browser. For this exercise, we are going to use Yandex.
I've selected Yandex because the have a reputation for good Russian-English translation and has a high request limit. While these translation API do not charge per se, they do limit the 
amount you can access from the command line in various ways. For example, there is a limit of 5000 characters for Google Translate per request. So if you send the API a 10,000 character file,
the Google Translate will translate the first 5,000 and stop. If you make too many request in too short an amount of time, they will block your IP for a period. I encourage you to experiment 
to find which translation site works best for you and your text.

To install Translate Shell, you will need to download a file and run it. Enter the command:
```wget git.io/trans```
```chmod +x ./trans```

Using Translate Shell is relatively easy. The line below takes a file, translates it into English, and save the output. 
`trans -e yandex :eng file://INPUT_FILENAME > OUTPUT_FILENAME`

The command `-e` specifies the translator you want to use. 

# Puting it all together with a loop 
Thus far, we have gone over the individual commands to preprocess, OCR, and tranlsate our document. This section will cover how to automate this process and iterate these three
commands over the files in a folder. We are going to write a script using [Nano](https://en.wikipedia.org/wiki/GNU_nano), a command line text editor, save it, and then use it to OCR and 
translate all the files in a folder. 

First, we need to open Nano and learn how to use it. Open Nano by typing `nano` in the command line. Nano is a freeware text editor available on Linux and MacOS. It's very easy to
use, but also has few of the editing feature you would see in Emacs or Vim. You cannot use your cursor in Nano. Instead, you will have to navigate using the arrow keys and `enter`.
Our script will be quite small, so this will not be a problem. When writting longer programs, you should use more advanced text editors.

The first thing you should do is enter the "shebang." This line will tell the computer what language your script is written in. For a BASH script, the line should be: `#!/bin/bash`.

The script we are going to write will have three parts. First, it will prompt you for a folder. Second, it will preprocess, OCR, and translate the images in that folder. Third, it will save the transcriptions and translations to seperate folders.

To incorporate user input, simply add `read -p` followed by what you want the user to see to your program. For example, the following two lines of code will prompt you for the name of a folder on your Desktop and then create a variable containing the full file path of that folder.
```read -p "enter folder name: " folder;```

The folder name you enter is passed to a variable named `folder` and is then passed into the variable `FILES` to complete the filepath.

Next, we need to set up a loop to iterate through all the files in the folder. Go into terminal and open a file in the Nano text editor by typing nano DESIRED_FILENAME.

Then, enter the following script. 
```
for f in $FILES;
do
  tiff=${f%.*}.tiff
  convert -density 300 $f -depth 8 -strip -background white -alpha off $tiff
  ocr=${f%.*}_ocr
  tlate=${f%.*}_trans
  tesseract $tiff $ocr -l rus
  trans -e yandex :eng file://$ocr.txt > $tlate.txt
  sleep 1m
done
```

Most of this code should be familiar. There are three important additions. 
1. One, there is a for loop. The first line creates a new variabel, `f`, that will hold the name of each 
file in our directory. 
2. Two, we use the image file name to create the transcription and translation filenames. The command `${VARIABLE%.*}` takes a file and removes the filename
extension. The `%` command removes a suffix. The `.*` specifies that the suffix is a "." and whatever follows it. 
3. Three, the `sleep 1m` command stops the program from starting the next file for one minute. This allows the previous file to finish being translated and written, as well as spacing out your requests to the translation APIs so they will not
block your IP. You may need to adjust this as APIs change their policies on what constitutes "too many" requests.

Once the file is saved, you need to make it an executable. That is, you need to change the permissions on the file so that it is treated as a script. Enter the command 
`chmod a+x FILENAME`. To execute the file, simply write `./FILENAME`


# What did we just do?
As we look at our output, you will see that machine translation and OCR require significant editing from humans with language of the source and target languages, as well as the
subject being discussed.  

Example one demonstrates how important the underlying image is. The image was both skewed and had significant noise. The pressence of speckles, dark streaks, and uneven or broken lettering 
make it difficult for the program to classify letters. The skew makes it difficult for the program to recognize lines of text. While the image can be rotated, the removal of noise is much 
more difficult. The combination of the two sources of error produces a very poor conversion of the image into text. 
    
Example two demonstrates that even with a good image, your first pass will not be perfect. Example two has some handwritting, but is generally free of noise and is not skewed.  
Even if the conversion of the image into text has relatively few errors, machines may not understand how to correctly translate every word. For example, on the first page of the translation, 
supposedly "owls" are connected with the party. This is because the abbreviation "сов." is short for "советский." However, the translator recognizes it as "сов" for owl. The human reader 
recognizes the period as a sign that the word is an abbreviation and fills in the rest based on context. Even though OCR program correctly interpreted the period, the translator did not 
understand what to do with it. 

The translator also struggles with proper nouns. The first line of the document is correctly rendered as "Товарищу МОЛОТОВУ В.М." However, it is translated as ```Comrade Hammer.``` Like many 
Soviet leaders, Molotov used a pseudonym. which literally means hammer. The name should be translated as "Molotov." 

Another problem are the hyphens at the end of lies. While Tesseract correctly recognizes the hyphens, neither Tesseract nor Yandex understand their purpose. While the hyphen tells 
the reader to follow the word onto the next line, both programs treat the two halves as seperate words. Obviously you can delete  One way to deal with this is to 
create a small [regex](https://programminghistorian.org/en/lessons/cleaning-ocrd-text-with-regular-expressions) to deal with this. The next steps will be text and user specific. You will have 
to look through the text and find any patterns of errors or go through and correct errors one by one. Even though we did the same things to both images, example two produces a much more 
faithful transcription and translation.

However, the translation and transcription of example two still contain many errors. The results for example one are barely intelligible. But a human reader, sufficently fluent in Russian,
could still read both with relative ease. Even someone with a basic understanding of the Russian alphabet could still correctly identify the letters. So, what use is OCR and machine translation
to you? 
 
# Conclusion 
While limited, the combination of OCR and machine translation can be a powerful tool for researchers. At the most basic level, we have a lot of the vocabulary in the document translated. For 
an intermediate student, having the majority of vocabulary in an article is a huge help. They can use grammar, context, and what other words they know to translate the rest of the article. We 
also have a sense of what these documents are about. We now understand the subject matter, but not the details. If this were a larger work, we could use the initial translation to scan the book
for potentially relevant passages. While the program helps human translators, the initial translations are of limited use.   

Our script does not produce a translation that can be quoted in an article or a transcription file that can be used with a text analysis algorithm. With this in mind, you should note that OCR 
and machine translation do not neccessarily save time. As you have seen, making a 100% transcription requires significant effort after you run Tesseract. What the script does offer is a way to
magnify existing language knowledge and help process large numbers of archival documents. 

 

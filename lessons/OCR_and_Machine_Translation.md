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
This is an article about the benefits of integrating digital techniques into humanities research. Many of my fellow historians are sceptical of investing time into learning digital techniques because they do not see the benefit to their research. But we all live in a world where our digital reach often exceeds our grasp. Researchers can access thousands of pages from online digital collections or use their cellphones to capture thousands of pages of archival documents in a single day. But access to this volume and variety of documents also presents problems. Managing and organizing thousands of image files is difficult to do using a [graphical user interface](https://en.wikipedia.org/wiki/Graphical_user_interface). Further, while access to documents relies less on geographic proximity, the language a text is written in restores borders. Access to documents does not equal understanding. However, command line tools offer us solutions to these common problems. Simple [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) scripts can make organizing and editing image files much easier. Combining [optical character recognition (OCR)](https://en.wikipedia.org/wiki/Optical_character_recognition) and [machine translation](https://en.wikipedia.org/wiki/Machine_translation) APIs (like Google Translate and Bing) promises a world where all text is keyword searchable and translated. Even if the particular programs demonstrated in this lesson are not of interest to you, the power of [scripting](https://en.wikipedia.org/wiki/Scripting_language) will be. Combining multiple command line tools, and designing projects with them in mind, is essential to making digital tools work for you.    

Lesson Goals
--------------
1. Learn how to prepare documents for OCR 
2. Create a Bash script that will prepare, OCR, and translate all documents in a folder 
3. Learn how make scripts to organize and edit your documents
4. Understand the limitations of OCR and machine translation 

# Setup

## Command Line and BASH 
This tutorial uses the [BASH scripting language](https://en.wikipedia.org/wiki/Bash_(Unix_shell)). If you are not comfortable with BASH, please take a moment to review the Programming Historian [tutorial](https://programminghistorian.org/en/lessons/intro-to-bash). BASH comes installed on Linux and Mac operating systems. The linked Programming Historian tutorial contains instructions for how Windows users can use an emulator to use BASH.

Now it is time for our first command. Open Terminal and enter the command `cd Desktop` to move to the Desktop. Here is where we will do our work.   

## Acquire the Data
For this tutorial, you will use two documents. Download example one [here](https://digitalarchive.wilsoncenter.org/document/120500) and example two 
[here](https://digitalarchive.wilsoncenter.org/document/119105). These documents are part of the Wilson Center Digital Archive's collection on Iran-Soviet relations and are originally from the Azerbaijan State Archive of Political Parties and Social Movements. Both documents are in Russian and primarily address the [Iran Crisis of 1946](https://en.wikipedia.org/wiki/Iran_crisis_of_1946). I selected these documents for two reason. One, the documents are high quality scans, but have errors common to many archival documents. Two, each document comes with an English translation, so we will be able to judge the fidelity of our machine translations. 

Save both example documents in a new folder on your Desktop. From now on, I will refer to the two articles as example one and example two. Example one has a lot of noise. As you can see, there is writing in different fonts and sizes, errant markings, and visible damage to the document. Also, the image is skewed. These unwanted variations in color and brightness are called [noise](https://en.wikipedia.org/wiki/Image_noise). While we cannot remove noise all together, we can minimize it by preprocessing the image.
 
## Image Processing 
The most important factor to OCR accuracy is the quality of the image you are using. Once the photo is taken, you cannot increase the resolution. Further, once you have decreased the resolution of an image, you cannot restore it. This is why you should keep an access and an archive copy of each image. Ideally the archive copy will be a TIFF file, because other file formats (notably JPG) compress the data in such a way that some of the original picture quality is lost. Consequently, JPG files are MUCH smaller than TIFF files. This is not neccessarily a problem. If you are working with typewritten documents that are clearly readable, do not worry about this. If you work with older, damaged, or handwritten documents, you may need the extra resolution in your pictures. When taking a picture of a document, make sure you have enough light or the flash is on. Also, avoid taking the photo at a skewed angle. That is, the document should appear straight in the picture. 

But often we are stuck with images that have signifcant noise. For example, we cannot remove damage to the original document. 
There are steps we can take to optimize the image for OCR and improve the accuracy rate. The first thing we will need to do is install a free command line tool called ImageMagick. 

### Mac Instillation 
Mac users will need to install a package manager called Homebrew. The instructions can be found 
[here](https://brew.sh/). 
On MacOS, the instillation requires two simple commands. 
```brew install imagemagick```
```brew install ghostscript``` 

### Windows Instillation 
The Windows instructions for ImageMagick can be found [here](http://imagemagick.sourceforge.net/http/www/windows.html).  

### ImageMagick and OCR 
With ImageMagick installed, we can now convert our files from PDF to TIFF and make some changes to the files that will help increase our OCR accuracy. OCR programs will only take image files (JPG, TIFF, PNG), so you must convert PDFs. The following line will convert a PDF and make it easier to OCR:

```convert -density 300 INPUT_FILENAME.pdf -depth 8 -strip -background white -alpha off OUTPUT_FILENAME.tiff```

The command does several things that significantly increase the OCR accuracy rate. The `density` and `depth` commands both make sure the file has the appropriate [DPI](https://en.wikipedia.org/wiki/Dots_per_inch) for OCR. The `strip`, `background`, and `alpha` commands make sure that the file has the right background. Most importantly, this line of commands converts the PDF into a TIFF image file. If you are not using a PDF, you should still use the above commands to ensure the image is ready for OCR. 

After these changes, your image may still have problems. For example, they may be askew or have uneven brightness. Fortunately, [ImageMagick](https://imagemagick.org/index.php) is a powerful tool that can help you clean image files. For an idea of other ImageMagick options that can help OCR, see this helpful [collection of scripts](http://www.fmwconcepts.com/imagemagick/textcleaner/index.php). Because OCR is a command line tool, you can write a script that will loop over over all of your images (hundreds or thousands) at once. You will learn how to do this later in the lesson.      

# OCR
This lesson will use the OCR program Tesseract. [Tesseeract 4.1](https://github.com/tesseract-ocr/tesseract) is the best open-source, out-of-the-box OCR program available. Google maintains Tesseract as free software and released it under the Apache License, Version 2.0. Tesseract supports over 100 different languages. If you have a particularly difficult or unique script (caligraphy or other handwriting) it might be worth training your own OCR algorithm. But for those of us who deal with type written documents, what we want is a program that will recognize several similar fonts and correclty identify imperfect letters. Tesseract 4.1 does just that. Google has already trained Tesseract to recognize a variety of fonts for dozens of languages. Below are the commands to install Tesseract as well as the Russian language package, which you will need for the rest of the lesson. 
```sudo port install tesseract```
```sudo port install tesseract-rus```

Windows instillation instructions can be found [here](https://github.com/UB-Mannheim/tesseract/wiki).

The commands for Tesseract are relatively simple. Just type:
```tesseract INPUT_FILENAME OUTPUT_FILENAME -l rus```
Our output is a plain text file in English.

# Translation  
[Translate Shell](https://www.soimort.org/translate-shell/#translate-shell) is a freeware program that allows you to access Google Translate, Bing Translator, Yandex.Translate, and Apertium from the command line. The program allows you to access
the API to these websites. That means you can use them from the command line and not through a web browser. For this exercise, we are going to use Yandex. I selected Yandex because they have a reputation for good Russian-English translation and a high request limit. While translation APIs do not charge per se, they do limit the amount you can access from the command line in various ways. For example, there is a limit of 5000 characters per request for Google Translate. So if you send the [API](https://en.wikipedia.org/wiki/Application_programming_interface) a 10,000 character file, Google Translate will translate the first 5,000 and stop. If you make too many requests in too short an amount of time, the API will temporarily block your IP address. You will need to experiment to find which translation API works best for you and your text.

To install Translate Shell, you will need to download a file and run it. Enter the command
```wget git.io/trans```
and then 
```chmod +x ./trans```

Using Translate Shell is relatively easy. The line below takes a file, translates it into English, and saves the output. 
`trans -e yandex :eng file://INPUT_FILENAME > OUTPUT_FILENAME`

The command `-e` specifies the translator you want to use. 

# Putting it all together with a loop 
Thus far, we have gone over the individual commands to preprocess, OCR, and tranlsate our documents. This section will cover how to automate this process with a script and iterate commands over all the files in a folder.

First, we need to open [Nano](https://en.wikipedia.org/wiki/GNU_nano) and begin writing our script. Nano is a freeware text editor available on Linux and MacOS. It is very easy to use, but has few of the editing feature you would see in [Emacs](https://en.wikipedia.org/wiki/Emacs) or [Vim](https://en.wikipedia.org/wiki/Vim_(text_editor)). You cannot use your cursor in Nano. Instead, you will have to navigate using the arrow keys and `enter`. Our script will be quite small, so the limited editing features of Nano will not be a problem. When writting longer programs, you should use more advanced text editors. Open Nano by typing `nano DESIRED_FILENAME` in the command line.

The first thing you should do is enter the [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)). This line will tell the computer what language your script is written in. For a BASH script, the line should be `#!/bin/bash`.

The script we are going to write will have three parts. First, it will prompt you for a folder. Second, it will prepare, OCR, and translate the images in that folder. Third, it will save the transcriptions and translations to seperate folders.

To incorporate user input, simply add `read -p` followed by a prompt for the user. For example, the following two lines of code will prompt you for the name of a folder on your Desktop and then create a variable containing the full file path of that folder.
```
read -p "enter folder name: " folder;
FILES=/Users/andrewakhlaghi/Desktop/test_dir/$folder/*
```
The folder name you enter is passed to a variable named `folder` and is then passed into the variable `FILES` to complete the filepath.

Next, we need to set up a loop to iterate through all the files in the folder. 

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
1. One, there is a loop. The first line creates a new variabel, `f`, that will hold the name of each 
file in our directory. 
2. Two, we use the image file name to create the transcription and translation filenames. The command `${VARIABLE%.*}` takes a file and removes the file extension. The `%` command removes a suffix. The `.*` specifies that the suffix is a "." and whatever follows it. 
3. Three, the `sleep 1m` command stops the program from starting the next file for one minute. This allows the previous file to finish being translated and written, as well as spacing out your requests to the translation APIs so they will not
block your IP. You may need to adjust the sleep time as APIs change their policies on what constitutes "too many" requests.

The third and final bloc of code will create two folders for your transcriptions and translations. Then it will move all the transcriptions to one folder and all the translations to another folder. 
```
mkdir $folder"_ocr"
mkdir $folder"_translation"
mv *_ocr.txt *_ocr
mv *_trans.txt *_translation
```

Add all three blocs together in your Nano file. Remember to include the correct shebang at the top of the script. Once the file is saved, you need to make it an executable. That is, you need to change the permissions on the file so that it is treated as a script. Enter the command `chmod a+x FILENAME`. To execute the file, simply write `./FILENAME`

# Results
As we look at our output, you will see that machine translation and OCR require significant editing from someone with knowledge of the source and target languages, as well as the subject being discussed.  

The results for example one demonstrate how important the underlying image is. The image of example one is both skewed and has significant noise. The pressence of speckles, dark streaks, and broken lettering make it difficult for the program to classify letters. The skew makes it difficult for the program to recognize lines of text. The combination of the two sources of error produces a very poor transcription. 

{% include figure.html filename="http://programminghistorian.github.io/ph-submissions/images/OCR-and-Machine-Translation/OCR_and_MachineTranslation1.jpg" caption="Our transcription of example one" %}

The results for example two demonstrates that even with a good image, your first transcription and translation will have errors. Example two has some errant handwritting, but is generally free of noise and is not skewed. Even if the conversion of the image into text has relatively few errors, machines may not understand how to correctly translate every word. For example, the translation of example two's second page has the sentence, "The party's connection to the owls." (see figure two) This is because the abbreviation "сов." is short for "советский" (Soviet). However, the translator recognized the abbreviation as "сов" for owl. The human reader can recognize the period as a sign that the word is an abbreviation and fills in the rest of the word based on context. Even though OCR program correctly transcribed the period, the translator did not understand what to do with it. 

{% include figure.html filename="http://programminghistorian.github.io/ph-submissions/images/OCR-and-Machine-Translation/OCR_and_MachineTranslation2.jpg" caption="The owl sentece in Russian" %}

{% include figure.html filename="http://programminghistorian.github.io/ph-submissions/images/OCR-and-Machine-Translation/OCR_and_MachineTranslation2_5.jpg" caption="The owl sentece in translated" %}

Another problem with the sentence is hyphens. While Tesseract correctly transcribed the hyphens, neither Tesseract nor Yandex understood their purpose. While the hyphen tells the reader to follow the word onto the next line, both programs treated the two halves as seperate words. Obviously you can delete the hyphens individually, but that is tedious. One way to deal with this is to create a small [regex](https://programminghistorian.org/en/lessons/cleaning-ocrd-text-with-regular-expressions) to delete the hyphen and join the two lines.

In addition to the hyphen and the abbreviation, Tesseract identified two "а"'s as "@"'s in our sentence about owls. Considering [email](https://en.wikipedia.org/wiki/Email) did not exist until the early 1960's, it is safe to assume that all "@"'s in the document are incorrectly identified as "а"'s. Therefore we can either use a regex or your text edit's Find and Replace function to make the substitutions. 

You can also use the Bash command [sed](https://en.wikipedia.org/wiki/Sed) to edit your document. For example, the `sed` script `sed s/@/а/g DOCUMENT.txt` will find all '@' characters and replace them with 'а'. 

If a sentence ends in a hyphen, the `sed` script below will delete the hyphen and join the two lines. 

```sed -e :a -e '/-$/N; s/-\n//; ta' INPUT.txt```

{% include figure.html filename="http://programminghistorian.github.io/ph-submissions/images/OCR-and-Machine-Translation/OCR_and_MachineTranslation3.jpg" caption="Our passage after a little editing" %}

Much like the other commands show above, you can keep a list of `sed` commands in a longer script and run them over every document you OCR. 

After making the above edits, put your edited transcription back through the translation API. Look at the imporvement to the sentence about owls. You can see how a few edits can radically improve the quality of our translations. 

{% include figure.html filename="http://programminghistorian.github.io/ph-submissions/images/OCR-and-Machine-Translation/OCR_and_MachineTranslation4.jpg" caption="Your improved translation" %}
 
# Other Possibilities with Scripting and ImageMagick 

## Editing your Documents with ImageMagick

Scripting can also help edit the images themselves. You already learned how to use ImageMagick to prepare a file for OCR. ImageMagick has many more options for editing images. Looking at example one, you will want to do three things. One, you will want to crop the picture and remove the excess border space around the document. Two, you will want to straighten the image so that the lines of text are parralel to the bottom of the document. Three, you will want to remove all the noise, especially the dark specks, that appears throughout the document. All three of these tasks can be scripted.

Cropping commands will be specific to each document. There are programs that can detect and cut around text. However those smartcropping programs are significantly more complicated and are outside the scope of this tutorial. Fortunately, smartcropping is also probably unnecessary for editing your archival documents. When you take photos of documents, you probably do so from the same angle and height. The relative position of the text in different photos will be similar. Consequently, you will want to trim similar amounts of the image from similar relative locations in the photograph to isolate the text. Remember, your cropped document does not need to be perfect for Tesseract to work. But removing any marginal notes or discolorations will increase the accuracy of the OCR. After some experimentation, you will find that you want to remove 200 pixels from the top of the document, 250 pixels from the right, 250 pixels from the bottom, and 800 pixels from the left of example one.

The script below allows you to crop and deskew every document in a given folder. 
```
#!/bin/bash 
read -p "enter folder name: " folder;

FILES=/FILE_PATH/$folder/*
for f in $FILES;
do
  convert $f -gravity north -chop 0x200 -gravity east -chop 250x0 -gravity south -chop 0x800 -gravity west -chop 800x0 $f
  convert $f -deskew 80% $f
done 
```
The second command will deskew each picture as well. That is, the `deskew` command will make sure that the body of the text is parallel with the bottom of the page. Remember, the `chop` commands will remove the specified amounts of pixels regardless of if there is text on them. Therefore, you will want to be careful about the contents of the folder you use with this script. This script will not only remove the same amount from the same location on each picture, it will also save over the original picture with the edited version. To avoid saving over the original, simply change the second `$f`. For example, if your files were named in the IMG_xxxx.jpg format, you would replace the second `$f` with `${f%.*}_EDITED.jpg`. This will remove the filename extension from the filename for each file and insert “EDITED.jpg” to distinguish the edited versions.   

A final useful script will reduce noise in the image. As discussed above, noise refers to unwanted variations in the brightness and color of digital media. In the case of example one, we can see a large number of black dots of varying size and shape splattered all over the document. This could be the result of problems with the copying device or damage to the original document. The ImageMagick `despeckle` command detects and reduces these dots. However, the `despeckle` command has no [parameters](https://en.wikipedia.org/wiki/Parameter_(computer_programming)). To meaningfully decrease the size of the spots on document one, you will have to repeatedly run the `despeckle` command on your file. Rewriting commands over and over would be tedious. Luckily, we can write a script that will repeat the command multiple times for us.

```
#!/bin/bash
read -p "enter file name: " fl;
convert $fl -despeckle -despeckle -despeckle -despeckle -despeckle $fl
```
This script will take the provided file name and perform the `despeckle` operation on it five times. The output will replace the original input file. As before, make sure the you are in the correct [working directory](https://en.wikipedia.org/wiki/Working_directory). The file you specify must be in your working directory. 

This is what example one will look like after cropping, deskewing, and repeated despeckling. 
{% include figure.html filename="http://programminghistorian.github.io/ph-submissions/images/OCR-and-Machine-Translation/OCR_and_MachineTranslation5.jpg" caption="The new and improved version of example one" %}

## Organize your documents
Scripting can also help you organize your documents. For example, a common problem for archival work is managing and organizing the thousands of images taken during an archival trip. Perhaps the biggest problem is cataloguing files by archival location. Digital cameras and smartphones assign photos a filename that looks something like IMG_xxxx.jpg. This filename does not tell you where that picture came from or what it contains. Instead, you might want each picture to be labeled according to the archive where it was taken. You can use a file's [metadata](https://en.wikipedia.org/wiki/Metadata) to write a script that renames files according to their archive. 

This script will compare a file's last modify date to the date of your visit to an archive and rename the file accordingly. 

```
#!/bin/bash 
read -p "enter archive name: " $archive_name;
read -p "enter  date of visit: " $visit;

ls -lt | awk '{if ($6$7==$visit) print $9}' >> list.txt
mkdir $archive_name

for i in $(cat list.txt);
do 
  mv $i $archive_name/$archive_name${i:3}; 
done
```

This will rename all files last modified on August 30th to`[ARCHIVE_NAME_INPUT]_XXXX.jpg`.
 
# Conclusion 
This lesson has focused on how to combine different command line tools to improve how you do research. No single program or script will revolutionize your research. Rather, learning how to combine a variety of different tools can radically alter how you use files and what files you are able to use. This lesson used the BASH scripting language to string tools together, but you can pick from a variety of different programming languages to create your own work flows. More important than learning how to use any particular command is learning how to conduct your research to make the most of digital tools. 

Knowing the capabilities and limitations of digital tools will help you conduct your research to get the maximum use out of them. For example, knowing the importance of image quality will help you chose how to capture images of documents. Further, knowing the limitations of ImageMagick's `crop` command will emphasize the importance of taking uniform pictures of documents.

Even if you are uninterested in OCR and machine translation, scripting offers you something. The ability to move and rename files can help you manage your research. While the command line tools I have demonstrated here may not be of interest to you, there are likely command line tools that will interest you. This article has given you the introduction to scripting and workflow you need to really begin using digital humanities tools. 


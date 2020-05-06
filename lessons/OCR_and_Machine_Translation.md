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
This is an article about the benefits of integrating simple digital techniques into humanities research. Many of my fellow historians are sceptical of investing time in learning digital techniques because they do not see the benefit to their research. But we all live in a world where our digital reach often exceeds our grasp. Researchers can access thousands of pages from online digital collections or use their cellphones to capture thousands of pages of archival documents in a single day. But access to this volume and variety of documents also presents problems. Managing and organizing thousands of image files is difficult to do using a [graphical user interface](https://en.wikipedia.org/wiki/Graphical_user_interface). Further, while access to documents relies less on geographic proximity, the language a text is written in restores borders. Access to documents does not equal understanding. However, [optical character recognition (OCR)](https://en.wikipedia.org/wiki/Optical_character_recognition) and [machine translation](https://en.wikipedia.org/wiki/Machine_translation) APIs (like Google Translate and Bing) promise a world where all text is keyword searchable and translated. This tutorial will give you a good idea of how far (or close?) we are to that point. By the end, you will be able to see for yourself that while both OCR and machine translation are imperfect, they can significantly expand scholarship, especially in the hands of people who already have an intermediate knowledge of the source and target languages. At the very least, you will know some simple scripts that will make organizing your research documents easier. 

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
[here](https://digitalarchive.wilsoncenter.org/document/119105). These documents are part of the Wilson Center Digital Archive's collection on Iran-Soviet relations and are originally from the are from Azerbaijan State Archive of Political Parties and Social Movements. Both documents are in Russian and primarily address the [Iran Crisis of 1946](https://en.wikipedia.org/wiki/Iran_crisis_of_1946). I selected these documents for two reason. One, the documents are good quality scans, but have errors common to many archival documents. Two, because each document comes with an original scan of the archival document and an English translation, we will be able to judge the fidelity of our machine translations. 

Save both example documents in a new folder on your Desktop. From now on, I will refer to the two article as example one and example two. Example one has a lot of noise. As you can see, there is writing in different fonts and sizes, errant markings, and visible damage to the document. Also, the image is skewed. These unwanted variations in color and brightness are called [noise](https://en.wikipedia.org/wiki/Image_noise). While we cannot remove noise all together, we can minimize it by preprocessing the image.
 
## Image Processing 
The most important factor to OCR accuracy is the quality of the image you are using. Once the photo is taken, you cannot increase the resolution. Further, once you have decreased the resolution of an image, you cannot restore it. This is why you should keep an access and an archive copy of each image. Ideally the archive copy will be a TIFF file, because other file formats (notablly JPG) compress the data in such a way that some of the original picture is lost. There's good reason for this. JPG files are MUCH smaller than TIFF files. This is not neccessarily a problem. If you are working with typewritten documents that are clearly readable, do not worry about this. Your phone's camera should be fine. If you work with older, damaged, or handwritten documents, you may need the extra resolution in your pictures. When taking a picture of a document, make sure you have enough light or the flash is on. Also, avoid taking the photo at a skewed angle. That is, the document should appear straight in the picture. 

There are steps we can take to optimize the image for OCR. The first thing we will need to do is install a free command line tool called ImageMagick. 

### Mac instructions
Mac users will need to install a package manager called Homebrew. The instructions can be found 
[here](https://brew.sh/). 
On MacOS, the instillation requires two simple commands. 
```brew install imagemagick```
```brew install ghostscript``` 

### Windows Instillation 
The Windows instructions for ImageMagick can be found [here](http://imagemagick.sourceforge.net/http/www/windows.html).  

### ImageMagick and OCR 
With ImageMagick installed, we can now convert our file from PDF to TIFF, as well as make some changes to the file that will help increase our OCR accuracy. OCR programs will only take image files (JPG, TIFF, PNG), so you must convert PDFs. The following line will convert the image and make it easier to OCR:

```convert -density 300 INPUT_FILENAME -depth 8 -strip -background white -alpha off OUTPUT_FILENAME.tiff```

The command does several things. Density and depth both make sure the file has the appropriate [DPI](https://en.wikipedia.org/wiki/Dots_per_inch) for OCR. However, precprocessing can significantly increase the OCR accuracy rate. The `strip`, `background`, and `alpha` commands make sure that the file has the right background. Most importantly, this line of commands converts the PDF into a TIFF image file. If you are not using a PDF, you should still use the above commands to ensure the image is ready for OCR. Your image may also have other problems. For example, they may be askew or have uneven brightness. Fortunately, [ImageMagick](https://imagemagick.org/index.php) is a powerful tool that and help you clean image files. For an idea of other ImageMagick options that help OCR, see this helpful [collection of scripts](http://www.fmwconcepts.com/imagemagick/textcleaner/index.php). Because OCR is a command line tool, you can write a script that will preprocess all of your images (hundreds or thousands) at once. You will learn how to do this later in the lesson.      
# OCR
This lesson will use the OCR program Tesseract. Tesseeract 4.1 is the best open-source, out-of-the-box OCR program available. Google maintains Tesseract as free software and released it under the Apache License, Version 2.0. Tesseract supports over 100 different languages. If you have a particularly difficult or unique script (caligraphy or other handwriting) it might be worth training your own OCR algorithm. But for those of us who deal with type written documents, what we want is a program that will recognize several similar fonts and correclty identify imperfect letters. Tesseract 4.1 does just that. Google has already trained Tesseract to recognize a variety of fonts for dozens of languages. Below are the commands to install Tesseract as well as the Russian language package, which you will need for the rest of the lesson. 
```sudo port install tesseract```
```sudo port install tesseract-rus```

Windows instillation instructions can be found [here](https://github.com/UB-Mannheim/tesseract/wiki).

The commands for Tesseract are relatively simple. Just type:
```tesseract INPUT_FILENAME OUTPUT_FILENAME -l rus```
Our output is a plain text file in English.

# Translation  
[Translate Shell](https://www.soimort.org/translate-shell/#translate-shell) is a freeware program that allows you to access Google Translate, Bing Translator, Yandex.Translate, and Apertium from the command line. The program allows you to access
the API to these websites. That means you can use them from the command line and not through a web browser. For this exercise, we are going to use Yandex. I've selected Yandex because the have a reputation for good Russian-English translation and a high request limit. While these translation API do not charge per se, they do limit the amount you can access from the command line in various ways. For example, there is a limit of 5000 characters per request for Google Translate. So if you send the API a 10,000 character file, Google Translate will translate the first 5,000 and stop. If you make too many requests in too short an amount of time, they will temporarily block your IP address. You will need to experiment to find which translation API works best for you and your text.

To install Translate Shell, you will need to download a file and run it. Enter the command:
```wget git.io/trans```
```chmod +x ./trans```

Using Translate Shell is relatively easy. The line below takes a file, translates it into English, and saves the output. 
`trans -e yandex :eng file://INPUT_FILENAME > OUTPUT_FILENAME`

The command `-e` specifies the translator you want to use. 

# Puting it all together with a loop 
Thus far, we have gone over the individual commands to preprocess, OCR, and tranlsate our documents. This section will cover how to automate this process with a script and iterate commands over all the files in a folder.

First, we need to open [Nano](https://en.wikipedia.org/wiki/GNU_nano) and begin writing our script. Nano is a simple command line text editor we can use to write our scripts. Open Nano by typing `nano` in the command line. Nano is a freeware text editor available on Linux and MacOS. It is very easy to use, but has few of the editing feature you would see in [Emacs](https://en.wikipedia.org/wiki/Emacs) or [Vim](https://en.wikipedia.org/wiki/Vim_(text_editor)). You cannot use your cursor in Nano. Instead, you will have to navigate using the arrow keys and `enter`. Our script will be quite small, so the limited editing features of Nano will not be a problem. When writting longer programs, you should use more advanced text editors.

The first thing you should do is enter the [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)). This line will tell the computer what language your script is written in. For a BASH script, the line should be `#!/bin/bash`.

The script we are going to write will have three parts. First, it will prompt you for a folder. Second, it will prepare the images, OCR, and translate the images in that folder. Third, it will save the transcriptions and translations to seperate folders.

To incorporate user input, simply add `read -p` followed by a prompt for the user. For example, the following two lines of code will prompt you for the name of a folder on your Desktop and then create a variable containing the full file path of that folder.
```
read -p "enter folder name: " folder;
FILES=/Users/andrewakhlaghi/Desktop/test_dir/$folder/*
```
The folder name you enter is passed to a variable named `folder` and is then passed into the variable `FILES` to complete the filepath.

Next, we need to set up a loop to iterate through all the files in the folder. Go into terminal and open a file in the Nano text editor by typing `nano DESIRED_FILENAME`.

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
1. One, there is a loop. The first line creates a new variabel, `f`, that will hold the name of each 
file in our directory. 
2. Two, we use the image file name to create the transcription and translation filenames. The command `${VARIABLE%.*}` takes a file and removes the file extension. The `%` command removes a suffix. The `.*` specifies that the suffix is a "." and whatever follows it. 
3. Three, the `sleep 1m` command stops the program from starting the next file for one minute. This allows the previous file to finish being translated and written, as well as spacing out your requests to the translation APIs so they will not
block your IP. You may need to adjust the time as APIs change their policies on what constitutes "too many" requests.

Once the file is saved, you need to make it an executable. That is, you need to change the permissions on the file so that it is treated as a script. Enter the command `chmod a+x FILENAME`. To execute the file, simply write `./FILENAME`

# Results
As we look at our output, you will see that machine translation and OCR require significant editing from someone with knowledge of the source and target languages, as well as the subject being discussed.  

Example one demonstrates how important the underlying image is. The image was both skewed and had significant noise. The pressence of speckles, dark streaks, and uneven or broken lettering make it difficult for the program to classify letters. The skew makes it difficult for the program to recognize lines of text. The combination of the two sources of error produces a very poor conversion of the image into text. 
    
Example two demonstrates that even with a good image, your first translation will have errors. Example two has some errant handwritting, but is generally free of noise and is not skewed. Even if the conversion of the image into text has relatively few errors, machines may not understand how to correctly translate every word. For example, the translation of example two's second page has the sentence, "The party's connection to the owls." This is because the abbreviation "сов." is short for "советский" (Soviet). However, the translator recognizes it as "сов" for owl. The human reader recognizes the period as a sign that the word is an abbreviation and fills in the rest based on context. Even though OCR program correctly interpreted the period, the translator did not understand what to do with it. 

Another problem with the sentence is hyphens. While Tesseract correctly recognizes the hyphens, neither Tesseract nor Yandex understand their purpose. While the hyphen tells the reader to follow the word onto the next line, both programs treat the two halves as seperate words. Obviously you can delete the hyphens individually, but that is tedious. One way to deal with this is to create a small [regex](https://programminghistorian.org/en/lessons/cleaning-ocrd-text-with-regular-expressions) to deal with this. 




The translator also struggles with proper nouns. The first line of the document is correctly rendered as "Товарищу МОЛОТОВУ В.М." However, it is translated as `Comrade Hammer.` Like many Soviet leaders, Molotov used a pseudonym, which literally means hammer. The name should be translated literally as "Molotov." 


 
# Other Possibilities with Scripting and ImageMagick 

## Editing your Documents with ImageMagick

Scripting can also help edit the images themselves. You already learned how to use ImageMagick to prepare a file for OCR. ImageMagick also has many more options for editing images. For example, looking at image one you will probably want to do three things. One, you want to crop, remove the excess border space, around the document, especially the black border on the left that may be treated as text. Two, you will want to straighten the image so that the lines of text are parralel to the bottom of the document. Three, you will want to remove all the noise, especially the dark specks, that appears throughout the document. All three of these tasks can be scripted, but still require experimentation. 

Cropping commands will be specific to each document. There are programs that can detect text and cut around it, however those smartcropping programs are significantly more complicated and are outside the scope of this tutorial. Fortunately, smart cropping is also probably unnecessary for editing archival documents. When you take photos of documents, you probably do so from the same angle and height. The relative position of the text in different photos will be similar. Consequently, you will want to trim similar amounts of the image from similar relative locations in the photograph to isolate the text. Remember, cropping a document does not need to be perfect for Tesseract to work. But removing any marginal notes or discolorations will increase the accuracy of the OCR. After some experimentation, you find that you want to remove 200 pixels from the top of the document, 250 pixels from the right, 250 pixels from the bottom, and 800 pixels from the left of example one.

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
The second command will deskew each picture as well. That is, the `deskew` will make sure that the body of the text is parallel with the bottom of the page. Remember, the `chop` commands will remove the specified amounts of pixels regardless of if there is text on them. Therefore, you will want to be careful about the contents of the folder you run this scrip on. This script will not only remove the same amount from the same location on each picture, it will also save over the original picture with the edited one. To avoid saving over the original, simply change the second `$f`. For example, if my files were named in the IMG_xxxx.jpg format, I would replace the second `$f` with `${f%.*}_EDITED.tiff`. This will remove the filename extension from the filename for each file and insert “EDITED.jpg” to distinguish the edited versions.   

A final useful script will help remove noise from the image. As discussed above, noise refers to unwanted variations in the brightness and color of digital media. In the case of example one, we can see a large number of black dots of varying size and shape splattered all over the document. This could be the result of problems with the copying device or damage to the original document. The ImageMagick `despeckle` command detects and reduces these dots. However, the `despeckle` command has no [parameters](https://en.wikipedia.org/wiki/Parameter_(computer_programming)). To further decrease the size of the spots on document one, you will have to repeatedly run the `despeckle` command on your file. Rewriting commands over and over would be tedious. Luckily, we can write a script that will repeat the command multiple times for us.

```
#!/bin/bash
read -p "enter file name: " fl;
convert $fl -despeckle -despeckle -despeckle -despeckle -despeckle $fl
```

Like our previous script, this script will take the provided file name and perform the `despeckle` operation on it five times. The output will replace the original input file. As before, make sure the you are in the correct [working directory](https://en.wikipedia.org/wiki/Working_directory). The file you specify must be in your working directory. 


## Organize your documents
Scripting can also help you organize your documents. For example, a common problem for archival work is managing and organizing the thousands of images made during an archival trip. Perhaps the biggest problem is cataloguing files by archival location. Digital cameras assign photos a filename that looks something like IMG_xxxx.jpg. This number does not tell you where that file came from or what it contains. Instead, you might want each file to be labeled by the archive it came from. You can use a files metadata to write a script that renames files according to their home archive. 

Scripting can also help you organize your documents. For example, a common problem for archival work is managing and organizing the thousands of images made during an archival trip. For example, a perennial and tedious task is cataloguing files by archival location. Digital cameras (including those on smartphones) assign photos a filename that looks something like IMG_xxxx.jpg. This number does not tell you where that file came from or what it contains. Instead, you probably want each file to have a more descriptive filename. You can use scripting and a file’s metadata to rename files according to their home archive. 

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
Digital tools can make it easier to deal with digitized documents and possible to use new types of documents. Scripting allows you to move, rename, and edit large numbers of images. The combination of OCR and machine translation can also be a powerful tool for researchers. At the most basic level, we have a lot of the vocabulary in the document translated. For an intermediate student, having the majority of vocabulary in an article is a huge help. They can use grammar, context, and what other words they know to translate the rest of the article. We also have a sense of what these documents are about. We now understand the subject matter, but not the details. If this were a longer document, we could use the initial translation to keyword search for relevant passages. 

Knowing the capabilities and limitations of digital tools will help you get the maximum use out of them. For example, knowing the importance of image quality will help you chose how to capture images of documents. Further, knowing the limitations of ImageMagick's `crop` command will emphasize the importance of taking uniform pictures of documents.  



 

---
title: |
    Introduction to Audiovisual Transcoding, Editing, and Data Visualization with FFmpeg
authors:
- David Rodriguez
date: 2018-08-03
reviewers:
layout: lesson
---

# Introduction
The Digital Humanities, as a discipline, have historically focused almost exclusively on the analysis of textual sources through computational methods (Hockey, 2004). However, there is growing interest in the field around using computational methods for the analysis of audiovisual cultural heritage materials as indicated by the creation of the [Alliance of Digital Humanities Organizations Special Interest Group: Audiovisual Materials in the Digital Humanities](https://avindhsig.wordpress.com/) and [the rise in submissions related to audiovisual topics at the global ADHO conference](https://figshare.com/articles/AV_in_DH_State_of_the_Field/5680114) over the past few years. Newer investigations, such as [Distant Viewing TV](https://distantviewing.org/), also indicate a shift in the field toward projects concerned with using computational techniques to expand the scope of materials digital humanists can explore. As Erik Champion states, "The DH audience is not always literature-focused or interested in traditional forms of literacy" and applying digital methodologies to the study of audiovisual culture is an exciting and emerging facet of Digital Humanities (Champion, 2017). There are many valuable, free, and open-source tools and resources available to those interested in working with audiovisual materials (for example, the Programming Historian tutorial [Editing Audio with Audacity](https://programminghistorian.org/en/lessons/editing-audio-with-audacity)) and this tutorial will introduce another: FFmpeg.

[FFmpeg](https://www.ffmpeg.org/) is the leading open-source multimedia framework for transcoding, editing, filtering, and playing nearly every kind of digital audio-visual format. Many common software applications and websites use FFmpeg to handle reading and writing audio-visual files, including VLC, Google Chrome, YouTube, [and many more.](https://trac.ffmpeg.org/wiki/Projects) In addition to being a software and web-developer tool, FFmpeg can be used at the command-line to perform many common, complex, and important tasks related to preservation, playback, and data visualization and retrieval. As such, FFmpeg is an incredibly valuable tool for digital humanists working with audio-visual data. Knowledge of the framework empowers researchers to manipulate audio-visual materials to meet their needs with a free, open-source solution that carries much of the functionality of expensive audio and video editing software.

## Prerequisites
Although it is helpful have some familiarity with Bash scripting, other programming languages, and/or command-line tools to learn the basics of FFmpeg, this prior knowledge is by no means necessary. However, you will need to be able to access your [Terminal](https://en.wikipedia.org/wiki/Terminal_(macOS)) or other command-line interface on your computer. If you are interested in learning more about these skills, check out the [Bash tutorial](https://programminghistorian.org/en/lessons/intro-to-bash) (Mac and Linux users) or the [Windows PowerShell tutorial](https://programminghistorian.org/en/lessons/intro-to-powershell#quick-reference). Additionally, a basic understanding of audiovisual [codecs](https://en.wikipedia.org/wiki/Codec) and [containers](https://en.wikipedia.org/wiki/Digital_container_format) will also be useful to understanding what FFmpeg does and how it works.

## Learning Objectives
* Learn how to install FFmpeg on your computer or use a demo version in your web browser
* Understand the basic structure and syntax of FFmpeg commands
* Learn several useful commands   
* Introduce resources for further exploration and experimentation

# Installing FFmpeg
Installing FFmpeg can be the most difficult part of using FFmpeg. Thankfully,
there are some helpful guides and resources available for installing the framework based on your operating system.

* **Note**: New versions of FFmpeg are released approximately every 6 months. To keep track of these updates, follow FFmpeg on [Twitter](https://twitter.com/FFmpeg) or through its [website](https://www.ffmpeg.org/index.html#news).

## For Mac OS Users
The simplest option is to use a package manager such as [Homebrew](https://brew.sh/)
to install FFmpeg and ensure it remains in the most up-to-date version. To complete this kind of installation, follow these steps:
* Install Homebrew following the instructions on the website
* Run `brew install ffmpeg` in your Terminal to initiate a basic installation.
    * **Note**: Generally, it is recommended to install FFMpeg with additional features than what is included in the basic installation. Including additional options will provide access to more of FFmpeg's tools and functionalities. Reto Kromer's [Apple installation guide](https://avpres.net/FFmpeg/install_Apple.html) provides a good set of additional options:
    `brew install ffmpeg --with-sdl2 --with-freetype --with-openjpeg --with-x265 --with-rubberband --with-tesseract`
    * For an explanation of these additional options, refer to [Ashley Blewer's FFmpeg guide](https://training.ashleyblewer.com/presentations/ffmpeg.html#10)
* To upgrade your installation to the latest version:
  `brew update && brew upgrade ffmpeg`
* For more installation options for Mac OS, see the [Mac OS FFmpeg Compilation Guide](https://trac.ffmpeg.org/wiki/CompilationGuide/macOS)

## For Windows Users
Windows users can use the package manager [Chocolately](https://chocolatey.org/) to install and maintain FFmpeg. Reto Kromer's [Windows instllation guide](https://avpres.net/FFmpeg/install_Windows.html) provides all the necessary information to use Chocolately or to install the software from a build.

## For Linux Users
[Linuxbrew](http://linuxbrew.sh/), a program similar to Homebrew, can be used to
install and maintain FFmpeg in Linux. Reto Kromer also provides a helpful [Linux installation guide](https://avpres.net/FFmpeg/install_Linux.html)
that closely resembles the Mac OS installation.

## Other Installation Resources

* [Download Packages](https://www.ffmpeg.org/download.html)
* [FFmpeg Compilation Guide](https://trac.ffmpeg.org/wiki/CompilationGuide)

## Testing the Installation
* To ensure FFmpeg is installed properly, run:
`ffmpeg -version`
* If you see a long output of information, the installation was successful! It
should look similar to this:

`ffmpeg version 3.4 Copyright (c) 2000-2017 the FFmpeg developers
built with Apple LLVM version 9.0.0 (clang-900.0.38)
configuration: --prefix=/usr/local/Cellar/ffmpeg/3.4 --enable-shared --enable-pthreads --enable-version3 --enable-hardcoded-tables --enable-avresample --cc=clang --host-cflags= --host-ldflags= --enable-gpl --enable-ffplay --enable-libfreetype --enable-libmp3lame --enable-librubberband --enable-libtesseract --enable-libx264 --enable-libx265 --enable-libxvid --enable-opencl --enable-videotoolbox --disable-lzma --enable-libopenjpeg --disable-decoder=jpeg2000 --extra-cflags=-I/usr/local/Cellar/openjpeg/2.3.0/include/openjpeg-2.3
libavutil 55. 78.100 / 55. 78.100
libavcodec 57.107.100 / 57.107.100
libavformat 57. 83.100 / 57. 83.100
libavdevice 57. 10.100 / 57. 10.100
libavfilter 6.107.100 / 6.107.100
libavresample 3. 7. 0 / 3. 7. 0
libswscale 4. 8.100 / 4. 8.100
libswresample 2. 9.100 / 2. 9.100
libpostproc 54. 7.100 / 54. 7.100`

* If you see something like `-bash: ffmpeg: command not found` then something has
gone wrong.

## Using FFmpeg in a web browser (without installing)
If you do not want to install FFmpeg on your computer but would like to become familiar with using it at the command-line, Brian Grinstead's [videoconverter.js](https://bgrins.github.io/videoconverter.js/demo/) provides a way to run FFmpeg commands and learn its basic functions in the web-browser of your choice.
  **Note**: This resource runs on an older version of FFmpeg and may not contain all the features of the most recent version.

# Basic Structure and Syntax of FFmpeg commands
Basic FFmepg commands consist of four elements:

`[Command Prompt] [Input File] [Flags/Actions] [Output File]`

* A command prompt will begin every ffmpeg command. Depending on the use, this
prompt will either be `ffmpeg` (changing files), `ffprobe` (gathering metadata from files), or `ffplay` (playback of files).
* Input files are the files being read, edited, or examined. The output file is
the new file created by the command or the report generated by an `ffprobe` command.
* Flags and actions are the things you are telling FFmpeg to do the input files.
Most commands will contain multiple flags and actions of various complexity.

Written generically, a basic FFmpeg command looks like this:

`ffmpeg -i /filepath/input_file.ext -flag some_action /filepath/output_file.ext`

Next, we will look at some examples of several different commands that use this
structure and syntax. These commands will also demonstrate some of FFmpeg's most
basic and useful functions.

# Command Examples
The following examples are written with generic file names like `input_file.ext`. In actual practice, you will need to write out the full name, extension, and relative filepath of all input and output files. You can follow these commands with any video file of your choice or download a sample file from [videoconverter.js](https://bgrins.github.io/videoconverter.js/demo/bigbuckbunny.webm). This video sample has been provided by [The Blender Foundation](https://www.blender.org/foundation/) under a [Creative Commons Attribution 3.0 license](https://creativecommons.org/licenses/by/3.0/).
Each example will also provide a brief explanation of each part of the command.

## Change Container (Re-Wrap)
In this example, we will begin with an input file with an `.mp4` extension (container) and create an new output file "re-wrapped" with an `.mov` container. It may be necessary to change containers depending on the operating system and compatibility other audiovisual software you are using, especially if you want to keep the original encoding (codec) of the input file (we will examine how to change the codec or "transcode" in the next example).

To change the container (extension) of a file:

`ffmpeg -i input_file.mp4 -c copy -map 0 output_file.mov`

* `ffmpeg` = starts the command
* `-i input_file.mp4` = path and name of input file
* `-c copy` = copy the streams directly, without re-encoding
* `-map 0` = map all streams in the input file into the output file. This is necessary
especially if the file has multiple audio or subtitle tracks.
* `output_file.mov` = path and name of output file. Note this is where the
new container type is specified.

## Change Codec & Container (Transcode)
In this example, we will re-encode (transcode) a new output file to a certain specification. Transcoding audiovisual files is a very common and often necessary procedure for compatibility or if you need to create surrogate or derivative versions of a file. Additionally, you will often (but not always) want or need to re-wrap and transcode files with the same command. The following command will write a ProRes 422 LT output file with an `.mov` extension and also re-encode the file's audio track to the `aac` codec:

`ffmpeg -i input_file.mp4 -c:v prores -profile:v 1 -c:a aac -vf yadif output_file.mov`

* `ffmpeg` = starts the command
* `-i input_file.mp4` = path and name of input file
* `-c:v prores` = copies the video stream to ProRes 422
* `-profile:v 1` = indicates the ProRes LT profile. More on [ProRes profiles](https://documentation.apple.com/en/finalcutpro/professionalformatsandworkflows/index.html#chapter=10%26section=2)
* `-c:a aac` = copies the audio stream to the [AAC](https://en.wikipedia.org/wiki/Advanced_Audio_Coding) codec
* `-vf yadif` = uses "yadif" video filter to [deinterlace](https://en.wikipedia.org/wiki/Deinterlacing) the image
* `output_file.mov` = path and name of output file. Note this is where a new container may also be specified.

## Demux Audio & Video (Separate audio and video streams into separate files)
"Demuxing" an audiovisual file simply means to separate its different components or tracks (for example, audio and video tracks) into their own files. This is useful if you are interested in examining these components discretely or performing some kind of specialized analysis.

To separate the streams in a file into new files:

### Extract Audio

`ffmpeg -i input_file.ext -c:a copy -vn output_file.ext`

### Extract Video

`ffmpeg -i input_file.ext -c:v copy -an output_file.ext`

* `ffmpeg` = starts the command
* `-i input_file.ext` = path and name of input file
* `-c:v copy` = copy video stream directly, without re-encoding
* `-c:a copy` = copy audio stream directly, without re-encoding
* `-vn` = tells FFmpeg to ignore video stream
* `-an` = tells FFmpeg to ignore audio stream
* `output_file.ext` = path and name of output file

Note that you will need to specify the correct extension depending on the kind of output file you are creating, however the `.mp4` container can be and is commonly used for either audio or video.

## Trim files
Similarly, you can create an excerpt of a file for more focused analysis or investigation. There are several methods of doing this, and the following examples provide different uses of FFmpeg syntax to create excerpts.

To create an excerpt of a file:

`ffmpeg -i input_file.ext -ss 00:02:30 -to 00:05:00 -c copy -map 0 output_file.ext`

* `ffmpeg` = starts the command
* `-i input_file.ext` = path and name of input file
* `-ss 00:02:30` = sets start point at 2 minutes and 30 seconds from start of file
* `-to 00:05:00` = sets end point to 5 minutes from start of file
* `-c copy` = copy the streams directly, without re-encoding
* `-map 0` = map all streams in the input file into the output file.
* `output_file.ext` = path and name of output file

Alternatively, `-t` can be used to set duration instead of start and end points:

`ffmpeg -i input_file.ext -ss 00:02:30 -t 150 -c copy -map 0 output_file.ext`

* `-ss 00:02:30 -t 150` = sets start point at 2 minutes and 30 seconds from start of file
and creates a 150-second-long excerpt

To create an excerpt starting at the beginning of a file:

`ffmpeg -i input_file.ext -t 30 -c copy -map 0 output_file.ext`

In this command, using `-t 30` will create a 30 second excerpt starting at timecode `00:00:00`

## Using FFprobe (Generate metadata reports)
`FFprobe` is a powerful tool for extracting metadata from audio-visual files. This information can be output into several structured data (machine-readable) formats including `.json` and `.xml` that can be used for computational analysis or simply to store important information about a file(s). This example will write a `.json` file containing the technical metadata of the input file:

`ffprobe -i input_file.ext -show_format -show_streams -print_format json > output_metadata_file.json`

* `ffprobe` = starts the command
* `-i input_file.ext` = path and name of input file
* `-show_format` = provides container information
* `-show_streams` = provides codec information for all streams
* `-print_format json` = specifies the format of the metadata report.
* `> output_metadata_file.json` = writes a new `.json` file containing the metadata report to a specified filepath and name. The file extension should match the format specified by the `print_format` flag.
  * Alternatively, you can write this command without `> output_metadata_file.json`
  and the report will be printed to the `stdout`.

For more information on this command, see Reto Kromer's [explanation](https://avpres.net/FFmpeg/probe_json.html)

## Using FFplay (File playback)
`FFplay` is useful for testing and playing back new files created using `ffmpeg` commands or as a simple media player. As we will also see, `ffplay` can be used to playback files with specific parameters and filters. To play a file, simply run:

`ffplay input_file.ext`

This command will play the file through one time and then close the command window. Note that with `ffplay` commands, you do not need indicate an `-i` flag or output file because the playback itself is the output. To loop playback indefinitely:

`ffplay -loop 0 input_file.ext`

The number `0` can be changed to any number and `ffplay` will play the file that many times.

## Visualize audio and video information (Create vectorscopes and waveforms)
[Data visualization](https://en.wikipedia.org/wiki/Data_visualization) is a concept familiar to digital humanists. For years, sound and video professionals have also relied on data visualization to work with audio-visual content. These types of visualizations include [vectorscopes](https://en.wikipedia.org/wiki/Vectorscope#Video) (to visualize video color information) and [waveform patterns](https://en.wikipedia.org/wiki/Waveform) (to visualize audio signal data). Although this kind of data visualization is not the kind traditionally created by DH scholarship, FFmpeg includes a number of tools and libraries that can be used to visualize sound and image information that can potentially expand the field and open new lines of critical inquiry.

This section will provide commands for creating a few different types of visualizations with examples of the intended result. Additionally, these commands are more complex than the previous examples in this tutorial and provide further insight into creating complex options for FFmpeg commands.

### Vectorscope (Video)
To play a video accompanied by a vectorscope:

`ffplay input_file.ext -vf "split=2[m][v], [v]vectorscope=b=0.7:m=color3:g=green[v],[m][v]overlay=x=W-w:y=H-h"`

* `ffplay` = starts the command
* `input_file.ext` = path and name of input file
* `-vf` = creates a [filter-graph](https://trac.ffmpeg.org/wiki/FilteringGuide) to use for the streams
* `"` = quotation mark to start the filter-graph. Information inside the quotation marks will specify the parameters of the vectorscope's appearance and position.
* `split=2[m][v]` = splits the input into two identical outputs called `[m]` and `[v]`
* `,` = comma signifies another parameter is coming
* `[v]vectorscope=b=0.7:m=color3:g=green[v]` = assigns the `[v]` output the vectorscope filter
* `[m][v]overlay=x=W-w:y=H-h` = overlays the vectorscope on top of the video image in a certain location (in this case, in the lower right corner of the frame)
* `"` = ends the filter-graph

{% include figure.html filename="vectorscope.png" caption="A sample video frame with a vectorscope" %}

As previously discussed, this `ffplay` command will playback the video one time and then close the window. You can add a `-loop` option, but it is likely that you'll want to create a new file with the vectorscope included in the image for later analysis and investigation. To accomplish this, we need to change the command prompt to `ffmpeg` and specify the parameters of the output file. Our new command looks like this:

`ffmpeg -i input_file.ext -vf "split=2[m][v], [v]vectorscope=b=0.7:m=color3:g=green[v],[m][v]overlay=x=W-w:y=H-h" -c:v libx264 -c:a copy output_file.ext`

Note the slight but important changes in syntax:
  * We have added an `-i` flag because it is an `ffmpeg` command
  * We have specified the output video codec as [H.264](https://en.wikipedia.org/wiki/H.264/MPEG-4_AVC) with the flag `-c:v libx264` and are not re-encoding the audio (`-c:a copy`), although you can specify another audio codec here if necessary.
  * We have specified the path and name of the `output_file.ext`

Generally, `ffplay` commands can be re-written as `ffmpeg` commands with similar tweaks to syntax, although commands containing more complex options may require more significant adjustments.

### Waveform (Audio)
To create a single image of a single-channel (mono) waveform from an input file:

`ffmpeg -i input_file.ext -filter_complex "aformat=channel_layouts=mono,showwavespic=s=600x240" -frames:v 1 output_file.ext`

* `ffmpeg` = starts the command
* `-i input_file.ext` = path and name of input file
* `-filter_complex` = creates a complex filter-graph
* `"` = quotation mark to start the filter-graph. Information inside the quotation
marks will specify the parameters of the waveform's appearance and size.
* `aformat=channel_layouts=mono` = sets the waveform to represent the audio information as a single-channel (mono)
* `showwavespic=s=600x240` = activates the `showwavespic` filter; `s=600x240` designates the size
of the image to be 600 pixels wide and 240 pixels tall.
* `"` = ends the filter-graph
* `frames:v 1` = assigns the output to one single frame (one image)  
* `output_file.ext` = path and name of output file. The extension should be an appropriate image format such as `.jpeg` or `.png`

{% include figure.html filename="waveform-image.png" caption="Waveform image output of the above command" %}

#### To create a video waveform:
This command will output a video file that displays the audio waveform in real-time:

`ffmpeg -i input_file.ext -filter_complex "[0:a]showwaves=s=1280x720:mode=line,format=yuv420p[v]" -map "[v]" -map 0:a -c:v libx264 -c:a copy output_file.ext`

* `ffmpeg` = starts the command
* `-i input_file.ext` = path and name of input file
* `-filter_complex` = creates a complex filter-graph
* `"` = quotation mark to start the filter-graph. Information inside the quotation
marks will specify the parameters of the waveform's appearance and size.
* `[0:a]showwaves=s=1280x720` = activates the `showwaves` filter and sets it to a certain size. This will be the size of the output video.
* `:mode=line,format=yuv420p[v]` = specifies what style of graph will be created in addition to the colorspace `yuv` and resolution `420p`
* `"` = ends the filter-graph
* `-map "[v]" -map 0:a` = maps the output of the filter-graph onto the output file
* `-c:v libx264 -c:a copy` = encode output video with an H.264 codec; encode output
audio with the same codec as the input file
* `output_file.ext` = path and name of output file.

{% include figure.html filename="waveform-video.gif" caption="GIF representation of the video output of the above command" %}

# Further Resources
FFmpeg has a large and well-supported community of users across the globe. As such, there are many open-source and free resources for discovering new commands and techniques for working with audio-visual media. Please contact the author with any additions to this list, especially educational resources in Spanish for learning FFmpeg.

* The Official [FFmpeg Documentation](https://www.ffmpeg.org/ffmpeg.html)
* [FFmpeg Wiki](https://trac.ffmpeg.org/wiki/WikiStart)
* [ffmprovisr](https://amiaopensource.github.io/ffmprovisr/) from the [Association of Moving Image Archivists](https://amianet.org/)
* Ashley Blewer's [Audiovisual Preservation Training](https://training.ashleyblewer.com/)
* Andrew Weaver's [Demystifying FFmpeg](https://github.com/privatezero/NDSR/blob/master/Demystifying_FFmpeg_Slides.pdf)
* Ben Turkus' [FFmpeg Presentation](https://docs.google.com/presentation/d/1NuusF948E6-gNTN04Lj0YHcVV9-30PTvkh_7mqyPPv4/present?ueb=true&slide=id.g2974defaca_0_231)
* Reto Kromer's [FFmpeg Cookbook for Archivists](https://avpres.net/FFmpeg/)

## Open-Source AV Analysis Tools using FFmpeg

* [MediaInfo](https://mediaarea.net/en/MediaInfo)
* [QC Tools](https://bavc.org/preserve-media/preservation-tools)

# References

* Champion, E. (2017) “Digital Humanities is text heavy, visualization light, and simulation poor,” Digital Scholarship in the Humanities 32(S1), i25-i32

* Hockey, S. (2004) “The History of Humanities Computing,” A Companion to Digital Humanities, ed. Susan Schreibman, Ray Siemens, John Unsworth. Oxford: Blackwell

# About the Author

Dave Rodriguez is an audiovisual archivist and filmmaker. He is currently a Resident Librarian at Florida State University.

### This tutorial was made possible with the support of the British Academy and written during the Programming Historian Workshop at La Universidad de Los Andes in Bogotá, Colombia, 31 July - 3 August, 2018.

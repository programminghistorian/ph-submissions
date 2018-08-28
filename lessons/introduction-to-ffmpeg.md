---
title: |
    Introduction to Audiovisual Transcoding, Editing, and Data Visualization with FFmpeg
authors:
- David Rodriguez
date: 2018-08-03
reviewers: Brandon Walsh
layout: lesson
---

# Introduction
The Digital Humanities, as a discipline, have historically focused almost exclusively on the analysis of textual sources through computational methods (Hockey, 2004). However, there is growing interest in the field around using computational methods for the analysis of audiovisual cultural heritage materials as indicated by the creation of the [Alliance of Digital Humanities Organizations Special Interest Group: Audiovisual Materials in the Digital Humanities](https://avindhsig.wordpress.com/) and [the rise in submissions related to audiovisual topics at the global ADHO conference](https://figshare.com/articles/AV_in_DH_State_of_the_Field/5680114) over the past few years. Newer investigations, such as [Distant Viewing TV](https://distantviewing.org/), also indicate a shift in the field toward projects concerned with using computational techniques to expand the scope of materials digital humanists can explore. As Erik Champion states, "The DH audience is not always literature-focused or interested in traditional forms of literacy" and applying digital methodologies to the study of audiovisual culture is an exciting and emerging facet of Digital Humanities (Champion, 2017). There are many valuable, free, and open-source tools and resources available to those interested in working with audiovisual materials (for example, the Programming Historian tutorial [Editing Audio with Audacity](/en/lessons/editing-audio-with-audacity)) and this tutorial will introduce another: FFmpeg.

[FFmpeg](https://www.ffmpeg.org/about.html) is "the leading multimedia framework able to decode, encode, transcode, mux, demux, stream, filter and play pretty much anything that humans and machines have created." Many common software applications and websites use FFmpeg to handle reading and writing audiovisual files, including VLC, Google Chrome, YouTube, [and many more.](https://trac.ffmpeg.org/wiki/Projects) In addition to being a software and web-developer tool, FFmpeg can be used at the command-line to perform many common, complex, and important tasks related to audiovisual file management, alteration, and analysis. These kinds of processes, such as editing, re-encoding, or extracting metadata from files, usually require access to other software (such as a non-linear video editor like Adobe Premire or Final Cut Pro), but FFmpeg allows a user to operate on audiovisual files directly without the use of third-party software or interfaces. As such, knowledge of the framework empowers users to manipulate audiovisual materials to meet their needs with a free, open-source solution that carries much of the functionality of expensive audio and video editing software. This tutorial will provide an introduction to reading and writing FFmpeg commands and discuss some use cases for how the framework can be used in Digital Humanties scholarship.

## Learning Objectives
* Learn how to install FFmpeg on your computer or use a demo version in your web browser
* Understand the basic structure and syntax of FFmpeg commands
* Learn several useful commands such as:
  * "Re-wrapping" (change file container) & Transcoding (re-encode files)
  * Demuxing (seperating audio and video tracks)
  * Trimming/Editing files
  * File playback
  * Generating metadata reports
  * Audio and Video Data Visualization (creating waveforms and vectorscopes)
* Introduce resources for further exploration and experimentation

## Prerequisites
Before starting this tutorial, you should be comfortable with locating and using your computer's [Terminal](https://en.wikipedia.org/wiki/Terminal_(macOS)) or other command-line interface, as this is where you will be entering and executing FFmpeg commands. If you need instruction on how to access and work at the command-line, I recommend the Program Historian's [Bash tutorial](/en/lessons/intro-to-bash) for Mac and Linux users or the [Windows PowerShell tutorial](/en/lessons/intro-to-powershell#quick-reference). Additionally, a basic understanding of audiovisual [codecs](https://en.wikipedia.org/wiki/Codec) and [containers](https://en.wikipedia.org/wiki/Digital_container_format) will also be useful to understanding what FFmpeg does and how it works. We will provide some additional information and discuss codecs and containers in a bit more detail in the Command Examples section of this tutorial.

# Installing FFmpeg
Installing FFmpeg can be the most difficult part of using FFmpeg. Thankfully, there are some helpful guides and resources available for installing the framework based on your operating system.

> * **Note**: New versions of FFmpeg are released approximately every 6 months. To keep track of these updates, follow FFmpeg on [Twitter](https://twitter.com/FFmpeg) or through its website. New versions of FFmpeg usually contain features such as new and updated filters, codec compatibilities, and bug fixes. The syntax of FFmpeg commands do not change with these updates and old capabilities are rarely removed. To get an idea of what kinds of features come with these updates, you can scroll through previous update announcements in the [News](https://www.ffmpeg.org/index.html#news) section of the FFmpeg website.

## For Mac OS Users
The simplest option is to use a package manager such as [Homebrew](https://brew.sh/)
to install FFmpeg and ensure it remains in the most up-to-date version. Homebrew is also useful in ensuring that your computer has the necessary dependencies installed to ensure FFMpeg runs properly. To complete this kind of installation, follow these steps:
* Install Homebrew following the instructions in the above link
* Run `brew install ffmpeg` in your Terminal to initiate a basic installation.
    * **Note**: Generally, it is recommended to install FFMpeg with additional features than what is included in the basic installation. Including additional options will provide access to more of FFmpeg's tools and functionalities. Reto Kromer's [Apple installation guide](https://avpres.net/FFmpeg/install_Apple.html) provides a good set of additional options:
    `brew install ffmpeg --with-sdl2 --with-freetype --with-openjpeg --with-x265 --with-rubberband --with-tesseract`
    * For an explanation of these additional options, refer to [Ashley Blewer's FFmpeg guide](https://training.ashleyblewer.com/presentations/ffmpeg.html#10)
* After installing, it is best practice to update Homebrew and FFmpeg to ensure all dependencies and features are most up-to-date by running:
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
  * FFmpeg allows access to binary files and source code directly through its website, enabling users to build the framework without a package manager. It is likely that only advanced users will want to follow this option.
* [FFmpeg Compilation Guide](https://trac.ffmpeg.org/wiki/CompilationGuide)
  * The FFmpeg Wiki page also provides a compendium of guides and strategies for building FFmpeg on your computer.

## Testing the Installation
* To ensure FFmpeg is installed properly, run:
`ffmpeg -version`
* If you see a long output of information, the installation was successful! It
should look similar to this:

`ffmpeg version 4.0.1 Copyright (c) 2000-2018 the FFmpeg developers
built with Apple LLVM version 9.1.0 (clang-902.0.39.1)
configuration: --prefix=/usr/local/Cellar/ffmpeg/4.0.1 --enable-shared --enable-pthreads --enable-version3 --enable-hardcoded-tables --enable-avresample --cc=clang --host-cflags= --host-ldflags= --enable-gpl --enable-ffplay --enable-libfreetype --enable-libmp3lame --enable-librubberband --enable-libtesseract --enable-libx264 --enable-libx265 --enable-libxvid --enable-opencl --enable-videotoolbox --disable-lzma --enable-libopenjpeg --disable-decoder=jpeg2000 --extra-cflags=-I/usr/local/Cellar/openjpeg/2.3.0/include/openjpeg-2.3
libavutil      56. 14.100 / 56. 14.100
libavcodec     58. 18.100 / 58. 18.100
libavformat    58. 12.100 / 58. 12.100
libavdevice    58.  3.100 / 58.  3.100
libavfilter     7. 16.100 /  7. 16.100
libavresample   4.  0.  0 /  4.  0.  0
libswscale      5.  1.100 /  5.  1.100
libswresample   3.  1.100 /  3.  1.100
libpostproc    55.  1.100 / 55.  1.100`

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

# Getting Started
For this tutorial, we will use the video clip found at [videoconverter.js](https://bgrins.github.io/videoconverter.js/demo/bigbuckbunny.webm). This video has been provided by [The Blender Foundation](https://www.blender.org/foundation/) under a [Creative Commons Attribution 3.0 license](https://creativecommons.org/licenses/by/3.0/). Download the video and save it to a directory that you can easily access on your computer under the name `bigbuckbunny.webm`. This video will be the primary "test subject" of this tutorial and will be used to demonstrate the features of FFmpeg.

# Command Examples

## Viewing Basic Metadata with FFprobe
Before we begin manipulating our `bigbuckbunny.webm` file, let's use FFmpeg to examine some basic information about the file itself using a simple `ffprobe` command. Navigate to the file's directory and execute:

`ffprobe bigbuckbunny.webm`

You will see the file's basic metadata printed in the `stdout`:

{% include figure.html filename="ffprobe_basic.png" caption="The output of a basic `ffprobe` command" %}

The `Input #0` line identifies the **container** as [.webm](https://www.webmproject.org/about/), which is a variation of the [Matroska](https://www.matroska.org/) standard. Containers (also called "wrappers") are synonymous with the file's extension and provide the file with structure for its various streams. Different containers (other common ones include `.mov`, `.mp4`, and `.avi`) have different features and compatibilities with various software. We will examine how and why you might want to change a file's container in the next command.

The lines `Stream #0:0` and `Stream #0:1` provide information about the file's streams (i.e. the content you see on screen and hear through your speakers) and identify the **codec** of each stream as well. Codecs specify how information is encoded/compressed (written and stored) and decoded/decompressed (played back). The file's video stream (`Stream #0:0`) uses the [vp8](https://en.wikipedia.org/wiki/VP8) codec while the audio stream (`Stream #0:1`) uses the [vorbis](https://en.wikipedia.org/wiki/Vorbis) codec. Codecs, to a much greater extent than containers, determine an audiovisual file's quality and compatibility (other common codecs include `H.264` and `ProRes` for video and `AAC` and `FLAC` for audio). We will examine how and why you might want to change a file's codec in the next command as well.

Now that we know more about the technical make-up of our file, we can begin exploring the transformative features and functionalities of FFmpeg (we will use `ffprobe` again later in the tutorial to conduct more advanced metadata extraction).

## Changing Containers and Codecs (Re-Wrap and Transcode)
Depending on your operating system, you may have one or more media players installed. For the purposes of demonstration, let's see what happens if you try to open `bigbuckbunny.webm` using the QuickTime media player that comes with Mac OSX:

{% include figure.html filename="QT_error.png" caption="Proprietary media players such as QuickTime are often limited in the kinds of files they can work with" %}

One option when faced with such a message is to simply use another media player ([VLC](https://www.videolan.org/vlc/index.html), which is built with FFmpeg, is an excellent open-source alternative) but simply "using another software" may not always be a viable solution. Many popular video editors such as Adobe Premiere, Final Cut Pro, and DaVinci Resolve all have their own limitations on the kinds of formats they are compatible with. Further, different web-platforms and hosting/streaming sites such as Vimeo have [their own requirements as well.](https://vimeo.com/help/compression) As such, it is important to be able to re-wrap and transcode your files to meet the various specifications for playback, editing, and digital publication.

> **Note**: For a complete list of codecs and containers supported by your installation of FFmpeg, run `ffmpeg -codecs` and `ffmpeg -formats`, respectively, to see the list printed to your `stdout`.

In this example, we will begin with our `bigbuckbunny.webm` and write a new file with video encoded to `H.264` and audio to `AAC` wrapped in an `.mp4` container, a very common and highly-portable combination of codecs and container. Here is the command you will execute along with an explanation of each part of the syntax:

`ffmpeg -i bigbuckbunny.webm -c:v libx264 -c:a aac bigbuckbunny.mp4`

* `ffmpeg` = starts the command
* `-i bigbuckbunny.webm` = specifies the input file
* `-c:v libx264` = copy the video stream to the H.264 codec
* `-c:a aac` = copy the audio stream to the AAC codec
* `bigbuckbunny.mp4` = specifies the output file. Note this is where the new container type is specified

If you execute this command as it is written and in the same directory as `bigbuckbunny.webm`, you will see a new file called `bigbuckbunny.mp4` appear in the directory. If you are operaing in Mac OSX, you will also be able to play this new file with QuickTime. Notice that although there isn't any significant visible or audible difference between the `.mp4` and `.webm` versions of the file, running `ffprobe bigbuckbunny.mp4` yields different technical metadata. Often this technical metadata can be just as important to accessing and working with audiovisual files than anything we can see or hear.

## Demux Audio & Video (Separate audio and video streams into separate files)
Now that we have a better understanding of streams, codecs, and containers, lets look at ways FFmpeg can help us work with these media components at a more granular level. One useful method is to "demux" the file into its constituent parts. "Demuxing" an audiovisual file simply means to separate its different components or tracks (for example, audio and video tracks) into their own files.

This is useful if you are interested in examining these components discretely or performing some kind of specialized analysis. For example, [historicist audio forensics](https://www.19.bbk.ac.uk/articles/10.16995/ntn.744/) is an emerging area of DH scholarship that utilizes digital tools like [Praat](https://en.wikipedia.org/wiki/Praat) and [Audacity](https://www.audacityteam.org/) to analyze archival recordings of human voices (Camlot, 2015). Other tools for audio analysis and annotation such as the [Variations Audio Timeliner](http://variations.sourceforge.net/vat/index.html) can also be employed for similar "close listening" applications. At the end of this section, you will have created "audio only" and "video only" versions of `bigbuckbunny.mp4` using FFmpeg's "demuxing" syntax.

> **Note**: For more commands related to historicist audio forensics, see the final two examples in this tutorial.

### Extract Audio

To create a new, stand-alone audio file from `bigbuckbunny.mp4`:

`ffmpeg -i bigbuckbunny.mp4 -c:a copy -vn bigbuckbunny_audio-only.mp4`

### Extract Video

To create a new, stand-alone video file from `bigbuckbunny.mp4`:

`ffmpeg -i bigbuckbunny.mp4 -c:v copy -an bigbuckbunny_video-only.mp4`

* `ffmpeg` = starts the command
* `-i bigbuckbunny.mp4` = specifies the input file
* `-c:v copy` = copy video stream directly, without re-encoding
* `-c:a copy` = copy audio stream directly, without re-encoding
* `-vn` = tells FFmpeg to ignore video stream
* `-an` = tells FFmpeg to ignore audio stream
* `bigbuckbunny_audio-only.mp4/bigbuckbunny_video-only.mp4` = specifies the output file

Note that you will need to specify the correct extension depending on the kind of output file you are creating, however the `.mp4` container can be and is commonly used for either audio or video.

## Trim files
Demuxing commands allow a user to parse files into their various streams, but you may also need to edit these files into excerpts for even more focused investigation. The following commands will demonstrate a few different command syntax structures for creating excerpts.

### Create an excerpt by setting a start and end point
In our first example, we'll create an excerpt from `bigbuckbunny.mp4` that contains everything in between the opening card reading "The Peach Open Movie Project Presents" (ending at timecode `00:00:05`) and the "Big Buck Bunny" title card (beginning at timecode `00:00:27`):

`ffmpeg -i bigbuckbunny.mp4 -ss 00:00:05 -to 00:00:27 -c copy -map 0 bigbuckbunny_middle.mp4`

* `ffmpeg` = starts the command
* `-i bigbuckbunny.mp4` = specifies the input file
* `-ss 00:00:05` = sets start point at 5 seconds from start of file
* `-to 00:00:27` = sets end point to 27 seconds from start of file
* `-c copy` = copy the streams directly, without re-encoding
* `-map 0` = map all streams in the input file into the output file.
* `bigbuckbunny_middle.mp4` = specifies the output file

### Create an excerpt by specifying duration
Alternatively, `-t` can be used in combination with the `-ss` flag to set the duration of an excerpt instead of an end point. In this example, we'll create an excerpt of the animated characters' first interaction with each other:

`ffmpeg -i bigbuckbunny.mp4 -ss 00:00:09 -t 8 -c copy -map 0 bigbuckbunny_firstinteraction.mp4`

* `-ss 00:00:09 -t 8` = sets start point at 9 seconds from start of file
and creates an 8-second-long excerpt

If you remove the `-ss` flag and only use `-t`, FFmpeg will create an excerpt starting at the beginning of the file (timecode `00:00:00`). In this example, we'll create an excerpt containing the first two shots of the video and introductory title cards:

`ffmpeg -i bigbuckbunny.mp4 -t 11 -c copy -map 0 bigbuckbunny_intro.mp4`

At this point in the tutorial, you should have 7 files in your directory (including the original `bigbuckbunny.webm` file). Next we'll see how to use `ffplay` to play these files quickly and efficiently from the command-line.

## Using FFplay (File playback)
`FFplay` is a useful tool for testing and playing back new files created using `ffmpeg` commands or as a simple media player. As shown earlier when attempting to play a `.webm` file with a proprietary software like QuickTime, many media players have limitations on the kinds of files they are compatible with. However, `ffplay` supports [most of the file types you are likely to encounter](https://en.wikipedia.org/wiki/FFmpeg#Supported_codecs_and_formats) and new libraries and codec/format compatibilities are always being added to new versions of the framework.

Basic `ffplay` syntax is very simple. Let's play our original `bigbuckbunny.webm` file by executing:

`ffplay bigbuckbunny.webm`

Note that with `ffplay` commands, you do not need indicate an `-i` flag or output file because the playback itself is the output. This command will play the file through one time in its own window. Although there are no traditional graphical icons of traditional media player features ("Play", "Stop", "Pause", etc.), these options can be [executed on your keyboard.](https://ffmpeg.org/ffplay.html#While-playing). Try out `ffplay` with the other files you've created and get a feel for using the keyboard controls. Also, notice that `ffplay` will seamlessly handle different kinds of files with the same simple command syntax shown above.

### FFplay Options
`FFplay` comes with a number of [options](https://ffmpeg.org/ffplay.html#Options) for customizing playback with the ability to loop playback being one of the more common ones. Adding options to `ffplay` commands is the same as regular FFmpeg syntax, and in this example we'll create an infinite loop (using the `-loop` flag) of one of the short excerpts we created earlier:

`ffplay -loop 0 bigbuckbunny_intro.mp4`

  **Note**: The number `0` can be changed to any number and `ffplay` will play the file that many times.

So far, we have examined basic metadata, transformed files, parsed and edited files, and explored how to playback what we have created. In the last sections of this tutorial, we will explore some more advanced commands that extract and visualize audiovisual data.

## Advanced FFprobe
At the beginning of this tutorial, we used an `ffprobe` command to view our file's basic metadata printed to the `stdout`. In these next examples, we'll explore some of the more advanced features of `ffprobe` to both access and gather metadata in structured data (i.e. machine-readable) formats such as `.json` or `.xml` in addition to other useful formats like `.csv`.

### Basic Technical Metadata Report
This first command will write a `.json` file containing the technical metadata of our original `bigbuckbunny.webm` file:

`ffprobe -i bigbuckbunny.webm -show_format -show_streams -print_format json > bbb_metadata_file.json`

* `ffprobe` = starts the command
* `-i bigbuckbunny.webm` = specifies the input file
* `-show_format` = provides container information
* `-show_streams` = provides codec information for all streams
* `-print_format json` = specifies the format of the metadata report.
* `> bbb_metadata_file.json` = writes a new `.json` file containing the metadata report. The file extension should match the format specified by the `print_format` flag.

{% include figure.html filename="JSON_basic.png" caption="The first several rows of the `.json` report we created" %}

  For more information on this command, see Reto Kromer's [explanation](https://avpres.net/FFmpeg/probe_json.html)

This metadata report contains important information about the technical composition of the file including what "hidden streams" (such as subtitle or commentary tracks) are included in addition to more granular information like [pixel aspect ratio](https://en.wikipedia.org/wiki/Pixel_aspect_ratio) (displayed in the `json` file as `sample_aspect_ratio`) which can have a significant effect on how your image renders in editing or digital publishing environments.

### Extracting Color Metadata
In addition to broad, technical metadata, we can use `ffprobe` to extract quantitative data about a file's streams (i.e. audio or video information). In this example, we are going to use the `signalstats` filter to create a `.json` report of average color [hue](https://en.wikipedia.org/wiki/Hue) and color [saturation](https://en.wikipedia.org/wiki/Colorfulness#Saturation) information, respectively, from the video stream of `bigbuckbunny.webm`. The use of [digital tools to analyze color information](https://filmcolors.org/2018/03/08/vian/) in motion pictures is another emerging facet of DH scholarship that overlaps with traditional film studies. The [FilmColors](https://filmcolors.org/) project, in particular, at the University of Zurich, interrogates the critical intersection of film's "formal aesthetic features to [the] semantic, historical, and technological aspects" of its production, reception, and dissemination through the use of digital analysis and annotation tools (Flueckiger, 2017). Although there is no standardized method for this kind of investigation at the time of this writing, the `ffprobe` command offered here is a powerful tool for extracting such information for use in computational analysis:

`ffprobe -f lavfi -i movie=bigbuckbunny.webm,signalstats -show_entries frame=pkt_pts_time:frame_tags=lavfi.signalstats.SATAVG:frame_tags=lavfi.signalstats.HUEAVG -print_format json > bbb_colorinfo.json`

* `ffprobe` = starts the command
* `-f lavfi` = specifies the [libavfilter](https://ffmpeg.org/ffmpeg-devices.html#lavfi) virtual input device as the chosen format. This is necessary when using `signalstats` and many filters in more complex FFmpeg commands.
* `-i movie=bigbuckbunny.webm` = name of input file
* `,signalstats` = specifies use of the `signalstats` filter with the input file
* `-show_entries` = sets list of entries that will be shown in the report. These are specified by the next options
* `frame=pkt_pts_time` = specifies showing each frame with its corresponding `pkt_pts_time`, creating a unique entry for each frame of video.
* `:frame_tags=lavfi.signalstats.SATAVG` = creates a tag for each frame that contains the average color saturation value
* `:frame_tags=lavfi.signalstats.HUEAVG` = creates a tag for each frame that contains the average color hue value
* `-print_format json` = specifies the format of the metadata report
* `> bbb_colorinfo.json` = writes a new `.json` file containing the metadata report. The file extension should match the format specified by the `print_format` flag.

> **Note**: For more information about the `signalstats` filter and the various metrics that can be extracted from video streams, refer to the FFmpeg's [Filters Documentation](https://ffmpeg.org/ffmpeg-filters.html#signalstats-1).

{% include figure.html filename="JSON_colorinfo.png" caption="The first five entries of the `.json` report created above" %}

This command provides an efficient way for extracting quantitative color metadata and rendering it into a structured data format compatible with various visualization platforms and applications. In the interest of space and scope of this introductory tutorial, we will limit our current exploration to kinds of data visualizations that are native to FFmpeg. However, if you are interested in investigating visualization with the color metadata set with have just created, you can adjust the command to output a `.csv` file and try the dataset with other open-source, browser-based visualization tools such as [RAW Graphs](https://rawgraphs.io/).

## Visualize Audio and Video Information (Create vectorscopes and waveforms)
Data visualization is a concept familiar to digital humanists. For years, sound and video professionals have also relied on data visualization to work with audio-visual content. These types of visualizations include [vectorscopes](https://en.wikipedia.org/wiki/Vectorscope#Video) (to visualize video color information) and [waveform patterns](https://en.wikipedia.org/wiki/Waveform) (to visualize audio signal data). Although this kind of data visualization is not the kind traditionally created by DH scholarship, FFmpeg includes a number of tools and libraries that can be used to visualize sound and image information that can potentially expand the field and open new lines of critical inquiry.

This section will provide commands for creating a few different types of visualizations with examples of the intended result. Additionally, these commands are more complex than the previous examples in this tutorial and provide further insight into creating complex options for FFmpeg commands.

### Vectorscope (Video)
Our first example will build on our `ffplay bigbuckbunny.webm` command to include a vectorscope as part of the playback image. To play the video accompanied by a vectorscope:

`ffplay bigbuckbunny.webm -vf "split=2[m][v], [v]vectorscope=b=0.7:m=color3:g=green[v],[m][v]overlay=x=W-w:y=H-h"`

* `ffplay` = starts the command
* `bigbuckbunny.webm` = path and name of input file
* `-vf` = creates a [filter-graph](https://trac.ffmpeg.org/wiki/FilteringGuide) to use for the streams
* `"` = quotation mark to start the filter-graph. Information inside the quotation marks will specify the parameters of the vectorscope's appearance and position.
* `split=2[m][v]` = splits the input into two identical outputs called `[m]` and `[v]`
* `,` = comma signifies another parameter is coming
* `[v]vectorscope=b=0.7:m=color3:g=green[v]` = assigns the `[v]` output the vectorscope filter
* `[m][v]overlay=x=W-w:y=H-h` = overlays the vectorscope on top of the video image in a certain location (in this case, in the lower right corner of the frame)
* `"` = ends the filter-graph

{% include figure.html filename="vector_bbb.png" caption="A sample video frame with a vectorscope" %}

As previously discussed, this `ffplay` command will playback the video one time and then close the window. You can add a `-loop` option, but it is likely that you'll want to create a new file with the vectorscope included in the image for later analysis and investigation. To accomplish this, we need to change the command prompt to `ffmpeg` and specify the parameters of the output file. Our new command looks like this:

`ffmpeg -i bigbuckbunny.webm -vf "split=2[m][v], [v]vectorscope=b=0.7:m=color3:g=green[v],[m][v]overlay=x=W-w:y=H-h" -c:v libx264 -c:a copy bbb_vectorscope.mp4`

Note the slight but important changes in syntax:
  * We have added an `-i` flag because it is an `ffmpeg` command
  * We have specified the output video codec as [H.264](https://en.wikipedia.org/wiki/H.264/MPEG-4_AVC) with the flag `-c:v libx264` and are not re-encoding the audio (`-c:a copy`), although you can specify another audio codec here if necessary.
  * We have specified the path and name of the output file

Generally, `ffplay` commands can be re-written as `ffmpeg` commands with similar tweaks to syntax, although commands containing more complex options may require more significant adjustments.

### Waveform (Audio)
Waveforms are one of the most common visualizations of sonic information. Most simply, a waveform expresses changes in an audio signal's [amplitude](https://en.wikipedia.org/wiki/Amplitude) over a given period of time. To create a single image of a single-channel (mono) waveform from an input file:

`ffmpeg -i bigbuckbunny.webm -filter_complex "aformat=channel_layouts=mono,showwavespic=s=600x240" -frames:v 1 bbb_waveimage.png`

* `ffmpeg` = starts the command
* `-i bigbuckbunny.webm` = path and name of input file
* `-filter_complex` = creates a complex filter-graph
* `"` = quotation mark to start the filter-graph. Information inside the quotation
marks will specify the parameters of the waveform's appearance and size.
* `aformat=channel_layouts=mono` = sets the waveform to represent the audio information as a single-channel (mono)
* `showwavespic=s=600x240` = activates the `showwavespic` filter; `s=600x240` designates the size
of the image to be 600 pixels wide and 240 pixels tall.
* `"` = ends the filter-graph
* `frames:v 1` = assigns the output to one single frame (one image)  
* `bbb_waveimage.png` = path and name of output file. The extension should be an appropriate image format such as `.jpeg` or `.png`

{% include figure.html filename="bbb_waveimage.png" caption="Single-image output of the above command" %}

#### To create a video waveform:
A static image of an audio signal can certainly be useful, but you may want to also output a video of the waveform as well. This can more dynamically and vividly visualize how an audio signal changes in real-time:

`ffmpeg -i bigbuckbunny.webm -filter_complex "[0:a]showwaves=s=1280x720:mode=line,format=yuv420p[v]" -map "[v]" -map 0:a -c:v libx264 -c:a copy bbb_wavevideo.mp4`

* `ffmpeg` = starts the command
* `-i bigbuckbunny.webm` = path and name of input file
* `-filter_complex` = creates a complex filter-graph
* `"` = quotation mark to start the filter-graph. Information inside the quotation
marks will specify the parameters of the waveform's appearance and size.
* `[0:a]showwaves=s=1280x720` = activates the `showwaves` filter and sets it to a certain size. This will be the size of the output video.
* `:mode=line,format=yuv420p[v]` = specifies what style of graph will be created in addition to the colorspace `yuv` and resolution `420p`
* `"` = ends the filter-graph
* `-map "[v]" -map 0:a` = maps the output of the filter-graph onto the output file
* `-c:v libx264 -c:a copy` = encode output video with an H.264 codec; encode output audio with the same codec as the input file
* `bbb_wavevideo.mp4` = path and name of output file.

{% include figure.html filename="waveform-video.gif" caption="GIF representation of the video output of the above command" %}

# Conclusion
In this tutorial, we have learned:
  * To install FFmpeg on different operating systems and how to access the framework in the web-browser
  * The basic syntax and structure of FFmpeg commands
  * To view basic technical metadata of an audiovisual file
  * To transform an audiovisual file through transcoding and re-wrapping
  * To parse and edit that audiovisual file by demuxing it and creating excerpts
  * To playback audiovisual files using `ffplay`
  * To generate different kinds of metadata using `ffprobe`
  * To generate different kinds of audiovisual data visualizations using complex filters and syntax

At a broader level, this tutorial aspires to provide an informed and enticing introduction to how audiovisual tools and methodologies can be incorporated in Digital Humanities projects and practices. With open and powerful tools like FFmpeg, there is vast potential for expanding the scope of the field to include more rich and complex types of media and analysis than ever before.

## Further Resources
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

* Camlot, J. (2015) “Historicist Audio Forensics: The Archive of Voices as Repository of Material and Conceptual Artefacts.”19: Interdisciplinary Studies in the Long Nineteenth Century. 2015(21)

* Champion, E. (2017) “Digital Humanities is text heavy, visualization light, and simulation poor,” Digital Scholarship in the Humanities 32(S1), i25-i32

* Flueckiger, B. (2017). "A Digital Humanities Approach to Film Colors". The Moving Image, 17(2), 71-94.

* Hockey, S. (2004) “The History of Humanities Computing,” A Companion to Digital Humanities, ed. Susan Schreibman, Ray Siemens, John Unsworth. Oxford: Blackwell

# About the Author

Dave Rodriguez is an audiovisual archivist, curator, and filmmaker. He is currently a Resident Librarian at Florida State University.

### This tutorial was made possible with the support of the British Academy and written during the Programming Historian Workshop at La Universidad de Los Andes in Bogotá, Colombia, 31 July - 3 August, 2018.

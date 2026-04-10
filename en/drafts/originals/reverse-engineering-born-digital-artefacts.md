---
title: "Reverse Engineering Born-Digital Artifacts: A Beginner's Guide"
slug: reverse-engineering-born-digital-artefacts
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
  - Adrian Demleitner
  - Daniel Gammenthaler
reviewers:
  - Laurisa Sastoque Pabón
  - Thorsten Ries
editors:
  - Nabeel Siddiqui
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/664
difficulty: 2
activity: transforming
topics: data-management, metadata
abstract: This lesson teaches reverse engineering to conduct historical analysis on digital artifacts.
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction to Reverse Engineering and Digital Archaeology

This lesson provides a gentle introduction to the technical skills required for the analysis of digital artifacts. While this term can include digitized versions of physical objects, such as a scan of a letter, this lesson focuses specifically on born-digital artifacts. These are materials native to code with no prior physical original: software, digital photographs, and databases. These artifacts are more than just their visible content; they exist within interwoven layers of file formats, operating systems, and hardware. Technically, they are embedded in systems of applications and hardware, but they are also influenced by environmental factors such as infrastructure, data centers, and socio-economic conditions.

The aim of this lesson is to enable readers to take their first steps in [reverse engineering](https://en.wikipedia.org/wiki/Reverse_engineering). In the context of computer science, this refers to the process of deconstructing digital objects to understand their design, composition, and how their structures shape their meanings. To do this, we use a **[hex viewer](https://en.wikipedia.org/wiki/Hex_editor)** (or hex editor), a tool that displays the raw binary data of a file in a human-readable hexadecimal format. This process is a cornerstone of [digital archaeology](https://en.wikipedia.org/wiki/Digital_archaeology), a field that applies forensic techniques to investigate the technical "strata" of our digital past.

Following an overview of reverse engineering and [software archaeology](https://en.wikipedia.org/wiki/Software_archaeology), this lesson explains how to use hex viewers to explore the components of an image file and compare the evolution of file formats for historical research. These examples illustrate the need to look beyond what is presented on the screen. This tendency to understand digital objects only as they appear on displays—rather than as complex, encoded structures—is known as screen essentialism. Recognizing this allows historians to interrogate digital records that may be interpreted differently by various hardware, such as screen readers or legacy systems.

Rather than advancing a theoretical argument, this lesson is a hands-on tutorial that teaches transferable analytical practices for working with born-digital artifacts. At the end of this lesson you will be able to:

- explain what reverse engineering is and why it is useful for analyzing born-digital artifacts in historical research.
- identify instances of “screen essentialism” and explain their limitations for historical analysis.
- use a hex viewer to inspect the raw data of digital files and perform comparative hex dump analysis to detect and interpret anomalies.

To illustrate these concepts, this lesson employs two case studies. First, we examine a JPEG image to demonstrate how different file formats can be "stacked" or hidden within one another. Second, we compare .doc and .docx files to show how the historical shift from proprietary binary formats to open-standard XML containers changed the transparency and preservability of digital records. Together, these examples provide the skills to begin engaging with digital sources in your own research, from proprietary formats to historical databases.

### Prerequisites and Technical Requirements

All necessary files and digital artifacts required for this lesson are provided. You do not need to source your own materials to follow the exercises; however, the skills taught in this lesson are designed to be applied to your own future research objects.

There are three fundamental technical requirements for this lesson that form the foundation of our digital archaeology approach.

1. The first requirement centres on having appropriate tools to transform digital artifacts into more accessible and analyzable states. While numerous tools and methodologies exist for this purpose, we begin with a straightforward yet powerful hex viewer, which allows us to examine the raw binary data of digital files. A hex viewer displays the hexadecimal representation of binary data, as explored in Kay Lack’s presentation on [binary, hex, and other ways of information encoding](https://www.0de5.net/stimuli/binary-code), making it possible to see patterns, headers, and structures that are otherwise hidden from conventional file viewers. We recommend using the command line tool `hexyl` or the browser-based [HexEd.it](https://hexed.it/) for reliable options that provide the necessary functionality for beginners while maintaining the depth required for more advanced analysis. In this lesson, you will learn to use `hexyl`.
2. Given our focus on a command line tool (`hexyl`), we expect you to be comfortable with this coding environment. We give examples throughout the lesson that can be copy/pasted, but some basic understanding of the Linux, macOS, or Windows shells will improve your digestion of this lesson. If you want to learn more about working in shell environments, Programming Historian has lessons on [Bash](https://programminghistorian.org/en/lessons/intro-to-bash) for Linux (and to some extent macOS), and [PowerShell](https://programminghistorian.org/en/lessons/intro-to-powershell) for Windows.
3. The third and last requirement involves acquiring suitable born-digital objects for analysis, which varies significantly depending on your specific research question and can encompass digital images, databases, software applications, and various other digital artifacts. While we provide curated digital artifacts for the two case studies presented in this lesson, the broader challenge lies in identifying and accessing appropriate materials for independent research, which we can't cover in this lesson.

## Reverse Engineering as Historical Method

In the study of born-digital artifacts, historians are increasingly confronted with the limitations of interpreting materials solely through their surface appearance. This issue is often described as _screen essentialism_, a term coined by Matthew G. Kirschenbaum to critique the tendency to understand digital objects only as they appear on a display rather than as complex, encoded structures.[^1] Screen essentialism often assumes a user who primarily interacts with a computer through sight. However, a digital object's "interface" or "surface" can vary significantly depending on the hardware used, such as a traditional monitor, a VR headset, or a screen reader utilized by a blind user. By looking beyond visual predominance, we see that born-digital materials — software, websites, PDFs, databases — are native to code. Unlike digitized analogue objects, which carry an assumed physical origin, the meaning of born-digital items is derived not only from their rendered appearance but also from how they are stored and processed. Overlooking these technical dimensions can lead to shallow readings and a failure to grasp how digital media shape, constrain, and enable historical expression.

This is where the practice of reverse engineering offers a compelling methodological pathway. Reverse engineering involves opening and deconstructing digital objects to understand how they work, what they are made of, and how their structures shape their meanings. This critical mode of inquiry can include:

- Investigating a file's metadata.
- Altering or corrupting digital files to observe their behavior.
- Reading "against the grain" of the interface to recover invisible labor, intentions, or constraints embedded in the technology.

Reverse engineering often involves working at the boundary between software and hardware. A computer operates through a layered architecture, from transistors and processors at the lowest level to operating systems and applications at the highest. Understanding these layers helps historians trace how high-level software instructions translate into low-level operations, and how choices made at one layer can shape or constrain what is possible at another.

{% include figure.html filename="en-or-reverse-engineering-born-digital-artefacts-01.png" alt="The illustration shows a stack of rectangles, on top of each other, each containing a label and standing for a layer. Some rectangles are also overlapping or divided into smaller units. On the left side are the labels 'software' and 'hardware' to illustrate which layers belong to which category. The software category on top contains layers such as 'applications' and 'operating system.' Among the the bottom hardware category are layers such as 'processor,' 'memory,' 'transistor' and others." caption="Figure 1. Schematic visualization of a computer's hardware and software layers." %}

For historians, this approach is especially important because most contemporary digital technologies are effectively closed-source. Proprietary systems are "black box[es] that cannot be opened"[^3], and without source code or documentation, their inner mechanisms remain invisible.[^4] Even preserved digital artifacts risk becoming unreadable without the original software or hardware.[^5] Reverse engineering — or "writing the missing manual" for "lost, secret, or otherwise obscured technologies"[^6] — offers historians one of the few ways to study these opaque systems.[^7][^8][^9] By transcending screen essentialism, it reveals the deeper structural, functional, and contextual layers of digital artifacts, aligning closely with digital source criticism: recognizing digital objects as part of broader technological and socio-economic frameworks.

The two case studies in this lesson demonstrate these principles through the internal structure of common file formats. To prepare for the first example, it is worth briefly introducing the concept of polyglot files: single files that are valid under multiple format specifications simultaneously. The security researcher Ange Albertini has explored this phenomenon extensively; his presentation "Funky File Formats" at the Chaos Communication Congress demonstrates how such files can function differently depending on the application interpreting them.[^11] Albertini also developed [Mitra](https://github.com/corkami/mitra), a tool for crafting multi-format files, and the [Corkami project](https://github.com/corkami/pics), a collection of hex patterns illustrating various file format structures. These resources are valuable references for understanding the binary composition of digital files, and the concept of polyglot files will be central to our first case study. A related practice is steganography — the art of concealing code or messages within other files, such as images — which was a popular topic in early hacking culture, now documented in part on [textfiles.com](http://www.textfiles.com/computers/DOCUMENTATION/hideseek.txt).

## First Case Study: Inspecting a JPEG Image with a Hex Viewer

Before beginning this hands-on analysis, you'll need to gather the necessary materials and tools to effectively examine digital image formats. First, get the sample files we provide for this exercise, [which you can download through this link](https://github.com/programminghistorian/ph-submissions/raw/refs/heads/gh-pages/assets/reverse-engineering-born-digital-artefacts/reverse-engineering-born-digital-artefacts.zip). Please note that all the following instructions are designed for these files provided with this lesson. 

If you feel confident enough to work with your own material, select a JPEG file with either a .jpg or .jpeg file extension that you'd like to analyse. This can be any digital photograph or image from your personal collection; the choice of image isn't critical for learning the fundamental concepts, though selecting something familiar to you may make the analysis more engaging and meaningful. 

Next, you'll need to install a hex viewer that will serve as your primary tool for examining the binary structure of the JPEG file.

A hex viewer can create hex dumps, which are textual representations of computer data in hexadecimal format, achieved by converting bytes into a two-digit hexadecimal number. This makes raw binary data more human-readable and easier to interpret for reverse engineering, or forensic analysis. There are several tools available for viewing hex data from a file. 

For our lesson, we will use `hexyl` as mentioned. We chose it primarily because we appreciate its functionality and simplicity. Installation packages are provided for most Linux distributions, for [macOS](https://github.com/sharkdp/hexyl?tab=readme-ov-file#on-macos) and [Windows](https://github.com/sharkdp/hexyl?tab=readme-ov-file#on-windows), and [instructions are provided on the tool's website](https://github.com/sharkdp/hexyl?tab=readme-ov-file#installation).

Our first case study focuses on practicing two core skills introduced in the learning objectives: identifying file signatures in a hex dump and reasoning about file structure independently of file extensions or graphical interfaces.


### Reading File Signatures in Hex Data

To illustrate the fundamentals of file analysis, we begin with the basic structure of a JPEG file. For this exercise, we have provided a file named `cat-with-hidden-content.jpg` within the `jpg_zip` folder. When you open this file using your computer's standard image viewer, it appears as a simple, humorous photo of a cat.

{% include figure.html filename="en-or-reverse-engineering-born-digital-artefacts-03.jpeg" alt="The photo shows a rather silly cat on a couch. The cat looks upwards and has its tongue out, making it look like a defiant kid. It's an orange tabby cat with fluffy fur and the couch is upholstered in grey cotton fabric." caption="Figure 3. The file cat-with-hidden-content.jpg displayed in a standard image viewer." %}

While the image viewer displays a visual scene, the underlying JPEG format follows a clearly defined architecture that can be displayed by the hex viewer. The JPEG file begins with a file signature (or “magic number”) that identifies the file type, followed by metadata, the compressed image data, and finally, an end-of-file marker. This predictable structure is what allows software to recognize and "parse" (interpret) the data correctly.

The infographic below provides a visual breakdown of this "bit code." You do not need to memorize every byte at this stage; rather, use this as an introduction to the structural markers that allow us to navigate a digital artifact.

{% include figure.html filename="en-or-reverse-engineering-born-digital-artefacts-02.png" alt="The illustration shows a color-coded hex dump on the left side. Some of the output is highlighted and connected with a dashed line to detailed explenations on the right side, indicating where the start of the image is, or where one could find more information about the files format." caption="Figure 2. Infographic annotating a JPEG's file header in hexadecimal notation. (Ange Albertini 2022 – CC-BY 4.0 )" %}

#### Finding File Signatures in Hex Data

When we use the hex viewer to open the provided sample JPEG `cat-with-hidden-content.jpg` within the `jpg_zip` folder, the hex view immediately exposes the file's structure. The file signature (FF D8 FF E0) at the beginning confirms its identity. Beyond the header, we find metadata describing dimensions and color depth, followed by the bulk of the file: compressed image data, which appears as a seemingly random string of hexadecimal values. 

To see this for yourself, navigate to the picture in a terminal of your choice. The following command is using `hexyl` to shows the hex code of the file. The `-n` option tells hexyl to only display the first 256 bytes. The `$` sign indicates a command to be copied into the terminal (so do not copy the $ itself).

```shell
$ hexyl cat-with-hidden-content.jpg -n 256
```

Executing this command will give us the following output:

```shell
┌────────┬─────────────────────────┬─────────────────────────┬────────┬────────┐
│00000000│ ff d8 ff e0 00 10 4a 46 ┊ 49 46 00 01 02 00 00 01 │××××0•JF┊IF0••00•│
│00000010│ 00 01 00 00 ff db 00 43 ┊ 00 08 06 06 07 06 05 08 │0•00××0C┊0•••••••│
│00000020│ 07 07 07 09 09 08 0a 0c ┊ 14 0d 0c 0b 0b 0c 19 12 │•••__•__┊•__••_••│
│00000030│ 13 0f 14 1d 1a 1f 1e 1d ┊ 1a 1c 1c 20 24 2e 27 20 │••••••••┊••• $.' │
│00000040│ 22 2c 23 1c 1c 28 37 29 ┊ 2c 30 31 34 34 34 1f 27 │",#••(7)┊,01444•'│
│00000050│ 39 3d 38 32 3c 2e 33 34 ┊ 32 ff db 00 43 01 09 09 │9=82<.34┊2××0C•__│
│00000060│ 09 0c 0b 0c 18 0d 0d 18 ┊ 32 21 1c 21 32 32 32 32 │__•_•__•┊2!•!2222│
│00000070│ 32 32 32 32 32 32 32 32 ┊ 32 32 32 32 32 32 32 32 │22222222┊22222222│
│*       │                         ┊                         │        ┊        │
│00000090│ 32 32 32 32 32 32 32 32 ┊ 32 32 32 32 32 32 ff c0 │22222222┊222222××│
│000000a0│ 00 11 08 04 7e 06 22 03 ┊ 01 22 00 02 11 01 03 11 │0•••~•"•┊•"0•••••│
│000000b0│ 01 ff c4 00 1f 00 00 01 ┊ 05 01 01 01 01 01 01 00 │•××0•00•┊•••••••0│
│000000c0│ 00 00 00 00 00 00 00 01 ┊ 02 03 04 05 06 07 08 09 │0000000•┊•••••••_│
│000000d0│ 0a 0b ff c4 00 b5 10 00 ┊ 02 01 03 03 02 04 03 05 │_•××0×•0┊••••••••│
│000000e0│ 05 04 04 00 00 01 7d 01 ┊ 02 03 00 04 11 05 12 21 │•••00•}•┊••0••••!│
│000000f0│ 31 41 06 13 51 61 07 22 ┊ 71 14 32 81 91 a1 08 23 │1A••Qa•"┊q•2×××•#│
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘
```

The leftmost column is the address of the line of data we see. The second and third columns show our data in hexadecimal notation, which we can investigate when we know what to look for. 

The two last columns is our data shown as ASCII interpretation. This simply means that hexyl renders the data as ASCII characters where possible, allowing human-readable text to appear alongside the hexadecimal values. It's those two columns which are of interest to our investigation if we're interested in text that was meant for humans to read. Limiting the output to the first 256 bytes allows us to focus on the file header and metadata without being overwhelmed by the full image data, which would be several thousand lines of output for this small image alone.

The file signature `FF D8 FF E0` at the beginning confirms that it is a JPEG file. A PNG file, as another example, would start with `89 50 4E 47 0D 0A 1A 0A`. Further file signatures are listed on [this List of file signatures](https://en.wikipedia.org/wiki/List_of_file_signatures) Following the file signature is information regarding metadata fields describing the image’s dimensions, color depth, and encoding settings, which is not of importance for our case here. The bulk of the file contains compressed image data, which appears as a seemingly random string of hex values.

#### Discovering a Hidden Archive: The Hybrid Artifact

While the standard JPEG ends predictably, digital artifacts can harbour what Albertini calls "polyglot" structures: a single file that is valid under multiple format specifications simultaneously. This challenges screen essentialism, because the file is not only what the icon on our desktop says it is; its meaning depends on which software reads it, and according to which structural rules.

To demonstrate these "dual identities," we will analyze `cat-with-hidden-content.jpg` again. While it appears to be a standard image, a hex dump reveals a second structural paradigm. JPEGs are read from the top down, and stop at an "End of Image" (EOI) marker. ZIP files, conversely, are typically parsed from the bottom up. This different standards allow the appending of a ZIP archive to the end of a JPEG, resulting in a hybrid file that remains valid for both an image viewer and an archive utility.

The following command uses `hexyl` again and adds a `|` "(pipe") to pass the full hex dump from `hexyl` to the `grep` utility, which searches the output by `ff d9` and simply prints the surrounding 10 lines. `[grep](https://man7.org/linux/man-pages/man1/grep.1.html)` is standard on macOS and Linux. Windows users can achieve similar results using [Select-String in PowerShell](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-string?view=powershell-7.6).

```shell
$ hexyl --color=never cat-with-hidden-content.jpg | grep -i -A 5 -B 5 'ff d9'
```
(Note: We use the --color=never flag here because terminal color codes can sometimes interfere with how grep searches for text.)

`ff d9` is the JPEG's EOI marker. Immediately following it, the trained eye will see the ZIP file signature: `50 4b 03 04`. You'll find these on the sixth line of our provided output bellow. By focusing on this specific location of the file, which is towards the end, you can directly observe the "seam" where the JPEG image data stops and a hidden ZIP structure begins.

```shell
┌────────┬─────────────────────────┬─────────────────────────┬────────┬────────┐
│00031900│ ff d9 50 4b 03 04 0a 00 ┊ 00 00 00 00 51 3d b6 5a │××PK••_0┊0000Q=×Z│
│00031910│ dd dd 14 7d 0d 00 00 00 ┊ 0d 00 00 00 12 00 1c 00 │××•}_000┊_000•0•0│
│00031920│ 68 69 64 64 65 6e 2d 63 ┊ 6f 6e 74 65 6e 74 2e 74 │hidden-c┊ontent.t│
│00031930│ 78 74 55 54 09 00 03 4a ┊ b9 2e 68 4a b9 2e 68 75 │xtUT_0•J┊×.hJ×.hu│
│00031940│ 78 0b 00 01 04 e8 03 00 ┊ 00 04 e8 03 00 00 48 65 │x•0••×•0┊0•×•00He│
│00031950│ 6c 6c 6f 20 57 6f 72 6c ┊ 64 21 0a 50 4b 01 02 1e │llo Worl┊d!_PK•••│
│00031960│ 03 0a 00 00 00 00 00 51 ┊ 3d b6 5a dd dd 14 7d 0d │•_00000Q┊=×Z××•}_│
│00031970│ 00 00 00 0d 00 00 00 12 ┊ 00 18 00 00 00 00 00 01 │000_000•┊0•00000•│
│00031980│ 00 00 00 a4 81 00 00 00 ┊ 00 68 69 64 64 65 6e 2d │000××000┊0hidden-│
│00031990│ 63 6f 6e 74 65 6e 74 2e ┊ 74 78 74 55 54 05 00 03 │content.┊txtUT•0•│
│000319a0│ 4a b9 2e 68 75 78 0b 00 ┊ 01 04 e8 03 00 00 04 e8 │J×.hux•0┊••×•00•×│
│000319b0│ 03 00 00 50 4b 05 06 00 ┊ 00 00 00 01 00 01 00 58 │•00PK••0┊000•0•0X│
│000319c0│ 00 00 00 59 00 00 00 00 ┊ 00                      │000Y0000┊0       │
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘
```

You might wonder: if we simply "glue" two files together, why doesn't the computer get confused? The answer lies in the structural paradigms of different file formats. A JPEG is a linear format; a image viewer starts at the top and stops as soon as it hits the `ff d9` (End of Image) marker. It simply ignores anything that follows. A ZIP file, however, operates on a linked or indexed paradigm. Most archive utilities do not read a ZIP from the beginning. Instead, they "seek" to the very end of the file to find the "End of Central Directory" (EOCD) record. The EOCD acts like a book's index, telling the computer exactly where each file starts within the archive. Because the ZIP utility looks at the footer (the end) rather than the header (the beginning), it doesn't care that there is a cat photo sitting on top of its data.

Before we extract the hidden archive, take another look at the hex output above. In the rightmost ASCII columns, you may be able to spot a familiar pattern: the characters hidden-content.txt are plainly visible in the data following the ZIP signature. This is the filename of a file stored inside the embedded archive — readable to the human eye even in raw hex, if you know where to look.
We can now demonstrate that file formats are defined by their byte patterns, not their file extensions. Rather than renaming the file, we will unzip the .jpg file directly. On macOS or Linux, run:

```shell
$ unzip cat-with-hidden-content.jpg -d extracted-content
```

(Windows users can use Expand-Archive -Path cat-with-hidden-content.jpg -DestinationPath extracted-content in PowerShell.)
This will create a folder called extracted-content containing the file hidden-content.txt. Open it in any text editor to see the message we embedded. The fact that unzip works on a file with a .jpg extension reinforces a key lesson: the archive utility reads the ZIP structure from the byte data, not from the filename. Reading the file as an image reveals a cat; reading it as an archive reveals a hidden text file. Both formats coexist within the same byte sequence, though only one is visible at a time depending on the software used. This is what Albertini means by a "polyglot" file, and it is also a simple example of steganography — the practice of concealing information within another medium.
This example is intentionally simplified to provide a controlled environment for practicing hex-dump analysis before applying these techniques to real-world document formats in the next case study.

### Second Case Study: Comparing .doc and .docx File Formats

Beyond the playful scenario of JPEGs and ZIPs, these same analytical skills allow historians to track the evolution of the digital record itself. As noted in our introduction, born-digital artifacts are often "black boxes" of proprietary code. A prime example of this is the massive shift in how Microsoft Word stored data in the mid-2000s. By comparing a legacy `.doc` file with a modern `.docx` file, we can see a move from the opaque, binary structures of the past toward the open-standard containers of the present.

The older `.doc` format (predominant until 2007) is a complex binary format. If you open such a file in a hex viewer, the actual text is often buried within layers of proprietary logic.

```shell
$ hexyl old-word-document.doc -n 256

┌────────┬─────────────────────────┬─────────────────────────┬────────┬────────┐
│00000000│ d0 cf 11 e0 a1 b1 1a e1 ┊ 00 00 00 00 00 00 00 00 │××•×××•×┊00000000│
│00000010│ 00 00 00 00 00 00 00 00 ┊ 3e 00 03 00 fe ff 09 00 │00000000┊>0•0××_0│
│00000020│ 06 00 00 00 00 00 00 00 ┊ 00 00 00 00 05 00 00 00 │•0000000┊0000•000│
│00000030│ 0f 02 00 00 00 00 00 00 ┊ 00 10 00 00 11 02 00 00 │••000000┊0•00••00│
│00000040│ 01 00 00 00 fe ff ff ff ┊ 00 00 00 00 0a 02 00 00 │•000××××┊0000_•00│
│00000050│ 0b 02 00 00 0c 02 00 00 ┊ 0d 02 00 00 0e 02 00 00 │••00_•00┊_•00••00│
│00000060│ ff ff ff ff ff ff ff ff ┊ ff ff ff ff ff ff ff ff │××××××××┊××××××××│
│*       │                         ┊                         │        ┊        │
│00000100│                         ┊                         │        ┊        │
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘
```

When you inspect a legacy `.doc` file, you will likely see the signature `D0 CF 11 E0`. This identifies an "OLE2" (Object Linking and Embedding) container. As we discussed in the section on [reverse engineering](#reverse-engineering-born-digital-media-artifacts), such files are not human-readable, at least without specialized tools. For the historian, this format represents the height of "screen essentialism": we see a formatted page on the screen, but the underlying code is a proprietary maze that is difficult to preserve or read against the grain. However, Microsoft Word's historical transition to the `.docx` default file format changed the nature of the artifact. Under the hood, a modern Word document is actually a ZIP archive in disguise, containing a collection of XML files that describe the document’s text and structure.

To verify this XML structure, run `hexyl` on the provided modern-word-document.docx:

```shell
$ hexyl modern-word-document.docx -n 256

┌────────┬─────────────────────────┬─────────────────────────┬────────┬────────┐
│00000000│ 50 4b 03 04 14 00 06 00 ┊ 08 00 00 00 21 00 1c 41 │PK•••0•0┊•000!0•A│
│00000010│ a8 2e 66 01 00 00 54 05 ┊ 00 00 13 00 08 02 5b 43 │×.f•00T•┊00•0••[C│
│00000020│ 6f 6e 74 65 6e 74 5f 54 ┊ 79 70 65 73 5d 2e 78 6d │ontent_T┊ypes].xm│
│00000030│ 6c 20 a2 04 02 28 a0 00 ┊ 02 00 00 00 00 00 00 00 │l ×••(×0┊•0000000│
│00000040│ 00 00 00 00 00 00 00 00 ┊ 00 00 00 00 00 00 00 00 │00000000┊00000000│
│*       │                         ┊                         │        ┊        │
│00000100│                         ┊                         │        ┊        │
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘
```

Notice the signature: `50 4B 03 04`. This is the exact same ZIP signature we identified in our cat image with the hidden ZIP file embedded. This discovery is a perfect example of why “signature hunting” is a foundational skill for digital archaeology. 


Recognizing this pattern allows a historian to bypass the word processor entirely; the file extension can simply be changed to `.zip` and the contents decompressed to reveal the raw XML text. This transparency represents a significant departure from the OLE2 “black box” of the `.doc` era. 

Recognizing this pattern allows us to apply the same technique we practiced in the first case study. Just as we unzipped the cat image directly, we can unzip the `.docx` file to reveal its internal structure. On macOS or Linux, run:

```shell
$ unzip modern-word-document.docx -d docx-contents
```

(Windows users can use Expand-Archive -Path modern-word-document.docx -DestinationPath docx-contents in PowerShell.)
Listing the extracted folder reveals a structured collection of XML files and directories:

```shell
$ ls docx-contents
[Content_Types].xml  _rels/  docProps/  word/
```

The `word/` directory contains the document's text in `document.xml`, its styling in `styles.xml`, and any embedded media in `word/media/`. If you explore that folder, you will find `image1.jpeg` — an image of a cat, embedded in the document but invisible from the word processor's interface alone. This hands-on inspection demonstrates how the signature-hunting and direct-extraction skills from the JPEG case study transfer directly to real-world document analysis.
This transparency represents a significant departure from the OLE2 "black box" of the `.doc` era, and that shift was not accidental. By the mid-2000s, governments and public institutions had grown increasingly concerned about long-term dependence on proprietary, closed-source formats for official records. If a vendor discontinued support or changed its format, decades of public documents risked becoming unreadable. In response, institutions such as the European Commission and the Commonwealth of Massachusetts began mandating or favouring open, interoperable document standards. Microsoft's introduction of the Office Open XML (`.docx`) format in 2007 — a ZIP container of human-readable XML files — was in part a response to this pressure and to the competing OpenDocument Format (ODF). For historians, this transition matters because it changed the nature of the artifact itself: a `.docx` file can be inspected, validated, and preserved independently of any single application, while a `.doc` file largely cannot.


### Writing the Missing Manual

Across both case studies, the analytical approach was the same: identifying recognizable signatures, comparing files that differ in controlled ways, and reasoning about file structure through hexadecimal inspection rather than relying on application-level tools. The JPEG's end-of-file marker revealed a hidden archive appended to an image; the ZIP signature at the start of a `.docx` file revealed that a Word document is, structurally, a compressed collection of XML files. In each case, the file's internal structure was explicitly documented and self-describing, which is a a property that made direct inspection possible.

Identifying such structural signatures is the first step in what might be described as “writing the missing manual” for a file. However, reverse engineering often requires more than locating signatures alone; it also requires attention to change. The value of these examples lies not in the novelty of file concatenation, but in practicing how to reason about file structure through direct inspection, comparison, and documented format constraints.

These same low-level analytical skills—hex-dump inspection, signature recognition, and comparative analysis—form the foundation for more advanced reverse engineering work. Born-digital artifacts encountered in historical research usually lack standardized file headers, explicit end-of-file markers, or central indexes comparable to those found in JPEG or ZIP formats. 

Researchers often face undocumented binaries and altered software whose structure must be reconstructed through analysis. In such cases, meaning can be inferred from patterns in raw byte sequences, repetition across multiple disk images, and anomalies that cannot be explained by normal execution. The techniques practiced in this lesson provide an essential starting point for the kind of investigative work that can reveal hidden histories of human intervention into binary code, be it for the purposes of spreading computer viruses, or to mod videogames.


### Conclusion and Next Steps

Having explored hex viewing and comparative hex dump analysis as foundational methods, historians may wish to pursue more advanced techniques in digital archaeology. Rather than providing a detailed walkthrough, this section points to tools and resources that can support deeper exploration.
For binary analysis and software inspection, [Radare2](https://github.com/radareorg/radare2) is a powerful open-source reverse engineering framework widely used by cybersecurity professionals. Although originally designed for low-level software diagnostics, exploit research, and malware analysis, it can also be leveraged by historians to explore the internal structure and behaviour of vintage software. Further information on [Radare2's installation](https://book.rada.re/install/intro.html) and operational specifics can be found in its official documentation. Similarly valuable is **[RetroDebugger](https://github.com/slajerek/RetroDebugger)**, a visual debugger integrated with emulators for classic systems such as the Commodore 64 and Atari 8-bit computers. Platforms such as **[RetroReversing.com](https://www.retroreversing.com/)** offer tutorials and a community environment for beginners, and web-based emulators like **[JS99er](https://js99er.net/#/)** allow immediate interaction with historical software. For visualizing binary file structures, the ImHex Patterns Repository provides structured templates that simplify complex file format analysis.
Several compelling studies also demonstrate the potential of reverse engineering as historical method, such as the analyses of the Mystery House game (Apple II, 1980)[^12], John Aycock's Amnesia Remembered[^13], the reconstruction of the maze-generation algorithm in Entombed (Atari 2600, 1982)[^14], and Aycock's large-scale study of code reuse across nearly two thousand Atari game ROMs.[^15]
To summarise, this lesson introduced reverse engineering as a critical methodology for historical analysis of borndigital artifacts, emphasising its role in overcoming screen essentialism. By inspecting digital files using hex viewers and comparative analysis, historians can uncover hidden structures, metadata, and functionalities that remain invisible through standard interfaces. The two case studies demonstrated how to identify file signatures, extract hidden content from a polyglot file, and trace the historical shift from proprietary binary formats to openstandard containers. These foundational skills hexdump inspection, signature recognition, and comparative analysis provide an essential starting point for engaging with borndigital sources, even as significant challenges remain in working with undocumented, proprietary, or obsolete digital artifacts.

## Footnotes

[^1]: Kirschenbaum, Matthew G. Mechanisms: New Media and the Forensic Imagination. The MIT Press, 2007. https://doi.org/10.7551/mitpress/7393.001.0001. For a recent application of these forensic methods to digital literacy and source criticism, see also: Feichtinger, Moritz. 2024. “From Source-Criticism to System-Criticism, Born Digital Objects, Forensic Methods, and Digital Literacy for All.” September 13. [https://doi.org/10.5281/zenodo.13907816](https://doi.org/10.5281/zenodo.13907816).

[^2]: Guay-Bélanger, Dany. 2022. “Assembling Auras: Towards a Methodology for the Preservation and Study of Video Games as Cultural Heritage Artefacts.” _Games and Culture_ 17 (5): 659–78. [https://doi.org/10.1177/15554120211020381](https://doi.org/10.1177/15554120211020381).

[^3]: Victoria and Albert Museum. “Preserving and Sharing Born Digital and Hybrid Objects · V\&A.” Accessed April 22, 2025. [https://www.vam.ac.uk/research/projects/preserving-and-sharing-born-digital-and-hybrid-objects](https://www.vam.ac.uk/research/projects/preserving-and-sharing-born-digital-and-hybrid-objects). Stallman, Richard, and Richard M. Stallman. _Free Software, Free Society: Selected Essays_. Edited by Joshua Gay. 1st. ed. Boston, Mass: Free Software Foundation, 2002, S.50.

[^4]: Moore, Jennifer, and Hannah Scates Kettler. “Who Cares About 3D Preservation?” _IASSIST Quarterly_ 42, no. 1 (2018): 15–15. [https://doi.org/10.29173/iq20](https://doi.org/10.29173/iq20).

[^5]: Shaw, Jonathan. “Digital Preservation: An Unsolved Problem | Harvard Magazine,” April 7, 2010. [https://www.harvardmagazine.com/2010/04/digital-preservation-an-unsolved-problem](https://www.harvardmagazine.com/2010/04/digital-preservation-an-unsolved-problem).

[^6]: Jones, Steven. “Reverse Engineering the First Humanities Computing Center.” _Digital Humanities Quarterly_ 12, no. 2 (2018). [https://www.digitalhumanities.org/dhq/vol/12/2/000380/000380.html](https://www.digitalhumanities.org/dhq/vol/12/2/000380/000380.html).

[^7]: Montfort, Nick, and Ian Bogost. 2009. _Racing the Beam: The Atari Video Computer System_. Platform Studies. Cambridge, Mass: MIT Press.

[^8]: Henry Jenkins. “A New ‘Platform’ for Games Research?: An Interview with Ian Bogost and Nick Montfort (Part One) — Pop Junctions,” April 27, 2009. [http://henryjenkins.org/blog/2009/04/an*interview*with*ian*bogost\*a.html](http://henryjenkins.org/blog/2009/04/an_interview_with_ian_bogost_a.html).

[^9]: CLIR. “Digital Forensics and Born-Digital Content in Cultural Heritage Collections • CLIR.” Accessed April 22, 2025. [https://www.clir.org/pubs/reports/pub149/](https://www.clir.org/pubs/reports/pub149/).

[^10]: Levy, Scott, and Jedidiah R. Crandall. “The Program with a Personality: Analysis of Elk Cloner, the First Personal Computer Virus.” arXiv, July 30, 2020. [https://doi.org/10.48550/arXiv.2007.15759](https://doi.org/10.48550/arXiv.2007.15759) and Giacalone, Anthony. “Agiacalone/Elk-Cloner-Malware.” Assembly, April 21, 2024. [https://github.com/agiacalone/elk-cloner-malware](https://github.com/agiacalone/elk-cloner-malware).

[^11]: Albertini, Ange. "Fearsome File Formats." Chaos Communication Congress. Hamburg, Dec 2024. 45min. [https://media.ccc.de/v/38c3-fearsome-file-formats](https://media.ccc.de/v/38c3-fearsome-file-formats) and Albertini, Ange. "Funky File Formats, Advanced Binary Tricks." Chaos Communication Congress. Hamburg, Dec 2014. 51min. [https://media.ccc.de/v/31c3_-_5930_-_en_-_saal_6_-_201412291400_-_funky_file_formats_-_ange_albertini](https://media.ccc.de/v/31c3_-_5930_-_en_-_saal_6_-_201412291400_-_funky_file_formats_-_ange_albertini).

[^12]: Biittner, Katie, and John Aycock. “Inspecting the Foundation of Mystery House | Journal of Contemporary Archaeology.” Accessed May 21, 2025. [https://journal.equinoxpub.com/JCA/article/view/17513](https://journal.equinoxpub.com/JCA/article/view/17513).

[^13]: Aycock, John. “Amnesia Remembered: Reverse Engineering a Digital Artifact.” In _Amnesia Remembered_. Berghahn Books, 2023. [https://doi.org/10.1515/9781800738683](https://doi.org/10.1515/9781800738683).

[^14]: Aycock, John, and Tara Copplestone. “Entombed: An Archaeological Examination of an Atari 2600 Game.” _The Art, Science, and Engineering of Programming_ 3, no. 2 (November 5, 2018): 4. [https://doi.org/10.22152/programming-journal.org/2019/3/4](https://doi.org/10.22152/programming-journal.org/2019/3/4).

[^15]: Aycock, John, Shankar Ganesh, Katie Biittner, Paul Allen Newell, and Carl Therrien. “The Sincerest Form of Flattery: Large-Scale Analysis of Code Re-Use in Atari 2600 Games.” In _Proceedings of the 17th International Conference on the Foundations of Digital Games_, 1–10. Athens Greece: ACM, 2022. [https://doi.org/10.1145/3555858.3555948](https://doi.org/10.1145/3555858.3555948).

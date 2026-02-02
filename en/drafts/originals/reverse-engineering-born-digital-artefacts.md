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
difficulty:
activity:
topics:
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

This lesson provides a gentle introduction to the technical skills required for the analysis of digital artifacts. These are more than just their visible content; they exist within interwoven layers that shape their function and meaning. Technically, they are embedded in systems of file formats, applications, operating systems, and hardware, but they are also influenced by environmental factors such as infrastructure, data centers, and socio-economic conditions.

The aim of this lesson is to enable readers to take their first steps in reverse engineering using **hex viewers**, which serve as an indispensable tool for initial analysis in reverse engineering and digital archaeology. The lesson begins with an overview of reverse engineering and software archaeology. Following this introduction to the research field, we dive into analysis using hex editors through two case studies. The case involves two examples of how digital formats can be recognized in modern computer architecture and illustrates the need to look beyond what is presented to us on the screen. The second one is an investigation of a “cracked” Commodore 64 video game from 1984, in which we combine reverse engineering with research into the history of digital technologies.

By introducing the analysis of file signatures, metadata, and structural anomalies, this lesson provides a introductionary understanding of how digital artifacts are constructed. Readers will be empowered to use hex viewer to interpret complex objects and to begin engaging with the digital sources in their own research, from proprietary formats to historical databases.

Rather than advancing a theoretical argument, this lesson is structured as a hands-on tutorial that teaches a small set of transferable analytical practices for working with born-digital artifacts. At the end of this lesson you will be able to

- explain what reverse engineering is and why it is useful for analyzing born-digital artifacts in historical research.
- identify instances of “screen essentialism” and explain their limitations for historical analysis.
- use a hex viewer to inspect the raw data of digital files and perform comparative hex dump analysis to detect and interpret anomalies.

You will also have made your first steps regarding

- applying digital archaeology techniques to investigate modified or cracked software, uncovering evidence of historical, cultural, or technical interventions.
- evaluating the limitations and challenges of reverse engineering, especially in the absence of original documentation or open-source code.

It is important to highlight that reverse engineering and working with born-digital artifacts can be a daunting endeavor, given all the different configurations of hard- and software and all the knowledge and skills that can be involved in this research domain. No matter what the research object is, it all begins with the simple realization, that there is always more to a digital artifact then is visible at first glance. This lesson will help with this realization and should be regarded as a first step in developing your own research strategies.

### Prerequisites and technical requirements

All necessary files and digital artifacts required for this lesson are provided. You do not need to source your own materials to follow the exercises; however, the skills learned here are designed to be applied to your own future research objects.
There are three fundamental technical requirements for this lesson that form the foundation of our digital archaeology approach.

1. The first requirement centres on having appropriate tools to transform digital artifacts into a more accessible and analyzable state. While numerous tools and methodologies exist for this purpose, we begin with a straightforward yet powerful hex viewer, which allows us to examine the raw binary data of digital files. A hex viewer displays the hexadecimal representation of binary data[^1], making it possible to see patterns, headers, and structures that are otherwise hidden from conventional file viewers. We recommend using the command line tool `hexyl` or the browser-based [HexEd.it](https://hexed.it/) for reliable options that provide the necessary functionality for beginners while maintaining the depth required for more advanced analysis. For the examples in this lesson, we will exclusively use `hexyl`.
2. Given our focus on a command line tool (`hexyl`), we expect you to be comfortable with this environment. We give examples throughout the lesson that can be copy/pasted, but some basic understanding of the Linux, macOS, or Windows shells will improve your digestion of this lesson. If you want to learn more about working in shell environments, Programming Historian has lessons on [Bash](https://programminghistorian.org/en/lessons/intro-to-bash) for Linux (and to some extent macOS), and [PowerShell](https://programminghistorian.org/en/lessons/intro-to-powershell) for Windows.
3. The third and last requirement involves acquiring suitable born-digital objects for analysis, which varies significantly depending on your specific research question and can encompass digital images, databases, software applications, and various other digital artifacts. While we provide curated digital artifacts for the two case studies presented in this lesson, the broader challenge lies in identifying and accessing appropriate materials for independent research, which we can't cover in this lesson.

## Reverse Engineering born-digital Media artifacts

In the study of born-digital artifacts, historians are increasingly confronted with the limitations of interpreting digital materials solely through their surface appearance — as they might appear in standard applications such as an operating system's media viewer. This issue, often described as _screen essentialism_[^2], refers to the tendency to understand digital objects only as they appear on screens rather than as complex, encoded structures with multiple layers of meaning. For the historian working with digital sources, this presents a significant methodological challenge: how can we analyse digital artifacts not just as static images or text, but as dynamic objects shaped by code, metadata, file formats, and usage contexts?

Born-digital artifacts, such as software, websites, digital photographs and videos, PDFs, databases, and other digital materials require us to rethink conventional source analysis. Unlike digitized analogue objects, which carry with them an assumed physical origin, born-digital materials are native to code. Their meaning is not only derived from their on-screen appearance, but also from how they are stored, processed, and rendered. Overlooking these dimensions can lead to shallow readings and a failure to grasp how digital media shape, constrain, and enable different forms of historical expression and evidence.

This is where the practice of reverse engineering offers a compelling methodological pathway. Reverse engineering, broadly construed, involves opening and deconstructing digital objects to understand how they work, what they are made of, and how their structures shape their meanings. It can include investigating a file’s metadata, altering or corrupting digital files to observe their behaviour, or reading against the grain of the interface to recover invisible labour, intentions, or constraints embedded in the technology. For historians, reverse engineering is not just a technical tool but a critical mode of inquiry that allows us to interrogate the digital record, challenge surface-level readings, and engage with digital artifacts on their own terms.

While preservation remains an important backdrop to this work, particularly in considering what aspects of digital artifacts are retained or lost over time[^3], this lesson focuses on reverse engineering as a form of historical analysis. By examining digital objects beyond the screen, we aim to demonstrate how this approach opens new avenues for interpretation, revealing the layered and often contradictory nature of digital evidence. This lesson introduces reverse engineering as a practical methodological approach that historians can use to investigate born-digital artifacts beyond their surface appearance.


### Why use reverse engineering?

Digital historians, much like archaeologists meticulously uncovering hidden layers of the past, employ reverse engineering to reveal the intricate architectures underlying software and digital file formats. Most contemporary digital technologies are effectively closed-source, leaving historians unable to see beyond their outward behavior. Proprietary systems are “black box[es] that cannot be opened”[^4], and without source code or documentation, their inner mechanisms remain invisible, which makes research and discoveries nearly impossible[^5]. Even preserved digital artifacts risk becoming unreadable without the original software or hardware, as data can remain “perfectly secure and complete, but still be unreadable” in the future[^6]. Reverse engineering—“writing the missing manual” for “lost, secret, or otherwise obscured technologies”[^7]—offers historians one of the few ways to study these opaque systems[^8] [^9] [^10]. By transcending screen essentialism, reverse engineering reveals the deeper structural, functional, and contextual layers of digital artifacts. This aligns closely with digital source criticism, recognizing digital objects as part of broader technological and socio-economic frameworks.

Digital artifacts, whether video games, databases, images, or malware, contain layers of information inaccessible through standard interfaces. Reverse engineering serves as a key methodology to uncover these hidden layers. By exploring a file’s internal construction, behavior under manipulation, and embedded metadata, historians can retrieve undocumented data, chart software evolution, and reconstruct historical contexts. This method is particularly crucial when studying closed-source systems, providing historians with a practical means to "write the missing manual" and document digital heritage even in the absence of original source code or documentation.

File structures and formats are especially interesting from a historical malware research perspective. One of the first computer viruses discovered in the wild, the Elk Cloner virus spread by attaching itself to a disk’s boot sector and activated whenever the infected disk was inserted into an Apple II computer.[^11] Around the same time, in early hacking culture, steganography — the art of hiding code or messages in images — also became a popular topic on message boards.[^12] If you want to dive deeper into file structures and formats, check out the work of Ange Albertini, a well-known security researcher who explores unusual file formats. His presentation, "Funky File Formats," at the chaos communication congress explores the concept of polyglot files—single files that are valid under multiple formats simultaneously[^13]. This exploration reveals how such files can function differently depending on the application interpreting them, offering unique insights into file format manipulation. Building upon this, Albertini developed Mitra, a tool designed to assist in crafting files that conform to multiple format specifications, streamlining the process of creating complex polyglots. Additionally, his Corkami project offers a comprehensive collection of hex patterns that illustrate various file format structures and anomalies, serving as a valuable reference for understanding the binary composition of different file types. For us digital Historians, it is essential to understand digital media artifacts as a structured or sometimes seemingly unstructured pile of binary data. One of the first jobs we do is to try to understand the underlying structure of those files. Engaging with resources like the Corkami project can deepen your understanding of file formats and uncover the hidden complexities within digital files, enhancing your skills in reverse engineering and digital archaeology.​

Reverse engineering, at its core, involves deconstructing a finished product to understand how it was made—a process that essentially takes the original engineering process and runs it in reverse, enabling the discovery of the design principles, coding techniques, and creative decisions embedded in its creation. But why invest time in reverse engineering old games, software of viruses? There are several motivations behind this practice. Historical preservation plays a significant role. Just as historians study traditional art and literature to understand human culture, examining Media artifacts like video games offers a window into the creative and technical history of modern digital culture. The act of reversing becomes a game in itself, where the challenge lies in unravelling the original developer's work.

{% include figure.html filename="en-or-reverse-engineering-born-digital-artefacts-01.png" alt="The illustration shows a stack of rectangles, on top of each other, each containing a label and standing for a layer. Some rectangles are also overlapping or divided into smaller units. On the left side are the labels software and hardware to illustrate which layers belong to which category. The software category on top contains layers such as applications and operating system. Among the the bottom hardware category are layers such as processor, memory, transistor and others." caption="Figure 1. Schematic visualization of a computer's hardware and software layers." %}

A computer operates through a layered architecture, where hardware and software components work together to process and execute instructions. At the lowest level, transistors form the building blocks of digital circuits, which combine to create processors, memory, and input/output (I/O) systems. These hardware components are managed through the instruction set architecture (ISA), which defines how the processor interprets and executes machine code. Firmware and assemblers translate low-level machine code into instructions the hardware can execute, while higher-level software like compilers and interpreters convert human-readable code into machine instructions. The operating system serves as a bridge between hardware and software, managing system resources and enabling applications to run smoothly.

Understanding this architecture is crucial for reverse engineering because it allows engineers to trace how high-level software instructions translate into low-level machine code and hardware operations. This knowledge helps in uncovering hidden functionalities, debugging errors, analyzing malware behaviour, and modifying or improving existing software. Reverse engineering often involves working at the boundary between software and hardware, requiring an in-depth understanding of how compilers, assemblers, and the instruction set architecture interact to produce executable code.

## The inner life of born-digital Media artifacts

Before beginning this hands-on analysis, you'll need to gather the necessary materials and tools to effectively examine digital image formats. First, get the sample files we provide for this exercise, [which you can download through this link](https://github.com/programminghistorian/ph-submissions/raw/refs/heads/gh-pages/assets/reverse-engineering-born-digital-artefacts/reverse-engineering-born-digital-artefacts.zip). If you feel confident enough to work with out own material, select a JPEG file with either a .jpg or .jpeg file extension that you'd like to analyse—this can be any digital photograph or image from your personal collection. The choice of image isn't critical for learning the fundamental concepts, though selecting something familiar to you may make the analysis more engaging and meaningful. We also note that all following instructions are provided for our provided files. Next, you'll need to install a hex editor that will serve as your primary tool for examining the binary structure of the JPEG file.

A hex viewer can create hex dumps, which are textual representation of computer data in hexadecimal format, achieved by converting bytes into a two-digit hexadecimal number. This makes raw binary data more human-readable and easier to interpret for reverse engineering, or forensic analysis. There are several tools available for viewing hex data from a file. For our lesson, we will use `hexyl` as mentioned. We chose it primarily because we appreciate its functionality and simplicity. Installation packages are provided for most Linux distributions, for [macOS](https://github.com/sharkdp/hexyl?tab=readme-ov-file#on-macos) and [Windows](https://github.com/sharkdp/hexyl?tab=readme-ov-file#on-windows), and [instructions are provided on the tool's website](https://github.com/sharkdp/hexyl?tab=readme-ov-file#installation).

The first case study focuses on practicing two core skills introduced in the learning objectives: identifying file signatures in a hex dump and reasoning about file structure independently of file extensions or graphical interfaces.


### The _bit_ code of an image

To illustrate the fundamentals of file analysis, we begin with the basic structure of a JPEG file. For this exercise, we have provided a file named `cat-with-hidden-content.jpg` within the `jpg_zip` folder. When you open this file using your computer's standard image viewer, it appears as a simple, humorous photo of a cat.

{% include figure.html filename="en-or-reverse-engineering-born-digital-artefacts-03.jpeg" alt="The photo shows a rather silly cat on a couch. The cat looks upwards and has its tongue out, making it look like a defiant kid. It's an orange tabby cat with fluffy fur and the couch is upholstered in grey cotton fabric." caption="Figure 3. The file cat-with-hidden-content.jpg displayed in a standard image viewer." %}

While the image viewer displays a visual scene, the underlying JPEG format follows a clearly defined architecture. It begins with a file signature (or “magic number”) that identifies the file type, followed by metadata, the compressed image data, and finally, an end-of-file marker. This predictable structure is what allows software to recognize and "parse" (interpret) the data correctly.

The infographic below provides a visual breakdown of this "bit code." You do not need to memorize every byte at this stage; rather, use this as an introduction to the structural markers that allow us to navigate a digital artifact.

{% include figure.html filename="en-or-reverse-engineering-born-digital-artefacts-02.png" alt="The illustration shows a color-coded hex dump on the left side. Some of the output is highlighted and connected with a dashed line to detailed explenations on the right side, indicating where the start of the image is, or where one could find more information about the files format." caption="Figure 2. Infographic annotating a JPEG's file header in hexadecimal notation. (Ange Albertini 2022 – CC-BY 4.0 )" %}

#### The Standard Pattern

When we open the provided sample JPEG `cat-with-hidden-content.jpg` within the `jpg_zip` folder with an hex viewer, the hex view immediately exposes this structure. The file signature (FF D8 FF E0) at the beginning confirms its identity. Beyond the header, we find metadata describing dimensions and color depth, followed by the bulk of the file: compressed image data, which appears as a seemingly random string of hexadecimal values. 

To see this for yourself, navigate to the picture in a terminal of your choice. The following command is using hexyl to shows the hex code of the file. The `-n` option tells hexyl to only display the first 256 bytes. The `$` sign indicates a command to be copied into the terminal (so do not copy the $ itself).

```shell
$ hexyl cat-with-hidden-content.jpg -n 256
```

Executing this command will give us the following output. The leftmost column is the address of the line of data we see. The second and third columns show our data in hexadecimal notation, which we can investigate when we know what to look for. The two last columns is our data shown as ASCII interpretation. This simply means that hexyl renders the data as ASCII characters where possible, allowing human-readable text to appear alongside the hexadecimal values. It's those two columns which are of interest to our investigation if we're interested in text that was meant for humans to read. Limiting the output to the first 256 bytes allows us to focus on the file header and metadata without being overwhelmed by the full image data, which would be several tousand lines of output for this small image alone.

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

The file signature `FF D8 FF E0` at the beginning confirms that it is a JPEG file. A PNG file, as another example, would start with `89 50 4E 47 0D 0A 1A 0A` [^14]. Following that is information regarding metadata fields describing the image’s dimensions, color depth, and encoding settings, which is not of importance for our case here. The bulk of the file contains compressed image data, which appears as a seemingly random string of hex values.

#### Challenging "Screen Essentialism": The Hybrid Artifact

While the standard JPEG ends predictably, digital artifacts can have "dual identities" by exploiting how different software "reads" or parses data. This challenges "screen essentialism"—the idea that a file is only what the icon on our desktop says it is.

To demonstrate this, we will analyze `cat-with-hidden-content.jpg` again. While it appears to be a standard image, a hex dump reveals a second structural paradigm. JPEGs are read from the top down and stop at an "End of Image" (EOI) marker. ZIP files, conversely, are typically parsed from the bottom up. This different standards allow the appending of a ZIP archive to the end of a JPEG, resulting in a hybrid file that remains valid for both an image viewer and an archive utility.

The following command uses hexyl again and adds a `|` "(pipe") to pass the full hex dump from hexyl to the `grep` utility[^15], which searches the output by `ff d9` and simply prints the surrounding 10 lines.

```shell
$ hexyl cat-with-hidden-content.jpg | grep -i -A 5 -B 5 'ff d9'
```

`ff d9` is the JPEG's EOI marker. Immediately following it, the trained eye will see the ZIP file signature: `50 4b 03 04`. You'll find these on the sixth line of our provided output bellow. By focusing on this specific location of the file, which is towards the end, you can directly observe the "seam" where the JPEG image data stops and a hidden ZIP structure begins.

```shell
│000318b0│ 33 90 68 10 43 2c bb 77 ┊ 20 e4 8e be 95 37 98 e1 │3×h•C,×w┊ ××××7××│
│000318c0│ 40 24 11 de a8 42 ce 17 ┊ ef 71 ed 52 ee fb c8 7d │@$•××B×•┊×q×R×××}│
│000318d0│ 3a d3 02 c4 4c 16 e7 00 ┊ fc ad 4c bc 8d a1 90 b2 │:×•×L•×⋄┊××L×××××│
│000318e0│ 8c 81 ce 6a ac 32 12 36 ┊ 9e ab de a6 98 b3 a8 05 │×××j×2•6┊×××××××•│
│000318f0│ 8e 18 e0 d0 00 2e d7 03 ┊ 9a 29 be 42 7a 51 40 1f │×•××⋄.×•┊×)×BzQ@•│
│00031900│ ff d9 50 4b 03 04 0a 00 ┊ 00 00 00 00 51 3d b6 5a │××PK••_⋄┊⋄⋄⋄⋄Q=×Z│
│00031910│ dd dd 14 7d 0d 00 00 00 ┊ 0d 00 00 00 12 00 1c 00 │××•}_⋄⋄⋄┊_⋄⋄⋄•⋄•⋄│
│00031920│ 68 69 64 64 65 6e 2d 63 ┊ 6f 6e 74 65 6e 74 2e 74 │hidden-c┊ontent.t│
│00031930│ 78 74 55 54 09 00 03 4a ┊ b9 2e 68 4a b9 2e 68 75 │xtUT_⋄•J┊×.hJ×.hu│
│00031940│ 78 0b 00 01 04 e8 03 00 ┊ 00 04 e8 03 00 00 48 65 │x•⋄••×•⋄┊⋄•×•⋄⋄He│
│00031950│ 6c 6c 6f 20 57 6f 72 6c ┊ 64 21 0a 50 4b 01 02 1e │llo Worl┊d!_PK•••│
```

You might wonder: if we simply "glue" two files together, why doesn't the computer get confused? The answer lies in the structural paradigms of different file formats. A JPEG is a linear format; a image viewer starts at the top and stops as soon as it hits the `ff d9` (End of Image) marker. It simply ignores anything that follows. A ZIP file, however, operates on a linked or indexed paradigm. Most archive utilities do not read a ZIP from the beginning. Instead, they "seek" to the very end of the file to find the "End of Central Directory" (EOCD) record. The EOCD acts like a book's index, telling the computer exactly where each file starts within the archive. Because the ZIP utility looks at the footer (the end) rather than the header (the beginning), it doesn't care that there is a cat photo sitting on top of its data.

If you are curious to see what we packed in the hidden ZIP file, rename `cat-with-hidden-content.jpg` to `cat-with-hidden-content.zip` and unzip it with the archive tool of your operating system. 

Identifying file signatures is a fundamental skill for reverse engineering born-digital records. Because file extensions can be misleading or intentionally changed, we must learn to look past the desktop icon to the data's underlying structure. Instead, we use computational searches with an hex viewer to "fingerprint" the data structure. This example is intentionally simplified to provide a controlled environment for practicing hex-dump analysis before moving to less structured historical artifacts.

### From Binary to XML: Comparing .doc and .docx

Beyond the playful scenario of JPEGs and ZIPs, these same analytical skills allow historians to track the evolution of the digital record itself. As noted in our introduction, born-digital artifacts are often "black boxes" of proprietary code. A prime example of this is the massive shift in how Microsoft Word stored data in the mid-2000s. By comparing a legacy `.doc` file with a modern `.docx` file, we can see a move from the opaque, binary structures of the past toward the open-standard containers of the present.

The older `.doc` format (predominant until 2007) is a complex binary format. If you open a such a file in a hex viewer, the actual text is often buried within layers of proprietary logic.

```shell
$ hexyl old-word-document.doc -n 256

┌────────┬─────────────────────────┬─────────────────────────┬────────┬────────┐
│00000000│ d0 cf 11 e0 a1 b1 1a e1 ┊ 00 00 00 00 00 00 00 00 │××•×××•×┊⋄⋄⋄⋄⋄⋄⋄⋄│
│00000010│ 00 00 00 00 00 00 00 00 ┊ 3e 00 03 00 fe ff 09 00 │⋄⋄⋄⋄⋄⋄⋄⋄┊>⋄•⋄××_⋄│
│00000020│ 06 00 00 00 00 00 00 00 ┊ 00 00 00 00 05 00 00 00 │•⋄⋄⋄⋄⋄⋄⋄┊⋄⋄⋄⋄•⋄⋄⋄│
│00000030│ 0f 02 00 00 00 00 00 00 ┊ 00 10 00 00 11 02 00 00 │••⋄⋄⋄⋄⋄⋄┊⋄•⋄⋄••⋄⋄│
│00000040│ 01 00 00 00 fe ff ff ff ┊ 00 00 00 00 0a 02 00 00 │•⋄⋄⋄××××┊⋄⋄⋄⋄_•⋄⋄│
│00000050│ 0b 02 00 00 0c 02 00 00 ┊ 0d 02 00 00 0e 02 00 00 │••⋄⋄_•⋄⋄┊_•⋄⋄••⋄⋄│
│00000060│ ff ff ff ff ff ff ff ff ┊ ff ff ff ff ff ff ff ff │××××××××┊××××××××│
│*       │                         ┊                         │        ┊        │
│00000100│                         ┊                         │        ┊        │
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘
```

When you inspect a legacy document, you will likely see the signature `D0 CF 11 E0`. This identifies an "OLE2" (Object Linking and Embedding) container. As we discussed in the section on [reverse engineering](#reverse-engineering-born-digital-media-artifacts), such files are non-human-readable without specialized tools. For the historian, this format represents the height of "screen essentialism": we see a formatted page on the screen, but the underlying code is a proprietary maze that is difficult to preserve or read against the grain. The transition to `.docx` changed the nature of the artifact. Under the hood, a modern Word document is actually a ZIP archive in disguise, containing a collection of XML files that describe the document’s text and structure.

To verify this, run hexyl on the provided modern-document.docx:

```shell
$ hexyl modern-word-document.docx -n 256

┌────────┬─────────────────────────┬─────────────────────────┬────────┬────────┐
│00000000│ 50 4b 03 04 14 00 06 00 ┊ 08 00 00 00 21 00 1c 41 │PK•••⋄•⋄┊•⋄⋄⋄!⋄•A│
│00000010│ a8 2e 66 01 00 00 54 05 ┊ 00 00 13 00 08 02 5b 43 │×.f•⋄⋄T•┊⋄⋄•⋄••[C│
│00000020│ 6f 6e 74 65 6e 74 5f 54 ┊ 79 70 65 73 5d 2e 78 6d │ontent_T┊ypes].xm│
│00000030│ 6c 20 a2 04 02 28 a0 00 ┊ 02 00 00 00 00 00 00 00 │l ×••(×⋄┊•⋄⋄⋄⋄⋄⋄⋄│
│00000040│ 00 00 00 00 00 00 00 00 ┊ 00 00 00 00 00 00 00 00 │⋄⋄⋄⋄⋄⋄⋄⋄┊⋄⋄⋄⋄⋄⋄⋄⋄│
│*       │                         ┊                         │        ┊        │
│00000100│                         ┊                         │        ┊        │
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘
```

Notice the signature: `50 4B 03 04`. This is the exact same ZIP signature we identified in our cat image with the hidden ZIP file embedded. This discovery is a perfect example of why “signature hunting” is a foundational skill for digital archaeology. Recognizing this pattern allows a historian to bypass the word processor entirely; the file extension can simply be changed to `.zip` and the contents decompressed to reveal the raw XML text. This transparency represents a significant departure from the OLE2 “black box” of the `.doc` era. The JPEG end-of-file marker and the ZIP central directory demonstrate a broader class of techniques for examining born-digital files whose internal structures are explicitly documented and self-describing. In both cases, the analytical task involved identifying recognizable signatures, comparing files that differ in controlled ways, and reasoning about file structure through hexadecimal inspection rather than relying on application-level tools.

Identifying such structural signatures is the first step in what might be described as “writing the missing manual” for a file. However, reverse engineering often requires more than locating signatures alone; it also requires attention to change. The value of these examples lies not in the novelty of file concatenation, but in practicing how to reason about file structure through direct inspection, comparison, and documented format constraints.

These same low-level analytical skills—hex-dump inspection, signature recognition, comparative analysis, and attention to file size—are reused in the following case study, even though the object of analysis is fundamentally different. We will look into a cracked Commodore 64 video game, that was published in 1984.

Commodore 64 disk images lack standardized file headers, explicit end-of-file markers, or central indexes comparable to those found in JPEG or ZIP formats. Instead, meaning must be inferred from patterns in raw byte sequences, repetition across multiple disk images, and anomalies that cannot be explained by normal execution. The purpose of the C64 example is therefore not to apply file-format knowledge directly, but to demonstrate how these methods remain useful even when formal structural documentation is absent, and how they can be used to identify deliberate human intervention in binary code by a specific historical community: game crackers.

This second case study applies the same analytical practices to a materially different artifact. Rather than relying on documented file formats, readers will practice comparative analysis across multiple binary files to identify anomalies that signal human intervention. The goal is not to master Commodore 64 internals, but to reuse the skills introduced earlier—hex inspection, comparison, and pattern recognition—under more historically realistic conditions.

## Reverse Engineering a cracked Commodore 64 Game

The second case study examines a cracked Commodore 64 game and applies the analytical practices introduced above to a materially different artifact, where file structure must be inferred rather than read from documented specifications. It extends the analytical approach introduced earlier to a born-digital object that lacks a standardized, self-describing file format. While the hex dump technique presented in the first case serves as a starting point, this case requires a shift from single-file analysis to the comparative examination of multiple disk images of the same commercial game release. Rather than working toward a full reverse engineering of the software, the aim is to demonstrate how historians can locate, isolate, and contextualize anomalous data by identifying differences across disk images that cannot be explained by normal distribution or execution, using only basic tools and careful comparison. This approach expands the earlier hex-dump peeking method through further investigation of file types and elementary comparison techniques, offering a practical point of entry into the reverse engineering of more complex digital objects.

Game cracking evolved beyond mere piracy into a sophisticated technical pursuit that demonstrated programming skill and ingenuity. Crackers not only removed copy protection but also enhanced games with custom intro screens, gameplay modifications, language translations, performance optimizations, and new functionality. These specialized reverse engineers required detailed knowledge of assembly language and hardware, as well as an understanding of how to deconstruct and rebuild programs to suit their purposes.

### SCA’s Summer Games

"Summer Games" is a sport competition game for the Commodore 64 published in 1984, in which different nations can compete in different sport fields. The Swiss Crackers Association (SCA) modified the game by adding the missing Swiss flag and anthem, demonstrating how reverse engineering served as cultural expression beyond mere copy protection removal. This modification required both technical skill to analyse the game's data structures and artistic sensitivity to maintain coherence with the original design, effectively claiming digital representation for Swiss identity.

SCA emerged in the mid-1980s as a notable multilingual collective that bridged European cracking scenes while developing elegant reverse engineering techniques. Their historical significance extends beyond cracking to creating one of the first Commodore 64 viruses and eventually transitioning to the demo scene—an evolution from circumvention to creative coding. Unlike many contemporaries, SCA maintained comprehensive documentation of their techniques, providing invaluable records for digital historians studying early cracking culture.

We've selected this specific SCA crack as our case study due to its research value for digital history, allowing us to reconstruct technical practices by examining disassembled code while revealing motivations beyond technical prowess. The addition of Swiss representation to an international sports game points to questions of national identity in early digital culture, showing how software became a platform for cultural expression and representation for communities overlooked in commercial products. The crack's code serves as a primary historical source that complements oral histories and other artifacts, transforming reverse engineering into a form of digital archaeology that expands our historical toolkit. When combined with ethnographic interviews, cracking documentation analysis, and media studies approaches, this technical examination reveals how knowledge circulated through informal pre-internet networks and provides a multidimensional understanding of early digital culture impossible through conventional historical methods alone.

### Getting Started

For this part of the lesson, we will work with files that we extracted from a disk image, and [you can download the necessary material via this archive.org link](https://archive.org/details/summer_games_clean-sca). In the archive you'll find a cracked[^16] and a supposedly clean[^17] version of the Commodore 64 game “Summer Games”. At this point we need to highlight that the original game from 1984 is the intellectual property of Epyx Computer Software, which means that it is under copyright protection. Downloading the game for research can be argued to fall under fair use, but such an evaluation is not guaranteed. Fair use in research is often favoring criticism, scholarship, or preservation, and highly depends on national doctrines of copyright law. In Switzerland, for example, downloading the _Summer Games_ for research purposes is generally legal under the Federal Act on Copyright and Related Rights (CopA), even from unauthorized sources. This highlights another important aspects. Accessing and researching born-digital artifacts is not only depending on technical skills or the right kind of methodological setup, but also on legal applications that can change in time and geographical delineations.

A first glance at the archive tells us that those games come as `.d64` files, which is a disk image—a virtual representation of a physical disk’s content. Since we are interested in investigating the cracked version, we need to contextualize our digital artefact towards that. A standard Commodore 64 `.d64` disk image file does not preserve most hardware-based copy protections, which was common. The `.d64` format is a logical sector image that captures only the decoded data payload. Consequently, it lacks the GCR (Group Coded Recording) level information (such as sync marks, deliberate block errors, or custom inter-sector gaps) required to bypass the hardware-level copy protection schemes prevalent in the C64 era.[^18]. As a result, games or software with sophisticated disk-based copy protection often cannot be run or properly emulated from a `.d64` image. For preserving original disks with copy protection intact, the `.g64` format is preferred, as it stores the low-level GCR data required for these mechanisms to function.

Finally, most `.d64` images available today have had their copy protection removed or bypassed to work in emulators. This would indicate that our virtual image of the cracked game might not contain everything we need to fully investigate this case. Let us have a closer look and compare our two versions. Since `.d64` is a container format, we need to unpack and reveal the container’s content first. There are many tools offering such a service, such as [C64-Tools](https://www.c64-tools.com/basic-2-extractor) or [DirMaster](https://style64.org/dirmaster). We prepared this step by using the Floppy Disk Emulator that comes with VICE, an emulator for the Commodore 64, and moved the dumped files to the respective folders `summer_games/content/clean` and `summer_games/content/sca`. In these two folders, you will find files without a file extension, that contain binary data as well as source code.

### Comparing the Game's different Versions

It is generally a good approach to go from an overview of the material at hand and start to concentrate on specific aspects that might seem interesting afterwards [^19]. To get a better understanding of what we are dealing with in this specific case, we first check for content and file size. We can do so with `ls`, which is a shell tool that lists folders and files and lets us know about some of their details, like size or when they have been changed the last time.

```shell
$ ls -l content/clean && ls -l content/sca
```

This results in a comparison of the two folders' files, first the clean version, followed by the cracked version. The following is an abreviated output. The first column shows the filesize in bits, and the second the file name. Depending on your shell environment, you will get more information from this command, which are not relevant for our analysis right now.

```shell
# Listing of the clean version
10140  a
10641  b
19833  d
  162  default
15571  e
 9489  f
23000  h
21290  i
 9757  k
 1138  l
  893  loader
 1121  m
   73 'summer games'
  162  wr

# Listing of SCA's cracked version
10140  a
10894  b
  893  c
19833  d
15571  e
 9489  f
23000  h
21290  i
 9757  k
 1144  l
 1121  m
  312 'summer games'
  162  wr
```

Both disk images seem almost identical. The files `a`, `d`, `e`, `f`, `h`, `i`, `k`, `m`, and `wr` are present on both disks, with identical file sizes. File `c` is not present in the clean version, whereas files `default` and `loader` are not present on the cracked one. Files `b`, `l` and `summer games` are present on both images, but differ in file size. This gives us a first indication of where to start, by figuring out where the two versions differ.

| File Name      | Clean Version     | SCA Cracked Version | Investigate? |
| :------------- | ----------------- | ------------------- | :----------: |
| a              | equal             |                     |              |
| b              | file sizes differ |                     |      ✅      |
| c              | not present       |                     |      ✅      |
| d              | equal             |                     |              |
| default        |                   | not present         |      ✅      |
| e              | equal             |                     |              |
| f              | equal             |                     |              |
| h              | equal             |                     |              |
| i              | equal             |                     |              |
| k              | equal             |                     |              |
| l              | file sizes differ |                     |      ✅      |
| loader         |                   | not present         |      ✅      |
| m              | equal             |                     |              |
| ‘summer games’ | file sizes differ |                     |      ✅      |
| wr             | equal             |                     |              |

Before checking the marked files, it is important to note that this is not foolproof. A note that got published alongside the clean version on archive.org mentions that “\[t\]here is some high score save data in the `WR` file from previous players.” This indicates that some of the files are of variable content. If the file `wr` holds high scores, its abbreviation indicates most likely “World Records”, given the context of the game. A hex dump of the two files quickly unveils their difference.

```shell
$ hexyl content/clean/wr && hexyl content/sca/wr
```

```shell
# Hexdump of the clean versions wr file
hexyl content/clean/wr && hexyl content/sca/wr

# Hexdump of SCA's versions wr file
┌────────┬─────────────────────────┬─────────────────────────┬────────┬────────┐
│00000000│ 00 0b 45 49 44 47 45 4e ┊ 4f 53 53 20 20 20 35 2e │0•EIDGEN┊OSS   5.│
│00000010│ 38 30 b8 0c 00 00 43 4e ┊ 30 44 45 42 52 30 5a 20 │80×_00CN┊0DEBR0Z │
│00000020│ 20 36 36 35 2e 39 30 90 ┊ 65 06 45 4e 47 4c 41 4e │ 665.90×┊e•ENGLAN│
│00000030│ 44 20 20 20 20 32 3a 31 ┊ 39 2e 33 cd ec fd 55 2e │D    2:1┊9.3×××U.│
│00000040│ 53 2e 41 2e 20 20 20 20 ┊ 20 20 30 39 2e 31 31 ee │S.A.    ┊  09.11×│
│00000050│ f6 ff 55 2e 53 2e 53 2e ┊ 52 2e 20 20 20 31 31 2e │××U.S.S.┊R.   11.│
│00000060│ 39 20 20 77 77 77 42 52 ┊ 41 5a 49 4c 20 20 20 20 │9  wwwBR┊AZIL    │
│00000070│ 20 31 3a 34 38 2e 36 9f ┊ b7 fe 4a 41 50 41 4e 20 │ 1:48.6×┊××JAPAN │
│00000080│ 20 20 20 20 20 30 3a 32 ┊ 36 2e 34 bf d9 ff 43 48 │     0:2┊6.4×××CH│
│00000090│ 4e 30 44 45 42 52 30 5a ┊ 20 20 20 20 20 32 35 25 │N0DEBR0Z┊     25%│
│000000a0│ 00 00                   ┊                         │00      ┊        │
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘
```

Here we encounter another advantage of hex dumps. Usually, the content of the game is only available to the researcher when it is played. This can result in a considerate investment regarding time and technical resources. A hex dump can make clear text contained in the game searchable. While a lot of the hex dumps output is obfuscated, ASCII characters can be converted and displayed in human-readable form. This becomes clear in our next comparison between the two ‘summer games’ files.

```shell
$ hexyl "content/clean/summer games" && hexyl "content/sca/summer games"
```

```shell
# Hexdump of the clean versions 'summer games' file
┌────────┬─────────────────────────┬─────────────────────────┬────────┬────────┐
│00000000│ 01 08 1b 08 01 00 8f 14 ┊ 14 14 14 14 53 55 4d 4d │•••••0×•┊••••SUMM│
│00000010│ 45 52 20 47 41 4d 45 53 ┊ 0d cc 0c 00 3a 08 0a 00 │ER GAMES┊_×_0:•_0│
│00000020│ 8b 20 41 b3 b1 33 20 a7 ┊ 20 41 b2 33 3a 93 22 4c │× A××3 ×┊ A×3:×"L│
│00000030│ 4f 41 44 45 52 22 2c 38 ┊ 2c 31 00 46 08 14 00 9e │OADER",8┊,10F••0×│
│00000040│ 20 34 39 31 35 32 00 00 ┊ 00                      │ 4915200┊0       │
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘

# Hexdump of SCA's versions 'summer gmaes' file
┌────────┬─────────────────────────┬─────────────────────────┬────────┬────────┐
│00000000│ 01 08 12 08 fa ff 9e 32 ┊ 32 33 34 14 14 14 14 14 │••••×××2┊234•••••│
│00000010│ 14 14 00 32 08 fa ff 22 ┊ 14 b0 c0 c0 c0 c0 c0 c0 │••02•××"┊•×××××××│
│00000020│ c0 c0 c0 c0 c0 c0 c0 c0 ┊ c0 c0 c0 c0 c0 c0 c0 c0 │××××××××┊××××××××│
│00000030│ c0 ae 00 52 08 fa ff 22 ┊ 14 dd 53 41 54 55 52 4e │××0R•××"┊•×SATURN│
│00000040│ 55 53 20 54 48 45 20 49 ┊ 4e 56 49 4e 43 49 42 4c │US THE I┊NVINCIBL│
│00000050│ 45 dd 00 72 08 fa ff 22 ┊ 14 dd 20 20 20 20 20 20 │E×0r•××"┊•×      │
│00000060│ 20 50 52 45 53 45 4e 54 ┊ 53 3a 20 20 20 20 20 20 │ PRESENT┊S:      │
│00000070│ 20 dd 00 92 08 fa ff 22 ┊ 14 dd 20 20 3c 20 20 53 │ ×0×•××"┊•×  <  S│
│00000080│ 55 4d 4d 45 52 20 20 47 ┊ 41 4d 45 53 20 20 3e 20 │UMMER  G┊AMES  > │
│00000090│ 20 dd 00 b2 08 fa ff 22 ┊ 14 ad c0 c0 c0 c0 c0 c0 │ ×0×•××"┊•×××××××│
│000000a0│ c0 c0 c0 c0 c0 c0 c0 c0 ┊ c0 c0 c0 c0 c0 c0 c0 c0 │××××××××┊××××××××│
│000000b0│ c0 bd 00 b8 08 fa ff 20 ┊ 00 00 00 a0 00 be e5 08 │××0×•×× ┊000×0××•│
│000000c0│ c8 b9 e5 08 20 f8 08 c8 ┊ c0 13 90 f1 58 a2 00 bd │×××• ×•×┊×•××X×0×│
│000000d0│ dc 08 9d 00 80 e8 e0 0a ┊ d0 f5 6c 00 80 0c 09 09 │×•×0×××_┊××l0×___│
│000000e0│ 80 c3 c2 cd 38 30 00 2f ┊ 01 37 b7 01 b8 01 b9 01 │××××800/┊•7×•×•×•│
│000000f0│ 0a 00 bb 0b bc 09 ff 00 ┊ c0 e8 f0 04 ca 95 00 60 │_0×•×_×0┊×××•××0`│
│00000100│ 8d 16 03 c8 b9 e5 08 8d ┊ 17 03 8a 60 43 a9 ba 8d │×••×××•×┊••×`C×××│
│00000110│ 00 80 8d 02 80 a9 08 8d ┊ 01 80 8d 03 80 a9 00 a2 │0××•××•×┊•××•××0×│
│00000120│ 00 a0 00 20 d5 ff 6c 16 ┊ 03 00 00 00 f0 00 00 00 │0×0 ××l•┊•000×000│
│00000130│ f0 00 00 00 f0 00 00 00 ┊                         │×000×000┊        │
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘
```

The file ‘summer games’ is the initial starting point when loading the game. After inserting the disk into a real Commodore 64 or an emulator, and typing in the standard loading command, it’s this file that starts the process. Despite some gibberish, there are some discernible differences. The clean version’s ‘summer games’ file mentions `loader` which is a file that is not present in the cracked version. The cracked `summer games` file, on the other hand, shows a tag by the games’ cracker “Saturnus the Invincible”, as well as being longer. The Commodore 64 used special characters that can’t be decoded on modern systems. Luckily, [C64-Tools](https://www.c64-tools.com/basic-2-extractor) and [SCA’s own platform](https://www.sca.ch/c64/software/sca-releases/SCA-Summer%20Games/SUMMER%20GAMES/view-source) allow us to display the file’s content with the correct characters.

{% include figure.html filename="en-or-reverse-engineering-born-digital-artefacts-04.png" alt="The excerpt of a screenshot shows three lines of code, each line alternating between white and grey background. The font is always black." caption="Figure 4. Clean version’s 'summer games' file content, produced with C64-Tools." %}

```shell
00001 REM SUMMER GAMES
00010 IF A<>3 THEN A=3:LOAD"LOADER",8,1
00020
```

{% include figure.html filename="en-or-reverse-engineering-born-digital-artefacts-05.png" alt="The excerpt of a screenshot shows light blue text on a blueish-purple background." caption="Figure 5. SCA cracked version’s 'summer games' file content, provided by the SCA website." %}

```shell
65530 SYS2234
65530 " -----------------------
65530 " SATURNUS THE INVINCIBLE
65530 "        PRESENTS:
65530 "   <  SUMMER  GAMES  >
65530 " -----------------------
65530
```

This is the final observation in this example. Both files contain Commodore 64 BASIC code. The clean version calls the `loader` file first, and then proceeds to execute custom code that has been loaded into the memory address `$C000` by the command `SYS 49152`. The cracked version instead directly executes codes at another address and has a comment displaying who cracked the game. This difference in the two initial files offers us important information on where to continue our investigation of the game's crack. From here on, we will need more specialised knowledge on how Commodore 64 games were programmed, protected, and cracked. We will also need specialised tools that can deal with machine code.

## Bridging File-Format Analysis and Disk-Based Software Artifacts

At first glance, the two case studies presented in this lesson appear only loosely connected. JPEG images and ZIP archives are modern, self-describing file formats with documented headers, signatures, and end markers, while Commodore 64 disk images rely on sector-based storage without standardized file headers, explicit end-of-file markers, or formal internal documentation. Skills learned from one format do not transfer mechanically to the other, and attempting to treat them as structurally comparable would be misleading.

The purpose of the first case study is therefore not to teach the internal structure of JPEG or ZIP files as reusable templates. Knowledge of specific elements such as JPEG metadata segments, ZIP central directory records, or checksum validation does not apply directly to `.d64` disk images. These format-specific details are intentionally confined to their example and are not meant to be generalized.

What *does* transfer between these examples is a set of analytical practices rather than a shared file structure. These practices include working below the graphical interface, using hex dumps to inspect raw binary data, identifying meaningful patterns within otherwise opaque byte sequences, comparing multiple versions of the same artifact to isolate anomalies, and reasoning about file behavior based on how software parses data rather than how files are named, packaged, or displayed to users.

The JPEG, ZIP, and `.docx` example provides a controlled environment in which readers can practice these techniques with immediate visual feedback and well-documented constraints. The Commodore 64 case study deliberately removes many of these affordances. Disk images of historical software rarely preserve original copy protection, lack standardized internal organization, and often survive only in modified or incomplete forms. In such cases, meaning must be inferred through comparison, repetition, and inconsistency rather than through reference to formal specifications.

For historians, this shift reflects real research conditions. Born-digital artifacts are seldom encountered as transparent, self-describing objects. More often, researchers must work with undocumented binaries, altered software, or partial disk images whose structure must be reconstructed through analysis rather than read from documentation. The purpose of the second case study is therefore not technical mastery of Commodore 64 internals, but to demonstrate how reverse engineering can function as a historical method for identifying deliberate human intervention, cultural authorship, and technical modification within opaque digital sources.

## Summary

This lesson explores reverse engineering as a critical methodology for historical analysis of born-digital artifacts, emphasizing its role in overcoming "screen essentialism"—the tendency to interpret digital objects solely through their visual representations. By examining deeper into digital files using techniques such as hex editing and comparative hex dump analysis, historians can uncover hidden structures, metadata, and functionalities that remain invisible when analysed superficially.

This lesson also highlights significant challenges and technical hurdles inherent in reverse engineering digital artifacts. Historians frequently encounter gaps in essential knowledge about proprietary file structures, software behaviours, and hardware constraints. This reality underscores an ongoing methodological dilemma: researchers often remain unaware of critical information that is missing, a situation exacerbated by the closed-source nature of many digital technologies. These technical barriers continually risk pushing researchers back toward screen essentialism, prompting surface-level interpretations due to insufficient technical literacy or documentation. Ultimately, this introductory exploration emphasizes that reverse engineering remains an evolving field with much still to discover, underscoring the importance of continuously expanding digital literacy and refining specialized historical methods to navigate the complexities of born-digital cultural artifacts.

## Further Resources

Having explored hex editing and comparative hex dump analysis as foundational methods, historians may wish to pursue more advanced techniques in digital archaeology. This final optional section of this lesson highlights possibilities for deeper exploration with reverse-engineering frameworks and analysis tools, outlining how such resources can be integrated into a historian’s workflow. Rather than providing a detailed walkthrough, this discussion points to the capabilities of tools like Radare2[^24] alongside other open-source options, encouraging experimentation and methodological expansion. Supplementary resources and recommendations are included to help readers build the skills needed to critically engage with complex born-digital artifacts.

---

Reverse engineering has emerged as an essential method in digital historical research, enabling historians to investigate born-digital artifacts beyond their surface-level representations. Several compelling studies highlight the potential of this approach, such as the analyses of the _Mystery House_ game (Apple II, 1980)[^20] and John Aycock’s _Amnesia Remembered_.[^21] Aycock’s _Amnesia Remembered_ offers a detailed exploration of software reuse by analyzing disassembled binaries from 1980s Atari ST games. This work demonstrates how reverse engineering can uncover historical coding practices, highlighting previously unnoticed relationships between software developers and revealing insights into the evolution of software design and reuse practices within the early gaming industry.

Additional influential examples include the analysis of the Atari 2600 game _Entombed_ (1982)[^22], which successfully reconstructed its maze-generation algorithm and uncovered hidden software issues, and Aycock's large-scale study, _The Sincerest Form of Flattery_ (2022)[^23], examining nearly two thousand Atari game ROMs to identify widespread patterns of code reuse.

To practically engage with reverse engineering, historians now have access to several approachable tools. One such tool is Radare2, a powerful open-source reverse engineering framework widely used by cybersecurity professionals for binary analysis and software inspection. Although originally designed for low-level software diagnostics, exploit research, and malware analysis, Radare2 can also be leveraged by historians to explore the internal structure and behaviour of vintage software. Its command-line interface and modular toolkit support disassembly, debugging, and data visualization—making it possible to inspect software logic even in the absence of source code. While a detailed explanation of its functionality would exceed the scope of this paper, further information on Radare2's installation and operational specifics can be found in its official documentation.[^25] The following shell output shows the reverse-engineered code from the game crack example, as visualized using Radare2.

```shell
# Open a dump of the summer games sca crack with radare2
r2 -a 6502 -b 8 -m 0x0801 summer_games_clean.pr
# The following performs a full analysis (disassembling, finding functions, etc.).
[0x00000801]> aaa
 # Go to where the SYS command jumps (start of machine code)
[0x00000801]> s 0x08ba
# Disassemble and print 20 instructions
[0x000008ba]> pd 20
            0x000008ba      a000           ldy #0x00
            ; CODE XREF from fcn.00000802 @ +0xc7
        ┌─> 0x000008bc      bee508         ldx 0x08e5,y
        ╎   0x000008bf      c8             iny
        ╎   0x000008c0      b9e508         lda 0x08e5,y
        ╎   0x000008c3      20f808         jsr fcn.000008f8
        ╎   0x000008c6      c8             iny
        ╎   0x000008c7      c013           cpy #0x13
        └─< 0x000008c9      90f1           bcc 0x0008bc
            0x000008cb      58             cli
            0x000008cc      a200           ldx #0x00
            ; CODE XREF from fcn.00000802 @ +0xd5
        ┌─> 0x000008ce      bddc08         lda 0x08dc,x
        ╎   0x000008d1      9d0080         sta 0x8000,x
        ╎   0x000008d4      e8             inx
        ╎   0x000008d5      e00a           cpx #0x0a
        └─< 0x000008d7      d0f5           bne 0x0008ce
            0x000008d9      6c0080         jmp (0x8000)
            0x000008dc      0c0909         nop 0x0909
            0x000008df      80c3           nop #0xc3
            0x000008e1      c2cd           nop #0xcd
            0x000008e3      38             sec
[0x000008ba]>
```

To make sense of this output, historians must become familiar with low-level machine instructions and how they operate within the architecture of the system they are studying—such as the 6502 processor in the Commodore 64.[^26] For example, the line `0x000008bc bee508 ldx 0x08e5,y` means “load the value from memory address 0x08e5 (offset by the Y register) into the X register.” Each line represents a discrete machine operation, and understanding these require learning a small set of core instructions (like `lda`, `sta`, `jsr`, `bne`) and how memory addresses and processor registers interact. While interpreting such code can be challenging at first, it opens up powerful avenues for understanding how software was constructed and modified in historical contexts.

Similarly valuable is **RetroDebugger[^27]**, a visual debugger integrated with emulators for classic systems (such as the Commodore 64 and Atari 8-bit computers), enabling step-by-step exploration of vintage software execution and memory states. Platforms such as **RetroReversing.com[^28]** offer detailed tutorials, practical documentation, and a community environment designed to guide beginners smoothly into reverse engineering.

Finally, for visualizing and interpreting binary file structures, the **ImHex Patterns Repository** provides structured templates that simplify complex file format analysis, supporting a clearer, guided understanding of digital files. Furthermore, web-based emulators like **JS99er[^29]**—a TI-99/4A emulator accessible directly from any browser—allow historians immediate, authentic interaction with historical software.

## Footnotes

[^1]: For a well explained primer on the different notations please enjoy the presentation by Kay Lack on [binary, hex, and other ways of information encoding](https://www.0de5.net/stimuli/binary-code).

[^2]: Feichtinger, Moritz. 2024. “From Source-Criticism to System-Criticism, Born Digital Objects, Forensic Methods, and Digital Literacy for All.” September 13. [https://doi.org/10.5281/zenodo.13907816](https://doi.org/10.5281/zenodo.13907816).

[^3]: Guay-Bélanger, Dany. 2022. “Assembling Auras: Towards a Methodology for the Preservation and Study of Video Games as Cultural Heritage Artefacts.” _Games and Culture_ 17 (5): 659–78. [https://doi.org/10.1177/15554120211020381](https://doi.org/10.1177/15554120211020381).

[^4]: Victoria and Albert Museum. “Preserving and Sharing Born Digital and Hybrid Objects · V\&A.” Accessed April 22, 2025. [https://www.vam.ac.uk/research/projects/preserving-and-sharing-born-digital-and-hybrid-objects](https://www.vam.ac.uk/research/projects/preserving-and-sharing-born-digital-and-hybrid-objects). Stallman, Richard, and Richard M. Stallman. _Free Software, Free Society: Selected Essays_. Edited by Joshua Gay. 1st. ed. Boston, Mass: Free Software Foundation, 2002, S.50.

[^4]: Moore, Jennifer, and Hannah Scates Kettler. “Who Cares About 3D Preservation?” _IASSIST Quarterly_ 42, no. 1 (2018): 15–15. [https://doi.org/10.29173/iq20](https://doi.org/10.29173/iq20).

[^6]: Shaw, Jonathan. “Digital Preservation: An Unsolved Problem | Harvard Magazine,” April 7, 2010. [https://www.harvardmagazine.com/2010/04/digital-preservation-an-unsolved-problem](https://www.harvardmagazine.com/2010/04/digital-preservation-an-unsolved-problem).

[^7]: Jones, Steven. “Reverse Engineering the First Humanities Computing Center.” _Digital Humanities Quarterly_ 12, no. 2 (2018). [https://www.digitalhumanities.org/dhq/vol/12/2/000380/000380.html](https://www.digitalhumanities.org/dhq/vol/12/2/000380/000380.html).

[^8]: Montfort, Nick, and Ian Bogost. 2009. _Racing the Beam: The Atari Video Computer System_. Platform Studies. Cambridge, Mass: MIT Press.

[^9]: Henry Jenkins. “A New ‘Platform’ for Games Research?: An Interview with Ian Bogost and Nick Montfort (Part One) — Pop Junctions,” April 27, 2009. [http://henryjenkins.org/blog/2009/04/an*interview*with*ian*bogost\*a.html](http://henryjenkins.org/blog/2009/04/an_interview_with_ian_bogost_a.html).

[^10]: CLIR. “Digital Forensics and Born-Digital Content in Cultural Heritage Collections • CLIR.” Accessed April 22, 2025. [https://www.clir.org/pubs/reports/pub149/](https://www.clir.org/pubs/reports/pub149/).

[^11]: Levy, Scott, and Jedidiah R. Crandall. “The Program with a Personality: Analysis of Elk Cloner, the First Personal Computer Virus.” arXiv, July 30, 2020. [https://doi.org/10.48550/arXiv.2007.15759](https://doi.org/10.48550/arXiv.2007.15759) and Giacalone, Anthony. “Agiacalone/Elk-Cloner-Malware.” Assembly, April 21, 2024. [https://github.com/agiacalone/elk-cloner-malware](https://github.com/agiacalone/elk-cloner-malware).

[^12]: Textfiles, hideseek, http://www.textfiles.com/computers/DOCUMENTATION/hideseek.txt

[^13]: Albertini, Ange. "Fearsome File Formats." Chaos Communication Congress. Hamburg, Dec 2024. 45min. [https://media.ccc.de/v/38c3-fearsome-file-formats](https://media.ccc.de/v/38c3-fearsome-file-formats) and Albertini, Ange. "Funky File Formats, Advanced Binary Tricks." Chaos Communication Congress. Hamburg, Dec 2014. 51min. [https://media.ccc.de/v/31c3_-_5930_-_en_-_saal_6_-_201412291400_-_funky_file_formats_-_ange_albertini](https://media.ccc.de/v/31c3_-_5930_-_en_-_saal_6_-_201412291400_-_funky_file_formats_-_ange_albertini).

[^14]: Further file signatures are listed on [https://en.wikipedia.org/wiki/List*of*file\*signatures](https://en.wikipedia.org/wiki/List_of_file_signatures)

[^15]: `grep` is installed on most Linux distributions as well as macOS, but not Windows.

[^16]: Graciously offered by SCA via [https://www.sca.ch/c64/software/sca-releases/SCA-Summer%20Games](https://www.sca.ch/c64/software/sca-releases/SCA-Summer%20Games)

[^17]: Hosted on [https://archive.org/details/summer\*games](https://archive.org/details/summer_games)

[^18]: Peter Schepers. “Introduction to the Various Emulator File Formats.” August 24, 1996. [https://ist.uwaterloo.ca/~schepers/formats/INTRO.TXT](https://ist.uwaterloo.ca/~schepers/formats/INTRO.TXT) and Peter Schepers, Ettore Perazzoli. “The G64 GCR-Encoded Disk Image Format.” VICE Manual - 11 The Emulator File Formats, June 1991. [https://www.cs.cmu.edu/~dsladic/vice/doc/html/vice_11.html](https://www.cs.cmu.edu/~dsladic/vice/doc/html/vice_11.html).

[^19]: Heilmann, Till A. "Wie liest man 100’000 Zeilen Code?" In _Quellcodekritik: zur Philologie von Algorithmen_, Erste Auflage, edited by Hannes Bajohr and Markus Krajewski. August Akademie. August Verlag, 2024.

[^20]: Biittner, Biittner, and John Aycock. “Inspecting the Foundation of Mystery House | Journal of Contemporary Archaeology.” Accessed May 21, 2025. [https://journal.equinoxpub.com/JCA/article/view/17513](https://journal.equinoxpub.com/JCA/article/view/17513).

[^21]: Aycock, John. “Amnesia Remembered: Reverse Engineering a Digital Artifact.” In _Amnesia Remembered_. Berghahn Books, 2023. [https://doi.org/10.1515/9781800738683](https://doi.org/10.1515/9781800738683).

[^22]: Aycock, John, and Tara Copplestone. “Entombed: An Archaeological Examination of an Atari 2600 Game.” _The Art, Science, and Engineering of Programming_ 3, no. 2 (November 5, 2018): 4. [https://doi.org/10.22152/programming-journal.org/2019/3/4](https://doi.org/10.22152/programming-journal.org/2019/3/4).

[^23]: Aycock, John, Shankar Ganesh, Katie Biittner, Paul Allen Newell, and Carl Therrien. “The Sincerest Form of Flattery: Large-Scale Analysis of Code Re-Use in Atari 2600 Games.” In _Proceedings of the 17th International Conference on the Foundations of Digital Games_, 1–10. Athens Greece: ACM, 2022. [https://doi.org/10.1145/3555858.3555948](https://doi.org/10.1145/3555858.3555948).

[^24]: “Radareorg/Radare2.” C. 2012. Reprint, radare org, June 1, 2025. [https://github.com/radareorg/radare2](https://github.com/radareorg/radare2).

[^25]: "Installation," in The Official Radare2 Book, accessed July 7, 2025. [https://book.rada.re/install/intro.html](https://book.rada.re/install/intro.html).

[^26]: “Steil, Michael. “6502 | Ultimate Commodore 64 Reference.” Accessed July 7, 2025. [https://www.pagetable.com/c64ref/6502/#](https://www.pagetable.com/c64ref/6502/#).

[^27]: slajerek. “Slajerek/RetroDebugger.” C, May 12, 2025. [https://github.com/slajerek/RetroDebugger](https://github.com/slajerek/RetroDebugger).

[^28]: “Retro Reverse Engineering.” Accessed May 21, 2025. [https://www.retroreversing.com/](https://www.retroreversing.com/).

[^29]: “JS99’er.” Accessed May 21, 2025. [https://js99er.net/](https://js99er.net/#/).

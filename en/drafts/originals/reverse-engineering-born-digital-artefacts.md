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
- Forename Surname
- Forename Surname
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

Our proposal enhances existing lessons by equipping historians with essential technical skills to analyse digital artifacts. These artifacts are more than their visible content, existing within interwoven layers that shape their function and meaning. Technically, they are embedded in systems of file formats, applications, operating systems, and hardware, but they are also influenced by environmental factors like infrastructure, data centres, and socio-economic conditions.

This lesson provides a thorough overview of reverse engineering and software archaeology. After outlining a basic overview of this field, we present some foundational techniques and tools. These can be applied for accessing, interpreting, and critically analysing previously opaque digital materials—such as old databases, early video games, or proprietary file formats. This skill set ultimately empowers readers to engage more confidently with the digital sources shaping insightful historical research today. The techniques and tools are illustrated through two case studies. The first is a presentation on how an image format can also be an archive, highlighting the necessity of looking beyond what is shown to us on screen. The second case is an investigation into a cracked Commdore 64 video game from 1984, in which we tie reverse engineering into studying the history of digital technology.

The goal of this lesson is to introduce the use of hex editors as a tool for reverse engineering and digital archaeology. By analysing raw hexadecimal data, historians and researchers can uncover hidden structures, embedded messages, and unexpected functionalities within digital files. Through practical examples, including a JPEG image of a cat that also functions as a ZIP archive, we aim to demonstrate how hex editing can reveal a file's true behaviour beyond its surface-level format. This lesson will equip you with the skills to identify file signatures, parse metadata, and recognize structural anomalies, fostering an understanding of how digital artifacts are constructed and how they may conceal multiple layers of information. By the end of this chapter, you will have the foundational knowledge needed to use hex editors for investigating and interpreting complex digital objects.

There are two fundamental technical requirements for this lesson that form the foundation of our digital archaeology approach.

1. The first requirement centres on having appropriate tools to transform digital artifacts into a more accessible and analysable state. While numerous tools and methodologies exist for this purpose, we begin with a straightforward yet powerful hex viewer, which allows us to examine the raw binary data of digital files. A hex viewer displays the hexadecimal representation of binary data, making it possible to see patterns, headers, and structures that are otherwise hidden from conventional file viewers. We recommend using the command line tool `hexyl` or the browser-based [HexEd.it](https://hexed.it/) for reliable options that provide the necessary functionality for beginners while maintaining the depth required for more advanced analysis.
2. The second essential requirement involves acquiring suitable born-digital objects for analysis, which varies significantly depending on your specific research question and can encompass digital images, databases, software applications, and various other digital artifacts. While we provide curated digital artifacts for the two case studies presented in this lesson, the broader challenge lies in identifying and accessing appropriate materials for independent research, which we can't cover in this lesson. 

## Reverse Engineering born-digital Media artifacts

In the study of born-digital artifacts, historians are increasingly confronted with the limitations of interpreting digital materials solely through their visual appearance. This issue, often described as *screen essentialism*[^1], refers to the tendency to understand digital objects only as they appear on screens rather than as complex, encoded structures with multiple layers of meaning. For the historian working with digital sources, this presents a significant methodological challenge: how can we analyse digital artifacts not just as static images or text, but as dynamic objects shaped by code, metadata, file formats, and usage contexts?

Born-digital artifacts, such as software, websites, digital photographs and videos, PDFs, databases, and other natively digital materials require us to rethink conventional source analysis. Unlike digitized analogue objects, which carry with them an assumed physical origin, born-digital materials are native to code. Their meaning is not only derived from their on-screen appearance, but also from how they are stored, processed, and rendered. Overlooking these dimensions can lead to shallow readings and a failure to grasp how digital media shape, constrain, and enable different forms of historical expression and evidence.

This is where the practice of reverse engineering (RE) offers a compelling methodological pathway. Reverse engineering, broadly construed, involves deconstructing digital objects to understand how they work, what they are made of, and how their structures shape their meanings. It can include investigating a file’s metadata, altering or corrupting digital files to observe their behaviour, or reading against the grain of the interface to recover invisible labour, intentions, or constraints embedded in the technology. For historians, reverse engineering is not just a technical tool but a critical mode of inquiry that allows us to interrogate the digital record, challenge surface-level readings, and engage with digital artifacts on their own terms.

While preservation remains an important backdrop to this work, particularly in considering what aspects of digital artifacts are retained or lost over time[^2], this lesson focuses on reverse engineering as a form of historical analysis. By examining digital objects beyond the screen, we aim to demonstrate how this approach opens new avenues for interpretation, revealing the layered and often contradictory nature of digital evidence.

This lesson argues that reverse engineering offers historians a critical methodological approach that counters screen-essentialism, enabling more profound insights into the sociocultural and technological contexts of digital artifacts.

### Closed-Source Digital Systems acting as Barriers to Historical Analysis

Most contemporary digital technologies are effectively closed-source, meaning their inner workings are not publicly accessible. A pervasive opaqueness creates significant barriers for historians and archivists studying born-digital artifacts. Researchers cannot inspect how digital artifacts were produced or operate internally, encountering only outward behaviors rather than underlying mechanisms. Further, proprietary software systems present an additional conflict because *"it's a black box that cannot be opened"*.[^4] Closed-source programs are not fundamentally auditable by outsiders. Without access to source code or technical documentation, the internal data structures, algorithms, and dependencies remain invisible, which *"hamper(s) (or mak(es) impossible) new discoveries"* about the artifact's creation and context.[^5] The closed nature of consumer computing technology severely limits direct historical analysis of digital content.

Even when digital artifacts are successfully preserved, researchers often lack access to original environments or software that generated them. Archives may hold the *bits* of decades-old documents or games, but without the closed software or hardware platform that originally interpreted those bits, their meaning remains elusive. Data can be kept *"perfectly secure and complete, but still be unreadable by machines and programs in the future"* if the requisite system is unavailable.[^10] Historians frequently confront "orphans": digital files estranged from proprietary applications that give them life.

**Reverse engineering** emerges as one of the few viable methods to open these black boxes. It involves taking apart a system to infer its design and operation.[^6] As one scholar explains, it's applied to *"lost, secret, or otherwise obscured technologies"* as a way to *"write the missing manual"* when official documentation is absent. This approach can be indispensable for historians of software and media. Techniques include disassembling binary code, monitoring inputs and outputs, or using emulators to study hardware behavior. Montfort and Bogost's *platform studies* of the Atari VCS[^7] required understanding the machine's proprietary architecture to explain how games were implemented, forming historical reverse-engineering.[^8] Matthew Kirschenbaum's *"forensic imagination"* invokes low-level examination of digital objects to uncover evidence of their creation and context.[^9] Scholars in software studies and media archaeology emphasize that absent source code access, one must interrogate software through interfaces, runtime behavior, or creative deconstruction. Reverse engineering becomes a key scholarly tactic for **insight into opaque systems**.[^3]

### Why use reverse engineering?

Digital historians, much like archaeologists meticulously uncovering hidden layers of the past, employ reverse engineering to reveal the intricate architectures underlying software and digital file formats. Rather than relying solely on visible interfaces—an approach known as screen essentialism—reverse engineering enables historians to delve into the structural, functional, and contextual layers of digital artifacts. This aligns closely with digital source criticism, recognizing digital objects as part of broader technological and socio-economic frameworks.

Digital artifacts, whether video games, databases, images, or malware, contain layers of information inaccessible through standard interfaces. Reverse engineering serves as a key methodology to uncover these hidden layers. By exploring a file’s internal construction, behavior under manipulation, and embedded metadata, historians can retrieve undocumented data, chart software evolution, and reconstruct historical contexts. This method is particularly crucial when studying closed-source systems, providing historians with a practical means to "write the missing manual" and document digital heritage even in the absence of original source code or documentation.

File structures and formats are especially interesting from a historical malware research perspective. One of the first computer viruses discovered in the wild, the Elk Cloner virus spread by attaching itself to a disk’s boot sector and activated whenever the infected disk was inserted into an Apple II computer.[^13] Around the same time, in early hacking culture, steganography — the art of hiding code or messages in images — also became a popular topic on message boards.[^14] If you want to dive deeper into file structures and formats, check out the work of Ange Albertini, a well-known security researcher who explores unusual file formats. His presentation, "Funky File Formats," at the chaos communication congress explores the concept of polyglot files—single files that are valid under multiple formats simultaneously. This exploration reveals how such files can function differently depending on the application interpreting them, offering unique insights into file format manipulation. Building upon this, Albertini developed Mitra, a tool designed to assist in crafting files that conform to multiple format specifications, streamlining the process of creating complex polyglots. Additionally, his Corkami project offers a comprehensive collection of hex patterns that illustrate various file format structures and anomalies, serving as a valuable reference for understanding the binary composition of different file types. For us digital Historians, it is essential to understand digital media artifacts as a structured or sometimes seemingly unstructured pile of binary data. One of the first jobs we do is to try to understand the underlying structure of those files. Engaging with resources like the Corkami project can deepen your understanding of file formats and uncover the hidden complexities within digital files, enhancing your skills in reverse engineering and digital archaeology.​ 

From a historical perspective, reverse engineering has been essential since the early days of computing. Initially formalized by M.G. Rekoff in 1985 for hardware cloning, reverse engineering rapidly expanded into software domains, influencing significant milestones such as the development of Linux. Without proprietary documentation, early Linux developers relied on reverse engineering to understand and replicate hardware compatibility and system interactions, laying the groundwork for open-source innovation.[^11] Reverse engineering also intersected significantly with video game culture, notably within hacking and modding communities. Enthusiasts reversed compiled game code to modify mechanics, uncover hidden features, and extend game longevity, thereby becoming key actors in digital preservation efforts. Through these activities, video games transitioned from mere consumer products into artifacts worthy of historical analysis.

Reverse engineering, at its core, involves deconstructing a finished product to understand how it was made—a process that essentially takes the original engineering process and runs it in reverse, enabling the discovery of the design principles, coding techniques, and creative decisions embedded in its creation. But why invest time in reverse engineering old games, software of viruses? There are several motivations behind this practice. Historical preservation plays a significant role. Just as historians study traditional art and literature to understand human culture, examining Media artifacts like video games offers a window into the creative and technical history of modern digital culture. The act of reversing becomes a game in itself, where the challenge lies in unravelling the original developer's work.

{% include figure.html filename="en-or-reverse-engineering-born-digital-artefacts-01.png" alt="The illustration shows a stack of rectangles, on top of each other, each containing a label and standing for a layer. Some rectangles are also overlapping or divided into smaller units. On the left side are the labels software and hardware to illustrate which layers belong to which category. The software category on top contains layers such as applications and operating system. Among the the bottom hardware category are layers such as processor, memory, transistor and others." caption="Figure 1. Schematic visualization of a computer's hardware and software layers." %} 

A computer operates through a layered architecture, where hardware and software components work together to process and execute instructions. At the lowest level, transistors form the building blocks of digital circuits, which combine to create processors, memory, and input/output (I/O) systems. These hardware components are managed through the instruction set architecture (ISA), which defines how the processor interprets and executes machine code. Firmware and assemblers translate low-level machine code into instructions the hardware can execute, while higher-level software like compilers and interpreters convert human-readable code into machine instructions. The operating system serves as a bridge between hardware and software, managing system resources and enabling applications to run smoothly.

Understanding this architecture is crucial for reverse engineering because it allows engineers to trace how high-level software instructions translate into low-level machine code and hardware operations. This knowledge helps in uncovering hidden functionalities, debugging errors, analysing malware behaviour, and modifying or improving existing software. Reverse engineering often involves working at the boundary between software and hardware, requiring an in-depth understanding of how compilers, assemblers, and the instruction set architecture interact to produce executable code.

## The inner life of born-digital Media artifacts 

Before beginning this hands-on analysis, you'll need to gather the necessary materials and tools to effectively examine digital image formats. First, select a JPEG file with either a .jpg or .jpeg file extension that you'd like to analyse—this can be any digital photograph or image from your personal collection, or alternatively, you can work with the sample files we provide for this exercise. [You can download the necessary files through this link.](https://github.com/programminghistorian/ph-submissions/raw/refs/heads/gh-pages/assets/reverse-engineering-born-digital-artefacts/reverse-engineering-born-digital-artefacts.zip). The choice of image isn't critical for learning the fundamental concepts, though selecting something familiar to you may make the analysis more engaging and meaningful. We also note that all following instructions are provided for our provided files. Next, you'll need to install a hex editor that will serve as your primary tool for examining the binary structure of the JPEG file. While numerous options exist, including both desktop applications and browser-based alternatives, we recommend using `hexyl`.

A hex dump is a textual representation of computer data in hexadecimal format, achieved by converting bytes into a two-digit hexadecimal number. This makes raw binary data more human-readable and easier to interpret for reverse engineering, or forensic analysis. There are several tools available for viewing hex data from a file. Here, we have listed some of the most commonly used ones.

| Name         | Platforms             | GUI | Notes                                                                | Link                                       |
| :----------- | :-------------------- | :-- | :------------------------------------------------------------------- | :----------------------------------------- |
| **ImHex**    | Windows, macOS, Linux | ✅   | Advanced, pattern-matching, modern UI, great for reverse engineering | [GitHub](https://github.com/WerWolv/ImHex) |
| **hexyl**    | Windows, macOS, Linux | ❌   | CLI hex viewer with colours, fast and clean                           | [GitHub](https://github.com/sharkdp/hexyl) |
| **HexEd.it** | Web-based             | ✅   | Full-featured online hex editor, great for quick edits               | [HexEd.it](https://hexed.it/)              |

For the following example, we will use hexyl. We chose it primarily because we appreciate its aesthetic, but you can use any hex viewer you want.

### The bit code of an image

To illustrate this, we begin with the basic structure of a JPEG file, as shown in the diagram below. The JPEG format follows a clearly defined structure, starting with a file signature or “magic number” that identifies it as a JPEG, followed by metadata, image data, and an end-of-file marker. This predictable format allows hex editors to recognize and parse the file correctly. The image below is an example of the bit code of an image. It is not necessary to fully understand this image at this point, but it shows some of the concepts that will be discussed in the lesson.

{% include figure.html filename="en-or-reverse-engineering-born-digital-artefacts-02.png" alt="The illustration shows a color-coded hex dump on the left side. Some of the output is highlighted and connected with a dashed line to detailed explenations on the right side, indicating where the start of the image is, or where one could find more information about the files format." caption="Figure 2. Infographic annotating a JPEG's file header in hexadecimal notation. (Ange Albertini 2022 – CC-BY 4.0 )" %}

When we open a sample JPEG of a cat in a hex editor, the hex view immediately exposes this structure. The file signature (FF D8 FF E0) at the beginning confirms that it is a JPEG file. We can also see metadata fields describing the image’s dimensions, colour depth, and encoding settings. The bulk of the file contains compressed image data, which appears as a seemingly random string of hex values. 

*Make sure to be in the appropriate directory before entering the following command into your terminal. If you have downloaded the provided files, and unzipped them in your personal "Downloads" folder, you can usually navigate there by `cd Downloads/reverse-engineering-born-digital-artefacts` after opening the terminal. The `-n` option tells hexyl to only display the first 256 bytes. In the spirit of a cooking show, we already prepared some of this lesson's files, which is why you find several images in the `jpg_zip` folder. You can ignore the others for now. The $ (dollar) sign in front of a line indicates a command to be copied into the terminal. The $ sign should not be coppied.*

```shell
$ hexyl jpg_zip/cat.jpg -n 256
```

The file signature `FF D8 FF E0` at the beginning confirms that it is a JPEG file. A PNG file, as another example, would start with `89 50 4E 47 0D 0A 1A 0A` [^12]. We can also see metadata fields describing the image’s dimensions, colour depth, and encoding settings. The bulk of the file contains compressed image data, which appears as a seemingly random string of hex values.

{% include figure.html filename="en-or-reverse-engineering-born-digital-artefacts-03.jpeg" alt="The photo shows a rather silly cat on a couch. The cat looks upwards and has its tongue out, making it look like a defiant kid. It's an orange tabby cat with fluffy fur and the couch is upholstered in grey cotton fabric." caption="Figure 3. A cat sitting on a couch." %}

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

Similarly, ZIP files have their own distinct file signature `50 4B 03 04` that identifies them as compressed archives. While these file types are typically seen as distinct, their binary structures can be combined in creative ways, exploiting differences in how file parsers read them. JPEG files are read from the beginning of the file, while ZIP files are parsed from the end—creating an opportunity to embed a ZIP archive inside a JPEG without breaking the integrity of either format.

### Creating the Image Zip File

To demonstrate this, we can create a file that functions as both a valid JPEG and a ZIP archive. The goal of this small exercise is to show how we can hide text in an image file. The process involves first creating a standard JPEG image file and then appending a ZIP archive to the end of the file. Since JPEG parsers will stop reading once they reach the end-of-file marker for the image, the additional ZIP data will remain hidden from the image viewer. However, a ZIP parser will read the file from the end and identify the ZIP header, enabling the file to function as a valid archive. This dual-format trick exploits the differences in how file types are interpreted by different software, effectively creating a file with two identities.

The following commandos create a text file, compress it into a ZIP file, then continues to create a copy of our cat image and finally appends the ZIP file to the copied image file. We will first navigate directly into the `jpg_zip` folder, for easier application of the terminal commands. *A # symbol in front of a line indicates a comment for you, the reader, and doesn't need to be coppied.*

*With PowerShell (Windows):*

```powershell
# Let's move to the appropriate files folder
$ cd jpg_zip

# Create the text file
$ "Hello World!" | Set-Content -Path hidden-content.txt -Encoding UTF8

# Create the zip archive
$ Compress-Archive -Path hidden-content.txt -DestinationPath hidden-content.zip

# Copy the image file
$ Copy-Item -Path jpg_zip/cat.jpg -Destination cat-with-hidden-content.jpg

# Append the zip file bytes to the copied image
$ $zipBytes = Get-Content -Path hidden-content.zip -Encoding Byte -Raw
$ Add-Content -Path cat-with-hidden-content.jpg -Value $zipBytes -Encoding Byte
```

*Under macOS or Linux Terminal:*  

```shell
# Let's move to the appropriate files folder
$ cd jpg_zip

# Create the text file
$ echo "Hello World" > hidden-content.txt

# Create the zip archive
$ zip hidden-content.zip hidden-content.txt

# Copy the image file
$ cp cat.jpg cat-with-hidden-content.jpg

# Append the zip file bytes to the copied image
$ cat hidden-content.zip >> cat-with-hidden-content.jpg
```

Let's check how our files look like now, through a hex dump.

```shell
$ hexyl hidden-content.zip  
```

```shell
# Hexdump of our zipped text file, its content decoded and visible on the right.
┌────────┬─────────────────────────┬─────────────────────────┬────────┬────────┐
│00000000│ 50 4b 03 04 0a 00 00 00 ┊ 00 00 51 3d b6 5a dd dd │PK••_000┊00Q=×Z××│
│00000010│ 14 7d 0d 00 00 00 0d 00 ┊ 00 00 12 00 1c 00 68 69 │•}_000_0┊00•0•0hi│
│00000020│ 64 64 65 6e 2d 63 6f 6e ┊ 74 65 6e 74 2e 74 78 74 │dden-con┊tent.txt│
│00000030│ 55 54 09 00 03 4a b9 2e ┊ 68 4a b9 2e 68 75 78 0b │UT_0•J×.┊hJ×.hux•│
│00000040│ 00 01 04 e8 03 00 00 04 ┊ e8 03 00 00 48 65 6c 6c │0••×•00•┊×•00Hell│
│00000050│ 6f 20 57 6f 72 6c 64 21 ┊ 0a 50 4b 01 02 1e 03 0a │o World!┊_PK••••_│
│00000060│ 00 00 00 00 00 51 3d b6 ┊ 5a dd dd 14 7d 0d 00 00 │00000Q=×┊Z××•}_00│
│00000070│ 00 0d 00 00 00 12 00 18 ┊ 00 00 00 00 00 01 00 00 │0_000•0•┊00000•00│
│00000080│ 00 a4 81 00 00 00 00 68 ┊ 69 64 64 65 6e 2d 63 6f │0××0000h┊idden-co│
│00000090│ 6e 74 65 6e 74 2e 74 78 ┊ 74 55 54 05 00 03 4a b9 │ntent.tx┊tUT•0•J×│
│000000a0│ 2e 68 75 78 0b 00 01 04 ┊ e8 03 00 00 04 e8 03 00 │.hux•0••┊×•00•×•0│
│000000b0│ 00 50 4b 05 06 00 00 00 ┊ 00 01 00 01 00 58 00 00 │0PK••000┊0•0•0X00│
│000000c0│ 00 59 00 00 00 00 00    ┊                         │0Y00000 ┊        │
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘
```

```shell
$ hexyl cat.jpg | tail -n 16; hexyl cat-with-hidden-content.jpg | tail -n 16
```
*The `| tail -n` part will return only the last 16 rows of output*

```shell
# Last lines of the hexdump of fig_003-cat.jpg
│00031820│ 52 ce 7e 61 c5 45 1c e4 ┊ b9 08 06 cf 52 2b 4d 2d │R×~a×E•×┊×••×R+M-│
│00031830│ 2d 63 1f 34 65 8f d6 9a ┊ 62 88 b1 0a 81 57 da 81 │-c•4e×××┊b××_×W××│
│00031840│ 14 9d da 32 63 c7 0f de ┊ ac 26 88 6e d7 2b 70 17 │•××2c×•×┊×&×n×+p•│
│00031850│ 03 a5 68 5b 5b 5b 18 f2 ┊ c8 c4 8f 7a 8b ed 50 c5 │•×h[[[•×┊×××z××P×│
│00031860│ 21 d8 8c 30 71 d6 81 94 ┊ 22 b3 30 3f 95 29 e7 d4 │!××0q×××┊"×0?×)××│
│00031870│ 56 b5 a0 89 2d a5 81 fe ┊ 74 6c f2 6a 39 ae 60 dc │V×××-×××┊tl×j9×`×│
│00031880│ 1f ca 25 b1 eb 4f 8a 48 ┊ e5 88 b2 a1 5a 00 e7 2f │•×%××O×H┊××××Z0×/│
│00031890│ d1 77 88 c4 6c 14 1e 18 ┊ 0a 9c 49 bb 4f 3c 64 a5 │×w××l•••┊_×I×O<d×│
│000318a0│ 6d 5c 5b 45 35 99 3b 70 ┊ c3 bd 60 43 27 92 b3 26 │m\[E5×;p┊××`C'××&│
│000318b0│ 33 90 68 10 43 2c bb 77 ┊ 20 e4 8e be 95 37 98 e1 │3×h•C,×w┊ ××××7××│
│000318c0│ 40 24 11 de a8 42 ce 17 ┊ ef 71 ed 52 ee fb c8 7d │@$•××B×•┊×q×R×××}│
│000318d0│ 3a d3 02 c4 4c 16 e7 00 ┊ fc ad 4c bc 8d a1 90 b2 │:×•×L•×0┊××L×××××│
│000318e0│ 8c 81 ce 6a ac 32 12 36 ┊ 9e ab de a6 98 b3 a8 05 │×××j×2•6┊×××××××•│
│000318f0│ 8e 18 e0 d0 00 2e d7 03 ┊ 9a 29 be 42 7a 51 40 1f │×•××0.×•┊×)×BzQ@•│
│00031900│ ff d9                   ┊                         │××      ┊        │
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘

# Last lines of the hexdump of our altered cat-with-hidden-content.jpg
│000318e0│ 8c 81 ce 6a ac 32 12 36 ┊ 9e ab de a6 98 b3 a8 05 │×××j×2•6┊×××××××•│
│000318f0│ 8e 18 e0 d0 00 2e d7 03 ┊ 9a 29 be 42 7a 51 40 1f │×•××0.×•┊×)×BzQ@•│
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

### Analysing the Image Zip File

When we open this hybrid file in a hex editor, the dual nature of the file becomes evident. The hex editor will display the initial JPEG file signature (`FF D8 FF E0`) at the beginning of the file, confirming its validity as an image. Scanning through the hex code, we can observe the image metadata and the compressed image data. However, at the end of the file, the ZIP file signature (`50 4B 03 04`) appears, indicating the presence of a valid ZIP archive. A hex editor allows us to parse the file structure manually, identifying the point where the image data ends and the ZIP archive begins. This example illustrates how hex editing can reveal hidden structures and dual functionalities within a single file, underscoring the value of reverse engineering in uncovering the hidden dimensions of digital artifacts.

To prove that our newly created JPG-ZIP file is still valid, we can open and look at it, but also rename and decompress it to retrieve the original text file.

```shell
# Copy our altered jpg file and rename the file ending to zip
$ cp cat-with-hidden-content.jpg cat-with-hidden-content.zip 

# Remove the original text file
$ rm hidden-content.txt

# Uncompress the copied jpg, and treat it as if it would be a zip file
$ unzip cat-with-hidden-content.zip

# Peeking into the unzipped content of the altered jpg
$ cat hidden-context.txt
```

The last command should return "Hello World!", the content of your original text file. The latter we compressed into a zip file, attached it to a JPEG, which we then renamed to a zip file, uncompressed, and retrieved the original text file again. Since we know the file signature of a ZIP file (`50 4B 03 04`), this allows us to search for this string within a JPG file. The following command will return a result, indicating that there is a ZIP file within our JPG file, expanding our close reading of these files through a computational approach.

```shell
$ hexyl --color never cat-with-hidden-content.jpg | grep '50 4b 03 04'
```
*hexyl by default adds colour information to the hex dump, which interferes with our search. We can disable this behaviour with the option `--color never`. You should recieve the following output. If no zip file would have been present in our jpg, we wouldn't have received any output at all. The fact that we got something returned proves that our little trick worked.*

```shell
# Output of our search for zip file header information in a jpg file.
│00031900│ ff d9 50 4b 03 04 0a 00 ┊ 00 00 00 00 51 3d b6 5a │××PK••_0┊0000Q=×Z│
```

This example illustrates how reverse engineering through hex analysis can uncover the layered nature of digital artifacts. What appears to be a simple image file may, in fact, be a container for additional data or hidden functionality. The ability to uncover and interpret these hidden structures is essential for understanding how digital objects are constructed and how their functionality can be manipulated or repurposed.

## Reverse Engineering a cracked Commodore 64 Game

The second case study examines a cracked Commodore 64 game. The hex dump technique presented in the first case serves as the starting point for larger and more elaborate examinations of born-digital objects. Since media archaeology can become a complex endeavour, it is important to know where to start with reverse engineering digital artifacts. This second case expands our hex dump peeking approach through further investigating file types and basic comparison techniques.

Game cracking evolved beyond mere piracy into a sophisticated technical pursuit, demonstrating programming skill and ingenuity. Crackers not only removed copy protection but also enhanced games with custom intro screens, gameplay modifications, language translations, performance optimizations, and new functionality. These specialized reverse engineers needed specialised knowledge of assembly language and hardware, and the understanding of how to  deconstruct and rebuild programs to suit their purposes.

### SCA’s Summer Games

The Swiss Crackers Association modified "Summer Games" by adding Switzerland's flag and anthem as a selectable country, demonstrating how reverse engineering served as cultural expression beyond mere copy protection removal. This modification required both technical skill to analyse the game's data structures and artistic sensitivity to maintain coherence with the original design, effectively claiming digital representation for Swiss identity.

SCA emerged in the mid-1980s as a notable multilingual collective that bridged European cracking scenes while developing elegant reverse engineering techniques. Their historical significance extends beyond cracking to creating one of the first Commodore 64 viruses and eventually transitioning to the demo scene—an evolution from circumvention to creative coding. Unlike many contemporaries, SCA maintained comprehensive documentation of their techniques, providing invaluable records for digital historians studying early cracking culture.

We've selected this SCA crack as our case study due to its research value for digital history, allowing us to reconstruct technical practices by examining disassembled code while revealing motivations beyond technical prowess. The addition of Swiss representation to an international sports game points to questions of national identity in early digital culture, showing how software became a platform for cultural expression and representation for communities overlooked in commercial products. The crack's code serves as a primary historical source that complements oral histories and other artifacts, transforming reverse engineering into a form of digital archaeology that expands our historical toolkit. When combined with ethnographic interviews, cracking documentation analysis, and media studies approaches, this technical examination reveals how knowledge circulated through informal pre-internet networks and provides a multidimensional understanding of early digital culture impossible through conventional historical methods alone.

### Getting Started

For this example, we acquired the cracked[^15] and a supposedly clean[^16] version of the Commodore 64 game “Summer Games”. A first glance tells us that those games come as `.d64` files, which is a disk image—a virtual representation of a physical disk’s content. Since we are interested in investigating the cracked version, we need to contextualize our digital artefact towards that.

A standard Commodore 64 `.d64` disk image file does not preserve most hardware-based copy protections, which was common. The `.d64` format captures only the standard sector data of a disk and does not record the low-level, non-standard disk structures (such as sync marks, deliberate errors, or unusual track layouts) that many C64 copy protection schemes rely on. As a result, games or software with sophisticated disk-based copy protection often cannot be run or properly emulated from a `.d64` image. For preserving original disks with copy protection intact, the `.g64` format is preferred, as it stores the low-level information needed for these protections to function.

Finally, most `.d64` images available today have had their copy protection removed or bypassed to work in emulators. This would indicate that our virtual image of the cracked game might not contain everything we need to fully investigate this case. Let us have a closer look and compare our two versions. Since `.d64` is a container format, we need to unpack and reveal the container’s content first. There are many tools offering such a service, such as [C64-Tools](https://www.c64-tools.com/basic-2-extractor) or [DirMaster](https://style64.org/dirmaster). We’ll be using the Floppy Disk Emulator that comes with VICE, an emulator for the Commodore 64.

```shell
# Let's move to the appropriate files folder
cd files/summer_games

# Dump the content of the clean Summer Games version
$ c1541 summer_games_clean.d64 -extract

# The dumps files have been moved to the folder 'dump_clean'.
# Same procedure for the SCA version of the game.
```
*The installation and operation of the VICE tools can't be covered here, all files are provided in the repository.*

### Comparing the Game's different Versions

Unpacking both game versions leaves us with two folders and a bunch of arbitrary labelled files, which we first check for content and file size.

```shell
$ ls -l dump_clean && ls -l dump_sca
```

```shell
# Listing of the clean Summer Games. The first column shows
# the filesize in bits, and the second the file name.
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

# Listing of SCA's Summer Games
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

Both disk images seem almost identical. The files a, d, e, f, h, i, k, m, and wr are present on both disks, with identical file sizes. File c is not present in the clean version, whereas files default and loader are not present on the cracked one. Files b, l and ‘summer games’ are present on both images, but differ in file size. This gives us a first indication of where to start, by figuring out where the two versions differ.

| File Name      | Clean Version     | SCA Cracked Version | Investigate? |
| :------------- | ----------------- | ------------------- | :----------: |
| a              | equal             |                     |              |
| b              | file sizes differ |                     |      ✅       |
| c              | not present       |                     |      ✅       |
| d              | equal             |                     |              |
| default        |                   | not present         |      ✅       |
| e              | equal             |                     |              |
| f              | equal             |                     |              |
| h              | equal             |                     |              |
| i              | equal             |                     |              |
| k              | equal             |                     |              |
| l              | file sizes differ |                     |      ✅       |
| loader         |                   | not present         |      ✅       |
| m              | equal             |                     |              |
| ‘summer games’ | file sizes differ |                     |      ✅       |
| wr             | equal             |                     |              |

Before checking the marked files, it is important to note that this is not foolproof. A note that got published alongside the clean version on archive.org mentions that “\[t\]here is some high score save data in the WR file from previous players.” This indicates that some of the files are of variable content. If the file wr holds high scores, its abbreviation probably means “World Records”, given the context of the game. A hex dump of the two files quickly unveils their difference.

```shell
# Hexdump of both versions wr file, for comparison
$ hexyl dump_clean/wr && hexyl dump_sca/wr
```

```shell
# Hexdump of the clean versions wr file
┌────────┬─────────────────────────┬─────────────────────────┬────────┬────────┐
│00000000│ 00 0b 53 50 49 4b 45 20 ┊ 20 20 20 20 20 20 36 2e │0•SPIKE ┊      6.│
│00000010│ 30 30 b8 0c 00 00 53 50 ┊ 49 4b 45 20 20 20 20 20 │00×_00SP┊IKE     │
│00000020│ 20 36 39 38 2e 37 35 75 ┊ 88 06 53 50 49 4b 45 20 │ 698.75u┊×•SPIKE │
│00000030│ 20 20 20 20 20 32 3a 32 ┊ 37 2e 34 bf d8 fd 53 50 │     2:2┊7.4×××SP│
│00000040│ 49 4b 45 20 20 20 20 20 ┊ 20 20 30 39 2e 35 31 ae │IKE     ┊  09.51×│
│00000050│ f6 ff 53 50 49 4b 45 20 ┊ 20 20 20 20 20 31 30 2e │××SPIKE ┊     10.│
│00000060│ 30 20 20 c8 c8 c8 53 50 ┊ 49 4b 45 20 20 20 20 20 │0  ×××SP┊IKE     │
│00000070│ 20 31 3a 34 30 2e 38 7f ┊ bf fe 53 50 49 4b 45 20 │ 1:40.8•┊××SPIKE │
│00000080│ 20 20 20 20 20 30 3a 32 ┊ 34 2e 33 cf db ff 53 50 │     0:2┊4.3×××SP│
│00000090│ 49 4b 45 20 20 20 20 20 ┊ 20 20 20 20 20 32 35 25 │IKE     ┊     25%│
│000000a0│ 00 00                   ┊                         │00      ┊        │
└────────┴─────────────────────────┴─────────────────────────┴────────┴────────┘

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

Here we encounter another advantage of hex dumps. Usually, the content of the game is only available to the researcher when it is played. This can be a considerate investment regarding time and technical resources. A hex dump can make clear text contained in the game searchable. While a lot of the hex dumps output is obfuscated, ASCII characters can be converted and displayed in human-readable form. This becomes clear in our next comparison between the two ‘summer games’ files.

```shell
$ hexyl "dump_clean/summer games" && hexyl "dump_sca/summer games"
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

The file ‘summer games’ is the initial starting point when loading the game. After inserting the disk into a real Commodore 64 or one of the various emulators, and typing in the standard loading command, it’s this file that starts the process. Despite some gibberish, there are some discernible differences. The clean version’s ‘summer games’ file mentions “loader” which is a file that is not present in the cracked version. The cracked ‘summer games’ file, on the other hand, shows a tag by the games’ cracker “Saturnus the Invincible”, as well as being longer. The Commodore 64 used special characters that can’t be decoded on modern systems. Luckily, [C64-Tools](https://www.c64-tools.com/basic-2-extractor) and [SCA’s own platform](https://www.sca.ch/c64/software/sca-releases/SCA-Summer%20Games/SUMMER%20GAMES/view-source) allow us to display the file’s content with the correct characters.

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

This is the final observation in this example. Both files contain Commodore 64 BASIC code. The clean version calls the ‘loader’ file first, and then proceeds to execute custom assembly code that has been loaded into the memory address `$C000` by the command `SYS 49152`. The cracked version instead directly executes codes at another address and has a comment displaying who cracked the game. This difference in the two initial files offers us important information on where to continue our investigation of the game's crack. From here on, we will need more specialised knowledge on how Commodore 64 games were programmed, protected, and cracked. We will also need specialised tools that can deal with machine code.

This example illustrates how reverse engineering transcends surface-level interpretations, revealing hidden technological, cultural, or historical dimensions.

## Summary

This lesson explores reverse engineering as a critical methodology for historical analysis of born-digital artifacts, emphasizing its role in overcoming "screen essentialism"—the tendency to interpret digital objects solely through their visual representations. By examining deeper into digital files using techniques such as hex editing and comparative hex dump analysis, historians can uncover hidden structures, metadata, and functionalities that remain invisible when analysed superficially.

The first investigation, examining a JPEG file containing an embedded ZIP archive, demonstrated how reverse engineering reveals dual-format file structures. These results serve as a basis for more complex digital archaeological explorations, as illustrated by the second case study involving a cracked Commodore 64 game. Through comparative analysis of cracked and clean versions of the game, reverse engineering techniques such as hex dumps enabled the identification of specific alterations, signatures, and embedded historical information.

However, this lesson also highlights significant challenges and technical hurdles inherent in reverse engineering digital artifacts. Historians frequently encounter gaps in essential knowledge about proprietary file structures, software behaviours, and hardware constraints. This reality underscores an ongoing methodological dilemma: researchers often remain unaware of critical information that is missing, a situation exacerbated by the closed-source nature of many digital technologies. These technical barriers continually risk pushing researchers back toward screen essentialism, prompting surface-level interpretations due to insufficient technical literacy or documentation. Ultimately, this introductory exploration emphasizes that reverse engineering remains an evolving field with much still to discover, underscoring the importance of continuously expanding digital literacy and refining specialized historical methods to navigate the complexities of born-digital cultural artifacts.

Having explored hex editing and comparative hex dump analysis as foundational methods, historians might be interested in going further with digital archaeology. In the final section, this lesson briefly introduces more advanced possibilities using radare2, an open-source framework for reverse-engineering and analyzing binaries. Rather than providing a detailed walkthrough, this discussion showcases some of radare2’s capabilities and outlines how historians could integrate such advanced tools into their workflow. Additionally, supplementary resources and further recommendations are provided to encourage readers to experiment and deepen their methodological approaches, enhancing their ability to critically engage with complex born-digital artifacts.

## Further Resources

Reverse engineering has emerged as an essential method in digital historical research, enabling historians to investigate born-digital artifacts beyond their surface-level representations. Several compelling studies highlight the potential of this approach, such as the analyses of the *Mystery House* game (Apple II, 1980)[^17] and John Aycock’s *Amnesia Remembered*.[^18]

Aycock’s *Amnesia Remembered* offers a detailed exploration of software reuse by analysing disassembled binaries from 1980s Atari ST games. This work demonstrates how reverse engineering can uncover historical coding practices, highlighting previously unnoticed relationships between software developers and revealing insights into the evolution of software design and reuse practices within the early gaming industry.

Additional influential examples include the analysis of the Atari 2600 game *Entombed* (1982)[^19], which successfully reconstructed its maze-generation algorithm and uncovered hidden software issues, and Aycock's large-scale study, *The Sincerest Form of Flattery* (2022)[^20], examining nearly two thousand Atari game ROMs to identify widespread patterns of code reuse.

To practically engage with reverse engineering, historians now have access to several approachable tools. One such tool is Radare2[^21], a powerful open-source reverse engineering framework widely used by cybersecurity professionals for binary analysis and software inspection. Although originally designed for low-level software diagnostics, exploit research, and malware analysis, Radare2 can also be leveraged by historians to explore the internal structure and behaviour of vintage software. Its command-line interface and modular toolkit support disassembly, debugging, and data visualization—making it possible to inspect software logic even in the absence of source code. The following image shows the reverse-engineered code from the game crack example, as visualized using Radare2.

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

To make sense of this output, historians must become familiar with low-level machine instructions[^22] and how they operate within the architecture of the system they are studying—such as the 6502 processor in the Commodore 64. For example, the line `0x000008bc bee508 ldx 0x08e5,y` means “load the value from memory address 0x08e5 (offset by the Y register) into the X register.” Each line represents a discrete machine operation, and understanding these require learning a small set of core instructions (like `lda`, `sta`, `jsr`, `bne`) and how memory addresses and processor registers interact. While interpreting such code can be challenging at first, it opens up powerful avenues for understanding how software was constructed and modified in historical contexts.

Similarly valuable is **RetroDebugger[^23]**, a visual debugger integrated with emulators for classic systems (such as the Commodore 64 and Atari 8-bit computers), enabling step-by-step exploration of vintage software execution and memory states. Platforms such as **RetroReversing.com[^24]** offer detailed tutorials, practical documentation, and a community environment designed to guide beginners smoothly into reverse engineering.

For visualizing and interpreting binary file structures, the **ImHex Patterns Repository** provides structured templates that simplify complex file format analysis, supporting a clearer, guided understanding of digital files. Furthermore, web-based emulators like **JS99er[^25]**—a TI-99/4A emulator accessible directly from any browser—allow historians immediate, authentic interaction with historical software.

Together, these resources significantly reduce barriers to entry, fostering an open, collaborative community around reverse engineering. This introductory exploration serves as a foundation, underscoring that much remains to be discovered through reverse engineering. With tools and case studies like those presented here, historians are well-positioned to expand their digital literacy, enrich their interpretations, and actively contribute to preserving and understanding our digital past.

## Footnotes

[^1]: Feichtinger, Moritz. 2024. “From Source-Criticism to System-Criticism, Born Digital Objects, Forensic Methods, and Digital Literacy for All.” September 13. [https://doi.org/10.5281/zenodo.13907816](https://doi.org/10.5281/zenodo.13907816).
[^2]: Guay-Bélanger, Dany. 2022. “Assembling Auras: Towards a Methodology for the Preservation and Study of Video Games as Cultural Heritage Artefacts.” _Games and Culture_ 17 (5): 659–78. [https://doi.org/10.1177/15554120211020381](https://doi.org/10.1177/15554120211020381).
[^4]: Victoria and Albert Museum. “Preserving and Sharing Born Digital and Hybrid Objects · V\&A.” Accessed April 22, 2025. [https://www.vam.ac.uk/research/projects/preserving-and-sharing-born-digital-and-hybrid-objects](https://www.vam.ac.uk/research/projects/preserving-and-sharing-born-digital-and-hybrid-objects). Stallman, Richard, and Richard M. Stallman. *Free Software, Free Society: Selected Essays*. Edited by Joshua Gay. 1st. ed. Boston, Mass: Free Software Foundation, 2002, S.50.

[^5]:  Moore, Jennifer, and Hannah Scates Kettler. “Who Cares About 3D Preservation?” *IASSIST Quarterly* 42, no. 1 (2018): 15–15. [https://doi.org/10.29173/iq20](https://doi.org/10.29173/iq20).

[^6]:  Jones, Steven. “Reverse Engineering the First Humanities Computing Center.” *Digital Humanities Quarterly* 12, no. 2 (2018). [https://www.digitalhumanities.org/dhq/vol/12/2/000380/000380.html](https://www.digitalhumanities.org/dhq/vol/12/2/000380/000380.html).

[^7]: Montfort, Nick, and Ian Bogost. 2009. _Racing the Beam: The Atari Video Computer System_. Platform Studies. Cambridge, Mass: MIT Press.
[^8]:  Henry Jenkins. “A New ‘Platform’ for Games Research?: An Interview with Ian Bogost and Nick Montfort (Part One) — Pop Junctions,” April 27, 2009. [http://henryjenkins.org/blog/2009/04/an*interview*with*ian*bogost*a.html](http://henryjenkins.org/blog/2009/04/an_interview_with_ian_bogost_a.html).

[^9]:  CLIR. “Digital Forensics and Born-Digital Content in Cultural Heritage Collections • CLIR.” Accessed April 22, 2025. [https://www.clir.org/pubs/reports/pub149/](https://www.clir.org/pubs/reports/pub149/).

[^10]:  Shaw, Jonathan. “Digital Preservation: An Unsolved Problem | Harvard Magazine,” April 7, 2010. [https://www.harvardmagazine.com/2010/04/digital-preservation-an-unsolved-problem](https://www.harvardmagazine.com/2010/04/digital-preservation-an-unsolved-problem).

[^11]:  [Ensom, “TECHNICAL NARRATIVES: ANALYSIS, DESCRIPTION AND REPRESENTATION IN THE CONSERVATION OF SOFTWARE-BASED ART.”](https://www.zotero.org/google-docs/?aEIUmD)

[^12]:  Further file signatures are listed on [https://en.wikipedia.org/wiki/List*of*file*signatures](https://en.wikipedia.org/wiki/List_of_file_signatures) 

[^13]:  Levy, Scott, and Jedidiah R. Crandall. “The Program with a Personality: Analysis of Elk Cloner, the First Personal Computer Virus.” arXiv, July 30, 2020. [https://doi.org/10.48550/arXiv.2007.15759](https://doi.org/10.48550/arXiv.2007.15759) and Giacalone, Anthony. “Agiacalone/Elk-Cloner-Malware.” Assembly, April 21, 2024. [https://github.com/agiacalone/elk-cloner-malware](https://github.com/agiacalone/elk-cloner-malware).

[^14]:  Textfiles, hideseek, http://www.textfiles.com/computers/DOCUMENTATION/hideseek.txt

[^15]:  Graciously offered by SCA via [https://www.sca.ch/c64/software/sca-releases/SCA-Summer%20Games](https://www.sca.ch/c64/software/sca-releases/SCA-Summer%20Games) 

[^16]:  Hosted on [https://archive.org/details/summer*games](https://archive.org/details/summer_games)  

[^17]:  Biittner, Biittner, and John Aycock. “Inspecting the Foundation of Mystery House | Journal of Contemporary Archaeology.” Accessed May 21, 2025. [https://journal.equinoxpub.com/JCA/article/view/17513](https://journal.equinoxpub.com/JCA/article/view/17513).

[^18]:  Aycock, John. “Amnesia Remembered: Reverse Engineering a Digital Artifact.” In *Amnesia Remembered*. Berghahn Books, 2023. [https://doi.org/10.1515/9781800738683](https://doi.org/10.1515/9781800738683).

[^19]:  Aycock, John, and Tara Copplestone. “Entombed: An Archaeological Examination of an Atari 2600 Game.” *The Art, Science, and Engineering of Programming* 3, no. 2 (November 5, 2018): 4. [https://doi.org/10.22152/programming-journal.org/2019/3/4](https://doi.org/10.22152/programming-journal.org/2019/3/4).

[^20]:  Aycock, John, Shankar Ganesh, Katie Biittner, Paul Allen Newell, and Carl Therrien. “The Sincerest Form of Flattery: Large-Scale Analysis of Code Re-Use in Atari 2600 Games.” In *Proceedings of the 17th International Conference on the Foundations of Digital Games*, 1–10. Athens Greece: ACM, 2022. [https://doi.org/10.1145/3555858.3555948](https://doi.org/10.1145/3555858.3555948).

[^21]:  “Radareorg/Radare2.” C. 2012. Reprint, radare org, June 1, 2025. [https://github.com/radareorg/radare2](https://github.com/radareorg/radare2).

[^22]:  “Steil, Michael. “6502 | Ultimate Commodore 64 Reference.” Accessed July 7, 2025. [https://www.pagetable.com/c64ref/6502/#](https://www.pagetable.com/c64ref/6502/#).

[^23]:  slajerek. “Slajerek/RetroDebugger.” C, May 12, 2025. [https://github.com/slajerek/RetroDebugger](https://github.com/slajerek/RetroDebugger).

[^24]:  “Retro Reverse Engineering.” Accessed May 21, 2025. [https://www.retroreversing.com/](https://www.retroreversing.com/).

[^25]:  “JS99’er.” Accessed May 21, 2025. [https://js99er.net/](https://js99er.net/#/).

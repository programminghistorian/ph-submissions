---
title: "Visualizing Historic Maps with IIIF and Allmaps"
slug: visualizing-historic-maps-iiif-allmaps
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Stephen Appel
- Ian Spangler
reviewers:
- Forename Surname
- Forename Surname
editors:
- Agustín Cosovschi
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/698
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

<!-- Begin Part 1.00 -->
## Web-based georeferencing with Allmaps

[Georeferencing](https://en.wikipedia.org/wiki/Georeferencing) turns scanned maps into spatial data by corresponding the pixels in a digital map image to real geographic locations. The process emerged from the practice of transforming aerial and satellite photography into usable spatial data.[^1] Today, historians and other humanities researchers georeference maps for things like data creation, change detection, and comparative analysis.

Traditionally, georeferencing requires uploading an image file, like a `JPG` or `TIFF`, to a geographic information system (GIS) or web client. The output typically includes a map in `GeoTIFF` format which can be overlaid on real-world geographies. You can check out existing *Programming Historian* lessons for explanations of these georeferencing workflows in [Map Warper](https://programminghistorian.org/en/lessons/introduction-map-warper), [QGIS 2.0](https://programminghistorian.org/en/lessons/georeferencing-qgis), and [KnightLab's StoryMap JS](https://programminghistorian.org/en/lessons/displaying-georeferenced-map-knightlab-storymap-js).

In this lesson, we introduce [Allmaps](https://allmaps.org), an open-source set of tools for
curating and georeferencing digital maps.

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-01.jpg" alt="A georeferenced historic map, overlaid in the Allmaps platform" caption="Figure 1. A georeferenced historic map, overlaid in the Allmaps platform." %}

Allmaps is a free, publicly accessible, and web-based solution to georeferencing.
Instead of requiring users to upload image files to a GIS or web client, Allmaps fetches
image files directly from digital collections and dynamically warps them in a web
browser. It is powered by a simple JSON file---a *georeference annotation*---which
contains all the metadata necessary to warp a map. In addition to providing a simple
interface for georeferencing, Allmaps provides a robust set of command-line tools and
web-mapping libraries that advanced users can use to extend their research and
visualization workflows.

Allmaps was founded by [Bert Spaan](https://bertspaan.nl/) and [Jules Schoonman](https://www.tudelft.nl/en/staff/j.a.schoonman/).
Bert Spaan is lead developer, and Jules Schoonman leads educational projects for the platform.
Other contributors and partners are listed on [allmaps.org](https://allmaps.org/#about-allmaps).

### Lesson path and prerequisites

The first part of this lesson is beginner-friendly and browser-based.
You will learn how to find a map shared through the International Image Interoperability
Framework (IIIF), georeference it in Allmaps Editor, and inspect the result in Allmaps Viewer.
These sections assume comfort using a web browser, copying URLs, and reading short snippets of JSON,
but they do not require command-line experience.

The later sections are more advanced. 
They use the command line to reuse Allmaps georeferencing data in local files, GIS workflows, and a small web map example.
They assume familiarity with installing software, navigating files from a terminal, and running commands. 
You can complete the browser-based sections first and return to the command-line sections later.
The Leaflet section also assumes basic familiarity with HTML, CSS, JavaScript, and the
structure of a simple Leaflet map.

IIIF appears here as prerequisite context for working with Allmaps resources.
This lesson does not teach how to create or host IIIF images and manifests from scratch.
For that, see the lesson "Creating and Hosting Basic IIIF Images and Manifests Using GitHub."

### What you will learn

1. Why georeferencing is useful for research and scholarship
2. The IIIF concepts needed to work with resources in Allmaps
3. How to use Allmaps to view and georeference IIIF maps
4. How to reuse Allmaps georeferencing data with command-line tools
5. How Allmaps annotations can move into GIS and web mapping workflows

### Why georeference?

Researchers and scholars georeference maps to compare places over time and connect historical maps to other spatial data.

At the Leventhal Map & Education Center, [Atlascope](https://atlascope.org) allows users to explore georeferenced urban atlases in a web map:

<iframe src="https://atlascope.org" title="Atlascope web map" width="100%" height="500px"></iframe>

Georeferencing makes it possible to:

- Compare landscapes past and present, including streets, buildings, waterways, shorelines, neighborhoods, and boundaries
- Study change over time by overlaying maps from different times
- Join sheets from an atlas or map set into a larger composite
- Derive geospatial data for further analysis

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-02.png" alt="Historic map image aligned over a modern GIS basemap." caption="Figure 2. The georeferencing process places a digital image into a GIS." %}

Traditional georeferencing solutions are built into geographic information systems (GIS) like QGIS
or ArcGIS. Although GIS-based georeferencing tools can still be useful for some workflows, they do
have a steep learning curve, and in the case of ArcGIS, are quite expensive. This is where IIIF
comes in: Allmaps can fetch compatible map images directly from digital collections and warp them
in a browser.

### What you need to know about IIIF for Allmaps

[IIIF](https://iiif.io/) (pronounced "triple-eye-eff") is a set of open standards for
delivering high-quality digital objects online. In this lesson, the most important IIIF
object is the manifest: a web-accessible JSON file that describes a digital object and
points applications toward the image data they need.

To georeference a map in Allmaps, you usually start with a IIIF manifest URL.
Allmaps reads that manifest to locate the map image and its image service.

The short IIIF context below is meant to help you recognize and use the resources that
Allmaps needs, not to explain every part of the IIIF standard.

From there, Allmaps can request the image data it needs, create a georeference annotation,
and warp the map in a browser.
For this lesson, you mainly need to be able to tell the difference between three URLs:

- A collection record URL, which is the human-readable page for an item in a digital collection
- A IIIF manifest URL, which is the JSON file that Allmaps needs in order to load the map
- An Allmaps annotation URL, which points to the georeferencing data created after a map has been
  worked on in Allmaps

For example, the digital collection record for the Leardo Mappamundi is:

**Tip:** Open each of the URLs in a new tab as you go.

[https://collections.lib.uwm.edu/digital/collection/agdm/id/37085/](https://collections.lib.uwm.edu/digital/collection/agdm/id/37085/)

The Leardo map's IIIF manifest is listed at the bottom of the page, near the IIIF logo:

[https://collections.lib.uwm.edu/iiif/info/agdm/37085/manifest.json](https://collections.lib.uwm.edu/iiif/info/agdm/37085/manifest.json)

If you open the manifest link in a browser, you will see [JSON](https://www.json.org/json-en.html)
(JavaScript Object Notation) data.
You do not need to copy that JSON text into Allmaps.
You only need the manifest URL itself.

The manifest leads Allmaps to the underlying IIIF image service.
A IIIF Image API URL can request the full image, a smaller version,
or a cropped region of the same source image.[^2]

The American Geographical Society Library Digital Map Collection is publicly accessed
through UWM Libraries at `collections.lib.uwm.edu`,
but some IIIF image service URLs resolve to the underlying CONTENTdm/OCLC host,
`cdm17272.contentdm.oclc.org`.
For most browsing purposes these point to the same resource.
However, Allmaps generates IDs from the exact image service URL string, so changing the
host changes the Allmaps ID and the expected filenames in some later steps.

For example, this URL requests a smaller version of the Leardo image:

[https://cdm17272.contentdm.oclc.org/iiif/2/agdm:37085/full/1200,/0/default.jpg](https://cdm17272.contentdm.oclc.org/iiif/2/agdm:37085/full/1200,/0/default.jpg)

### IIIF map collections

Allmaps uses these APIs (and others) to fetch IIIF images from digital repository servers
and warp them in a web browser.
The Allmaps platform consists of two main apps: [Allmaps Editor](https://editor.allmaps.org),
which allows you to georeference a IIIF map, and [Allmaps Viewer](https://viewer.allmaps.org),
which allows you to view them.

All of the maps in [AGSL](https://uwm.edu/lib-collections/agsl-digital-map-collection/)
and [LMEC](https://collections.leventhalmap.org) digital collections are IIIF compliant.
Additionally, the Allmaps project maintains a [list of IIIF map collections](https://github.com/allmaps/iiif-map-collections/blob/main/iiif-map-collections.yml)
across the world.
Any of the collections that you see in this list should be easy to work with in Allmaps.

Other websites may require more sleuthing to find the manifest.
On the [David Rumsey Map Collection](https://www.davidrumsey.com), the IIIF manifest is
listed under the share menu:

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-03.png" alt="David Rumsey Map Collection share menu showing IIIF manifest options." caption="Figure 3. Finding a IIIF manifest in the David Rumsey Map Collection." %}

If you are comfortable installing a browser extension, [DetektIIIF](https://seige.digital/en/detektiiif/)
can help identify IIIF resources on pages where the manifest link is not visible.
If a IIIF image is present on a website, DetektIIIF can usually find its manifest.

<!-- Begin Part 1.01 -->
## Allmaps Editor

Now that you know what kind of resource Allmaps needs, we can begin georeferencing.

First, launch Allmaps Editor by going to [https://editor.allmaps.org](https://editor.allmaps.org).
You can choose a map to georeference by either:

1. Entering a IIIF manifest URL in the text box at the top of the page
2. Scrolling down to find a map in one of the featured collections

When entering a manifest, paste the manifest URL itself, not the JSON text that appears
when you open the manifest in a browser.

Allmaps uses metadata in the IIIF manifest to fetch image data from the host institution's
servers.

Allmaps is especially useful for large-scale maps whose content can be matched to modern geography,
such as:

- Urban atlases like fire insurance atlases, plats, and quartersectional atlases
- County and state maps, highway maps, and recreation maps
- Topographic or thematic map series

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-04.png" alt="American Geographical Society Library Digital Map Collection item page showing the IIIF manifest URL field." caption="Figure 4. Finding the IIIF manifest URL in the American Geographical Society Library Digital Map Collection." %}

This lesson will use screenshots from georeferencing this
[chart of New Zealand](https://collections.lib.uwm.edu/digital/collection/agdm/id/3198/),
but you should pick a different map to georeference.

### Draw a mask

The first step is adding a clipping mask.
This involves drawing a line around the map areas of the document to exclude the collar or
marginalia.
The mask identifies parts of the scanned image that you want to georeference.
Only parts of the image inside the mask will be warped.
In the Allmaps lexicon, one mask defines a "map" on a region of the "image".

Use the "Draw Mask" tab to add a mask before moving on to georeferencing.
Click to add points, and double-click to close the polygon.
If you mess up, click "Cancel" to start over.

In the figure below, note that the pink line defines the mask and excludes the map collar from the defined map.

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-05.png" alt="Screenshot of Allmaps Editor with a polygon mask drawn around the map area." caption="Figure 5. Drawing a clipping mask in Allmaps Editor." %}

Your image may include multiple maps! If so, each map gets its own mask.

In the figure below, three maps are defined from a single image: the main map image (labeled 1) and two inset map areas (labeled 2 and 3).

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-06.jpg" alt="Scanned page showing multiple maps on one sheet. Main map labeled 1, inset maps labeled 2 and 3." caption="Figure 6. A scanned page with multiple maps, each of which would need its own mask." %}

Much of the time, your mask will simply be a rectangle drawn just inside the map's neatline.

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-07.png" alt="Screenshot zoomed to a corner showing the mask just inside the neatline." caption="Figure 7. A rectangular mask drawn near the map corners." %}

### Georeference the map

Ground control points (GCPs) guide Allmaps in aligning the scanned image (left side) with real-world geography (right side).

Use the "Georeference" tab to begin placing GCPs.

To create one, find a location that clearly matches on both sides, such as a street intersection, the corner of a recognizable building, or a stable political boundary.

Click the same spot on both sides of the editor.

In the figure below, note the pink dot labeled `2` on both sides of the image, in this case an easily identifiable location near Cape Reinga on the Aupōuri Peninsula of New Zealand.

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-08.png" alt="Screenshot of Allmaps Editor with matching ground control points placed on the scanned map and the modern basemap." caption="Figure 8. Adding ground control points in Allmaps Editor." %}

When placing ground control points---especially for cartographic corpora like urban atlases---consider the following:

- **Avoid water bodies**: they change too much over time to be reliable.
- **Use roads and buildings**: as long as they have not been torn down or significantly altered.
- **Check your progress**: sometimes only a few GCPs are needed. Too many can actually introduce unwanted distortion. A good check-in is after placing 5-10 points.

These guidelines are adapted from the Leventhal Map & Education Center's guide to georeferencing with Allmaps.[^4]

Remember, landscapes change: roads shift, water levels fluctuate, buildings are razed and replaced.

Before reading further, create a few GCPs of your own and check the "Results" tab to see how the
map begins to align.

#### The georeference annotation

Behind the scenes, placing GCPs in Allmaps creates a **[Georeference Annotation](https://iiif.io/api/extension/georef/)**, a standard format for storing geospatial information associated with a IIIF image. The Annotation specification is maintained by the [IIIF Consortium](https://iiif.io).

Each point creates a pair of values:

- **Resource coordinates** – pixel location in the image (e.g. 3017, 4367)
- **Geometry coordinates** – geographic location in longitude/latitude (e.g. 172.936215°E, 43.7589394°S)

```json
{
  "type": "Feature",
  "properties": {
    "resourceCoords": [3017, 4367]
  },
  "geometry": {
    "type": "Point",
    "coordinates": [172.936215, 43.7589394]
  }
}
```

Allmaps uses this data to calculate the warping or stretching needed to align the map image in geographic space. Six-digit coordinate precision is probably overkill, but hey, it gives us an excuse to use [one of our favorite xkcd comics](https://xkcd.com/2170):

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-09.png" alt="A humorous comic that highlights the diminishing returns of latitude/longitude precision beyond four decimal points" caption="Figure 9. Coordinate precision, by xkcd." %}

Georeference annotations are automatically created when you draw a mask or place a control point.
From Allmaps Editor, here is how you can locate a map's georeference annotation:

1. Click the green "Export" button
2. Click the up-right arrow by the "Georeference annotation" to open it in a new tab, or click the purple `</> Code` button to inspect the annotation in Allmaps Editor

Here is the georeference annotation for that chart of New Zealand:

[https://annotations.allmaps.org/images/ed34bf1e16463906](https://annotations.allmaps.org/images/ed34bf1e16463906)

That ID, `ed34bf1e16463906`, is called an "Allmaps ID."
It is unique to the Allmaps data ecosystem.
It is generated by passing the IIIF manifest through a hashing algorithm that produces a
unique, 16-digit alphanumeric identifier.

Open the annotation in a new tab and inspect it. Can you make sense of what each `key` and each `value` are communicating? Can you locate the resource coordinates and geometry coordinates?

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-10.png" alt="Diagram showing how pixel coordinates in the image correspond to geographic coordinates in the georeference annotation." caption="Figure 10. Resource coordinates and geometry coordinates in a georeference annotation." %}

### Review results

The "Results" tab displays a preview of the map with georeferencing applied.
It is a useful way to check alignment and see if you are on the right track.

Notice in the figure below that the map is displayed with its collar removed beyond the neatline and the shape is no longer rectangular and has taken on a parallelogram shape.

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-11.png" alt="Screenshot of the Results tab in Allmaps Editor showing the georeferenced preview over the basemap." caption="Figure 11. Previewing georeferencing results in Allmaps." %}

In the upper right, under *Export*, you will see a drawer with more tools:

- Link to view in Allmaps Viewer
- Link to the annotation
- A `</> Code` button shows the full Georeference Annotation as a popup
- XYZ tiles (usable in web maps or GIS software)

On the bottom right, under *Maps* you can find:

- **Transformation** and **Projection** to modify how the map is warped and how its coordinates are stored
- **GCP List** – lists all your points; delete ones that do not work

The *Transformation* option controls the algorithm Allmaps uses to warp the image from your control points. Different algorithms will produce different results. 
Some stretch or distort the image more than others, so changing the transformation can change how you interpret the map, not just how it looks.

The *Projection* option lets you choose the projection used for the map's geospatial coordinates.
These settings are written into the georeference annotation, so they become part of the map data that Viewer, the tile server, and other Allmaps tools read later.

Compare transformation and projection options as different interpretations of the same control points, and pay attention to places where the map stretches, bends, or preserves local detail.

The animation below shows just how much changing the transformation algorithm can impact the overlay.

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-12.gif" alt="Animated comparison showing how different transformation algorithms warp the same georeferenced map in different ways." caption="Figure 12. Different transformation algorithms can produce different warping results." %}

<!-- TODO: Need updated screenshot. -->
{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-13.png" alt="Screenshot of the Allmaps export drawer showing links to the viewer, annotation, code, and tile tools." caption="Figure 13. The share menu in Allmaps." %}

Click the *View in Allmaps Viewer* link in the Export menu to continue.
Next we will work with the map in Allmaps Viewer.

<!-- Begin Part 1.02 -->
## Allmaps Viewer

[Allmaps Viewer](https://viewer.allmaps.org) is used to view georeferenced maps in Allmaps.
Similar to the *Results* tab in Editor, you can see the warped map overlaid on a web map.

Viewer also includes additional tools that let you customize the appearance and functionality of your map.
Common tools (found at the bottom of the screen) include sliders that control layer transparency/opacity and background removal.

Background removal is especially useful with historical maps—it removes the blank paper and helps isolate printed geographic content from the scanned page, making overlays easier to interpret.

Viewer is not used to georeference maps.
Instead, it is used for inspecting results and assessing how a warped historical map
behaves in relation to modern geography.

The figure below shows a georeferenced map of New Zealand with the background removed.

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-14.png" alt="Comparison in Allmaps Viewer showing the same map with background removal off and on." caption="Figure 14. Background removal in Allmaps Viewer." %}

Allmaps Viewer has some useful keyboard shortcuts:

- _Space_ – Toggle transparency on/off
- _B_ – Toggle background removal
- _M_ – Toggle display of the mask line
- _T_ – Cycle transformation algorithm
- _G_ – Display a grid over the image
- _D_ – Cycle display of distortions: surface deformation, angle distortion, or none

### View stitched atlas sheets

The example below uses georeferenced atlas sheets for Lynn, Massachusetts.
The Allmaps annotation is:

[https://annotations.allmaps.org/manifests/23379602e8187445](https://annotations.allmaps.org/manifests/23379602e8187445)

<iframe
  src="https://viewer.allmaps.org/?url=https%3A%2F%2Fannotations.allmaps.org%2Fmanifests%2F23379602e8187445"
  title="Allmaps Viewer showing georeferenced atlas sheets for Lynn, Massachusetts"
  width="100%"
  height="650"
  allowfullscreen>
</iframe>

[View in Allmaps Viewer](https://viewer.allmaps.org/?url=https%3A%2F%2Fannotations.allmaps.org%2Fmanifests%2F23379602e8187445)

Since these atlas pages were carefully masked, they mosaic almost seamlessly, allowing one to
explore the whole atlas at once.
This kind of stitching takes careful work: small differences in mask placement, GCPs,
or transformation settings can create visible gaps or overlaps between sheets.

Using _M_ to display the mask lines shows how all the component maps fit together.

When working with multi-sheet objects:

- _[_ and _]_ – Cycle through maps
- Open the map context menu, for example by right-clicking – Change map layer order

Once you have checked how the map behaves in the viewer, you can also use the same georeferenced map outside Allmaps.

The viewer is useful for inspecting alignment; XYZ tiles make the warped map available as a layer in desktop GIS software.

### Use XYZ tiles in GIS

Allmaps provides a free *XYZ tile server*, allowing you to bring georeferenced maps directly into GIS software like QGIS.
Note: this is not intended for permanent hosting.

In QGIS, use the Add XYZ Layer tool:

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-15.png" alt="QGIS dialog for adding a new XYZ tile layer." caption="Figure 15. Opening the XYZ tile layer dialog in QGIS." %}

Copy the XYZ Tile URL from the Allmaps Editor Share tools:

<!-- TODO: Update this screenshot before submission. -->
{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-16.png" alt="Allmaps export menu showing where to copy the XYZ tile URL." caption="Figure 16. Finding the XYZ tile URL in Allmaps." %}

Then create a new XYZ Connection in QGIS and paste in the URL. No other changes are usually needed.

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-17.png" alt="QGIS form for creating a new XYZ connection by pasting the tile URL." caption="Figure 17. Creating a new XYZ connection in QGIS." %}

Now you can use your georeferenced map directly in desktop GIS as a reference layer alongside other raster and vector data.

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-18.png" alt="Georeferenced historical map displayed in QGIS from the Allmaps XYZ tile service." caption="Figure 18. A georeferenced map displayed in QGIS." %}

Use the Allmaps Tile Server for testing desktop GIS workflows or other software that needs an XYZ
tile URL.
Because each requested tile has to be fetched, warped, and returned by a server, tiles may load
slowly, break, or stop working.

For web maps you control, Allmaps Viewer or the Allmaps plugins for OpenLayers and Leaflet are
usually better choices because they can warp IIIF images directly in the browser.
This means the browser does the transformation work instead of depending on a tile server for every map tile.

More detail on the Allmaps Tile Server is available in this
[Observable notebook](https://observablehq.com/@allmaps/allmaps-tile-server).


<!-- Begin Part 3.00 -->
## Install the Allmaps CLI and dependencies

So far, the lesson has focused on introductory, browser-based tools: finding IIIF resources,
georeferencing a map in Allmaps Editor, and inspecting the result in Allmaps Viewer.
The next sections introduce more advanced workflows at the command line so you can reuse Allmaps
georeferencing data in your own files, GIS projects, and web maps.

<div class="alert alert-warning" markdown="block">
This portion assumes some familiarity with the command line in a Unix environment
(Linux, macOS, or a Unix-like environment on a Windows PC), installing packages,
and generating and running scripts from the command line.

Never copy and paste code into your terminal unless you understand what it is doing.
This lesson requires installing software such as
[Allmaps Command Line](https://www.npmjs.com/package/@allmaps/cli),
[Node.js](https://nodejs.org/en/download),
[GDAL](https://gdal.org/en/stable/download.html),
[dezoomify-rs](https://github.com/lovasoa/dezoomify-rs),
and other dependencies.

Installation and compatibility will vary depending on your operating system,
OS version, and shell environment.
</div>

### Environment setup

#### Windows only: Set up WSL

macOS and Linux users can skip this section and jump to [Linux and Unix](#linux-and-unix).

This lesson uses WSL for Windows because the command-line tools in this section are easiest to install and teach in a Unix-like environment.
WSL gives Windows users a Linux shell that behaves much like the macOS and Linux workflows used in the rest of the lesson,
which keeps commands, paths, and troubleshooting more consistent.

Native Windows workflows are possible, but they require different setup steps.
Follow Microsoft's [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
documentation to set up WSL with Ubuntu, then continue with the Linux and Unix instructions below.

#### Linux and Unix

The commands below are written for Ubuntu and Debian-based environments, including Ubuntu on WSL, that use the `apt` package manager.
Other Linux or Unix-like systems may use different package managers, package names, and compilation methods.

Install the current long-term support (LTS) version of Node.js using the standard installer or package manager for your operating system.

On Ubuntu, Debian, or Ubuntu on WSL, you can use the instructions from Node.js:

[https://nodejs.org/en/download](https://nodejs.org/en/download)

Use Node.js 22 or newer, preferably the current LTS version.

After installation, confirm that Node.js and npm are available:

```bash
node --version
npm --version
```

If both commands print version numbers, continue with the next step.

Install GDAL:

```bash
sudo apt install gdal-bin libgdal-dev
```

#### macOS

Install [Homebrew](https://brew.sh/) if not already installed.

Refresh Homebrew’s package list:

```zsh
brew update
```

Install Node.js. You can use the installer from Node.js or Homebrew.

```zsh
brew install node
```

After installation, confirm that Node.js and npm are available:

```bash
node --version
npm --version
```

If both commands print version numbers, continue with the next step.

Install GDAL:

```zsh
brew install gdal
```

### Install the Allmaps CLI and dependencies

Install the Allmaps CLI:

```bash
npm install -g @allmaps/cli
```

Confirm that Allmaps CLI and GDAL are available:

```bash
allmaps --help
gdalinfo --version
```

One example in this portion uses a small local web server to preview files in the browser.
If Python 3 is already installed, you can use its built-in server.

Alternatively, because this lesson already uses Node.js and npm, you can use `npx http-server`.

### Tools for JSON inspection and GeoTIFF export

The GeoJSON workflow uses `jq` to inspect geometry types.

The GeoTIFF workflow uses `jq` to inspect IIIF Image API metadata and `dezoomify-rs` to download a full-resolution image when the source image dimensions do not match the Allmaps annotation.

On Ubuntu/Debian or Ubuntu on WSL, install jq:

```bash
sudo apt install jq
```

On macOS, install jq with Homebrew:

```zsh
brew install jq
```

[`dezoomify-rs`](https://github.com/lovasoa/dezoomify-rs) is used for full image extraction.

On Ubuntu/Debian or Ubuntu on WSL, install Rust and then install `dezoomify-rs` with Cargo:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Load Cargo in your current terminal session:

```bash
source "$HOME/.cargo/env"
```

Confirm Cargo is available:

```bash
cargo --version
```

Install dezoomify-rs:

```bash
cargo install dezoomify-rs
```

On macOS, install dezoomify-rs with Homebrew instead:

```zsh
brew install dezoomify-rs
```

Confirm the tools are available:

```bash
jq --version
dezoomify-rs --help
```

<div class="alert alert-warning" markdown="block">
If installation fails, the most likely missing pieces are Node.js, npm, GDAL, Rust/Cargo, or small command-line utilities such as `jq`.
After installing a new tool, you may need to restart your terminal before the command is available.
</div>

### Download the lesson files

Before continuing, download the sample files supplied with this lesson and unzip them in
the directory where you will work through the command-line examples. In the lesson
preview, these files are available in the
`visualizing-historic-maps-iiif-allmaps` assets directory.
Once the lesson is published, use the lesson's download link to retrieve the zipped files.

The examples below assume that you have placed the unzipped files in a local folder named
`data`, alongside any files you create while following the lesson. For example, your
working directory should contain files such as `data/annotation.json`,
`data/voiries1300_2009_clean.json`, and
`data/voiries1300_2009_clean.geometries.ndjson`. If you use a different folder name or
arrange the files differently, adjust the paths in the commands accordingly.

<!-- Begin Part 3.01 -->
## Draw GeoJSON on a IIIF image

The georeference metadata produced by Allmaps Editor can be used to convert geospatial coordinates to pixel coordinates to draw GeoJSON on the original unwarped map.

In the command-line examples below, `jq` is a small tool for inspecting and reshaping JSON data.

### Paris example

For the main walkthrough, this example overlays a medieval road network from around 1300 on the 1821 AGSL map of Paris.
The goal is to draw historical vector data directly on the scanned map image, rather than placing both layers on a modern web map.
This lets us ask how the medieval street network relates to the geography shown on the
nineteenth-century map.

Keep a logbook or text file for the URLs, manifests, IDs, filenames, and other reference information you use in a project,
particularly if you are using an example other than the one provided.

For this walkthrough, the key values are:

<div class="table-wrapper" markdown="block">

| Resource | Location / URL |
| --- | --- |
| AGSL Map of Paris, 1821 | [https://collections.lib.uwm.edu/digital/collection/agdm/id/1550/](https://collections.lib.uwm.edu/digital/collection/agdm/id/1550/) |
| IIIF manifest URL       | [https://collections.lib.uwm.edu/iiif/info/agdm/1550/manifest.json](https://collections.lib.uwm.edu/iiif/info/agdm/1550/manifest.json) |
| Viewer URL | [https://viewer.allmaps.org/?url=https%3A%2F%2Fannotations.allmaps.org%2Fimages%2Fadeae8a56aaf59fb](https://viewer.allmaps.org/?url=https%3A%2F%2Fannotations.allmaps.org%2Fimages%2Fadeae8a56aaf59fb) |
| Georeference annotation | [https://annotations.allmaps.org/images/adeae8a56aaf59fb](https://annotations.allmaps.org/images/adeae8a56aaf59fb) |
| Allmaps Image ID        | `adeae8a56aaf59fb` |
| Image ID URL            | [https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550](https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550) |
| Image Dimensions        | `10784 x 6941` |
| Original source file | `data/voiries1300_2009.json` |
| Lesson-ready file | `data/voiries1300_2009_clean.json` |

</div>

#### Data note

The road network was originally published by ALPAGE as "Road network in 1300" by Caroline Bourlet and Anne-Laure Bethe.[^5]

[Download original data](https://alpage.huma-num.fr/documents/ressources/shapes/52-voieries1300_2009.zip) (optional)

The local file `data/voiries1300_2009.json` is derived from that source. A cleaned teaching version is included, `data/voiries1300_2009_clean.json`, where each `MultiLineString` has already been split into separate `LineString` features.

### Process overview

The workflow starts with a historical map that has already been georeferenced in Allmaps. We use a frozen copy of the georeference annotation for that image, feed it to the Allmaps CLI, and use it to build the transformation between geographic coordinates and image pixels. Then we convert the GeoJSON from longitude/latitude into SVG coordinates measured in the original image space and display that transformed SVG as an overlay on the original, unwarped IIIF image.

Allmaps is not changing the GeoJSON into a new map projection for display in a web map. It is converting the GeoJSON into image-space coordinates so the shapes can be drawn directly on the scanned map image.

For this example, we need three things: a historical image georeferenced in Allmaps, the georeference annotation for that image, and some geographic data to overlay. Here, those are the [1821 AGSL Paris map](https://collections.lib.uwm.edu/digital/collection/agdm/id/1550/), `data/annotation.json`, and `data/voiries1300_2009_clean.json`.

#### Use the frozen `annotation.json`

Because Allmaps georeferencing data can be edited, this lesson uses a frozen copy of the Paris georeference annotation included at `data/annotation.json`.

That local copy was downloaded from the Allmaps annotations service using the Paris map's IIIF manifest URL:

[https://annotations.allmaps.org/?url=https://collections.lib.uwm.edu/iiif/info/agdm/1550/manifest.json](https://annotations.allmaps.org/?url=https://collections.lib.uwm.edu/iiif/info/agdm/1550/manifest.json)

For your own map, you can download the current annotation JSON from the annotations service with
`curl`:

```bash
curl -L "https://annotations.allmaps.org/?url=YOUR_IIIF_MANIFEST_URL" -o data/annotation.json
```

#### Confirm that the map has georeference metadata

The file `data/annotation.json` contains:

* the IIIF image identifier
* the image dimensions
* the ground control points
* the transformation type

You can inspect it with:

```bash
allmaps annotation parse data/annotation.json
```

You should see output like this:

```json
[
  {
    "@context": "https://schemas.allmaps.org/map/2/context.json",
    "type": "GeoreferencedMap",
    "id": "https://annotations.allmaps.org/maps/2543dadd9c2fa8b1",
    "created": "2026-04-03T16:46:18.241Z",
    "modified": "2026-04-03T16:46:18.241Z",
    "resource": {
      "id": "https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550",
      "width": 10784,
      "height": 6941,
      "type": "ImageService2",
      "partOf": [
...
```

That command translates the annotation into Allmaps' internal `GeoreferencedMap` format.
This is the moment where the CLI learns how the Paris image relates to real-world coordinates.

#### Inspect the prepared GeoJSON

Before transforming the GeoJSON, inspect the prepared file in two ways.
First, open [https://geojson.io](https://geojson.io) in your browser and use the
open/import function to load `data/voiries1300_2009_clean.json`.

You should see the medieval road network drawn over the modern basemap.
This confirms that the file is valid GeoJSON with geographic longitude/latitude coordinates.

Then use `jq` to check what kinds of geometry appear in the file:

```bash
jq -r '[.features[].geometry.type] | unique[]' 'data/voiries1300_2009_clean.json'
```

For this dataset, the result is:

```bash
LineString
```

This matters because the next steps assume each feature can be transformed and drawn as a line, rather than as mixed geometry types that would need extra cleanup or styling.

To keep this lesson focused, the GeoJSON cleanup has already been done. The lesson package includes both the cleaned `FeatureCollection` and a prepared geometry stream for the CLI:

* `data/voiries1300_2009_clean.json`
* `data/voiries1300_2009_clean.geometries.ndjson`

The second file contains one geometry per line, ready to be piped into the local Allmaps CLI.
`.ndjson` is a Newline Delimited JSON file.

#### Transform GeoJSON into image-space SVG

Now we can run the actual Allmaps transformation:

```bash
allmaps transform geojson \
  -a data/annotation.json \
  < data/voiries1300_2009_clean.geometries.ndjson \
  > voiries1300_2009.svg
```

If this runs without error, expect not to see anything output to your shell.

This command is worth unpacking carefully:

* `transform geojson` takes geographic geometry and converts it into resource coordinates
* `-a data/annotation.json` supplies the georeference annotation
* `< data/voiries1300_2009_clean.geometries.ndjson` sends the prepared geometries into the command through standard input
* `> voiries1300_2009.svg` saves the transformed output as SVG
* `\` is a line continuation character. It tells the shell to treat the next line as part of the same command.

The result is not a new GeoJSON.
It is an SVG graphic whose coordinates match the pixel grid of the 1821 Paris image.

#### Overlay the SVG on the IIIF image

Once `voiries1300_2009.svg` exists, the hard part is done. You now have:

* the historical image served via IIIF
* an SVG whose coordinates line up with that image

For a quick visual check, make a small web page.
The page creates an SVG with the IIIF image first, then adds the transformed road lines on top.

From `data/annotation.json`, we know the original image dimensions:

```json
    "resource": {
      "id": "https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550",
      "width": 10784,
      "height": 6941,
      ...
```

Create a file named `paris-road-overlay.html` (in the same directory as `voiries1300_2009.svg`) that contains the content below:

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Paris road overlay</title>
    <style>
      body {
        margin: 0;
      }

      svg {
        display: block;
        width: 100vw;
        height: auto;
      }
    </style>
  </head>
  <body>
    <div id="map"></div>

    <script>
      const width = 10784
      const height = 6941
      const imageUrl =
        'https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550/full/full/0/default.jpg'

      // Use fetch() to request the file voiries1300_2009.svg
      async function main() {
        const transformedSvg = await fetch('voiries1300_2009.svg').then(
          (response) => response.text()
        )

        // Take the SVG generated by Allmaps, remove its outer wrapper
        const roadLines = transformedSvg
          .replace('<svg xmlns="http://www.w3.org/2000/svg">', '')
          .replace('</svg>', '')
          // Style the road lines in cyan for high contrast
          .replaceAll(
            '<polyline ',
            '<polyline style="stroke: #00ffff; fill: none; stroke-width: 10; stroke-linecap: round; stroke-linejoin: round;" '
          )

        // Find the empty map container, fill it with one SVG containing the Paris map image plus the transformed road overlay.
        document.querySelector('#map').innerHTML = `
          <svg viewBox="0 0 ${width} ${height}" width="${width}" height="${height}">
            <image href="${imageUrl}" width="${width}" height="${height}" />
            ${roadLines}
          </svg>
        `
      }

      main()
    </script>
  </body>
</html>
```

This HTML page loads the original IIIF image, reads the SVG created by Allmaps, styles the road lines, and draws both layers together in the same pixel coordinate space.

Because the page uses `fetch()` to load `voiries1300_2009.svg`, open it through a small local web server.

If Python 3 is installed, use its built-in server:

```bash
python3 -m http.server 8000
```
Alternatively, use Node/npm:

```bash
npx http-server . -p 8000
```

Then open `http://localhost:8000/paris-road-overlay.html` in your browser.
You should see the 1821 Paris map with the medieval road network drawn over it as high-contrast cyan lines.

Allmaps gives us a transformation between geographic coordinates and map image pixels.
In this example, we use that transformation to move GeoJSON into the image's own coordinate space, then draw the resulting SVG on top of the original IIIF image.

<!-- Begin Part 3.02 -->
## Export a GeoTIFF with Allmaps CLI

In the previous section, you used the Paris annotation to transform GeoJSON into image-space SVG.
Now you will use the same annotation to generate a georeferenced Cloud Optimized GeoTIFF (COG).
This format is commonly used for web maps and allows efficient access to large raster datasets.

For an introduction to COGs and how they enable efficient, web-based access to raster data, see the Cloud Optimized GeoTIFF project website.[^6]

### Confirm the georeference annotation

If you are working through this section with the lesson's Paris example, use the frozen annotation at `data/annotation.json`. If you are using a different map, use the annotation for that map instead.

### Download the IIIF image


```bash
allmaps fetch full-image "https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550"
ls -lh *.jpg
```

<div class="alert alert-warning" markdown="block">
For this Paris example, the generated script expects the downloaded image to be named with its
Allmaps Image ID: `adeae8a56aaf59fb.jpg`.
If your file has a different name, rename it before continuing:

```bash
mv current-filename.jpg adeae8a56aaf59fb.jpg
```

If you use a different map, your Allmaps ID and filename will be different.
Check the generated script for the exact filename it expects.

</div>

By default, `allmaps fetch full-image` may not download the highest-resolution version.

To see which sizes the IIIF server can provide, inspect the image service metadata:

```bash
curl -s https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550/info.json | jq '.sizes'
```

For this example, the largest size listed should be `10784 x 6941`, matching the dimensions in the Allmaps annotation.
If your local JPEG is smaller than the largest size, it will not match the pixel coordinates in the Allmaps annotation. In that case, use `dezoomify-rs` to download the full-resolution image:

```bash
dezoomify-rs "https://cdm17272.contentdm.oclc.org/iiif/2/agdm:1550" full.jpg
mv full.jpg adeae8a56aaf59fb.jpg
```

### Generate the GeoTIFF script

```bash
cat data/annotation.json | allmaps script geotiff > paris_geotiff.sh
```

This will generate a shell script file `paris_geotiff.sh` that you will run soon.

**The generated script expects a specific filename; if yours differs, it will fail.**

### Edit the script

Open the script in VS Code or your text editor of choice:

```bash
# Visual Studio Code:
code paris_geotiff.sh

# nano
nano paris_geotiff.sh

# etc.
```

Look for this block near line 66:

```bash
gdalwarp \
  -of COG -co COMPRESS=JPEG -co QUALITY=75 \
  -dstalpha -overwrite \
  -r cubic \
  -cutline ./adeae8a56aaf59fb_2543dadd9c2fa8b1.geojson -crop_to_cutline -cutline_srs "EPSG:4326" \
  -s_srs 'EPSG:3857' \
  -t_srs 'EPSG:3857' \
  -ts 9819 6706 \
  -order 1 \
  ./adeae8a56aaf59fb_2543dadd9c2fa8b1.vrt \
  ./adeae8a56aaf59fb_2543dadd9c2fa8b1-warped.tif
```

This command uses [`gdalwarp`](https://gdal.org/en/stable/programs/gdalwarp.html) to apply the georeferencing from the annotation and generate a georeferenced raster.

Before running the script, make the following adjustment:

**Remove** `-cutline_srs` flag. This option is not supported in all GDAL versions and may cause the script to fail.

Before: `-cutline ./adeae8a56aaf59fb_2543dadd9c2fa8b1.geojson -crop_to_cutline -cutline_srs "EPSG:4326" \`
After: `-cutline ./adeae8a56aaf59fb_2543dadd9c2fa8b1.geojson -crop_to_cutline \`

If you have sufficient available memory (RAM), you can speed up processing by adding `-multi -wm 2048`.
On low-memory systems, this may cause the command to fail.

**Add** `-multi -wm 2048` to the `gdalwarp` command.

Each line in a multi-line command must end with `\`, except the final line.
If a line is missing `\`, the command will terminate early and cause errors such as 'command not found' or 'No target filename specified'.

Your updated `gdalwarp` command block should read like this:

```bash
gdalwarp \
  -of COG -co COMPRESS=JPEG -co QUALITY=75 \
  -dstalpha -overwrite \
  -r cubic \
  -cutline ./adeae8a56aaf59fb_2543dadd9c2fa8b1.geojson -crop_to_cutline \
  -multi -wm 2048 \
  -s_srs 'EPSG:3857' \
  -t_srs 'EPSG:3857' \
  -ts 9819 6706 \
  -order 1 \
  ./adeae8a56aaf59fb_2543dadd9c2fa8b1.vrt \
  ./adeae8a56aaf59fb_2543dadd9c2fa8b1-warped.tif
```

Save the script file:

**VS Code**: File > Save or _Ctrl+S_ to save.

**nano**: _Ctrl+O_ to *write out* (save), _Enter_ to confirm filename, _Ctrl+X_ to exit nano

**vim**: _Esc_, then type `:wq` and _Enter_ to save and quit

<div class="alert alert-warning" markdown="block">
There is [an issue](https://github.com/allmaps/allmaps/issues/261) related to the `-cutline_srs` flag on the Allmaps repository.
</div>

### Run the script

```bash
bash paris_geotiff.sh
```

If the script runs successfully, the output file is now georeferenced using the control points from the Allmaps annotation.

<div class="alert alert-warning" markdown="block">
Troubleshooting script failures and errors:

* See above "Download the IIIF Image" step if your image size is wrong.
* Ensure you have made the appropriate adjustments in the generated shell script in the
  "Edit the Script" step above. Regenerate the script to start over if you make a mistake.
* Triple check your filenames and ensure they match what the shell script expects.
</div>

### Verify the output with GDAL

```bash
gdalinfo *-warped.tif
```

**Check for the following in the output:**

- `EPSG:3857` — confirms the map is in Web Mercator
- `Size is ...` — shows the pixel dimensions of the output image
- `LAYOUT=COG` — confirms the file is a Cloud Optimized GeoTIFF

You do not need to understand the full output; just confirm these values appear.

You have now generated a georeferenced GeoTIFF from an Allmaps annotation. This file can be used in GIS software or served as a web-accessible raster.

<!-- Begin Part 3.03 -->

## Use Allmaps with Leaflet

Allmaps provides three different libraries for loading georeferenced maps as web map layers. You can use Leaflet, OpenLayers, or MapLibre.

This section focuses on the Allmaps Leaflet plugin.
Once you understand this workflow, the OpenLayers and MapLibre options follow a similar pattern.

The Allmaps Leaflet plugin, described in greater detail in [this Observable Notebook](https://observablehq.com/@allmaps/leaflet-plugin) as well as the [official Allmaps documentation](https://allmaps.org/docs/packages/leaflet/#_top), is distributed via [npm](https://www.npmjs.com/package/@allmaps/leaflet).

### Copy the template

The `data/allmaps-leaflet-demo.zip` file in this lesson package contains three files
that provide a minimal working demo of the Allmaps Leaflet plugin in a simple Leaflet web
map. Those files are:

- `index.html`: the web page structure for our simple web map
- `script.js`: the necessary JavaScript for creating a Leaflet map with two layers, a base map and an Allmaps overlay
- `style.css`: the CSS that gives the page and map container their size and layout

Unzip `data/allmaps-leaflet-demo.zip`, then open the `data/allmaps-leaflet-demo` folder
in a text editor like VS Code. If need be, install the "Live Server" extension by
Ritwick Dey, which allows you to view the web map as local files in a web browser. You
can install the extension by searching "Live Server" in the "Extensions" tab (the little
building blocks) of VS Code.

If you click "Go Live" in the bottom right-hand corner of VS Code, the Leaflet web map should open in your default web browser.

If you want to learn more about Leaflet, check out these *Programming Historian* lessons by [Kim Pham on geocoding](https://programminghistorian.org/en/lessons/mapping-with-python-leaflet) and [Stephanie J. Richmond and Tommy Tavenner on maps of correspondences](https://programminghistorian.org/en/lessons/using-javascript-to-create-maps).

### Find the Allmaps plugin

Open the `index.html` file.
Near the top of the file, two lines load Leaflet and the Allmaps Leaflet plugin:

```html
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
<script type="module" src="https://cdn.jsdelivr.net/npm/@allmaps/leaflet/dist/bundled/allmaps-leaflet-1.9.umd.js"></script>
```

The first line loads Leaflet.
The second line loads the Allmaps plugin so that we can use it in `script.js`.

### script.js

The Allmaps Leaflet plugin uses georeference annotations to overlay maps.
We will use this georeference annotation...

[https://annotations.allmaps.org/manifests/cfb327e4b43395e3](https://annotations.allmaps.org/manifests/cfb327e4b43395e3)

... which corresponds to [this map of Boston](https://collections.leventhalmap.org/search/commonwealth:3f463198b):

{% include figure.html filename="en-or-visualizing-historic-maps-iiif-allmaps-19.jpg" alt="A map of Boston from 1838, by T.G. Bradford" caption="Figure 19. A map of Boston from 1838, by T.G. Bradford. Source: https://collections.leventhalmap.org/search/commonwealth:3f463198b" %}

#### Map setup

Open `script.js`.
The file starts by creating a Leaflet map centered on Boston:

```js
const map = L.map("map", {
  center: [42.3518, -71.05],
  zoom: 13,
  minZoom: 7,
  maxZoom: 24,
  zoomControl: false,
});
```

The map also includes an OpenStreetMap base layer:

```js
let tileLayerDetails = {
  tileSize: 512,
  zoomOffset: -1,
  minZoom: 14,
  maxZoom: 24,
  crossOrigin: true,
};

let streets_base = L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", tileLayerDetails).addTo(map);
```

#### Add the Allmaps layer

The Allmaps work happens in two lines:

- `annotationUrl` contains the URL of the georeference annotation
- `WarpedMapLayer` creates a new `WarpedMapLayer` and adds it to the map

```js
let annotationUrl = 'https://annotations.allmaps.org/manifests/cfb327e4b43395e3';
let warpedMapLayer = new Allmaps.WarpedMapLayer(annotationUrl).addTo(map);
```

In a [vanilla JS setup](https://stackoverflow.com/questions/20435653/what-is-vanillajs) like ours, note that you must call the `WarpedMapLayer` method by prefixing it with `Allmaps.`. This syntax would be slightly different---and it would more closely resemble the code snippets found on the [`@allmaps/leaflet` npm documentation](https://www.npmjs.com/package/@allmaps/leaflet)---if you installed it with `npm` and used it in a front-end framework like Svelte, Vue, or React.

At this point, the map should display the georeferenced overlay.

#### Add the layer list

All that remains is to create a layer list, which allows us to toggle the map's
visibility on and off, with these three lines of code:

```js
let base = { "OpenStreetMap": streets_base };
let overlay = { "Allmaps overlay": warpedMapLayer };
let layerControl = L.control.layers(base, overlay).addTo(map);
```

In Leaflet-speak, these are called "layer controls," and you can [read more about them here](https://leafletjs.com/examples/layers-control/).

### Final map

<!-- TODO: Adjust the Leaflet demo zoom levels so the background map appears without requiring the reader to zoom in. -->
<iframe src="https://programminghistorian.github.io/ph-submissions/assets/visualizing-historic-maps-iiif-allmaps/allmaps-leaflet-demo/index.html" title="Allmaps Leaflet demo map" width="100%" height="500px"></iframe>

[View sample map in a new window](https://programminghistorian.github.io/ph-submissions/assets/visualizing-historic-maps-iiif-allmaps/allmaps-leaflet-demo/index.html){:target="_blank"}

Try adding different annotations (just note you will have to update the `center` array,
which is hard-coded to a latitude/longitude pair for Boston).

## Conclusions

In this lesson, you learned how to move from a map image in a digital collection
to a georeferenced layer that can be viewed, inspected, exported, and reused.
You found IIIF manifest URLs, opened maps in Allmaps Editor, placed control
points, drew masks, reviewed alignment in Allmaps Viewer, and inspected the
georeference annotation that Allmaps creates behind the scenes.
All of this was done in your web browser and without GIS software!

The georeference annotation is the key object that makes this reuse possible.
It records the relationship between the pixels of a map image and geographic
coordinates in a standard, portable format.
That means the work you do in Allmaps Editor does not stay locked inside a
single viewer.
The same annotation can be read by Allmaps Viewer, used by command-line tools,
converted into files for GIS, or loaded into a web map with the Allmaps Leaflet
plugin.

Open [Allmaps Editor](https://editor.allmaps.org) and try the same
process with another map.
You can start with one of the maps suggested by Allmaps, or use a manifest URL
for a map from another IIIF collection.
From there, you can compare historical maps, prepare georeferenced images for
teaching, or build lightweight web maps for research projects.
The [Allmaps Observable notebooks](https://observablehq.com/@allmaps) are also
a useful place to see development examples, experiments, and features in
progress.

And if you want to have fun with georeferencing, check out
[Allmaps Here](https://here.allmaps.org), which turns georeferenced maps into
postcards, or [Allmaps Arcade](https://arcade.allmaps.org), a game for placing
old maps on the globe.

## About the Authors

[Stephen Appel](https://srappel.github.io) is the Geospatial Information Librarian at the American Geographical Society Library at the University of Wisconsin Milwaukee Libraries; Milwaukee, Wisconsin, United States.

[Ian Spangler](https://itspangler.com/) is Associate Curator of Digital & Participatory Geography at the Norman B. Leventhal Map & Education Center at the Boston Public Library and teaches a Geospatial Humanities course at Tufts University; Boston, Massachusetts, United States.

##### Endnotes

[^1]: C. D. Lippitt, "Georeferencing and Georectification," in *The Geographic Information Science & Technology Body of Knowledge*, 3rd Quarter 2020 ed., ed. John P. Wilson (UCGIS, 2020), https://gistbok-ltb.ucgis.org/page/current/concept/DC-01-030, doi:10.22224/gistbok/2020.3.3.

[^2]: International Image Interoperability Framework, "Image API 2.1.1," accessed May 11, 2026, https://iiif.io/api/image/2.1/.

[^4]: Leventhal Map & Education Center, "Georeference Urban Atlases with Allmaps," *Cartinal*, accessed May 11, 2026, https://cartinal.leventhalmap.org/guides/georeferencing-with-allmaps.html#best-practices-for-creating-gcps.

[^5]: Caroline Bourlet and Anne-Laure Bethe, "Road Network in 1300," ALPAGE, accessed May 11, 2026, https://alpage.huma-num.fr/ancient-urban-fabric/.

[^6]: Cloud Optimized GeoTIFF, "Cloud Optimized GeoTIFF," accessed May 11, 2026, https://cogeo.org/.

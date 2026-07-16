---
title: "Extracting Structured Data using Vision-Language Models"
slug: structured-data-vision-language-models
layout: lesson
collection: lessons
date: YYYY-MM-DD
authors:
- Brice Bowrey
reviewers:
- Forename Surname
- Forename Surname
editors:
- Caio Mello
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/694
difficulty: 
activity: 
topics: 
abstract: Short abstract of this lesson
avatar_alt: Visual description of lesson image
doi: XX.XXXXX/phen0000
---

{% include toc.html %}

## Introduction

Digital humanities (DH) research often involves transforming unstructured data into structured data. Unstructured data, such as the text on a book page, lacks explicitly defined relational information. Readers must infer the relationships, themes, and meaning embedded in the words through their semantic and cultural understanding of the language. In contrast, structured data, such as a bibliographic citation, follows a schema that explicitly defines relationships between elements. It is this explicit structure that makes such data accessible to computation, while also opening new avenues for understanding humanistic artifacts at scale. This lesson provides instruction on using the flexible predictive powers of local, open large language models (LLMs) to extract structured data from images and texts.

Christof Schöch nuanced the structured-versus-unstructured-data dichotomy by introducing the concepts of "smart data" and "big data." He defines smart data as clean, homogeneous data that a scholar may have enriched through manual annotation. Examples include digital editions marked up in TEI or XML, or a database of tags a scholar has assigned after a close reading of texts. In contrast, big data is large in volume and heterogeneous in form. Scholars working with big data must use probabilistic and quantitative methods to analyze their sources, such as word frequency analysis, topic modeling, and other forms of distant reading. Schöch encourages DH scholars to pursue methods of creating data that is _both_ bigger, in terms of scale, _and_ smarter, in that it is accessible to more types of qualitative analysis.[^1]

Language models are one means of creating bigger, smarter data. When using structured outputs, models will respond according to a fixed schema, selecting choices from predefined options and encoding information in specific formats. These outputs emulate human annotation, but models generally work much faster than humans. And because LLMs approximate semantic understandings of language, they are well-suited for the textual data humanists and historians often encounter. In other words, LLMs unlock some of the advantages of smart data while operating at the scale of big data.

Despite their advantages, LLMs are still predictive models that generate probable text sequences based on patterns drawn from training data.[^2] As with other machine-learning-based techniques, such as optical character recognition (OCR) and named entity recognition (NER), scholars should expect language models to make mistakes. Those mistakes will likely differ in form and frequency compared to mistakes made by human annotators. It is also likely that an LLM will be less accurate than a machine-learning model trained specifically for any given task. However, creating the data to train a custom model is labor-intensive, and the resulting model cannot be easily adapted or reused, making a language model the most effective option in some scenarios. LLMs are valuable tools, but scholars must apply them alongside the skepticism, critical analysis, and reflexive thinking central to humanities-informed scholarship.

The core intellectual challenge of working with structured outputs is establishing a data schema, or a structured way of representing the information the model should extract. As many digital scholars have described, computational analysis does not obviate the analytical work of traditional humanities fields. Instead, computational methods foreground the scholar's interpretive choices in the curation of sources, the selective extraction of information, and the interpretation of outputs.[^3] A scholar studying information networks of nineteenth century physicians might collect letters exchanged between peers and use structured outputs to extract the names of correspondents for use in a network graph. Another scholar studying film advertising might digitize posters and use structured outputs to extract information about image composition. A scholar studying medieval illuminated manuscripts might use structured outputs to create a Boolean (true/false) record of pages containing illumination, and then compare the prevalence of illumination across time and geography. Each scholar is pursuing a research question that will require an entirely different schema and will require experimentation with different models, prompts, and datasets.

## Prerequisites

> Note: At the time of writing, the methods described in this tutorial will work best on a discrete GPU with at least 12GB of VRAM, such as the AMD Radeon RX 6700 XT or the NVIDIA GeForce RTX 3060 12GB. Small models should also perform well on Apple M-series processors with at least 12GB of integrated memory, found in many Apple computers from the last six years. Language model will run on systems that do not meet these requirements, but the performance may be significantly degraded. Systems with more powerful hardware can run larger models, potentially yielding more accurate or consistent results.

1. **Install Python**: Python is a simple programming language that we will use to define our schema and interact with the language model. _Programming Historian_ has previously published a [foundational lesson on installing Python](https://doi.org/10.46430/phen0009), though numerous other tutorials are readily accessible online.[^4]
2. **Install _uv_**: _uv_ is a Python package manager designed as a next-generation replacement for tools like `pip` and `venv`. We will use _uv_ to set up our development environment and install the third-party libraries required for our analysis. To begin using _uv_, you may wish to consult the various [installation methods](https://docs.astral.sh/uv/getting-started/installation/) detailed in the official documentation. If you already have a preferred method for managing development environments, you may use that instead.
3. **Install an IDE**: An IDE (Integrated Development Environment) is a graphical interface designed for viewing and modifying code. I recommend Visual Studio Code (VS Code), given its robust extension ecosystem and its deep integrations with development tools such as Git, Dev Containers, and remote machines. Alternatively, if you prefer a fully open-source environment, VS Codium provides the same core functionality as VS Code but purposefully excludes telemetry and proprietary additions bundled with the original product.

## Configuring the LLM

> Note: LM Studio is an actively developed product. The onboarding process, UI, and UX will change over time. I have provided general directions in this tutorial. Consult the [official documentation](https://lmstudio.ai/docs/app) for the latest information and consider joining the [LM Studio community on Discord](https://discord.gg/aPQfnNkxGC) to ask questions and get help.

[Download LM Studio](https://lmstudio.ai/download) from the application website. You can decline any offers to create an account or link the application to other instances. However, you should enable "Developer Mode" if prompted. If there is no prompt, you must activate Developer Mode in the Settings menu. When you reach the application's home screen, it will automatically detect your hardware configuration and download additional runtime engines, potentially causing temporary lag. In the Settings menu, you can view the detected hardware and installed runtimes. All configuration _should_ happen automatically, but checking the hardware and runtimes will be the first step in troubleshooting any problems.

You should now download an appropriate LLM. You can do this from the model search page. The search page typically highlights the most popular models and filters out those that cannot run on your hardware. For our purposes, you must use a model with "vision" capabilities. The capabilities of each model will be listed on the model card when you select it. For best performance, select a model that fits entirely within your GPU's available VRAM. To find models that fit on your GPU, look for the "Full GPU Offload Possible" badge. 

When you choose a model, you are negotiating between quality, speed, and the capability of your hardware. The size of the model and its level of quantization are the two features you will want to consider when making a selection. The size of an LLM is usually measured by its number of _parameters_. The parameter count of a model is typically listed on the model card, and it is often expressed in the model’s name as a number followed by “B,” meaning billion. For example, `gemma-4-12b` is a 12-billion-parameter model. You can think of parameters, roughly, as the adjustable values the model uses to inform its output — like the many dials on a large industrial machine. More dials means the machine can have more fine-grained and nuanced responses to an input. Similarly, models with more parameters are often more capable of handling tasks intelligently, although size alone does not determine quality.

Larger models require more system resources to run, but quantization can partially reduce those hardware requirements. To return to the machine analogy, quantization is like reducing the possible positions of each dial. The machine can still operate, but it has less fine-grained control. Ideally, quantization will modestly reduce output quality while substantially reducing memory use and computation time. If you see several download options for a model in LM Studio, those options often allow you to choose between different quantization levels. The `Q4` version of a model is more compressed and usually easier to run on consumer hardware. The `Q6` or `Q8` version preserves more precision, but will require more memory. Because the most appropriate model choice depends on your hardware, your corpus, and the kinds of responses your research task requires, it is often worth experimenting with different models and quantizations after initial testing.

Once you have selected a model, we need to serve the model so that we can access it from Python. On the Developer page of LM Studio, set the Local Server status to "Running." Then, load the model you downloaded previously. You will see various configuration options.

We have now finished configuring LM Studio, but the application must remain running in the background for the rest of our work.

## Configuring Python

Begin by opening VS Code and navigating to the folder you intend to use as your project directory, either through _File → Open Folder_ or by launching VS Code directly from that directory.

Once your project folder is open, bring up the integrated terminal with the shortcut _Ctrl + \`_. This keeps everything within a single window and ensures any commands you run are scoped to your project directory. From here, initialize a new _uv_ project by running:

```
uv init
```

This sets up the foundational project structure that _uv_ expects. Next, add the dependencies your project will need — `ipykernel` for Jupyter support, `pydantic` for creating structured data schema, and `lmstudio` for model interactions:

```
uv add ipykernel pydantic lmstudio
```

Alternatively, if you would like to reproduce the exact environment I created when developing this lesson, you can install the packages using the provided [`requirements.txt`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/structured-data-vision-language-models/requirements.txt) file:

```
uv pip install -r requirements.txt
```

Next, apply the changes to the environment and activate it:

```
uv sync
```

Finally, create a new `.ipynb` notebook file in your project directory. You can do this in VS Code by opening the Command Palette (_Ctrl + Shift + P_); typing and selecting "New Jupyter Notebook"; then using _Ctrl + S_ to save the resulting file into your project folder. This notebook will be your primary workspace for the code that follows. For a more comprehensive introduction to the environment, you might consult _Programming Historian_'s earlier lesson on working with [Jupyter Notebooks](https://doi.org/10.46430/phen0087).[^5]

## Extracting the Data

We now begin writing code in our `.ipynb` file.

```python
import os
import json
import lmstudio as lms
from pydantic import BaseModel, Field
from typing import Literal
```

These lines import the libraries our script will require. The first two lines add standard utilities that allow our script to interact with the operating system (OS) and write structured data in JSON (JavaScript Object Notation) format. The next line imports LM Studio’s Python SDK, which provides a programmatic interface for controlling the LM Studio application you installed earlier. The last two lines introduce modules that we will use to programmatically define our desired schema, so that the model returns structured data rather than unstructured text.

We should now confirm that our code can communicate with the LM Studio instance we configured earlier.

```python
SERVER_API_HOST = "localhost:1234"
lms.configure_default_client(SERVER_API_HOST)

if lms.Client.is_valid_api_host(SERVER_API_HOST):
    print("An LM Studio API server instance is available.")
else:
    print("No LM Studio API server instance found.")
```

The initial two lines of code handle the "handshake," or the opening of a connection between our script and the server. By defining `SERVER_API_HOST` as `localhost:1234`, we are telling our script to look for a server running at the standard address used by LM Studio. We then pass this address to the `lms.configure_default_client` method, which sets the stage for all subsequent requests in our session. Finally, we call the `is_valid_api_host` method to verify that our configuration is indeed correct and that the server is responsive.

Throughout this lesson, we will work with a small sample of photographs drawn from the [Digital Dress Collection](wayne.contentdm.oclc.org/digital/collection/digital-dress), a digital repository that preserves images of clothing worn in Michigan during the eighteenth and nineteenth centuries. I have stored my copy of the photos in a directory called `clothing_images` that sits beside my `.ipynb` notebook. If you would like to work through the code with the same images, you will find links to download them in the provided [`digital_dress_links.csv`](https://github.com/programminghistorian/ph-submissions/blob/gh-pages/assets/structured-data-vision-language-models/digital_dress_links.csv) file. However, because the underlying computations may vary slightly across executions, your outputs may differ from mine even if you use the same code.

With the image corpus in place, we can now focus on the most consequential step of this workflow: defining a schema. In the code, the schema is simply a machine readable description of the categories you will use to capture information from your sources. More importantly, the design of your schema is where your interpretive priorities become explicit. Schema emerge from the context surrounding your sources and the research questions guiding your inquiry.

### Schema Example 1

If a scholar were investigating changing patterns of color in clothing over time, they might define a schema that looks like this:

```python
class ClothingInfo(BaseModel):
    item_type: Literal["dress", "shoe", "hat"] = Field(..., description="The type of clothing item in the image.")
    color: Literal["red", "blue", "green", "yellow", "orange", "purple", "pink", "black", "white"] = Field(..., description="The color of the clothing item in the image.")
```

In this code we create a class called `ClothingInfo`. In Python, classes are groupings of data and functionality that can inherit from templates, such as `BaseModel`. Each line of the class declares a special type known as a `Literal`; that is, a value that must be chosen from a fixed set of options. For our purposes, this functions as a controlled vocabulary. By stating that `item_type` must be "dress", "shoe", or "hat", we instruct the model to restrict its response to one of these three options. Similarly, the second line limits the model's output to a predefined list of common hues, ensuring that the generated values remain consistent and predictable. The `Field(..., description=...)` syntax serves two purposes: the ellipsis (...) marks the field as required, while the description string provides information about the attribute for the model to consider as context.

The options in the controlled vocabulary should stem from your research question, as well as the contextual understandings and interpretive frameworks you bring to the source material. More precise terms might better distinguish between the colors that were popular during a particular historical period, since period-specific nomenclature may capture nuances that generic labels obscure. Likewise, if the clothing items in your corpus are frequently multi-colored, you may need a different data structure, or you may find this method is unsuitable entirely. And if you are interested only in the prevalence of a single color, a Boolean field might offer a cleaner, more direct way to collect the data you need.

### Schema Example 2

```python
class LetterInfo(BaseModel):
    sender: str | None = Field(default=None, description="The name of the sender, if available.")
    recipient: str | None = Field(default=None, description="The name of the recipient, if available.")
    date: str | None = Field(
        default=None, 
        description="The date of the letter in YYYY-MM-DD format, if available.",
        pattern=r"^\d{4}-\d{2}-\d{2}$"
    )
```

Another common historical artifact a scholars may work with is correspondence. While our previous example focused on restricting values to a specific list, the `LetterInfo` class demonstrates how we might handle handle unpredictable data, such as names or dates, where the researcher cannot define every possible option in advance. For the `sender` and `recipient` attributes, we use the syntax `str | None`. It tells the language model that it can respond with either a string of text (a name) or the value of `None`. We further refine the schema by using the `Field` function to designate `None` as the default option in addition to providing a description.

The treatment of the `date` attribute is perhaps the most useful part of this construction. Date formats are notoriously varied, yet computational tools require them to be perfectly uniform. To solve this, we use the pattern parameter, which accepts a "regular expression" (or regex). This particular pattern mandates that a date must consist of exactly four digits, a hyphen, two digits, another hyphen, and two final digits (representing YYYY-MM-DD). Even if the language model reads a date as "April 15, 1950", it should return the date as "1950-04-15". By enforcing a standardized and machine readable structure for dates, we ensure that our data can later be sorted chronologically or visualized on a timeline without manual correction.

### Running the model

In many natural language processing workflows, you will need to specify which language model your code should call. When working locally with LM Studio, the model in your code must be the same as the model you have already chosen to load in the application. In our current example, we use the string `google/gemma-4-e4b`. You can find the identifier for the model you are running by looking in the LM Studio interface.

```python
model_name = "google/gemma-4-e4b"
```

Next, we will write a prompt that provides the model with additional context and direction. Prompting, however, is not an exact science. More elaborate instructions do not necessarily yield better results, and in some cases, longer prompts will decrease accuracy while increasing processing times. In practice, you will likely refine your prompt through iterative experimentation, adjusting the wording as you examine the outputs you receive and decide what works well.

```python
prompt_example_1 = "Analyze the provided image and identify the type (Dress, Shoe, Hat) and dominant color of the clothing item."
```

```python
prompt_example_2 = """
        Analyze the provided image and identify the type and dominant color of the clothing item.

        - item_type:
                - Dress: Look for a single-piece garment designed to cover the torso and hang down over the legs. Key indicators include a bodice connected to a skirt, lack of separate pant legs, and a feminine silhouette.
                - Shoe: Look for footwear designed to be worn on the feet. Key indicators include a structured sole, heel, laces or straps, and a shape that conforms to the human foot (e.g., sneakers, boots, pumps, or sandals).
                - Hat: Look for a head covering worn on the top of the head. Key indicators include a crown (the part that fits over the head) and often a brim or peak (e.g., baseball caps, beanies, or sun hats). 

        - color:
                - Red: (255, 0, 0)
                - Blue: (0, 0, 255)
                - Green: (0, 255, 0)
                - Yellow: (255, 255, 0)
                - Orange: (255, 165, 0)
                - Purple: (128, 0, 128)
                - Pink: (255, 192, 203)
                - Black: (0, 0, 0)
                - White: (255, 255, 255)
        """
```
For the rest of this lesson, we will continue working with images from the Digital Dress Collection.

To pass an image to the language model, we first need to prepare it in a form the model can actually read. In first line assigns the file path of the image to a variable for convenient reference in subsequent code. The second line calls the `prepare_image` method from `lms`, the LM Studio SDK we imported at the start. This method reads the file from disk and converts it into something the model and SDK are prepared to handle.

```python
image_path = "clothing_images/digital-dress_1384_large.jpg"
image_handle = lms.prepare_image(image_path)
```

We now instantiate the model we defined earlier in the code. The `temperature` parameter controls how much randomness the model introduces when generating text. A value of 0.0 suppresses variation, leading to more deterministic and reproducible outputs. Low temperature is generally preferable for analytical tasks where accuracy matters more than creativity. If you were instead using the model to draft prose or brainstorm ideas, you might raise the temperature, which would produce more diverse, and sometimes more interesting, results. However, for our purposes, consistency is the priority.

```python
model = lms.llm(model_name, config={"temperature": 0.0})
```

Once the model is loaded, we create a `Chat` instance to "converse" with the model. The second line populates the chat with our input, attaching both the text prompt (`prompt_example_1`) and the image (`image_handle`) that we prepared in earlier steps. The third line is where the inference actually happens. Calling `model.respond()` with the `response_format` argument sends the assembled conversation to the LLM and requests a structured response. The final line simply prints the resulting prediction object to the output cell, which is useful for inspection during development.

**Input:**
```python
chat = lms.Chat()
chat.add_user_message(prompt_example_1, images=[image_handle])
prediction = model.respond(chat, response_format=ClothingInfo)
print(prediction)
```

**Output:**
```python
{
    "color": "green",
    "item_type": "dress"
}
```

The block above handled a single image. To processes photos at scale, we can extend the same logic to an entire directory of photographs using a "for loop." Iterating over `os.listdir("clothing_images")` yields each filename in turn, and for each one the code reproduces the full processing pipeline. The loop resets the `Chat` instance on every iteration because each photograph can be treated as an independent query. There is no need to carry conversational context forward, and doing so would likely confuse the model by presenting it with an accumulating sequence of unrelated images. The final print statement pairs each filename with its corresponding prediction object, rendering a readable record of what the model inferred about each clothing item.

**Input:**
```python
for photo in sorted(os.listdir("clothing_images")):
    image_handle = lms.prepare_image(os.path.join("clothing_images", photo))
    chat = lms.Chat()
    chat.add_user_message(prompt_example_1, images=[image_handle])
    prediction = model.respond(chat, response_format=ClothingInfo)
    print(f"{photo}: {prediction}")
```

**Output:**
```python
digital-dress_1384_large.jpg: {
    "color": "green",
    "item_type": "dress"
}
digital-dress_1793_large.jpg: {
    "color": "white",
    "item_type": "hat"
}
digital-dress_1931_large.jpg: {
    "color": "black",
    "item_type": "dress"
}
digital-dress_2149_large.jpg: {
    "color": "black",
    "item_type": "hat"
}
digital-dress_3270_large.jpg: {
    "color": "white",
    "item_type": "dress"
}
digital-dress_4068_large.jpg: {
    "color": "pink",
    "item_type": "dress"
}
digital-dress_4090_large.jpg: {
    "color": "black",
    "item_type": "hat"
}
digital-dress_4445_large.jpg: {
    "color": "green",
    "item_type": "dress"
}
digital-dress_4658_large.jpg: {
    "color": "blue",
    "item_type": "shoe"
}
digital-dress_4829_large.jpg: {
    "color": "red",
    "item_type": "shoe"
}
```

Note the _key:value_ structure of the output. This is JSON syntax, a common format for representing structured data and, in many contexts, the _lingua franca_ of data exchange on modern computers. Because many tools for visualization and analysis can read JSON, saving the model predictions in this format creates a portable record of the outputs. To conclude our script, we will write the structured predictions to a JSON file, where they can be stored, inspected, and used in subsequent stages of a processing pipeline.

```python
# Create a dictionary with predictions
predictions = {}

# Loop through images and store predictions in the dictionary
for photo in sorted(os.listdir("clothing_images")):
    image_handle = lms.prepare_image(os.path.join("clothing_images", photo))
    chat = lms.Chat()
    chat.add_user_message(prompt_example_1, images=[image_handle])
    prediction = model.respond(chat, response_format=ClothingInfo)
    predictions[photo] = prediction.parsed

# Save predictions to a JSON file
with open("predictions.json", "w", encoding="utf-8") as f:
    json.dump(predictions, f, indent=4, sort_keys=True, ensure_ascii=False)
```

## Conclusion

The structured output capabilities of LLMs present a practical way to extract data from historical records, but there are epistemic limitations researchers should consider. Rather than treating LLMs as a revolution, we can understand them as a form of computational text analysis: an approach that uses mathematical methods to identify patterns in text. When using LLMs, specifically, scholars may encounter predictive failures — commonly called hallucinations — in which model outputs diverge from reasonable expectations. At a more fundamental level, computational text analysis attempts to capture in numbers precisely those values, experiences, and meanings that many scholars regard as unquantifiable.[^6] Returning to the example in this lesson, we see this tension clearly. Color is not an objective and stable datum. The meaning, interpretation, and classification of color are bound up with context, culture, and individual perception. When considering these methods, scholars must make a critical assessment of what can be counted, what resists counting, and what level of accuracy in counting is required in the context of their research question and sources.

Although language models are imperfect, they can effectively bridge the gap between big data and smart data. They can process many inputs far faster than humans (the "big"), while producing data that supports deeper qualitative analysis (the "smart"). Even as language models generate data, the researcher uses their interpretive expertise to guide the process by defining schemas, curating inputs, and evaluating outputs in context. Moving forward, the challenge is not only how efficiently we can extract data, but also how thoughtfully we can design the intellectual frameworks that guide extraction. Historians and DH scholars using these methods must ensure that computation serves interpretation, rather than replacing it.

## Acknowledgements

The method presented in this lesson was developed with the support of a grant from the Alfred P. Sloan Foundation’s History of Science & Technology Program.

## Endnotes

[^1]: Christof Schöch, “Big? Smart? Clean? Messy? Data in the Humanities,” _Journal of Digital Humanities_ 2, no. 3 (2013).

[^2]: Emily M. Bender et al., “On the Dangers of Stochastic Parrots: Can Language Models Be Too Big?,” _Proceedings of the 2021 ACM Conference on Fairness, Accountability, and Transparency_, March 3, 2021, 610–23, <https://doi.org/10.1145/3442188.3445922>.

[^3]: Johanna Drucker, “Humanities Approaches to Graphical Display,” _Digital Humanities Quarterly_ 5, no. 1 (2011), <https://doi.org/10.63744/r4ysrh7ae534>; Hannigan T.R. et al., “Topic Modeling in Management Research: Rendering New Theory from Textual Data,” _Academy of Management Annals_ 13, no. 2 (2019): 586–632, <https://doi.org/10.5465/annals.2017.0099>; Miriam Posner, _Humanities Data: A Necessary Contradiction_, June 25, 2015, <https://miriamposner.com/blog/humanities-data-a-necessary-contradiction/>.

[^4]: William J. Turkel and Adam Crymble, “Python Introduction and Installation,” _Programming Historian_, no. 1 (2012), <https://doi.org/10.46430/phen0009>.

[^5]: Quinn Dombrowski et al., “Introduction to Jupyter Notebooks,” _Programming Historian_, no. 8 (2019), <https://doi.org/10.46430/phen0087>.

[^6]: For further discussion of critiques directed at quantification in the humanities, see: Dong Nguyen et al., “How We Do Things With Words: Analyzing Text as Social and Cultural Data,” _Frontiers in Artificial Intelligence_ 3 (2020), <https://doi.org/10.3389/frai.2020.00062>; Stephen Marche, “Literature Is Not Data: Against Digital Humanities,” _Los Angeles Review of Books_, October 28, 2012, <https://lareviewofbooks.org/article/literature-is-not-data-against-digital-humanities>; J. Flanders, “Data and Wisdom: Electronic Editing and the Quantification of Knowledge,” _Literary and Linguistic Computing_ 24, no. 1 (2009): 53–62, <https://doi.org/10.1093/llc/fqn036>.

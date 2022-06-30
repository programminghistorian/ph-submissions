---
title: "Creating GUIs in Python for Digital Humanities Projects"
collection: lessons
layout: lesson
slug: creating-guis-in-python-for-digital-humanities-projects
date: 2022-MM-DD
authors:
  - Christopher Thomas Goodwin
reviewers:
  - Firstname Surname
  - Firstname Surname
editors:
  - Yann Ryan
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/479
difficulty: TBC
activity: TBC
topics: [TBC]
abstract: TBC
avatar_alt: TBD
doi: TBD
---

{% include toc.html %}


# Introduction

This tutorial demonstrates how to implement a Graphical User Interface (GUI) using Python. GUIs are an expected feature
of most modern applications, and most users lack the necessary computing skills to execute Python scripts or use
terminal/command-line applications. Sharing scripts between experienced digital humanists usually presents few problems.
However, digital humanists may wish to share their tools to aid other researchers’ projects or facilitate research team
collaboration. Sometimes, a researcher simply needs a tool that runs with minimal up-front time investiture to run a
research tool. In these cases, programs and applications that place user-friendliness and usability near the forefront
of design goals can be beneficial. This tutorial focuses on the three steps involved in creating applications for
computer users of nearly all digital skill levels: designing a GUI, implementing a GUI within an application, and
creating an executable file to distribute the application.

## Learning Goals
This lesson uses Python to create a program with a GUI interface that can merge multiple PDF documents into a single
PDF file. The main goal is to learn the basics of creating GUIs. By the end of this lesson, you will be able to:

- Design a GUI using proven design principles of user-friendliness
- Create a GUI using Qt Designer
- Implement a GUI within a Python script
- Build a distributable application version of your script

## Prerequisites and Tools

The following instructions work on macOS, Windows, and Linux machines.

You should have some familiarity with the command line interface on your system. For Linux and Mac users, you can learn
this through Programming Historian's [Introduction to the Bash Command Line] (https://programminghistorian.org/en/lessons/intro-to-bash).
Windows users can learn about the Power Shell with Programming Historian's [Introduction to the Windows Command Line with PowerShell] (https://programminghistorian.org/en/lessons/intro-to-powershell).

You will need any version of Python 3, though 3.5+ is recommended. You will also need the Python package installer, pip.
A tutorial is available at Programming Historian's [Installing Python Modules with pip] (https://programminghistorian.org/en/lessons/installing-python-modules-pip).

This tutorial uses the PyQt5 Python GUI package. Use the following command to install PyQt5:

```pip install PyQt5```

You will also need to download QT Designer, an application to create Python GUIs using drag-and-drop widgets. The application is available
for download at [fman build system](https://build-system.fman.io/qt-designer-download).[^1]

```pip install pyqt5-tools --pre```

PyPDF4 is a useful package that can open and modify PDFs within a Python environment. Use the following command to install it:

```pip install pypdf4```

Pyinstaller can convert a Python script into a distributable application file. Use the following pip command:

```pip install -U pyinstaller```

Finally, download the [sample PDFs] (/CREATING-GUIS-IN-PYTHON-FOR-DIGITAL-HUMANITIES-PROJECTS-SAMPLE-PDFS.zip) for testing your application near the end of this tutorial.

## Command Line Interface vs. GUI: Merits and Drawbacks

Most Python programmers are familiar with using a command-line interface (CLI). The text-based user interface is one
of the oldest interface methods and the fastest way to deploy Python scripts. But CLIs can easily daunt more casual computer users. GUIs, however, are often easier to learn, and most users are already
familiar with their use; anyone who has used a computer since the 1990s is familiar with GUIs and how they operate. Furthermore,
there exist many tasks for which a GUI is better suited. For example, a GUI can offer granular control over operating system
files through drag-and-drop functionality. This tutorial provides a concrete example: the program’s goal is to merge various
PDFs. A CLI could do this, but it would be challenging to merge PDFs that were not in the same file directory. With the
GUI in this tutorial and drag-and-drop functionality, the user can select and merge specific PDFs from any file location
on the computer, including the hard drive, cloud, USB stick, or other peripherals.

How does one decide between a CLI and a GUI? If the script requires little or no interaction from the user, use a CLI.
If the program is relatively uncomplicated, again, a CLI will likely suffice. However, if you wish to share your applications
or scripts with users with little programming knowledge or computing skills, you should use a GUI. Finally, suppose your
application contains complicated features, and you do not know in what order the user might want to use those features.
In that case, a GUI provides the freedom for the user and is actually simpler for the programmer to implement than the
confusing and intricate logic branches and loops that a CLI script would require.

In our own case, we will program a GUI to deal with a common problem among historians: merging PDF files. Historians often
find themselves with various PDF files that are logically connected or that would be simpler to use for research or collaboration
if they were merged into a single document. Many archives on the internet only allow downloading one page at a time, rather than
an entire document. Another scenario arises when historians only download the pages they need and skip intervening pages. Or,
historians at physical archives take digital pictures of only certain documents, rather than the entire file. At the end of their archival visit, they find
that they have a large number of individual images, of which many should be part of one document or file. Oftentimes, internet
archives or digital cameras name these files in conventional and logical ways (img_001, img_002, img_003). Our Python
script will provide a simple drag-and-drop interface to move these files into the application and a single button press
will merge them into one document. We will even easily allow the user to manipulate the ordering of files, just in case some
files were not named in logical succession.

Our PDF Merger will provide flexibility, ease of use, and efficiency that a traditional CLI application cannot achieve when
confronting a similar research challenge.

## GUI Design Principles

Deciding to implement a GUI often involves a reorientation of the programmer’s priorities. The objective is no longer to
simply program an application that works but one that virtually anyone can use at any skill level. There is no standard for
GUI design, but we will focus on the following principles that can provide a basic guideline for beginners:

1. Visibility. Key attributes of the interface should be readily visible to users. Examples include buttons with specific
   functions and a clean navigation menu. At the same time, the visibility principle incorporates the idea that not everything
   should be visible; the interface should remain clutter-free and intuitive for the user.
2. Consistency. Elements on the screen (such as buttons and menus) should have a consistent style. If the application requires
   multiple screens, consistency of style should be maintained throughout. The navigation menu should not appear at the top of
   the window on one screen and at the bottom of the window on the next screen.
3. Learnability. The learning curve for using the application’s GUI should be as small as possible. This does not
   mean that the application itself cannot be complicated, but that learning to operate the GUI should interfere as
   little as possible with using the application.
4. Predictability. Functions within the GUI, such as buttons or menus, should operate as the user expects them to.
   You should design your GUI to align user expectations with interacting with the GUI. There should be some foreseeable
   path for the user to reach their goal within the application.

The field of user interface design is now vast. The Additional Resources section below contains more advanced resources for
those wishing to dive more deeply into the field.

# A GUI Project: PDF Merger

Merging PDF files in a directory is a relatively easy goal using Python and freely available packages. A basic script
operated from the command line can accomplish the task. Yet, what if the user only desires to merge some of the PDFs in
the directory rather than all of them? Or perhaps PDFs stored in various locations across the user’s hard drive need to
be merged. In the former case, the user would need to remove the undesired files. In the latter case, the user would have
to move or copy the files into one central location. An application with a GUI and drag-and-drop functionality can make
the process trivial.

## Designing the Interface with Qt Designer

To begin, launch the Qt Designer application you downloaded earlier by clicking on its icon. After the application loads, a prompt will request you to create a New Form.
To simplify this project, we will select “Dialog without Buttons.” Ensure that “Show this Dialog on Startup” is selected, and then press Create.

As you can see, Qt Designer contains many windows and many options and the arrangement is cluttered. If your screen size permits it, arrange the windows
as Figure 1 shows. This format provides an efficient means for accessing the tools we will need the most. At the center of our layout is the Dialog box
that will become our GUI. To its right is the Widget Box that contains all the UI features that Qt Designer can implement; this includes simple design
features such as static text to more complicated features like the interactive List Widget that we will work with. Our other main toolbox resides
on the right, the Property Editor. It is here that we will customize every widget we implement and can do so at a granular level. Below the dialog
box lies the Signal/Slot Editor window. Later in the tutorial we will use this to implement the more intricate interactions between the GUI
and the user. The final three windows are the Object Inspector, Action Editor, and Resource Browser. These are less frequently used tools
and will play no role in our tutorial. If the myriad of Qt Designer's windows has left you with little screen space, you should close
these unused windows.

{% include figure.html filename="CREATING-GUIS-IN-PYTHON-FOR-DIGITAL-HUMANITIES-PROJECTS1.png" caption="Figure 1. The Qt Designer Windows" %}

QLabels provide a means to display plain text in your application, such as titles. From the Widget Box and under
the "Display Widgets" section, drag “Label” to the Dialog box. Center it on the dialog box, but do not worry about precise locations while using Qt Designer.
It is usually easier to align objects directly in the code, a task we will return to later. Highlight the Property
Editor and under the QObject heading, select `objectName` and type in its value of `title_label`. Everything needs a descriptive name because the UI will
eventually be converted to Python code, and we will need to keep track of which objects we are editing. Still in
the Property Editor, find the `font` heading, expand it with the small arrow and set the value for `Point size` to 24. Under the `QLabel` change the `text`
value to “PDF File Merger”. Changing the text size and adding more text has increased the text beyond the bounds of the textboxes and textboxes in Qt Designer do not automatically resize. Select the textbox
and drag from one of the corners to increase the size until the text fits comfortably. Now, drag the textbox until its centered
near the top of the dialog box. Your application now has a title that greets users and ensures they know
precisely what application they are using.

Next, from the "Buttons" section of the Widget Box, drag a Push Button to your Dialog box. In the Property Editor, set the following
values: `objectName: merge_button`; `text: Merge Files`. Go to the Widget Box and select Edit Signals/Slots
from the top of the screen. When you hover your mouse over an object in your dialog box, it will now highlight
red. Press and hold on your Merge Files button and drag the mouse slightly off the button until you see a red
line appear. Then release your mouse button. The Configure Connection dialog box will appear. Select `clicked()`
from the left side of the menu and Edit on the right side. Under the top box labeled Slots, press the green
addition sign. Type in `mergeDocSlot()`. Click "Ok" to close the window and again to close the next window. You should be back to the basic Qt Designer windows. Now select the item
you just created. This creates the connection between the button in the user interface and the function we will
write later, `mergeDocSlot()`. Clicking the button signals the execution of the specific function. Without this,
the button could be clicked, but nothing would happen.

Now, we need a list view to drag-and-drop files into our application and view which files we’ve added. We will
use the QListWidget for this function. Drag the List Widget under the "Item Widgets (Item-Based)" heading from the Widget Box to your Dialog box. In the
Property Editor, set its objectName to `file_list_widget`. Select the widget and use your mouse at one of its corners to configure its size to roughly the proportions shown in Figure 2
below.

Your final design should look like the following:

{% include figure.html filename="CREATING-GUIS-IN-PYTHON-FOR-DIGITAL-HUMANITIES-PROJECTS2.png" caption="Figure 2. Final Design of the User Interface" %}

Save your UI document as `PDFFileMerger.ui`. Qt Designer has created the UI file, which contains XML representing
the entire design in a convenient “tree” format. We must now convert this XML data into Python code that will provide
the basic structure of our application.

Open your terminal or shell and navigate to the directory where you saved your UI file. Type the following:

`pyuic5 -x PDFFileMerger.ui -o PDFFileMerger.py`

A Python file will generate in the same directory. As you can see from this file, everything done in Qt Designer
could have been done solely with Python code. Qt Designer, however, can speed along the process, especially for
programs employing many widgets or multiple screens. Qt Designer has provided the basic Python code that we will now
edit to implement our features.

## Creating the User Interface Functionality

In your Python editor or IDE, open the newly created PDFFileMerge.py file. Our entire codebase will reside in this single script. We will begin by adding
the necessary libraries. Qt Designer will have automatically added some of the following but
ensure that all are present in your Python file.

```
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtCore import QObject, pyqtSlot
from PyPDF4 import PdfFileMerger
```

Your beginning file, which is the .ui file converted to Python code, should look like this:

```
class Ui_Dialog(object):
    def setupUi(self, Dialog):
        Dialog.setObjectName("Dialog")
        Dialog.resize(667, 514)
        font = QtGui.QFont()
        font.setPointSize(26)
        Dialog.setFont(font)
        self.title_label = QtWidgets.QLabel(Dialog)
        self.title_label.setGeometry(QtCore.QRect(250, 30, 291, 41))
        self.title_label.setObjectName("label")
        self.merge_button = QtWidgets.QPushButton(Dialog)
        self.merge_button.setGeometry(QtCore.QRect(230, 400, 225, 45))
        self.merge_button.setObjectName("merge_button")
      self.file_list_widget = QtWidgets.ListWidget(Dialog)
        self.file_list_widget.setGeometry(QtCore.QRect(70, 100, 531, 261))
        self.file_list_widget.setObjectName("file_list_widget")

        self.retranslateUi(Dialog)
        self.merge_button.clicked.connect(self.mergeDocSlot)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        _translate = QtCore.QCoreApplication.translate
        Dialog.setWindowTitle(_translate("Dialog", "Dialog"))
        self.title_label.setText(_translate("Dialog", "PDF File Merger"))
        self.merge_button.setText(_translate("Dialog", "Merge Files"))


if __name__ == "__main__":
    import sys

    app = QtWidgets.QApplication(sys.argv)
    Dialog = QtWidgets.QDialog()
    ui = Ui_Dialog()
    ui.setupUi(Dialog)
    Dialog.show()
    sys.exit(app.exec_())
```

At this point, two things need to be edited. First, change `class Ui_Dialog(object)` to `class Ui_Dialog(QObject)`.
This will allow us to seamlessly use slots and signals to allow the user to interact directly with the application.
Second, change `self.file_list_widget = QtWidgets.QListWidget(Dialog)` to `self.file_list_widget = ListDragWidget(Dialog)`.
With this change, we will be able to implement drag-and-drop functionality and have better memory management.

The class definition will now look like this:

```
class Ui_Dialog(QObject):
    def setupUi(self, Dialog):
        Dialog.setObjectName("Dialog")
        Dialog.resize(667, 514)
        font = QtGui.QFont()
        font.setPointSize(26)
        Dialog.setFont(font)
        self.title_label = QtWidgets.QLabel(Dialog)
        self.title_label.setGeometry(QtCore.QRect(250, 30, 291, 41))
        self.title_label.setObjectName("label")
        self.merge_button = QtWidgets.QPushButton(Dialog)
        self.merge_button.setGeometry(QtCore.QRect(230, 400, 225, 45))
        self.merge_button.setObjectName("merge_button")
        self.file_list_widget = ListDragWidget(Dialog)
        self.file_list_widget.setGeometry(QtCore.QRect(70, 100, 531, 261))
        self.file_list_widget.setObjectName("file_list_widget")

        self.retranslateUi(Dialog)
        self.merge_button.clicked.connect(self.mergeDocSlot)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        _translate = QtCore.QCoreApplication.translate
        Dialog.setWindowTitle(_translate("Dialog", "Dialog"))
        self.title_label.setText(_translate("Dialog", "PDF File Merger"))
        self.merge_button.setText(_translate("Dialog", "Merge Files"))
```

Our list of PDF files to merge will not be stored in a Python list or dictionary but directly in the QListWidget
itself. This simple solution prevents the need to pass variables around functions or declare global variables.

We will need to create a new class outside the `Ui_Dialog` class to implement drag-and-drop functionality.

```
class ListDragWidget(QtWidgets.QListWidget):
    """Creates a list widget that allows user to drag and drop PDF
    files into the widget area to add these files."""
    def __init__(self, parent):
        super(ListDragWidget, self).__init__(parent)
        self.setAcceptDrops(True)
        self.setDragDropMode(QtWidgets.QAbstractItemView.InternalMove)

    def dragEnterEvent(self, event):
        if event.mimeData().hasUrls():
            event.acceptProposedAction()
        else:
            super(ListDragWidget, self).dragEnterEvent(event)

    def dragMoveEvent(self, event):
        super(ListDragWidget, self).dragMoveEvent(event)

    def dropEvent(self, event):
        if event.mimeData().hasUrls():
            for file in event.mimeData().urls():
                if file.path().endswith('.pdf'): # make sure it is a PDF file
                    self.addItem(file.path())
        else:
            super(ListDragWidget, self).dropEvent(event)
```

The `dragEnterEvent` function allows files to be dragged onto the widget itself. The `dropEvent` function enables the
functionality for releasing the mouse button. Both use `event.mimeData().hasUrls()` to ensure that what is being
dragged and dropped has a file path, verifying that it is, in fact, a file. The `dropEvent` function contains
additional verification that the file is a PDF document.

Now that we can select the PDF files we want to merge, we need to add the functionality to combine the files.

Return to the `Ui_Dialog` class and add the following function below the `retranslateUi(self,  Dialog)` function
generated during conversion from the Qt Designer file:

```
@pyqtSlot()
def mergeDocSlot(self):
    output_file_name = 'merged.pdf'  # default name for file output

    if self.file_list_widget.count() > 1:  # no merging unless there are enough documents to merge

        options = QtWidgets.QFileDialog.Options()
        options |= QtWidgets.QFileDialog.DontUseNativeDialog
        output_file_name, _ = QtWidgets.QFileDialog.getSaveFileName(
            None, "Save File", "merged", "PDF File (*.pdf)", options=options)

        for i in range(self.file_list_widget.count()):
            if output_file_name + ".pdf" == self.file_list_widget.item(i).text():
                error_message = QtWidgets.QMessageBox.critical(None, "Error!",
                                                               "Error! Your file name is already in use!")
                return

        if output_file_name:  # check to make sure there is a name
            # user's file name won't include .pdf unless they type it in
            output_file_name = output_file_name + '.pdf'

            # create PDF merger object
            pdf_merger = PdfFileMerger(open(output_file_name, "wb"))

            for i in range(self.file_list_widget.count()):
                # get everything from the file list
                pdf_merger.append(self.file_list_widget.item(i).text())

            pdf_merger.write(output_file_name)
            pdf_merger.close()

            success_message = QtWidgets.QMessageBox.information(
                None, "Files Merged", f"{output_file_name} has been successfully written!")
```

First, we create a generic output file name for our final PDF. Next, we use PyQt’s built-in file-saving dialogue
boxes. This allows the user to choose a file name and ensures it will be saved as a PDF file.

The next `for loop` is purely for error-proofing and providing consistent behavior for the end-user. It ensures
that the user does not select an output name that matches one of the files in the list to be merged. This would
cause the original file to be overwritten and lose its data, a behavior that the user would likely not desire.
Note, however, that this is based on file path, so if the file name matches, but the files are in two different
locations, the files will be merged because there is no danger of data being overwritten.

The `if statement` double-checks that a file name exists, and the next line ensures that the file extension will
be the correct .pdf extension. The double-check provides one last line of defense against the application
crashing unexpectedly or inadvertent loss of data.

We now create an object using the PyPDF4 library, set it as the output filename, and ensure it is in a writeable
mode (`“wb”`).

The next `for loop` iterates through every item in the QListWidget and appends it to our PDFMerger object. Once
it completes, the following line of code instructs PyPDF4 to write the output file as a single PDF document.

If the file output is successful, we use PyQt’s built-in information message box to inform the user that their
operation succeeded. This provides predictability for the user. Users expect confirmation of success or
failure during computing operations, and if they do not receive it, they suspect an error has occurred.

## Error Testing and Future Additions for Users

At this point, the application functions once you run the PdfFileMerger.py script on your computer. Because this application is
likely intended for distribution so that others might benefit from your hard work, you should spend some time
testing for errors—the end-user will not have the ability to open the original script and fix errors as they arise.

Four PDF files are available to download to test your application and one "merged.pdf" to compare with your own application's output. They consist of an excerpt from Thomas Carlyle's
*The Moral Phenomena of Germany* (1845).[^2] Once your run your PDF Merger script, drag the four files into the list widget.
You must drag and drop in the list widget as our code specified that area as drag-and-droppable--the user cannot simply drop PDF files anywhere in the application. The items will enter the
widget in the order that is considered alphabetical on your operating system (they are currently numbered to be
alphabetical on MacOS). Our application also allows the user to re-arrange the order once the files have been dropped
into the list widget. Whatever order prevails in the list widget at the time of merging execution is the order the files
will appear in the final merged document.

Once you press "Merge PDFs," select the final file location and a filename. If all processed correctly, you should
see a dialogue box confirming successful execution. Now, navigate to the location you selected for your merged document. Open it.
The document should contain be 9 PDF pages long. Each PDF page should consist of two pages from Carlyle's work. The original
source material pages are numbered. Ensure that the beginning page is "Introduction" and that the following pages are numbered,
in order, from 5 to 21. If the numbers match up, the merging was completely successful. You may also verify that your
final document matches the provided "merged.pdf".

On a short note, the selection of PDF files was made so as to best ensure error detection (at least rudimentarily, for our purposes).
For example, the four documents are of varying lengths: 2 pages, 1 page, 5 pages, 1 page. These refer to PDF "pages," not
the amount of pages of the original source document. Testing this shows us that the various `for` loops in our code
correctly iterate through each page of each document. That we test four documents at once also verifies that our code does
not iterate incorrectly. Even the selection of two 1-page files was purposeful, in that it helps verify against certain
edge cases of our iterations over files and pages. Especially for GUI applications, it is essential to test edge cases
and what "strange" things a user might do that could crash the application. The developer cannot imagine all possibilities,
but thorough testing should ensure that the vast majority of use cases are covered. It is recommended that you try a few
variations of PDFs to test if you can break the application--and also do not forget to try adding something in the incorrect
order, using the list widget to correct the order, and then verifying that the merging is correct. If it is not, verify that
your code matches the code above.

There are also examples of error checking in our code that fulfill the principle of consistency and predictability in our user interface.
For instance, in the `mergeDocSlot` function, one of the first lines of code is an `if statement` to check if QListWidget contains more than one PDF file to
merge. This does two things for the user. First, if there are zero items in the ListWidget, the application will
not crash when the user inadvertently clicks the Merge PDFs button, and the program attempts to merge nothing,
an obvious impossibility. Second, suppose there is only one PDF to merge. In that case, no merging needs to occur.
It saves the user time by not rolling through the file-save dialogue boxes and conserves computer memory and
storage space by not needlessly creating and storing additional documents. The former example shows error
prevention, while the latter follows our principle of predictability of usage for the user.

Another example exists in the QListWidget code. At two points, we check with `.hasUrls()` to ensure that the file the
user is dragging and dropping has a valid file path. Finally, when the user releases the mouse button, our code
ensures that the file is a PDF when the actual drop occurs. If another file type could be added, the app would
crash as soon as PyPDF4 attempted to merge PDF files with other file formats. Our code prevents the user from even
attempting to merge a PDF with an audio or video file. Future features that the app developer might add could help
the user in this regard. For example, a common task is to merge Microsoft Word documents with PDFs. An app developer
could add a way for the program to detect a Word document, convert it to a PDF, and merge it with the other PDFs.
The Python package [docx2pdf] (https://pypi.org/project/docx2pdf/) provides a package to implement this feature.

When designing applications with GUIs, it’s important to remember that one of the primary goals is the ease of
use for the end-user. Further feature implementation projects left to the reader of this tutorial that could
aid usability are: a browse button to add files through an ordinary file dialogue box; a remove selected item
button to eliminate an erroneously added file on the list; a clear all list items button to empty the list
completely; a formal exit button. The Additional Resources section contains a link to the PyQt5 documentation
that contains instructions and examples of all the necessary UI features: file browsing dialog boxes and
button interactions with signals. With the exception of the Word to PDF converter outlined above, the author's
GitHub page contains a repository showing code to implement the above features: [PDF Merger] (https://github.com/cgoodwinDH/PDFMerger). It
is suggested that you try implementing the features first, as an exercise, before consulting the repository. You should
also keep in mind that there are many, many ways to implement a single feature; do not worry if your code
looks vastly different from that provided in the repository. You should, however, compare the code to look
for inefficiencies or alternate methods--always a valuable learning exercise.

# Creating the Distributable Application

The last significant step to making an application distributable is creating the executable file. Most users are
unfamiliar with running a Python script and rely on executable files such as .exe files on Windows and .app
files on macOS. Indeed, most users will not bother with an application or script if it requires compiling,
using a terminal, or running a script. If you want the broadest audience for your application, it needs to
come packaged and instantly usable after downloading.

Open your terminal and navigate to the directory containing your Python application. On macOS, enter the following
command:

`pyinstaller PDFFilemerger.py --windowed`

For Windows and Linux users:

`pyinstaller PDFFilemerger.py --onefile`

Allow the process to finish. You will find several directories created in the same folder as the original file.
Your completed, distributable application will be in the “dist” folder as a .app file (macOS), .exe file (Windows),
or an executable binary (Linux).

When you decide to distribute the application, remember that pyinstaller is not a cross-compiler. You must create
an executable for each operating system if you want a distributable application for that operating system.
For example, the .app executable you create on macOS will not work on Windows or Linux. To make executables work
on other platforms, you need to compile the application on that specific platform or use a virtual machine
running that operating system and compile it from there.

# Concluding Remarks

You now have an application with a GUI easily distributable to other users. Be aware that most email servers
block users from sending executable files. Personal websites or GitHub are preferable methods for distributing
applications.

This tutorial has provided the necessary skills to begin using Qt Designer and PyQt and to integrate your code
with these libraries. A plethora of documentation exists on the internet for more advanced features of PyQt.
While GUIs initially take extra time to develop, even a very simple GUI compiled into a distributable application
pays dividends in spreading the usage of your application. Whereas most users would immediately skip a
command-line script, users are more likely to engage with an application with even a very simple GUI.

## Additional Resources

It is important for programmers to become familiar with the official documentation for the tools they use. Qt for
Python is a vast project that one tutorial cannot cover. When issues arise, the Qt documentation should be one
of the first places you search for answers. The official documentation is available at
[Qt for Python] (https://doc.qt.io/qtforpython/).

The developers of [PyPDF4] (https://github.com/claird/PyPDF4) host their package open-source on GitHub. Tests, sample code
and documentation exist within their repository.

GUI design is now a vast field and many companies hire specialists to implement aesthetically appealing, easily useable
interfaces. A corresponding literature has emerged. The following are good places to begin:

1. Galitz, Wilbert O. *The Essential Guide to User Interface Design: An Introduction to GUI Design Principles and Techniques*.
Third edition. Indianapolis, IN: Wiley Publishing, 2007.

2. Johnson, Jeff. *Designing with the Mind in Mind: Simple Guide to Understanding User Interface Design Guidelines*.
2nd edition. Amsterdam: Morgan Kaufmann, 2014.

3. Platt, David. *The Joy of UX: User Experience and Interactive Design for Developers*. Boston: Addison-Wesley, 2016.

## Endnotes

[^1]: This tutorial uses Qt Designer version 5.9.6.
[^2]: Carlyle, Thomas. *The Moral Pheomena of Germany*. London: Painter, 1845. Available in the public domain at [HaithiTrust] (https://catalog.hathitrust.org/Record/100461771).

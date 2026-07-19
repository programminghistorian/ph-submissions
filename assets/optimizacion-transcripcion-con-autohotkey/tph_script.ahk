#Requires AutoHotkey v2.0
#SingleInstance Force
SetTitleMatchMode "RegEx"
SetWinDelay 0

; |----------------------CONTEXTO---------------------------|

isEditorActive() {
    return WinActive(
        "ahk_exe (soffice\.bin|notepad\+\+\.exe|Code\.exe|notepad\.exe)"
    ) || WinActive("^Prueba de script TPH AHK$")
}

#HotIf isEditorActive()

; |----------------------HOTKEYS---------------------------|

!g::
{
    releaseModifiers()
    SendText '<gap reason=""></gap>'
}

!s::
{
    releaseModifiers()
    SendText '<supplied reason=""></supplied>'
    Send "{Left 13}"
}

!1::
{
    Run "https://pares.cultura.gob.es/"
    Run "https://www.iifilologicas.unam.mx/dicabenovo/"
    Run "swriter.exe" ; LibreOffice Writer
}

!n::tagger("<name>", "</name>")
!p::tagger("<place>", "</place>")
!t::tagger("<title>", "</title>")

!u::convertSelection("upper")
!l::convertSelection("lower")
!c::insertNote("<note>[Comentario]</note>")

; |----------------------HOTSTRINGS---------------------------|

::tph::The Programming Historian
:*:@n::<name></name>{Left 7}
:*:@p::<place></place>{Left 8}
:*:@t::<title></title>{Left 8}

; |----------------------HOTSTRING PLANTILLA TEI-XML---------------------------|

::tei.xml::
{
    template := '
(
<?xml version="1.0" encoding="UTF-8"?>
<?xml-model
  href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng"
  type="application/xml"
  schematypens="http://relaxng.org/ns/structure/1.0"
?>
<?xml-model
  href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng"
  type="application/xml"
  schematypens="http://purl.oclc.org/dsdl/schematron"
?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>Título del documento</title>
      </titleStmt>
      <publicationStmt>
        <p>
		Información sobre la publicación de este documento (no de su fuente).
		</p>
      </publicationStmt>
      <sourceDesc>
        <p>Información sobre la fuente de este documento.</p>
      </sourceDesc>
    </fileDesc>
  </teiHeader>
  <text>
    <body>
      <p>Algo de texto aquí.</p>
    </body>
  </text>
</TEI>
)'

    savedClipboard := ClipboardAll()
    A_Clipboard := template

    if ClipWait(1) {
        Send "^v"
        Sleep 100
    }

    A_Clipboard := savedClipboard
}

; |----------------------DICABENOVO---------------------------|

; |-----A-----|

; |-----B-----|

; |-----C-----|

; |-----D-----|

; |-----E-----|

; |-----F-----|

; |-----G-----|

; |-----H-----|

; |-----I-----|

; |-----J-----|

; |-----K-----|

; |-----L-----|

; |-----M-----|

; |-----N-----|

; |-----Ñ-----|

; |-----O-----|

; |-----P-----|

; |-----Q-----|

; |-----R-----|

; |-----S-----|

; |-----T-----|

; |-----U-----|

::ulte.::ulteriorm<expan>en</expan>te
::ulti.::ultimam<expan>en</expan>te
::ulto.::ult<expan>im</expan>o
::ulta.::ult<expan>im</expan>a
::unani.::unanimem<expan>en</expan>te
::unani-::unani-mem<expan>en</expan>te
::unicam.::unicam<expan>en</expan>te
::uni.::uni<expan>versi</expan>dad
::uti.::utilid<expan>a</expan>d

; |-----V-----|

; |-----W-----|

; |-----X-----|

; |-----Y-----|

; |-----Z-----|

; |----------------------MARCADO SENCILLO A TEI-XML---------------------------|

^!x::convertSimpleMarkup()

#HotIf

; |----------------------FUNCIONES---------------------------|

releaseModifiers() {
    ; Libera los modificadores antes de enviar otras combinaciones
    KeyWait "Alt"
    KeyWait "Ctrl"
    Send "{Alt Up}{Ctrl Up}"
}

tagger(openTag, closeTag) {
    releaseModifiers()

    savedClipboard := ClipboardAll()   ; guarda el portapapeles
    A_Clipboard := ""                  ; lo limpia
    Send "^c"                          ; copia la selección

    if !ClipWait(0.3) {
        A_Clipboard := savedClipboard
        return
    }

    selectedText := A_Clipboard
    A_Clipboard := savedClipboard      ; restaura el portapapeles original

    ; Si no hay texto seleccionado, termina la función
    if (selectedText = "")
        return

    ; Escribe las etiquetas y el texto seleccionado
    SendText(openTag . selectedText . closeTag)
}

convertSelection(mode) {
    releaseModifiers()

    savedClipboard := ClipboardAll()
    A_Clipboard := ""
    Send "^c"

    if !ClipWait(0.3) {
        A_Clipboard := savedClipboard
        return
    }

    selectedText := A_Clipboard
    A_Clipboard := savedClipboard

    if (selectedText = "")
        return

    if (mode = "upper")
        SendText(StrUpper(selectedText))
    else if (mode = "lower")
        SendText(StrLower(selectedText))
    else
        SendText(selectedText)
}

insertNote(noteText) {
    releaseModifiers()
    SendText(noteText)
}

convertSimpleMarkup() {
    releaseModifiers()

    savedClipboard := ClipboardAll()
    A_Clipboard := ""
    Send "^c"

    if !ClipWait(1) {
        A_Clipboard := savedClipboard
        return
    }

    text := A_Clipboard
    A_Clipboard := savedClipboard

    text := RegExReplace(
        text,
        "\*\*([^*]+)\*\*",
        "<place>$1</place>"
    )
    text := RegExReplace(
        text,
        "(?<!\*)\*([^*]+)\*(?!\*)",
        "<name>$1</name>"
    )
    text := RegExReplace(
        text,
        "_([^_]+)_",
        "<title>$1</title>"
    )

    SendText(text)
}

; |----------------------INTERFAZ---------------------------|

global scriptActive := true
global mainGui, testEdit, toggleButton

createGui()

createGui() {
    global mainGui, testEdit, toggleButton

    mainGui := Gui(
        "+AlwaysOnTop +Resize +MinimizeBox",
        "Prueba de script TPH AHK"
    )
    mainGui.SetFont("s10", "Segoe UI")

    mainGui.AddText(
        "w500",
        "Escribe en la caja para probar los atajos y abreviaturas."
    )

    testEdit := mainGui.AddEdit(
        "w500 h180 WantTab",
        "Prueba aquí:`r`n`r`ntph`r`nulte.`r`n@n`r`n@p`r`n@t"
    )

    toggleButton := mainGui.AddButton("w500 h35", "Desactivar atajos")
    toggleButton.OnEvent("Click", (*) => toggleScript())

    mainGui.Show("AutoSize Center")
}

toggleScript() {
    global scriptActive, toggleButton

    scriptActive := !scriptActive

    if scriptActive {
        Suspend false
        toggleButton.Text := "Desactivar atajos"
    } else {
        Suspend true
        toggleButton.Text := "Activar atajos"
    }
}

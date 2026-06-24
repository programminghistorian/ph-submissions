#Requires AutoHotkey v2.0
#SingleInstance Force
SetTitleMatchMode "RegEx"
SetKeyDelay 0, 50
SetWinDelay 0

;	|----------------------HOTKEYS---------------------------|

!g::	Send "<gap reason=`"`"></gap>"

!s::
{
	Send "<supplied reason=`"`"></supplied>"
	Send	"{Left 13}"
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

!u::ConvertSelection("upper")
!l::ConvertSelection("lower")
!c::InsertNote("<note>[Comentario]</note>")

;	|----------------------HOTSTRINGS---------------------------|

::tph::The Programming Historian
::@n::<name></name>{Left 7}
::@p::<place></place>{Left 8}
::@t::<title></title>{Left 8}

;	|----------------------HOTSTRING PLANTILLA XML-TEI---------------------------|

::tei.xml::
{
    plantilla := '
(
<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml"
  schematypens="http://purl.oclc.org/dsdl/schematron"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>Título del documento</title>
      </titleStmt>
      <publicationStmt>
        <p>Información sobre la publicación de este documento (no de su fuente).</p>
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

    A_Clipboard := plantilla
    ClipWait 1
    Send "^v"
}

;	|----------------------DICABENOVO---------------------------|

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

;	|----------------------FUNCIONES---------------------------|

tagger(openTag, closeTag) {
	ClipSaved := ClipboardAll()   ; guarda el portapapeles
	A_Clipboard := ""             ; lo limpia
	Send "^c"                     ; copia la selección

	if !ClipWait(0.3) {
		A_Clipboard := ClipSaved
		EnsureAltUp()
		return
	}

	selectedText := A_Clipboard
	A_Clipboard := ClipSaved      ; restaura el portapapeles original

	; si no hay texto, nada
	if (selectedText = "") {
		EnsureAltUp()
		return
	}

	; escribimos directamente las etiquetas y el texto seleccionado
	SendText openTag . selectedText . closeTag
	EnsureAltUp()                 ; nos aseguramos de que Alt no se quede presionado
}

EnsureAltUp() {
    ; Espera un momento a que Alt se suelte, y si sigue “pulsada”, la suelta a la fuerza
    KeyWait "Alt", "T0.2"              ; espera hasta 0.2 s a que Alt se libere
    if GetKeyState("Alt", "P") {       ; si físicamente sigue abajo...
        Send "{Alt up}"                ; ...la forzamos a soltar
    }
}

ConvertSelection(mode) {
    ClipSaved := ClipboardAll()
    A_Clipboard := ""
    Send "^c"
    if !ClipWait(0.3) {
        A_Clipboard := ClipSaved
        EnsureAltUp()
        return
    }

    selectedText := A_Clipboard
    A_Clipboard := ClipSaved

    if (selectedText = "") {
        EnsureAltUp()
        return
    }

    if (mode = "upper")
        newText := StrUpper(selectedText)
    else if (mode = "lower")
        newText := StrLower(selectedText)
    else
        newText := selectedText

    ; pegamos el texto transformado
    A_Clipboard := newText
    ClipWait 0.3
    Send "^v"

    EnsureAltUp()
}

InsertNote(noteText) {
    ; inserta el texto de la nota sin tocar el portapapeles
    SendText noteText
    EnsureAltUp()
}

;	|----------------------MARCADO SENCILLO A XML-TEI---------------------------|

^!x:: {
    A_Clipboard := ""

    Send "^c"
    if !ClipWait(1)
        return

    texto := A_Clipboard

    texto := RegExReplace(texto, "\*\*([^*]+)\*\*", "<place>$1</place>")
    texto := RegExReplace(texto, "(?<!\*)\*([^*]+)\*(?!\*)", "<name>$1</name>")
    texto := RegExReplace(texto, "_([^_]+)_", "<title>$1</title>")

    A_Clipboard := texto
    Send "^v"
	EnsureAltUp()
}


;	|----------------------INTERFAZ---------------------------|

global ScriptActivo := true
global MainGui, TestEdit, BtnToggle

CrearGUI()

CrearGUI() {
    global MainGui, TestEdit, BtnToggle

    MainGui := Gui("+AlwaysOnTop +Resize +MinimizeBox", "Prueba de script TPH AHK")
    MainGui.SetFont("s10", "Segoe UI")

    MainGui.AddText("w500", "Escribe en la caja para probar los atajos y abreviaturas.")

    TestEdit := MainGui.AddEdit(
        "w500 h180 WantTab",
        "Prueba aquí:`r`n`r`ntph`r`nulte.`r`n@n`r`n@p`r`n@t"
    )

    BtnToggle := MainGui.AddButton("w500 h35", "Desactivar atajos")
    BtnToggle.OnEvent("Click", (*) => ToggleScripts())

    MainGui.Show("AutoSize Center")
}

ToggleScripts() {
    global ScriptActivo, BtnToggle

    ScriptActivo := !ScriptActivo

    if ScriptActivo {
        Suspend false
        BtnToggle.Text := "Desactivar atajos"
    } else {
        Suspend true
        BtnToggle.Text := "Activar atajos"
        EnsureAltUp()
    }
}
// =============================================================================
// config.js — Versión simple de acompañamiento a la lección de
// Programming Historian en español:
// "Narración de historias con mapas usando el software libre MapLibre"
//
// Esta versión contiene los tres capítulos que la lección construye paso a
// paso. Sirve como punto de partida y de verificación: si tu archivo se ve
// como este, vas por buen camino.
// =============================================================================

var config = {
    // Mapa base de OpenFreeMap: no requiere registro ni clave de API.
    // Otros estilos: 'bright', 'positron', 'fiord'.
    style: 'https://tiles.openfreemap.org/styles/liberty',
    showMarkers: false,
    markerColor: '#3FB1CE',
    inset: true,
    legend: false,
    theme: 'dark',
    use3dTerrain: false, // el terreno 3D se trata en la sección avanzada de la lección
    useCustomLayers: true, // habilita las capas definidas en sources.js
    bookmarks: false,
    chapterReturn: false,
    title: 'Medir la Tierra',
    logo: '',
    subtitle: 'La Misión Geodésica Francesa al Ecuador (1736–1743)',
    byline: 'Por Felipe Valdez',
    mobileview: '<div id="rotate-mobile"><em>Para una mejor experiencia en dispositivos móviles, gira tu dispositivo a orientación horizontal.</em><br><br><img src="images/device.png">',
    footer: 'Fuentes: Charles-Marie de La Condamine, <em>Relation abrégée</em> (1745), Gallica, BnF; Jorge Juan y Antonio de Ulloa, <em>Relación histórica</em> (1748), BNE. <br> Creado con la plantilla <a href="https://github.com/digidem/maplibre-storymap" target="_blank">MapLibre Storytelling</a> y datos de <a href="https://openfreemap.org" target="_blank">OpenFreeMap</a>.',
    chapters: [
        // ---------------------------------------------------------------------
        // CAPÍTULO 1 — La apertura: cámara planetaria
        // Zoom muy bajo y pitch 0 para transmitir abstracción y escala global.
        // jumpTo porque es la vista inicial: no hay un "antes" desde el cual volar.
        // ---------------------------------------------------------------------
        {
            id: 'cap-0-apertura',
            alignment: 'left',
            hidden: false,
            title: '¿Qué forma tiene la Tierra?',
            image: './images/cap0_esferoide_newton.jpg',
            caption: 'Comparación de los dos modelos del esferoide terrestre, siglo XVIII. Dominio público.',
            description: 'En 1734, la Academia Real de Ciencias de París enfrentaba una disputa que dividía a la ciencia europea: ¿es la Tierra un esferoide achatado en los polos, como sostenía Isaac Newton, o achatado en el ecuador, como defendía la escuela de Jacques Cassini? La única forma de resolverlo era medir. La Academia decidió enviar dos expediciones simultáneas a los extremos del planeta: una a Laponia, dirigida por Maupertuis (1736–1737), y otra al territorio de la Real Audiencia de Quito, en el actual Ecuador.',
            location: {
                center: [0.0, 0.0], // [longitud, latitud] — ¡ojo con el orden!
                zoom: 1.6,
                pitch: 0,
                bearing: 0
            },
            mapAnimation: 'jumpTo',
            rotateAnimation: false,
            mapInteractive: false,
            callback: '',
            onChapterEnter: [],
            onChapterExit: []
        },
        // ---------------------------------------------------------------------
        // CAPÍTULO 2 — La Rochelle: la transición como gesto narrativo
        // El flyTo convierte el cambio de escala (planeta → puerto) en un
        // descenso dramático. El bearing 270 gira la cámara hacia el oeste:
        // el lector mira desde el puerto hacia el Atlántico, la dirección
        // exacta del viaje que está por comenzar.
        // ---------------------------------------------------------------------
        {
            id: 'cap-1-la-rochelle',
            alignment: 'left',
            hidden: false,
            title: 'La Rochelle: el embarque',
            image: './images/cap1_la_condamine_carmontelle.jpg',
            caption: 'Retrato de Charles-Marie de La Condamine por Carmontelle. Wikimedia Commons, dominio público.',
            description: 'El 16 de mayo de 1735 zarpa del puerto de La Rochelle el navío <em>Portefaix</em>. A bordo viaja un equipo singular: los académicos Charles-Marie de La Condamine, Pierre Bouguer y Louis Godin; el botánico Joseph de Jussieu; el médico Jean Seniergues; el cartógrafo Jean-Baptiste Verguin; el dibujante Jean-Louis de Morainville; y Hugot, el relojero encargado de mantener vivos los instrumentos. Llevan consigo cuadrantes, relojes de péndulo y toesas de hierro: instrumentos de precisión nunca antes embarcados hacia América.',
            location: {
                center: [-1.1517, 46.1591], // puerto de La Rochelle
                zoom: 13,
                pitch: 30,
                bearing: 270 // vista hacia el Atlántico: la dirección del viaje
            },
            mapAnimation: 'flyTo',
            rotateAnimation: false,
            mapInteractive: false,
            callback: '',
            onChapterEnter: [],
            onChapterExit: []
        },
        // ---------------------------------------------------------------------
        // CAPÍTULO 3 — Triangular los Andes: capas sincronizadas con la historia
        // Al entrar, onChapterEnter enciende las tres capas definidas en
        // sources.js (líneas, cumbres y etiquetas) con un fundido de 1,5
        // segundos. Al salir, onChapterExit las apaga. El valor de "layer"
        // debe coincidir EXACTAMENTE con el "id" de la capa en sources.js.
        // ---------------------------------------------------------------------
        {
            id: 'cap-5-triangulacion',
            alignment: 'left',
            hidden: false,
            title: 'Triangular los Andes',
            image: './images/cap5_chimborazo_relacion.jpg',
            caption: 'El Chimborazo en la <em>Relación histórica</em> (1748). BNE. Dominio público.',
            description: 'El equipo extiende la triangulación hacia el sur por el callejón interandino, acampando durante semanas a más de 4.000 metros para colocar miras en las cumbres y medir los ángulos entre ellas. Sobre el mapa, la red de triángulos reproduce lo que la expedición dibujaba en papel.',
            location: {
                center: [-78.6500, -1.5000], // entre Cotopaxi y Chimborazo
                zoom: 8,
                pitch: 60,
                bearing: 0
            },
            mapAnimation: 'flyTo',
            rotateAnimation: true, // rotación lenta al llegar: evoca la medición paciente
            mapInteractive: false,
            callback: '',
            onChapterEnter: [
                {
                    layer: 'triangulacion-lineas',
                    opacity: 0.8,
                    duration: 1500
                },
                {
                    layer: 'triangulacion-cumbres',
                    opacity: 1,
                    duration: 1500
                },
                {
                    layer: 'triangulacion-etiquetas',
                    opacity: 1,
                    duration: 1500
                }
            ],
            onChapterExit: [
                {
                    layer: 'triangulacion-lineas',
                    opacity: 0
                },
                {
                    layer: 'triangulacion-cumbres',
                    opacity: 0
                },
                {
                    layer: 'triangulacion-etiquetas',
                    opacity: 0
                }
            ]
        }
    ]
};

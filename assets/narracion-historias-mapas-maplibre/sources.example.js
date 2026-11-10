// =============================================================================
// sources.js — Versión simple de acompañamiento a la lección de
// Programming Historian en español:
// "Narración de historias con mapas usando el software libre MapLibre"
//
// Define una sola fuente de datos (la red de triangulación de la Misión
// Geodésica) y tres capas que la dibujan: las líneas de visión entre cumbres,
// los puntos de las cumbres, y sus etiquetas.
//
// Todas las capas comienzan con opacidad 0: se encienden y apagan desde
// config.js con onChapterEnter y onChapterExit.
// =============================================================================

var externalData = {
    sources: [
        {
            "name": "triangulacion",
            "source": {
                "type": "geojson",
                "data": {
                    "type": "FeatureCollection",
                    "features": [
                        { "type": "Feature", "properties": { "nombre": "Pambamarca" }, "geometry": { "type": "Point", "coordinates": [-78.2000, -0.0700] } },
                        { "type": "Feature", "properties": { "nombre": "Pichincha" }, "geometry": { "type": "Point", "coordinates": [-78.5980, -0.1710] } },
                        { "type": "Feature", "properties": { "nombre": "El Corazón" }, "geometry": { "type": "Point", "coordinates": [-78.6790, -0.5330] } },
                        { "type": "Feature", "properties": { "nombre": "Cotopaxi" }, "geometry": { "type": "Point", "coordinates": [-78.4360, -0.6800] } },
                        { "type": "Feature", "properties": { "nombre": "Tungurahua" }, "geometry": { "type": "Point", "coordinates": [-78.4420, -1.4670] } },
                        { "type": "Feature", "properties": { "nombre": "Chimborazo" }, "geometry": { "type": "Point", "coordinates": [-78.8170, -1.4690] } },
                        { "type": "Feature", "properties": { "nombre": "Buerán" }, "geometry": { "type": "Point", "coordinates": [-78.9500, -2.6800] } },
                        {
                            "type": "Feature",
                            "properties": { "nombre": "Cadena de triángulos" },
                            "geometry": {
                                "type": "MultiLineString",
                                "coordinates": [
                                    [[-78.2000, -0.0700], [-78.5980, -0.1710]],
                                    [[-78.2000, -0.0700], [-78.6790, -0.5330]],
                                    [[-78.5980, -0.1710], [-78.6790, -0.5330]],
                                    [[-78.5980, -0.1710], [-78.4360, -0.6800]],
                                    [[-78.6790, -0.5330], [-78.4360, -0.6800]],
                                    [[-78.6790, -0.5330], [-78.4420, -1.4670]],
                                    [[-78.4360, -0.6800], [-78.4420, -1.4670]],
                                    [[-78.4360, -0.6800], [-78.8170, -1.4690]],
                                    [[-78.4420, -1.4670], [-78.8170, -1.4690]],
                                    [[-78.4420, -1.4670], [-78.9500, -2.6800]],
                                    [[-78.8170, -1.4690], [-78.9500, -2.6800]]
                                ]
                            }
                        }
                    ]
                }
            }
        }
    ],
    layers: [
        {
            "id": "triangulacion-lineas",
            "type": "line",
            "source": "triangulacion",
            "filter": ["==", "$type", "LineString"],
            "paint": {
                "line-color": "#1c4587",
                "line-width": 1.5,
                "line-dasharray": [2, 2],
                "line-opacity": 0
            }
        },
        {
            "id": "triangulacion-cumbres",
            "type": "circle",
            "source": "triangulacion",
            "filter": ["==", "$type", "Point"],
            "paint": {
                "circle-radius": 6,
                "circle-color": "#1c4587",
                "circle-stroke-color": "#ffffff",
                "circle-stroke-width": 2,
                "circle-opacity": 0,
                "circle-stroke-opacity": 0
            }
        },
        {
            "id": "triangulacion-etiquetas",
            "type": "symbol",
            "source": "triangulacion",
            "filter": ["==", "$type", "Point"],
            "layout": {
                "text-field": ["get", "nombre"],
                "text-font": ["Noto Sans Regular"],
                "text-size": 12,
                "text-offset": [0, 1.2],
                "text-anchor": "top"
            },
            "paint": {
                "text-color": "#10294f",
                "text-halo-color": "#ffffff",
                "text-halo-width": 1.5,
                "text-opacity": 0
            }
        }
    ]
};

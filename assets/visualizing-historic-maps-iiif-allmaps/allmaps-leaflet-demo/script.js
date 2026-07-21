// map setup functions

const map = L.map("map", {
  center: [42.3518, -71.05],
  zoom: 13,
  minZoom: 7,
  maxZoom: 24,
  zoomControl: false,
});

// make and load base map

let tileLayerDetails = {
  tileSize: 512,
  zoomOffset: -1,
  minZoom: 7,
  maxZoom: 24,
  crossOrigin: true,
};
let streets_base = L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", tileLayerDetails).addTo(map);

// define and load default warped maps

let annotationUrl = 'https://annotations.allmaps.org/manifests/cfb327e4b43395e3';
let warpedMapLayer = new Allmaps.WarpedMapLayer(annotationUrl).addTo(map);

// add the layer list

let base = { "OpenStreetMap": streets_base };
let overlay = { "Allmaps overlay": warpedMapLayer };
let layerControl = L.control.layers(base, overlay).addTo(map);

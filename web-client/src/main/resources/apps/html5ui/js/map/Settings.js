OpenLayers.DOTS_PER_INCH = 90.71;
OpenLayers.ImgPath = '../../apps/js/OpenLayers/img/';

OpenLayers.IMAGE_RELOAD_ATTEMPTS = 3;

// Remove pink background when a tile fails to load
OpenLayers.Util.onImageLoadErrorColor = "transparent";

// Lang
OpenLayers.Lang.setCode(GeoNetwork.defaultLocale);

OpenLayers.Util.onImageLoadError = function() {
    this._attempts = (this._attempts) ? (this._attempts + 1) : 1;
    if (this._attempts <= OpenLayers.IMAGE_RELOAD_ATTEMPTS) {
        this.src = this.src;
    } else {
        this.style.backgroundColor = OpenLayers.Util.onImageLoadErrorColor;
        this.style.display = "none";
    }
};

// add Proj4js.defs here
// Proj4js.defs["EPSG:27572"] = "+proj=lcc +lat_1=46.8 +lat_0=46.8 +lon_0=0
// +k_0=0.99987742 +x_0=600000 +y_0=2200000 +a=6378249.2 +b=6356515
// +towgs84=-168,-60,320,0,0,0,0 +pm=paris +units=m +no_defs";
// Proj4js.defs["EPSG:28992"] = "+proj=sterea +lat_0=52.15616055555555
// +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel
// +units=m +no_defs";
Proj4js.defs["EPSG:2154"] = "+proj=lcc +lat_1=49 +lat_2=44 +lat_0=46.5 +lon_0=3 +x_0=700000 +y_0=6600000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs";

Proj4js.defs["EPSG:3857"] = "+proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +a=6378137 +b=6378137 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
Proj4js.defs["EPSG:4326"] = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs";
GeoNetwork.map.printCapabilities = window.location.href;
GeoNetwork.map.printCapabilities = 
  GeoNetwork.map.printCapabilities.substring(0,
          GeoNetwork.map.printCapabilities.lastIndexOf("/"));
GeoNetwork.map.printCapabilities = 
  GeoNetwork.map.printCapabilities.substring(0,
          GeoNetwork.map.printCapabilities.lastIndexOf("/"));
GeoNetwork.map.printCapabilities = 
  GeoNetwork.map.printCapabilities.substring(0,
          GeoNetwork.map.printCapabilities.lastIndexOf("/")) + "/pdf";

// Config for WGS84 based maps
GeoNetwork.map.PROJECTION = "EPSG:3857";
GeoNetwork.map.EXTENT = new OpenLayers.Bounds(-550000, 5000000, 1200000, 7000000);
//GeoNetwork.map.EXTENT = new OpenLayers.Bounds(-5.1,41,9.7,51);



GeoNetwork.map.BACKGROUND_LAYERS = [
    //new OpenLayers.Layer.WMS("Background layer", "/geoserver/wms", {layers: 'gn:world,gn:ne_50m_boundary_da,gn:ne_50m_boundary_lines_land,gn:ne_50m_coastline', format: 'image/jpeg'}, {isBaseLayer: true}),
   // new OpenLayers.Layer.WMS("Background layer", "http://www2.demis.nl/mapserver/wms.asp?", {layers: 'Countries', format: 'image/jpeg'}, {isBaseLayer: true})
    new OpenLayers.Layer.WMS(
            "Global Imagery",
            "https://webgate.acceptance.ec.europa.eu/estat/inspireec/gis/arcgis/services/Basemaps/2014_Countries_NoLabels_GreyBackground_3857/MapServer/WMSServer?",
            {layers: "0,1,2,3,4,5,6,7,8,9,10,11,12,13"}
        ),
];
//https://webgate.acceptance.ec.europa.eu/estat/inspireec/gis/arcgis/rest/services/Basemaps/Blue_marble_3857/MapServer/WMSServer?
//	http://data.geus.dk/gis/arcgis/services/GtW/S014_Jordartskort_200000/MapServer/WMSServer?
// Config for OSM based maps
if (useOSMLayers) {
    GeoNetwork.map.PROJECTION = "EPSG:3857";
    //GeoNetwork.map.EXTENT = new OpenLayers.Bounds(-550000, 5000000, 1200000, 7000000);
    GeoNetwork.map.EXTENT = new OpenLayers.Bounds(-20037508.34,-20037508.34,20037508.34,20037508.34);
    GeoNetwork.map.BACKGROUND_LAYERS = [
        
 //       new OpenLayers.Layer.Google("Google Streets"),
        new OpenLayers.Layer.WMS(
                "Global Imagery",
                "https://webgate.acceptance.ec.europa.eu/estat/inspireec/gis/arcgis/services/Basemaps/2014_Countries_NoLabels_GreyBackground_3857/MapServer/WMSServer?",
                {layers: "0,1,2,3,4,5,6,7,8,9,10,11,12,13"}
            ),
       new OpenLayers.Layer.OSM()
    ];
    

} else {
	 GeoNetwork.map.PROJECTION = "EPSG:3857";
    GeoNetwork.map.EXTENT = new OpenLayers.Bounds(-20037508, -19971868, 20037508, 19971868);
	GeoNetwork.map.BACKGROUND_LAYERS = [	        
	        new OpenLayers.Layer.WMS(
	                "Countries Grey",
	                "https://webgate.acceptance.ec.europa.eu/estat/inspireec/gis/arcgis/services/Basemaps/2014_Countries_NoLabels_GreyBackground_3857/MapServer/WMSServer?",
	                {layers: "0,1,2,3,4,5,6,7,8,9,10,11,12,13"}
	            ),
	         new OpenLayers.Layer.WMS(
		                "Hypsometric",
		                "https://webgate.acceptance.ec.europa.eu/estat/inspireec/gis/arcgis/services/Basemaps/Hypsometric_3857/MapServer/WMSServer?",
		                {layers: "0"}
		        ),  
		    new OpenLayers.Layer.WMS(
		                "Natural Earth",
		                "https://webgate.acceptance.ec.europa.eu/estat/inspireec/gis/arcgis/services/Basemaps/Natural_Earth_3857/MapServer/WMSServer?",
		                {layers: "0"}
		        ),  
		    new OpenLayers.Layer.WMS(
		                "Blue marble",
		                "https://webgate.acceptance.ec.europa.eu/estat/inspireec/gis/arcgis/services/Basemaps/Blue_marble_3857/MapServer/WMSServer?",
		                {layers: "0"}
		        )
	  
	    ];
}




GeoNetwork.map.CONTEXT_MAP_OPTIONS = {
    controls: [],
    theme:null
};

GeoNetwork.map.CONTEXT_MAIN_MAP_OPTIONS = {
    controls: [],
    theme:null
};

GeoNetwork.map.MAP_OPTIONS = {
    projection : GeoNetwork.map.PROJECTION,
    maxExtent: GeoNetwork.map.EXTENT,
    restrictedExtent : GeoNetwork.map.EXTENT,
    resolutions: GeoNetwork.map.RESOLUTIONS,
    controls: [],
    maxScale: 10000,
    theme:null
};

GeoNetwork.map.MAIN_MAP_OPTIONS = {
    projection : GeoNetwork.map.PROJECTION,
    maxExtent: GeoNetwork.map.EXTENT,
    restrictedExtent : GeoNetwork.map.EXTENT,
    resolutions: GeoNetwork.map.RESOLUTIONS,
    //center: new OpenLayers.LonLat(0,8000000),
    center: new OpenLayers.LonLat(1000000,7000000),
    controls: [],
    theme:null
};

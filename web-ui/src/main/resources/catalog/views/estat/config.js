(function() {

  goog.provide('gn_search_estat_config');

  var module = angular.module('gn_search_estat_config', []);

  module.value('gnTplResultlistLinksbtn',
      '../../catalog/views/estat/directives/partials/linksbtn.html');

  module
      .run([
        'gnSearchSettings',
        'gnViewerSettings',
        'gnOwsContextService',
        'gnMap',
        function(searchSettings, viewerSettings, gnOwsContextService, gnMap) {
          // Load the context defined in the configuration
          viewerSettings.defaultContext =
            viewerSettings.mapConfig.viewerMap ||
                (viewerSettings.mapConfig.projection == 'EPSG:3857')?
                    '../../map/config-viewer-3857.xml':'../../map/config-viewer-4326.xml';

         // window.localStorage.removeItem('owsContext');
          var owsContextText = window.localStorage.getItem('owsContext');

          // Update some map properties from localStorage owsContext
          if (owsContextText) {
              // OWC Client
              // Jsonix wrapper to read or write OWS Context
              var context = new Jsonix.Context(
                  [XLink_1_0, OWS_1_0_0, Filter_1_0_0, GML_2_1_2, SLD_1_0_0, OWC_0_3_1],
                  {
                      namespacePrefixes: {
                          'http://www.w3.org/1999/xlink': 'xlink',
                          'http://www.opengis.net/ows': 'ows'
                      }
                  }
              );
              var unmarshaller = context.createUnmarshaller();
              var owsContext = unmarshaller.unmarshalString(owsContextText).value;

              var bbox = owsContext.general.boundingBox.value;
              var projection = bbox.crs;

              viewerSettings.mapConfig.center =
                  ol.extent.getCenter(ol.extent.boundingExtent([bbox.lowerCorner, bbox.upperCorner]));


              viewerSettings.mapConfig.projection = bbox.crs;
          }

          viewerSettings.selectedbgLayer = viewerSettings.mapConfig.gntype || 'Blue_marble_4326_tile';

          // Keep one layer in the background
          // while the context is not yet loaded.
          viewerSettings.bgLayers = [
             gnMap.createLayerForType(viewerSettings.selectedbgLayer)
          ];

          viewerSettings.servicesUrl =
            viewerSettings.mapConfig.listOfServices || {};

          var bboxStyle = new ol.style.Style({
            stroke: new ol.style.Stroke({
              color: 'rgba(255,0,0,1)',
              width: 2
            }),
            fill: new ol.style.Fill({
              color: 'rgba(255,0,0,0.3)'
            })
          });
          searchSettings.olStyles = {
            drawBbox: bboxStyle,
            mdExtent: new ol.style.Style({
              stroke: new ol.style.Stroke({
                color: 'orange',
                width: 2
              })
            }),
            mdExtentHighlight: new ol.style.Style({
              stroke: new ol.style.Stroke({
                color: 'orange',
                width: 3
              }),
              fill: new ol.style.Fill({
                color: 'rgba(255,255,0,0.3)'
              })
            })

          };

          /*******************************************************************
             * Define maps
             */
          var mapproj = viewerSettings.mapConfig.projection || 'EPSG:4326';
          var minZoom = viewerSettings.mapConfig.minZoom || 0;
          var maxZoom = viewerSettings.mapConfig.maxZoom || 11;
          var center = viewerSettings.mapConfig.center || [5,50];
          var mapsConfig = {
              	projection: mapproj,
                  center: center,
                  zoom: 4,
                  maxZoom: maxZoom,
                  minZoom: minZoom
                };

//          var mapsConfig = {
//            center: [280274.03240585705, 6053178.654789996],
//            zoom: 2
//            //maxResolution: 9783.93962050256
//          };

          var viewerMap = new ol.Map({
			   controls: [],
        	   //controls: [new ol.control.ScaleLine()],
			   view: new ol.View(mapsConfig)
          });

          var searchMap = new ol.Map({
            controls:[],
            layers: [gnMap.createLayerForType(viewerSettings.selectedbgLayer)],
            view: new ol.View(mapsConfig)
//            view: new ol.View({
//              center: mapsConfig.center,
//              zoom: 2
//            })
          });


            function checkForProjection() {
                if (jQuery('#projection').length === 0) {
                    window.setTimeout(checkForProjection, 500);
                    return;
                }


                ol.control.Projection = function(opt_options) {
                    var options = opt_options || {};
                    var _this = this;

                    var projSwitcher = document.getElementById('projectionSelector');

                    projSwitcher
                        .addEventListener(
                            'change',
                            function(evt) {
                                var oldProj =  _this.getMap().getView()
                                    .getProjection();
                                var newProj = ol.proj
                                    .get(this.value);

                                /*if (newProj.getCode() == 'EPSG:4326') {
                                    minResolution: 0.0000000026193447411060333,
                                    maxResolution: 0.3515625,
                                } else {
                                    minResolution: 0.0000000026193447411060333,
                                    maxResolution: 0.3515625,
                                }*/

                                var newView = new ol.View({
                                    //minResolution: 0.00029158412279196264,
                                    //maxResolution: 39135.75848201024,
                                    projection: newProj,
                                    center:  ol.proj.transform(_this.getMap().getView().getCenter(), oldProj, newProj),
                                    zoom:  _this.getMap().getView().getZoom(),
                                    minZoom: 2
                                    //maxZoom: parseInt(maxZoom)
                                });

                                // Set the view
                                _this.getMap().setView(newView);

                                _this
                                    .getMap()
                                    .getControls()
                                    .forEach(
                                        function(
                                            control) {
                                            if (typeof control.setProjection === "function") {
                                                control
                                                    .setProjection(newProj);
                                            }
                                        });


                                if (newProj.getCode() == 'EPSG:4326') {
                                    viewerSettings.selectedbgLayer = 'Natural_Earth_4326_tile';
                                    viewerSettings.defaultContext = '../../map/config-viewer-4326.xml';
                                } else {
                                    viewerSettings.selectedbgLayer = 'Natural_Earth_3857_tile';
                                    viewerSettings.defaultContext = '../../map/config-viewer-3857.xml';
                                }

                                // Keep one layer in the background
                                // while the context is not yet loaded.
                                viewerSettings.bgLayers = [
                                    gnMap.createLayerForType(viewerSettings.selectedbgLayer)
                                ];

                                gnOwsContextService.
                                loadContextFromUrl(viewerSettings.defaultContext ,
                                    _this.getMap());

                            });
                    ol.control.Control.call(this, {
                        element : projSwitcher,
                        target : options.target
                    });
                    this.set('element', projSwitcher);
                };
                ol.inherits(ol.control.Projection, ol.control.Control);

                ol.control.Projection.prototype.setMap = function(map) {
                    ol.control.Control.prototype.setMap.call(this, map);
                    if (map !== null) {
                        this.get('element').value = map.getView()
                            .getProjection().getCode();
                    }
                };

                ol.control.Projection.prototype.changeLayerProjection = function(
                    layer, oldProj, newProj) {
                    if (layer instanceof ol.layer.Group) {
                        layer.getLayers()
                            .forEach(
                                function(subLayer) {
                                    this.changeLayerProjection(
                                        subLayer, oldProj,
                                        newProj);
                                });
                    } else if (layer instanceof ol.layer.Tile) {
                        var tileLoadFunc = layer.getSource()
                            .getTileLoadFunction();
                        layer.getSource().setTileLoadFunction(
                            tileLoadFunc);
                    } else if (layer instanceof ol.layer.Vector) {
                        var features = layer.getSource().getFeatures();
                        for (var i = 0; i < features.length; i += 1) {
                            features[i].getGeometry().transform(
                                oldProj, newProj);
                        }
                    }
                };

                ol.control.Projection.prototype.addProjection = function(
                    projection,text) {
                    ol.proj.addProjection(projection);
                    var projSwitcher = this.get('element');
                    var newProjOption = document
                        .createElement('option');
                    newProjOption.value = projection.getCode();
                    newProjOption.textContent = text;//projection.getCode();
                    projSwitcher.appendChild(newProjOption);
                };

                var projControl = new ol.control.Projection({
                    target : document.getElementById('projection')
                });

                viewerMap.addControl(projControl);
            }

            window.setTimeout(checkForProjection, 500);


            /** Facets configuration */
          searchSettings.facetsSummaryType = 'details';

          /*
             * Hits per page combo values configuration. The first one is the
             * default.
             */
          searchSettings.hitsperpageValues = [20, 50, 100];

          /* Pagination configuration */
          searchSettings.paginationInfo = {
            hitsPerPage: searchSettings.hitsperpageValues[0]
          };

          /*
             * Sort by combo values configuration. The first one is the default.
             */
          searchSettings.sortbyValues = [{
            sortBy: 'relevance',
            sortOrder: ''
          }, {
            sortBy: 'changeDate',
            sortOrder: ''
          }, {
            sortBy: 'title',
            sortOrder: 'reverse'
          }, {
            sortBy: 'rating',
            sortOrder: ''
          }, {
            sortBy: 'popularity',
            sortOrder: ''
          }, {
            sortBy: 'denominatorDesc',
            sortOrder: ''
          }, {
            sortBy: 'denominatorAsc',
            sortOrder: 'reverse'
          }];

          /* Default search by option */
          searchSettings.sortbyDefault = searchSettings.sortbyValues[0];

          /* Custom templates for search result views */
          searchSettings.resultViewTpls = [{
                  tplUrl: '../../catalog/components/search/resultsview/' +
                  'partials/viewtemplates/grid.html',
                  tooltip: 'Grid',
                  icon: 'fa-th'
                }];

          // For the time being metadata rendering is done
          // using Angular template. Formatter could be used
          // to render other layout

          // TODO: formatter should be defined per schema
          // schema: {
          // iso19139: 'md.format.xml?xsl=full_view&&id='
          // }
          searchSettings.formatter = {
            // defaultUrl: 'md.format.xml?xsl=full_view&id='
            defaultUrl: 'md.format.xml?xsl=xsl-view&uuid=',
            defaultPdfUrl: 'pdf?uuid=',
            list: [{
            //  label: 'inspire',
            //  url: 'md.format.xml?xsl=xsl-view' + '&view=inspire&id='
            //}, {
              //  label: 'full',
              //  url: 'md.format.xml?xsl=xsl-view&view=advanced&id='
              //}, {
              label: 'full',
              url: 'md.format.xml?xsl=xsl-view&view=advanced&uuid='
              /*
               // You can use a function to choose formatter
               url : function(md) {
               return 'md.format.xml?xsl=full_view&uuid=' + md.getUuid();
               }*/
            }]
          };

          // Mapping for md links in search result list.
          searchSettings.linkTypes = {
            links: ['LINK'],
            downloads: ['DOWNLOAD'],
            layers:['OGC', 'kml'],
            maps: ['ows']
          };

          // Set the default template to use
          searchSettings.resultTemplate =
              searchSettings.resultViewTpls[0].tplUrl;

          // Set custom config in gnSearchSettings
          angular.extend(searchSettings, {
            viewerMap: viewerMap,
            searchMap: searchMap
          });

        }]);
})();

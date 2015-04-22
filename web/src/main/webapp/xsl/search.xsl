<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:geonet="http://www.fao.org/geonetwork"
	xmlns:exslt="http://exslt.org/common" exclude-result-prefixes="exslt geonet">
	<xsl:include href="metadata/common.xsl" />
	<xsl:output omit-xml-declaration="no" method="html"
		doctype-public="html" indent="yes" encoding="UTF-8" />
	<xsl:variable name="hostUrl" select="concat(/root/gui/env/server/protocol, '://', /root/gui/env/server/host, ':', /root/gui/env/server/port)"/>
	<xsl:variable name="baseUrl" select="/root/gui/url" />
	<xsl:variable name="serviceUrl" select="concat($hostUrl, /root/gui/locService)" />
	<xsl:variable name="rssUrl" select="concat($serviceUrl, '/rss.search?sortBy=changeDate')" />
	<xsl:variable name="siteName" select="/root/gui/env/site/name"/>
	
	<!-- main page -->
	<xsl:template match="/">
    <html class="no-js">
           <xsl:attribute name="lang">
                <xsl:value-of select="/root/gui/language" />
            </xsl:attribute>
    
			<head>
				<meta http-equiv="Content-type" content="text/html;charset=UTF-8"></meta>
				<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1"></meta>
				<title><xsl:value-of select="$siteName" /></title>
				<meta name="description" content="" ></meta>
                <meta name="viewport" content="width=device-width"></meta>
				<meta name="og:title" content="{$siteName}"/>
				
				<link rel="icon" type="image/gif" href="../../images/logos/favicon.png" />
				<link rel="alternate" type="application/rss+xml" title="{$siteName} - RSS" href="{$rssUrl}"/>
				<link rel="search" href="{$serviceUrl}/portal.opensearch" type="application/opensearchdescription+xml" 
					title="{$siteName}"/>
				

                <!--  CSS for OL -->
                <link rel="stylesheet" type="text/css">
                    <xsl:attribute name="href"><xsl:value-of
                        select="$baseUrl" />/apps/js/OpenLayers/theme/default/style.css</xsl:attribute>
                </link>
                
				<!-- CSS for Ext -->
				<link rel="stylesheet" type="text/css">
					<xsl:attribute name="href"><xsl:value-of
						select="$baseUrl" />/apps/js/ext/resources/css/ext-all.css</xsl:attribute>
				</link>
				<link rel="stylesheet" type="text/css">
					<xsl:attribute name="href"><xsl:value-of
						select="$baseUrl" />/apps/js/ext/resources/css/xtheme-gray.css</xsl:attribute>
				</link>

				<link rel="stylesheet" type="text/css">
					<xsl:attribute name="href"><xsl:value-of
						select="$baseUrl" />/apps/js/ext-ux/Rating/rating.css</xsl:attribute>
				</link>
				<link rel="stylesheet" type="text/css">
					<xsl:attribute name="href"><xsl:value-of
						select="$baseUrl" />/apps/js/ext-ux/SuperBoxSelect/superboxselect.css</xsl:attribute>
				</link>
				<link rel="stylesheet" type="text/css">
					<xsl:attribute name="href"><xsl:value-of
						select="$baseUrl" />/apps/js/ext-ux/LightBox/lightbox.css</xsl:attribute>
				</link>
				<link rel="stylesheet" type="text/css">
					<xsl:attribute name="href"><xsl:value-of
						select="$baseUrl" />/apps/js/ext-ux/FileUploadField/file-upload.css</xsl:attribute>
				</link>
				<link rel="stylesheet" type="text/css">
					<xsl:attribute name="href"><xsl:value-of
						select="$baseUrl" />/apps/js/ext-ux/MultiselectItemSelector-3.0/Multiselect.css</xsl:attribute>
				</link>


				<link rel="stylesheet">
					<xsl:attribute name="href"><xsl:value-of
						select="$baseUrl" />/apps/html5ui/css/normalize.min.css</xsl:attribute>
				</link>
				<link rel="stylesheet">
                    <xsl:attribute name="href"><xsl:value-of
                        select="$baseUrl" />/apps/html5ui/css/ec.css</xsl:attribute>
                </link>
				<link rel="stylesheet">
                    <xsl:attribute name="href"><xsl:value-of
                        select="$baseUrl" />/apps/html5ui/css/main_ec.css</xsl:attribute>
                </link>
                <link rel="stylesheet">
                    <xsl:attribute name="href"><xsl:value-of
                        select="$baseUrl" />/apps/html5ui/css/ec-content.css</xsl:attribute>
                </link>
                <link rel="stylesheet">
                    <xsl:attribute name="href"><xsl:value-of
                        select="$baseUrl" />/apps/html5ui/css/colors.css</xsl:attribute>
                </link>
				<link rel="stylesheet">
					<xsl:attribute name="href"><xsl:value-of
						select="$baseUrl" />/apps/html5ui/css/gnmetadatadefault.css</xsl:attribute>
				</link>
				<link rel="stylesheet">
					<xsl:attribute name="href"><xsl:value-of
						select="$baseUrl" />/apps/html5ui/css/gnmetadataview.css</xsl:attribute>
				</link>
				<link rel="stylesheet">
					<xsl:attribute name="href"><xsl:value-of
						select="$baseUrl" />/apps/html5ui/font-awesome/css/font-awesome.css</xsl:attribute>
				</link>



				<!--[if lt IE 7]> <link rel="stylesheet"> <xsl:attribute name="href"><xsl:value-of 
					select="$baseUrl" />/apps/html5ui/css/ltie7.css"/></xsl:attribute> </link> <![endif] -->

				<script type="text/javascript">
					<xsl:attribute name="src"><xsl:value-of
						select="$baseUrl" />/apps/js/ext/adapter/ext/ext-base.js</xsl:attribute>
				</script>

				<script type="text/javascript">
					<xsl:attribute name="src"><xsl:value-of
						select="$baseUrl" />/apps/js/ext/ext-all.js</xsl:attribute>
				</script>

				<script type="text/javascript">
					<xsl:attribute name="src"><xsl:value-of
						select="$baseUrl" />/apps/html5ui/js/vendor/modernizr-2.6.1-respond-1.1.0.min.js</xsl:attribute>
				</script>
				<script type="text/javascript">
					<xsl:attribute name="src"><xsl:value-of
						select="$baseUrl" />/apps/html5ui/js/ec.js</xsl:attribute>
				</script>

			</head>
			<body class="euShortContent">
				<div class="layout" id="cookie-warning" style="display: none;" >
					<div id="cookie-container">
						<p id="cookie-warning-caption">Cookies</p>
						<p id="cookie-warning-message">This site uses cookies to offer you a better browsing experience.</p>
						
		                <div id="accept-cookies" onclick="acceptCookies()">
		                    <span class="button">I accept cookies</span>
		                </div>
		                <div id="refuse-cookies" onclick="refuseCookies()">
		                    <span class="button">I refuse cookies</span>
		                </div>
	                </div>
				</div>
				<div class="layout" id="layout">
					<div class="lang-en" id="header">
						  <p class="banner-flag">
						  <img alt="European Commission logo" id="banner-flag">
						  <xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/html5ui/images/logo_en.gif</xsl:attribute>
						  </img>
						  </p>
 	          			  <p id="banner-title-text" style="color:#0065A2">INSPIRE@EC Portal</p>
			               <span id="banner-image-right"></span><span class="title-en" id="banner-image-title"></span><p class="off-screen">Service tools</p>
							<ul class="reset-list" id="services">
								<li>
									<a id="browse-tab" class="selected" href="javascript:showBrowse();">
										<xsl:value-of select="/root/gui/strings/home" />
									</a>
								</li>
								<xsl:if test="string(/root/gui/session/userId)!=''">
									<li>
										<a id="catalog-tab" href="javascript:showSearch();">
											<xsl:value-of select="/root/gui/strings/porCatInfoTab" />
										</a>
									</li>
									<li>
										<a id="map-tab" href="javascript:showBigMap();">
											<xsl:value-of select="/root/gui/strings/map_label" />
										</a>
									</li>
								</xsl:if>
								<li>
									<a id="about-tab" href="javascript:showAbout();">
										<xsl:value-of select="/root/gui/strings/about" />
									</a>
								</li>
				               <li>
					               <a id="legal-tab" href="javascript:showLegal();">
										<xsl:value-of select="/root/gui/strings/legal" />
					               </a>
				               </li>
				               <li>
					               <a id="contact-tab" href="javascript:showContact();">
										<xsl:value-of select="/root/gui/strings/contact" />
					               </a>
				               </li>
				               <li>
					               <span id="login-stuff" style="display:none;">
									<a id="user-button">
										<xsl:choose>
											<xsl:when test="string(/root/gui/session/userId)=''">
										  	<xsl:attribute name="href"><xsl:value-of select="$baseUrl" />/login</xsl:attribute>
										 	</xsl:when>
											<xsl:otherwise>
										  	<xsl:attribute name="href">javascript:app.loginApp.logout();</xsl:attribute>
										 	</xsl:otherwise>
									  </xsl:choose>
										<i class="fa fa-user"></i>
										<span id="user-button_label">
											<xsl:choose>
												<xsl:when test="string(/root/gui/session/userId)=''">
													<xsl:value-of select="/root/gui/strings/signIn"/>
										 		</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="/root/gui/strings/signOut"/>
										 		</xsl:otherwise>
									  	</xsl:choose>
										</span>
									</a>
									<label id="username_label">
										<xsl:if test="string(/root/gui/session/userId)!=''">
											<xsl:value-of select="concat(' - ',/root/gui/session/name,' ')"/>
										</xsl:if>
									</label>
									<label id="name_label">
										<xsl:if test="string(/root/gui/session/userId)!=''">
											<xsl:value-of select="concat(/root/gui/session/surname,' ')"/>
										</xsl:if>
									</label>
									<label id="profile_label">
										<xsl:if test="string(/root/gui/session/userId)!=''">
											<xsl:value-of select="concat('(',/root/gui/session/profile,') ')"/>	
										</xsl:if>
									</label>
<!-- 									<xsl:if test="string(/root/gui/session/profile)='Administrator'"> -->
										<a href="javascript:catalogue.admin();" id="administration-button">
	 										<xsl:if test="string(/root/gui/session/userId)=''">
	 											<xsl:attribute name="style">display:none;</xsl:attribute>
											</xsl:if>
											<i class="fa fa-wrench"></i>
											<xsl:value-of select="/root/gui/strings/admin"/>
										</a>
<!-- 									</xsl:if> -->
									
									
									<!-- The following login section is not used but is references in LoginApp.js -->
									<!-- Do not remove before changing LoginApp.js -->
									<script>function false_(){ return false; }</script>
									<form id="login-form" style="display:none;" onsubmit="return false_();">
										<div id="login_div" style="display:none;" >
											<label>User name:</label>
											<input type="text" id="username" name="username"/><br/>
											<label>Password: </label>
											<input type="password" id="password" name="password"/><br/>
											<input type="submit" id="login_button" value="Login"/>
								  		</div>
									</form>
					 			 </span>
					 			</li>
				            </ul>
				            
				            
						             <p class="off-screen mob-title" id="language-selector-title">Language selector</p>


<!-- 						                       <a class="reset-list language-selector-title" href="javascript:toggle('lang-form');"><span id="current-lang">English</span>&#160;<i class="fa fa-angle-double-down"></i>
													<div id="lang-form" style="display:none;"> </div>
												</a>
 -->
				
					
					
					
<!-- 							<a class="reset-list language-selector" href="javascript:toggle('lang-form');"><span id="current-lang">English</span>&#160;<i class="fa fa-angle-double-down"></i> -->
<!-- 								<div id="lang-form" style="display:none;"> </div> -->
<!-- 							</a> -->
					
					</div>		
					
					 <div id="page-container">
            			<div id="container"><a class="off-screen" id="content" name="content"></a><p class="off-screen">Additional tools</p>
							<ul class="reset-list" id="additional-tools">
			                  <li><a href="javascript:window.print();" id="printer-button"><img alt="Print version" src="/geonetwork/apps/html5ui/images/print.gif"></img></a></li>
			                  <li><a href="javascript:tools.fonts.decrease();" title="Decrease text"><img alt="smaller font" id="small font" src="/geonetwork/apps/html5ui/images/font-decrease.gif"></img></a></li>
			                  <li><a href="javascript:tools.fonts.increase();" title="Increase text"><img alt="smaller font" id="small font" src="/geonetwork/apps/html5ui/images/font-increase.gif"></img></a></li>
			                  <li>
			                     <div id="share-tool"><script type="text/javascript">if(typeof iBeginShare == "object"){iBeginShare.attachLink('share-tool');}</script></div>
			                  </li>
<!-- 			                  <li><a id="rss-button" href="/geonetwork/srv/eng/rss.latest"><img alt="smaller font" id="rss" src="/geonetwork/apps/html5ui/images/buttonRSS.gif"></img></a></li>
 -->			               </ul>
			               
			               <div id="path">
			                  <p class="off-screen">Navigation path</p>
			                  <ul class="reset-list"  style="margin-right:80px">
			                     <div id="bread-crumb-app"></div>
			                  </ul>
			               </div>
<!-- 			               <h1><span style="padding:15px">INSPIRE@EC Portal</span></h1> -->
			               <div id="main">
			               			        <div id="copy-clipboard-ie"></div>
		                       <div id="share-capabilities" style="display:none">
		                            <a id="custom-tweet-button" href="javascript:void(0);" target="_blank">
		                                    <xsl:value-of select="/root/gui/strings/tweet" />
		                            </a>
		                            <div id="fb-button">
		                           </div>
		                       </div>
<!-- 		                       <div id="permalink-div" style="display:none"></div> -->
		                        <div id="bread-crumb-app"></div>
		                        <div id="search-form" style="display: none;">
		                            <fieldset id="search-form-fieldset">
		                            <div id="search-form-top">
		                                <legend id="legend-search">
		                                    <xsl:value-of select="/root/gui/strings/search" />
		                                </legend>
		                                <span id='fullTextField'></span>
		                                <input type="button"
		                                    onclick="Ext.getCmp('advanced-search-options-content-form').fireEvent('search');Ext.getCmp('popupminiMap').show();"
		                                    onmouseover="Ext.get(this).addClass('hover');"
		                                    onmouseout="Ext.get(this).removeClass('hover');"
		                                    id="search-submit" class="form-submit" value="&#xf002;">
		                                </input>
		                                <input type="button"
		                                    onclick="Ext.getCmp('advanced-search-options-content-form').fireEvent('reset');"
		                                    onmouseover="Ext.get(this).addClass('hover');"
		                                    onmouseout="Ext.get(this).removeClass('hover');"
		                                    id="reset-search-submit" class="form-submit" value="&#xf00d;">
		                                </input>
		                                <div class="form-dummy">
		                                    <span><xsl:value-of select="/root/gui/strings/dummySearch" /></span>
			                                <div id="ck1"/>
			                                <div id="ck2"/>
			                                <div id="ck3"/>
		                                </div>
		                                <div id="show-advanced" onclick="showAdvancedSearch()">
		                                    <span class="button"><xsl:value-of select="/root/gui/strings/advancedOptions.show" />&#160;<i class="fa fa-angle-double-down fa-2x show-advanced-icon"></i></span>
		                                </div>
		                                <div id="hide-advanced" onclick="hideAdvancedSearch(true)" style="display: none;">
		                                    <span class="button"><xsl:value-of select="/root/gui/strings/advancedOptions.hide" />&#160;<i class="fa fa-angle-double-up fa-2x hide-advanced-icon"></i></span>
		                                </div>
									</div>
	                                <div id="advanced-search-options" >
	                                    <div id="advanced-search-options-content"></div>
	       		                        <div id="advanced-search-options-buttom-line" style="height: 10px; padding-left: 15px; padding-right: 15px; border-bottom:2px solid #69c"/>
	                                </div>
		                            </fieldset>
		                        </div>
							
		
			                    <div id="browser">
			                     <div id="welcome-text">
			                      	  <xsl:copy-of select="/root/gui/strings/welcome.text"/>
			                      	  <xsl:if test="string(/root/gui/session/userId)!='' and string(/root/gui/session/profile)='Guest'">
			                      	  	<xsl:copy-of select="/root/gui/strings/guestinformation.text"/>
			                      	  </xsl:if>
								</div>
                    	  <xsl:if test="string(/root/gui/session/userId)!=''">
		                        <aside class="tag-aside">
<!-- 			                    	  <div id="welcome-text"> -->
<!-- 			                      		  <xsl:copy-of select="/root/gui/strings/welcome.text"/> -->
<!-- 									  </div> -->
		                          <div id="tags">
		                            <header><h1><span><xsl:value-of select="/root/gui/strings/tag_label" /></span></h1></header>
		                            <div id="cloud-tag"></div>
		                          </div>
		                        </aside>
		                        <article class="main-article">
		                          <div>
		                            <section>
		                              <div id="featured-metadata">
		                                <header><h1><span><xsl:value-of select="/root/gui/strings/featuredDatasets" /></span></h1></header>
		                              </div>
		                              <br/>
		                              <div id="my-metadata">
		                                <header><h1><span><xsl:value-of select="/root/gui/strings/myDatasets" /></span></h1></header>
		                              </div>
		                              <br/>
		                              <div id="popular-metadata">
		                                <header><h1><span><xsl:value-of select="/root/gui/strings/popularDatasets" /></span></h1></header>
		                              </div>
		                              <br/>
		                              <div id="latest-metadata">
		                                <header><h1><span><xsl:value-of select="/root/gui/strings/latestDatasets" /></span></h1></header>
		                              </div>
		                            </section>
		                          </div>
		                        </article>
                      	  </xsl:if>
		                      </div>
			                    <div id="about" style="display:none;">
			                    	<div id="about-text">			                    	
			                      	<xsl:copy-of select="/root/gui/strings/about.text"/>
		                        </div>
		                      </div>
			                    <div id="legal" style="display:none;">
			                    	<div id="legal-text">
			                      		<xsl:copy-of select="/root/gui/strings/legal.text"/>
		                        	</div>
		                      	</div>
			                    <div id="contact" style="display:none;">
			                    	<div id="contact-text">
			                      		<xsl:copy-of select="/root/gui/strings/contact.text"/>
		                        	</div>
		                      </div>
			                    
								<div id="big-map-container" style="display:none;"/>
		                       <div id="permalink-div" style="display:none"/>
		                       <div id="metadata-info" style="display:none;"/>
								<div id="search-container" class="main wrapper clearfix">
									<div id="bread-crumb-div"></div>
		
									<aside id="main-aside" class="main-aside" style="display:none;">
											<header><xsl:value-of select="/root/gui/strings/filter" /></header> 
 											<div id="facets-panel-div"></div>
		  			         	 	      	<div id="mini-map"></div>
										</aside>
									<article>
										
										<header>
										</header>
										<section>
											<div id="result-panel"></div>
										</section>
										<footer>
										</footer>
									</article>
								</div>
								<!-- .main .wrapper .clearfix -->
			               
			               
			               
			               
			               
			               </div>
			               
					
						</div>
					</div>
			</div>
					
					
					
					
				<!-- klip herfra -->	
					
<!-- 					<a href="javascript:window.print();" id="printer-button"><i class="fa fa-print"></i><xsl:value-of select="/root/gui/strings/print-button"/></a> -->
<!-- 					<a id="rss-button" href="/geonetwork/srv/eng/rss.latest"><i class="fa fa-rss-square"></i><xsl:value-of select="/root/gui/strings/rss-button"/></a> -->
<!-- 					<span id="login-stuff"> -->
<!-- 						<a id="user-button"> -->
<!-- 							<xsl:choose> -->
<!-- 								<xsl:when test="string(/root/gui/session/userId)=''"> -->
<!-- 							  	<xsl:attribute name="href"><xsl:value-of select="$baseUrl" />/login</xsl:attribute> -->
<!-- 							 	</xsl:when> -->
<!-- 								<xsl:otherwise> -->
<!-- 							  	<xsl:attribute name="href">javascript:app.loginApp.logout();</xsl:attribute> -->
<!-- 							 	</xsl:otherwise> -->
<!-- 						  </xsl:choose> -->
<!-- 							<i class="fa fa-user"></i> -->
<!-- 							<span id="user-button_label"> -->
<!-- 								<xsl:choose> -->
<!-- 									<xsl:when test="string(/root/gui/session/userId)=''"> -->
<!-- 										<xsl:value-of select="/root/gui/strings/signIn"/> -->
<!-- 							 		</xsl:when> -->
<!-- 									<xsl:otherwise> -->
<!-- 										<xsl:value-of select="/root/gui/strings/signOut"/> -->
<!-- 							 		</xsl:otherwise> -->
<!-- 						  	</xsl:choose> -->
<!-- 							</span> -->
<!-- 						</a> -->
<!-- 						<label id="username_label"> -->
<!-- 							<xsl:if test="string(/root/gui/session/userId)!=''"> -->
<!-- 								<xsl:value-of select="concat(/root/gui/session/name,' ')"/> -->
<!-- 							</xsl:if> -->
<!-- 						</label> -->
<!-- 						<label id="name_label"> -->
<!-- 							<xsl:if test="string(/root/gui/session/userId)!=''"> -->
<!-- 								<xsl:value-of select="concat(/root/gui/session/surname,' ')"/> -->
<!-- 							</xsl:if> -->
<!-- 						</label> -->
<!-- 						<label id="profile_label"> -->
<!-- 							<xsl:if test="string(/root/gui/session/userId)!=''"> -->
<!-- 								<xsl:value-of select="concat('(',/root/gui/session/profile,')')"/>	 -->
<!-- 							</xsl:if> -->
<!-- 						</label> -->
<!-- 						<a href="javascript:catalogue.admin();" id="administration-button"> -->
<!-- 							<xsl:if test="string(/root/gui/session/userId)=''"> -->
<!-- 								<xsl:attribute name="style">display:none;</xsl:attribute> -->
<!-- 							</xsl:if> -->
<!-- 							<i class="fa fa-wrench"></i> -->
<!-- 							<xsl:value-of select="/root/gui/strings/admin"/> -->
<!-- 						</a> -->
<!-- 						<script>function false_(){ return false; }</script> -->
<!-- 						<form id="login-form" style="display: none;" onsubmit="return false_();"> -->
<!-- 							<div id="login_div"> -->
<!-- 								<label>User name:</label> -->
<!-- 								<input type="text" id="username" name="username"/><br/> -->
<!-- 								<label>Password: </label> -->
<!-- 								<input type="password" id="password" name="password"/><br/> -->
<!-- 								<input type="submit" id="login_button" value="Login"/> -->
<!-- 					  	</div> -->
<!-- 						</form> -->
<!-- 				  </span> -->
					<!-- from here on, all elements are floated to the right so 
					     they are in reverse order -->
<!-- 					<a id="help-button" target="_blank" href="/geonetwork/docs/eng/users"> -->
<!-- 						<i class="fa fa-question-circle"></i><xsl:value-of select="/root/gui/strings/help"/> -->
<!-- 					</a> -->
<!-- 					<a id="lang-button" href="javascript:toggle('lang-form');"> -->
<!--             <xsl:for-each select="/root/gui/config/languages/*"> -->
<!--               <xsl:variable name="lang" select="name(.)"/> -->
<!--               <xsl:if test="/root/gui/language=$lang"> -->
<!--                 <span id="current-lang"><xsl:value-of select="/root/gui/strings/*[name(.)=$lang]"/></span>&#160;<i class="fa fa-angle-double-down"></i> -->
<!--               </xsl:if> -->
<!--             </xsl:for-each> -->
<!-- 						<div id="lang-form" style="display:none;"></div> -->
<!--           </a> -->
<!-- 			</div> -->
			
			
			
			

				
<!--     		  <div id="page-container">   -->
<!-- 				<div id="container"> -->
<!-- 					<a class="off-screen" id="content" name="content"></a><p class="off-screen">Additional tools</p> -->
<!-- 	                <ul class="reset-list" id="additional-tools"> -->
<!-- 	                  <li><a href="javascript:window.print();" id="printer-button"><img alt="Print version" src="/geonetwork/apps/html5ui/images/print.gif"></img></a></li> -->
<!-- 	                  <li><a href="javascript:tools.fonts.decrease();" title="Decrease text"><img alt="smaller font" id="small font" src="/geonetwork/apps/html5ui/images/font-decrease.gif"></img></a></li> -->
<!-- 	                  <li><a href="javascript:tools.fonts.increase();" title="Increase text"><img alt="smaller font" id="small font" src="/geonetwork/apps/html5ui/images/font-increase.gif"></img></a></li> -->
<!-- 	                  <li> -->
<!-- 	                     <div id="share-tool"><script type="text/javascript">if(typeof iBeginShare == "object"){iBeginShare.attachLink('share-tool');}</script></div> -->
<!-- 	                  </li> -->
<!-- 	                  <li><a id="rss-button" href="/geonetwork/srv/eng/rss.latest"><img alt="smaller font" id="rss" src="/geonetwork/apps/html5ui/images/buttonRSS.gif"></img></a></li> -->
<!-- 	                </ul> -->
<!-- 					<div id="header"> -->
<!-- 					  <div id="logo"></div> -->
<!-- 						<header class="wrapper clearfix"> -->
<!-- 							<div style="width: 100%; margin: 0 auto;"> -->
<!-- 								<nav id="nav"> -->
<!-- 									<ul id="main-navigation"> -->
<!-- 										<li> -->
<!-- 											<a id="browse-tab" class="selected" href="javascript:showBrowse();"> -->
<!-- 												<xsl:value-of select="/root/gui/strings/home" /> -->
<!-- 											</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a id="catalog-tab" href="javascript:showSearch();"> -->
<!-- 												<xsl:value-of select="/root/gui/strings/porCatInfoTab" /> -->
<!-- 											</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a id="map-tab" href="javascript:showBigMap();"> -->
<!-- 												<xsl:value-of select="/root/gui/strings/map_label" /> -->
<!-- 											</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a id="about-tab" href="javascript:showAbout();"> -->
<!-- 												<xsl:value-of select="/root/gui/strings/about" /> -->
<!-- 											</a> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</nav> -->
<!-- 							</div> -->
<!-- 						</header> -->
<!-- 					</div> -->
					
<!-- 					<div id="main"> -->
<!-- 			        <div id="copy-clipboard-ie"></div> -->
<!--                        <div id="share-capabilities" style="display:none"> -->
<!--                             <a id="custom-tweet-button" href="javascript:void(0);" target="_blank"> -->
<!--                                     <xsl:value-of select="/root/gui/strings/tweet" /> -->
<!--                             </a> -->
<!--                             <div id="fb-button"> -->
<!--                            </div> -->
<!--                        </div> -->
<!--                        <div id="permalink-div" style="display:none"></div> -->
<!--                         <div id="bread-crumb-app"></div> -->
<!--                         <div id="search-form" style="display:none;"> -->
<!--                             <fieldset id="search-form-fieldset"> -->
<!--                                 <legend id="legend-search"> -->
<!--                                     <xsl:value-of select="/root/gui/strings/search" /> -->
<!--                                 </legend> -->
<!--                                 <span id='fullTextField'></span> -->
<!--                                 <input type="button" -->
<!--                                     onclick="Ext.getCmp('advanced-search-options-content-form').fireEvent('search');" -->
<!--                                     onmouseover="Ext.get(this).addClass('hover');" -->
<!--                                     onmouseout="Ext.get(this).removeClass('hover');" -->
<!--                                     id="search-submit" class="form-submit" value="&#xf002;"> -->
<!--                                 </input> -->
<!--                                 <div class="form-dummy"> -->
<!--                                     <span><xsl:value-of select="/root/gui/strings/dummySearch" /></span> -->
<!-- 	                                <div id="ck1"/> -->
<!-- 	                                <div id="ck2"/> -->
<!-- 	                                <div id="ck3"/> -->
<!--                                 </div> -->
                                
<!--                                 <div id="show-advanced" onclick="showAdvancedSearch()"> -->
<!--                                     <span class="button"><xsl:value-of select="/root/gui/strings/advancedOptions.show" />&#160;<i class="fa fa-angle-double-down fa-2x show-advanced-icon"></i></span> -->
<!--                                 </div> -->
<!--                                 <div id="hide-advanced" onclick="hideAdvancedSearch(true)" style="display: none;"> -->
<!--                                     <span class="button"><xsl:value-of select="/root/gui/strings/advancedOptions.hide" />&#160;<i class="fa fa-angle-double-up fa-2x hide-advanced-icon"></i></span> -->
<!--                                 </div> -->
<!--                                 <div id="advanced-search-options" > -->
<!--                                     <div id="advanced-search-options-content"></div> -->
<!--                                 </div> -->
<!--                             </fieldset> -->
<!--                         </div> -->
					

<!-- 	                    <div id="browser"> -->
<!--                         <aside class="tag-aside"> -->
<!-- 	                    	  <div id="welcome-text"> -->
<!-- 	                      	  <xsl:copy-of select="/root/gui/strings/welcome.text"/> -->
<!-- 												  </div> -->
<!--                           <div id="tags"> -->
<!--                             <header><h1><span><xsl:value-of select="/root/gui/strings/tag_label" /></span></h1></header> -->
<!--                             <div id="cloud-tag"></div> -->
<!--                           </div> -->
<!--                         </aside> -->
<!--                         <article> -->
<!--                           <div> -->
<!--                             <section> -->
<!--                               <div id="latest-metadata"> -->
<!--                                 <header><h1><span><xsl:value-of select="/root/gui/strings/latestDatasets" /></span></h1></header> -->
<!--                               </div> -->
<!--                               <div id="popular-metadata"> -->
<!--                                 <header><h1><span><xsl:value-of select="/root/gui/strings/popularDatasets" /></span></h1></header> -->
<!--                               </div> -->
<!--                             </section> -->
<!--                           </div> -->
<!--                         </article> -->
<!--                       </div> -->

<!-- 	                    <div id="about" style="display:none;"> -->
<!-- 	                    	<div id="about-text"> -->
<!-- 	                      	<xsl:copy-of select="/root/gui/strings/about.text"/> -->
<!--                         </div> -->
<!--                       </div> -->
	                    
<!-- 						<div id="big-map-container" style="display:none;"/> -->
<!--                        <div id="metadata-info" style="display:none;"/> -->
<!-- 						<div id="search-container" class="main wrapper clearfix"> -->
<!-- 							<div id="bread-crumb-div"></div> -->

<!-- 							<aside id="main-aside" class="main-aside" style="display:none;"> -->
<!-- 								<header><xsl:value-of select="/root/gui/strings/filter" /></header> -->
<!-- 								<div id="facets-panel-div"></div> -->
<!-- 							</aside> -->
<!-- 							<article> -->
<!-- 								<aside id="secondary-aside" class="secondary-aside" style="display:none;"> -->
<!-- 									<header><xsl:value-of select="/root/gui/strings/recentlyViewed" /></header> -->
<!--                   <div id="recent-viewed-div"></div> -->
<!--                   <div id="mini-map"></div> -->
<!-- 								</aside> -->
<!-- 								<header> -->
<!-- 								</header> -->
<!-- 								<section> -->
<!-- 									<div id="result-panel"></div> -->
<!-- 								</section> -->
<!-- 								<footer> -->
<!-- 								</footer> -->
<!-- 							</article> -->
<!-- 						</div> -->
<!-- 						.main .wrapper .clearfix -->
<!-- 					</div> -->



					<div id="only_for_spiders">
						<xsl:for-each select="/root/*/record">
							<article>
								<xsl:attribute name="id"><xsl:value-of
									select="uuid" /></xsl:attribute>
								<xsl:apply-templates mode="elementEP"
									select="/root/*[name(.)!='gui' and name(.)!='request']">
									<xsl:with-param name="edit" select="false()" />
									<xsl:with-param name="uuid" select="uuid" />
								</xsl:apply-templates>
							</article>
						</xsl:for-each>
					</div>
					
					<div class="layout-footer" id="EC-footer">
	                  <ul class="footer-items">
	                     <li class="modification-date"><span>Last update: 21/4/2015</span></li>
	                     <li><a href="#">Top</a></li>
	                     <li><a id="browse-tab" class="selected" href="javascript:showBrowse();">Home</a></li>
						 <xsl:if test="string(/root/gui/session/userId)!=''">
		                     <li><a id="catalog-tab" href="javascript:showSearch();"><xsl:value-of select="/root/gui/strings/porCatInfoTab" /></a></li>
		                     <li><a id="map-tab" href="javascript:showBigMap();"><xsl:value-of select="/root/gui/strings/map_label" /></a></li>
	                     </xsl:if>
	                     <li>
	                     	<a id="about-tab" href="javascript:showAbout();">
								<xsl:value-of select="/root/gui/strings/about" />
							</a>
	                     </li>
	                     <li>
	                     	<a id="legal-tab" href="javascript:showLegal();">
								<xsl:value-of select="/root/gui/strings/legal" />
							</a>
						</li>
	                     <li><a id="contact-tab" href="javascript:showContact();">
								<xsl:value-of select="/root/gui/strings/contact" />
							</a>
	                     </li>
	                  </ul>
	               </div>
					

<!-- 					<div id="footer"> -->
<!--             <xsl:if test="/root/gui/config/html5ui-footer!='true'"> -->
<!--               <xsl:attribute name="style">display:none;</xsl:attribute> -->
<!--             </xsl:if> -->
<!-- 						<footer class="wrapper"> -->
<!-- 							<ul> -->
<!-- 								<li style="float:left"> -->
<!-- 									<xsl:value-of select="/root/gui/strings/poweredBy"/>  -->
<!-- 									<a href="http://geonetwork-opensource.org/">GeoNetwork OpenSource</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!--                                     <a href="http://www.gnu.org/copyleft/gpl.html">GPL</a> -->
<!-- 								</li> -->
<!-- 							</ul> -->
<!-- 						</footer> -->
<!-- 					</div> -->
<!-- 				</div> -->

				<input type="hidden" id="x-history-field" />
				<iframe id="x-history-frame" height="0" width="0"></iframe>

                 <xsl:choose>
                     <xsl:when test="/root/gui/config/map/osm_map = 'true'">
                         <script>
                             var useOSMLayers = true;
                         </script>
                     </xsl:when>

                     <xsl:otherwise>
                         <script>
                             var useOSMLayers = false;
                         </script>
                     </xsl:otherwise>
                 </xsl:choose>

<!--   				<xsl:choose> -->
<!-- 					<xsl:when test="/root/request/debug"> -->
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/ext-ux/Rating/RatingItem.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/ext-ux/FileUploadField/FileUploadField.js</xsl:attribute>
						</script>
						
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/ext-ux/TwinTriggerComboBox/TwinTriggerComboBox.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/ext-ux/DateTime/DateTime.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/ext-ux/RowExpander/RowExpander.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/ext-ux/MultiselectItemSelector-3.0/DDView.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/ext-ux/MultiselectItemSelector-3.0/Multiselect.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/ext-ux/SuperBoxSelect/SuperBoxSelect.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/ext-ux/LightBox/lightbox.js</xsl:attribute>
						</script>
						
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/proj4js-compressed.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/OpenLayers/lib/OpenLayers.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/GeoExt/lib/overrides/override-ext-ajax.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/GeoExt/lib/GeoExt.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/GeoExt-ux/LayerOpacitySliderPlugin/LayerOpacitySliderPlugin.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/GeoExt-ux/TabCloseMenu/TabCloseMenu.js</xsl:attribute>
						</script>
						
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/js/GeoNetwork/lib/GeoNetwork.js</xsl:attribute>
						</script>
						
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/html5ui/js/GlobalFunctions.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/html5ui/js/Settings.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/html5ui/js/Templates.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/html5ui/js/Shortcuts.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/html5ui/js/map/Settings.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/html5ui/js/map/MapApp.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/html5ui/js/search/SearchApp.js</xsl:attribute>
						</script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/html5ui/js/user/LoginApp.js</xsl:attribute>
						</script>
                        <script type="text/javascript">
                            <xsl:attribute name="src"><xsl:value-of
                                select="$baseUrl" />/apps/html5ui/js/state/PermalinkProvider.js</xsl:attribute>
                        </script>
                        <script type="text/javascript">
                            <xsl:attribute name="src"><xsl:value-of
                                select="$baseUrl" />/apps/html5ui/js/state/History.js</xsl:attribute>
                        </script>
						<script type="text/javascript">
							<xsl:attribute name="src"><xsl:value-of
								select="$baseUrl" />/apps/html5ui/js/BreadCrumb.js</xsl:attribute>
                        </script>
                        <script type="text/javascript">
                            <xsl:attribute name="src"><xsl:value-of
                                select="$baseUrl" />/apps/js/GeoNetwork/lib/GeoNetwork/map/windows/AddWMTS.js</xsl:attribute>
                        </script>
                        <script type="text/javascript">
                            <xsl:attribute name="src"><xsl:value-of
                                select="$baseUrl" />/apps/js/GeoNetwork/lib/GeoNetwork/map/widgets/tree/WMTSTreeGenerator.js</xsl:attribute>
                        </script>
                        <script type="text/javascript">
                            <xsl:attribute name="src"><xsl:value-of
                                select="$baseUrl" />/apps/html5ui/js/App.js</xsl:attribute>
						</script>
						
<!--  					</xsl:when> -->
<!-- 					<xsl:otherwise> -->
<!-- 						<script type="text/javascript" src="{concat($baseUrl, '/apps/html5ui/js/App-mini.js')}"></script> -->
<!-- 						<script type="text/javascript" src="{concat($baseUrl, '/apps/html5ui/js/GlobalFunctions.js')}"></script> -->
<!-- 					</xsl:otherwise> -->
<!-- 				</xsl:choose> -->



<!--             </div> -->
	
	
	
		</body>
	</html>
	</xsl:template>
</xsl:stylesheet>

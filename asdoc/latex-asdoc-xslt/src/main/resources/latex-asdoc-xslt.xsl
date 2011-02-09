<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://saxon.sf.net/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ifn="urn:internal:functions" version="2.0" exclude-result-prefixes="saxon xs ifn">
	<xsl:character-map name="disable">
		<xsl:output-character character="&amp;" string="&amp;"/>
		<xsl:output-character character="&lt;" string="&lt;"/>
		<xsl:output-character character="&gt;" string="&gt;"/>
		<xsl:output-character character="&#145;" string="&amp;lsquo;"/>
		<xsl:output-character character="&#146;" string="&amp;apos;"/>
		<xsl:output-character character="&#151;" string="&amp;mdash;"/>
		<xsl:output-character character="&#x2014;" string="&amp;mdash;"/>
		<xsl:output-character character="&#x2009;" string="&amp;thinsp;"/>
		<xsl:output-character character="&#xAE;" string="&amp;reg;"/>
		<xsl:output-character character="&#xB0;" string="&amp;deg;"/>
		<xsl:output-character character="&#x2122;" string="&amp;trade;"/>
	</xsl:character-map>
	<xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes" use-character-maps="disable" indent="no"/>
	<xsl:param name="page-header-left" select="'Freeform Systems'"/>
	<xsl:param name="page-header-right" select="''"/>
	<xsl:param name="title" select="''" />
	<xsl:param name="sub-title" select="''" />
	<xsl:param name="author" select="''" />
	<xsl:param name="date" select="''" />
	
	<xsl:param name="dita-dir" select="'tempdita'"/>
	<xsl:param name="delimiter" select="system-property('file.separator')"/>
	<xsl:param name="packages-map-path" select="concat($dita-dir,$delimiter,'packages.dita')"/>
	<xsl:param name="toplevel-path" select="'toplevel.xml'" />
	<xsl:param name="constants-xref-id" select="':constants'" />
	<xsl:param name="public-methods-xref-id" select="':public:methods'" />
	<xsl:param name="protected-methods-xref-id" select="':protected:methods'" />
	<xsl:param name="public-properties-xref-id" select="':public:properties'" />
	<xsl:param name="protected-properties-xref-id" select="':protected:properties'" />
	<xsl:param name="include-class-meta" select="false()" />
	<xsl:param name="link-report-path" select="''" />
	<xsl:param name="end-tag" select="'}'" />
	
	<xsl:variable name="packages" select="document($packages-map-path)" />
	<xsl:variable name="toplevel" select="document($toplevel-path)" />
	
	<xsl:variable name="start-verb" select="'\verb|'" />
	<xsl:variable name="end-verb" select="'|'" />
	
	<xsl:variable name="start-tt" select="'\texttt{'" />
	<xsl:variable name="end-tt" select="'}'" />
	
	<xsl:variable name="start-alltt" select="concat('\begin{alltt}',$newline)" />
	<xsl:variable name="end-alltt" select="concat($newline,'\end{alltt}')" />

	<xsl:variable name="newline">
		<xsl:text>
</xsl:text>
	</xsl:variable>
	<xsl:variable name="tab" select="'  '" />
	
	<xsl:template match="/">

		<xsl:call-template name="header" />
	
		<!--  PACKAGES-->
		<xsl:for-each select="$packages//apiItemRef">
			<xsl:sort select="substring-before(@href,'.xml')" />
			
			<!--  PACKAGE-->
			<xsl:variable name="package-path" select="concat($dita-dir,$delimiter,@href)" />
			<xsl:variable name="package" select="document($package-path)" />
			<xsl:variable name="package-id" select="$package/apiPackage/@id"/>
			<xsl:variable name="package-id-null" select="concat($package-id,'.null')"/>
			<xsl:variable name="package-interfaces" select="$toplevel//interfaceRec[@namespace = $package-id and @access != 'internal' and @access != 'private']"/>
			<xsl:variable name="package-classes" select="$toplevel//classRec[@namespace = $package-id and @access != 'internal' and @access != 'private']"/>
			
			<!-- LEFT HAND PAGE HEADER -->
			<xsl:text>\lhead{\scriptsize{\textsc{</xsl:text>
			<xsl:call-template name="xref">
				<xsl:with-param name="input" select="$package-id" />
			</xsl:call-template>
			<xsl:text>}}}</xsl:text>
			<xsl:value-of select="$newline" />
			<xsl:text>\rhead{}</xsl:text>
			
			<!-- PACKAGE PART DECLARATION -->
			<xsl:call-template name="part">
				<xsl:with-param name="title" select="$package-id"/>
				<xsl:with-param name="label" select="$package-id"/>
			</xsl:call-template>
			
			<!-- PACKAGE DESCRIPTION IF AVAILABLE -->
			<xsl:variable name="package-description" select="$toplevel//packageRec[@fullname = $package-id or @fullname = $package-id-null]" />
			<xsl:variable name="pkg-description" select="$package-description/description" />
			<xsl:variable name="pkg-description" select="replace($pkg-description,'^\s+','')" />
			<xsl:variable name="pkg-description" select="replace($pkg-description,'\s+$','')" />			
			
			<xsl:choose>
				<xsl:when test="$package-description">
					
					<xsl:value-of select="'\paragraph{'" />
					
					<!-- newline handling for package descriptions - nultiple paragraphs -->
					<xsl:if test="contains($pkg-description,$newline)">
						<xsl:variable name="pkg-description">
							<xsl:call-template name="sanitize">
								<xsl:with-param name="input" select="$pkg-description" />
							</xsl:call-template>							
						</xsl:variable>
						<xsl:call-template name="auto-xref">
							<xsl:with-param name="input" select="$pkg-description" />
						</xsl:call-template>
					</xsl:if>
					
					<!-- single paragraph -->
					<xsl:if test="not(contains($pkg-description,$newline))">
						<xsl:variable name="pkg-description">
							<xsl:call-template name="sanitize">
								<xsl:with-param name="input" select="$pkg-description" />
							</xsl:call-template>
						</xsl:variable>			
						<xsl:call-template name="auto-xref">
							<xsl:with-param name="input" select="$pkg-description" />
						</xsl:call-template>
					</xsl:if>
					
					<!-- end the package description paragraph -->
					<xsl:value-of select="'}'" />					
						
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="paragraph">
						<xsl:with-param name="text">
							<xsl:call-template name="missing">
								<xsl:with-param name="type" select="'package'" />
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- PACKAGE CLASS LISTING -->
			<xsl:if test="count($package-classes) &gt; 0">
				<xsl:call-template name="section">
					<xsl:with-param name="title" select="'Classes'" />
				</xsl:call-template>
				<xsl:call-template name="classifier-listing">
					<xsl:with-param name="input" select="$package-classes" />
				</xsl:call-template>
			</xsl:if>
			
			<!-- PACKAGE INTERFACE LISTING -->
			<xsl:if test="count($package-interfaces) &gt; 0">
				<xsl:call-template name="section">
					<xsl:with-param name="title" select="'Interfaces'" />
				</xsl:call-template>
				<xsl:call-template name="classifier-listing">
					<xsl:with-param name="input" select="$package-interfaces" />
				</xsl:call-template>
			</xsl:if>
			
			<!--  CLASS OR INTERFACE-->
			<xsl:for-each select="$package//apiClassifier">
				<xsl:sort select="apiName"/>
				
				<xsl:variable name="class-id" select="@id"/>
				<xsl:variable name="has-constants" select="count(apiValue/apiValueDetail/apiValueDef[not(apiProperty)]) &gt; 0"/>
				<xsl:variable name="constants" select="apiValue[not(apiValueDetail/apiValueDef/apiProperty)]" />
				<xsl:variable name="has-constructor" select="apiConstructor/apiConstructorDetail/apiConstructorDef/apiAccess[@value = 'public' or @value = 'protected']" />
				<xsl:variable name="is-class" select="not(apiClassifierDetail/apiClassifierDef/apiInterface)"/>
				
				<xsl:variable
					name="public-methods"
					select="apiOperation[apiOperationDetail/apiOperationDef/apiAccess/@value = 'public']" />
					
				<xsl:variable
					name="protected-methods"
					select="apiOperation[apiOperationDetail/apiOperationDef/apiAccess/@value = 'protected']" />	
					
				<xsl:variable
					name="public-properties"
					select="apiValue[apiValueDetail/apiValueDef/apiAccess/@value = 'public' and apiValueDetail/apiValueDef/apiProperty]" />
					
				<xsl:variable
					name="protected-properties"
					select="apiValue[apiValueDetail/apiValueDef/apiAccess/@value = 'protected' and apiValueDetail/apiValueDef/apiProperty]" />
					
				<!-- RIGHT HAND PAGE HEADER -->
				<xsl:text>\rhead{\scriptsize{\textsc{</xsl:text>
				<xsl:call-template name="xref">
					<xsl:with-param name="input" select="$class-id" />
				</xsl:call-template>
				<xsl:text>}}}</xsl:text>
				<xsl:value-of select="$newline" />					
				
				<xsl:call-template name="section">
					<xsl:with-param name="title" select="apiName"/>
					<xsl:with-param name="label" select="$class-id"/>
				</xsl:call-template>
				
				<xsl:call-template name="class-details">
					<xsl:with-param name="package" select="$package-id"/>
				</xsl:call-template>
				
				<!-- CLASS DESCRIPTION -->
				<xsl:variable
					name="class-description"
					select="apiClassifierDetail/apiDesc" />				
				
				<!-- HANDLE MISSING CLASS/INTERFACE DESCRIPTIONS -->
				<xsl:choose>
					<xsl:when test="normalize-space($class-description) != ''">
						<xsl:call-template name="description-paragraph">
							<xsl:with-param name="input" select="$class-description"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="missing-prefix">
							<xsl:if test="$is-class">
								<xsl:value-of select="'class'" />
							</xsl:if>
							<xsl:if test="not($is-class)">
								<xsl:value-of select="'interface'" />
							</xsl:if>
						</xsl:variable>
						<xsl:call-template name="paragraph">
							<xsl:with-param name="text">
								<xsl:call-template name="missing">
									<xsl:with-param name="type" select="$missing-prefix" />
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				
				<!-- SEE ALSO XREF -->
				<xsl:call-template name="list-see" />
				
				<!-- SUMMARY LISTINGS -->
				<xsl:call-template name="class-summary">
					<xsl:with-param name="constants" select="$constants"/>
					<xsl:with-param name="public-methods" select="$public-methods"/>
					<xsl:with-param name="protected-methods" select="$protected-methods"/>
					<xsl:with-param name="public-properties" select="$public-properties"/>
					<xsl:with-param name="protected-properties" select="$protected-properties"/>
				</xsl:call-template>			
				
				<!-- CONSTRUCTOR -->
				<xsl:if test="$has-constructor">
					
					<xsl:call-template name="subsection">
						<xsl:with-param name="title" select="apiConstructor/apiName"/>
						<xsl:with-param name="label" select="apiConstructor/@id"/>
					</xsl:call-template>
					
					<xsl:variable
						name="constructor-description"
						select="apiConstructor/apiConstructorDetail/apiDesc" />
					
					<!-- HANDLE MISSING CONSTRUCTOR DESCRIPTIONS -->
					<xsl:choose>
						<xsl:when test="normalize-space($constructor-description) != ''">
							<xsl:call-template name="description-paragraph">
								<xsl:with-param name="input" select="$constructor-description"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="paragraph">
								<xsl:with-param name="text">
									<xsl:call-template name="missing">
										<xsl:with-param name="type" select="'constructor'" />
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>					
					
					<xsl:call-template name="parameter-list">
						<xsl:with-param name="params" select="apiConstructor/apiConstructorDetail/apiConstructorDef/apiParam" />
					</xsl:call-template>
					
					<xsl:call-template name="exceptions-list">
						<xsl:with-param name="params" select="apiConstructor/apiConstructorDetail/apiConstructorDef/apiException" />
					</xsl:call-template>
					
					<xsl:call-template name="constructor-signature" />
				</xsl:if>
				
				<!-- CONSTANTS -->
				<xsl:if test="$has-constants">
					<xsl:call-template name="subsection">
						<xsl:with-param name="title" select="'Constants'"/>
						<xsl:with-param name="label" select="concat($class-id,$constants-xref-id)"/>
					</xsl:call-template>
					
					<xsl:for-each select="$constants">
						<xsl:sort select="apiName"/>
						<xsl:if test="not(apiValueDetail/apiValueDef/apiProperty)">
							<xsl:call-template name="subsubsection">
								<xsl:with-param name="title" select="apiName"/>
								<xsl:with-param name="label" select="@id"/>
							</xsl:call-template>
							<xsl:call-template name="description-paragraph">
								<xsl:with-param name="input" select="apiValueDetail/apiDesc"/>
							</xsl:call-template>
							<xsl:call-template name="property-signature" />
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
				
				<!-- PUBLIC METHODS -->					
				<xsl:if test="$public-methods">
					<xsl:call-template name="subsection">
						<xsl:with-param name="title" select="'Public methods'"/>
						<xsl:with-param name="label" select="concat($class-id,$public-methods-xref-id)"/>
					</xsl:call-template>
					<xsl:call-template name="list-methods">
						<xsl:with-param name="input" select="$public-methods" />
					</xsl:call-template>
				</xsl:if>
				
				<!-- PROTECTED METHODS -->		
				<xsl:if test="$protected-methods">
					<xsl:call-template name="subsection">
						<xsl:with-param name="title" select="'Protected methods'"/>
						<xsl:with-param name="label" select="concat($class-id,$protected-methods-xref-id)"/>
					</xsl:call-template>
					<xsl:call-template name="list-methods">
						<xsl:with-param name="input" select="$protected-methods" />
					</xsl:call-template>
				</xsl:if>
				
				<!-- PUBLIC PROPERTIES -->					
				<xsl:if test="$public-properties">
					<xsl:call-template name="subsection">
						<xsl:with-param name="title" select="'Public properties'"/>
						<xsl:with-param name="label" select="concat($class-id,$public-properties-xref-id)"/>
					</xsl:call-template>
					<xsl:call-template name="list-properties">
						<xsl:with-param name="input" select="$public-properties" />
					</xsl:call-template>
				</xsl:if>
				
				<!-- PROTECTED PROPERTIES -->					
				<xsl:if test="$protected-properties">
					<xsl:call-template name="subsection">
						<xsl:with-param name="title" select="'Protected properties'"/>
						<xsl:with-param name="label" select="concat($class-id,$protected-properties-xref-id)"/>
					</xsl:call-template>
					<xsl:call-template name="list-properties">
						<xsl:with-param name="input" select="$protected-properties" />
					</xsl:call-template>
				</xsl:if>
				
			</xsl:for-each>
		</xsl:for-each>
		
		<xsl:call-template name="appendix"/>
		<xsl:call-template name="footer"/>
	</xsl:template>
	
	<xsl:template name="missing">
		<xsl:param name="prefix" select="'missing'" />
		<xsl:param name="type" select="''" />
		<xsl:param name="suffix" select="'description'" />
		<xsl:variable name="message" select="concat('[',$prefix,' ',$type,' ',$suffix,']')" />
		<xsl:call-template name="textcolor">
			<xsl:with-param name="input">
				<xsl:call-template name="textsc">
					<xsl:with-param name="input" select="normalize-space($message)" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="appendix">
		
		<xsl:variable name="classes" select="$toplevel//classRec" />
		<xsl:variable name="interfaces" select="$toplevel//interfaceRec" />
		
		<xsl:call-template name="section">
			<xsl:with-param name="title" select="'Appendix'"/>
			<xsl:with-param name="label" select="'appendix'"/>
		</xsl:call-template>
		
		<!-- CUSTOM APPENDICES FIRST -->
		<xsl:for-each select="//appendix">
			<xsl:call-template name="sanitize">
				<xsl:with-param name="input" select="." />
			</xsl:call-template>			
		</xsl:for-each>
		
		<!-- ALL CLASSES -->
		<xsl:if test="count($classes) &gt; 0">
			<xsl:call-template name="subsection">
				<xsl:with-param name="title" select="'Class Index'"/>
				<xsl:with-param name="label" select="'class:index'"/>
			</xsl:call-template>
			<xsl:for-each select="$packages//apiItemRef">
				<xsl:variable name="package-path" select="concat($dita-dir,$delimiter,@href)" />
				<xsl:variable name="package" select="document($package-path)" />
				<xsl:variable name="package-id" select="$package/apiPackage/@id"/>
				<xsl:variable name="package-id-null" select="concat($package-id,'.null')"/>
				<xsl:variable name="package-classes" select="$toplevel//classRec[@namespace = $package-id and @access != 'internal' and @access != 'private']"/>
				<xsl:if test="count($package-classes) &gt; 0">
					<xsl:call-template name="subsubsection">
						<xsl:with-param name="escaped" select="true()" />
						<xsl:with-param name="title">
							<xsl:call-template name="xref">
								<xsl:with-param name="input">
									<xsl:call-template name="escape">
										<xsl:with-param name="input" select="$package-id" />
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="classifier-listing">
						<xsl:with-param name="input" select="$package-classes" />
					</xsl:call-template>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		
		<!-- ALL INTERFACES -->
		<xsl:if test="count($interfaces) &gt; 0">
			<xsl:call-template name="subsection">
				<xsl:with-param name="title" select="'Interface Index'"/>
				<xsl:with-param name="label" select="'interface:index'"/>
			</xsl:call-template>
			<xsl:for-each select="$packages//apiItemRef">
				<xsl:variable name="package-path" select="concat($dita-dir,$delimiter,@href)" />
				<xsl:variable name="package" select="document($package-path)" />
				<xsl:variable name="package-id" select="$package/apiPackage/@id"/>
				<xsl:variable name="package-id-null" select="concat($package-id,'.null')"/>
				<xsl:variable name="package-interfaces" select="$toplevel//interfaceRec[@namespace = $package-id and @access != 'internal' and @access != 'private']"/>
				<xsl:if test="count($package-interfaces) &gt; 0">
					<xsl:call-template name="subsubsection">
						<xsl:with-param name="escaped" select="true()" />
						<xsl:with-param name="title">
							<xsl:call-template name="xref">
								<xsl:with-param name="input">
									<xsl:call-template name="escape">
										<xsl:with-param name="input" select="$package-id" />
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="classifier-listing">
						<xsl:with-param name="input" select="$package-interfaces" />
					</xsl:call-template>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>	
	</xsl:template>
	
	<xsl:template name="inheritance">
		<xsl:param name="input" select="''" />
		<xsl:param name="prefix" select="' \begin{math}\Rightarrow\end{math} '" />
		
		<!-- TODO : add support for interface inheritance hierarchy -->
		
		<!--
		apiInterface
		apiBaseInterface
		-->
		
		<xsl:if test="$input != ''">
			<xsl:if test="$prefix != ''">
				<xsl:value-of select="$prefix" />
			</xsl:if>
			
			<!-- checking for a known class or interface for the inheritance -->
			<xsl:variable name="matched" select="$toplevel//classRec[@fullname=$input] | $toplevel//interfaceRec[@fullname=$input]" />
			<xsl:choose>
				<!-- check for a valid xref -->
				<xsl:when test="$matched">
					<xsl:call-template name="xref">
						<xsl:with-param name="input" select="$input"/>
					</xsl:call-template>

					<xsl:variable name="namespace" select="$matched/@namespace" />
					<xsl:variable name="base" select="$matched/@baseclass" />
					<xsl:variable name="doc" select="document(concat($dita-dir,$delimiter,$namespace,'.xml'))" />

					<xsl:variable name="found" select="$doc//apiClassifier[@id = $base]" />
				
					<xsl:if test="$found">
						
						<xsl:choose>
							<xsl:when test="$found/apiClassifierDetail/apiClassifierDef/apiBaseClassifier != ''">
								<xsl:call-template name="inheritance">
									<xsl:with-param name="input" select="$found/apiClassifierDetail/apiClassifierDef/apiBaseClassifier" />
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$found/apiClassifierDetail/apiClassifierDef/apiBaseInterface != ''">
									<xsl:call-template name="inheritance">
										<xsl:with-param name="input" select="$found/apiClassifierDetail/apiClassifierDef/apiBaseInterface" />
									</xsl:call-template>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="not($found)">
						<xsl:call-template name="inheritance">
							<xsl:with-param name="input" select="$base" />
						</xsl:call-template>						
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$input" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="implements">
		<xsl:param name="input" select="apiClassifierDetail/apiClassifierDef/apiBaseInterface" />
		
		<xsl:for-each select="$input">
			
			<xsl:variable name="current" select="." />
			
			<xsl:if test="position() &gt; 1">
				<xsl:value-of select="', '" />
			</xsl:if>

			<xsl:variable name="matched" select="$toplevel//interfaceRec[@fullname=$current]" />
			
			<xsl:choose>
				<!-- check for a valid xref -->
				<xsl:when test="$matched">
					
					<xsl:call-template name="xref">
						<xsl:with-param name="input" select="$current"/>
					</xsl:call-template>

					<xsl:variable name="namespace" select="$matched/@namespace" />
					<xsl:variable name="base" select="$matched/@baseclass" />
					<xsl:variable name="doc" select="document(concat($dita-dir,$delimiter,$namespace,'.xml'))" />

					<xsl:variable name="found" select="$doc//apiClassifier[@id = $base]" />
				
					<xsl:if test="$found">
						<xsl:call-template name="implements">
							<xsl:with-param name="input" select="$found" />
						</xsl:call-template>
					</xsl:if>
			
					<xsl:if test="not($found)">
						<xsl:call-template name="implements">
							<xsl:with-param name="input" select="$base" />
						</xsl:call-template>
					</xsl:if>
				
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$current" />
				</xsl:otherwise>
			</xsl:choose>
			
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="list-methods">
		<xsl:param name="input" select="''" />			
		<xsl:for-each select="$input">
			<xsl:sort select="apiName"/>
			<xsl:call-template name="subsubsection">
				<xsl:with-param name="title" select="apiName" />
				<xsl:with-param name="label" select="@id" />
			</xsl:call-template>
			
			<xsl:if test=".//apiDeprecated | .//prolog/asCustoms/deprecated">
				<xsl:call-template name="start-paragraph" />
				<xsl:call-template name="deprecated" />
				<xsl:call-template name="end-paragraph" />
			</xsl:if>
									
			<xsl:call-template name="description-paragraph">
				<xsl:with-param name="input" select="apiOperationDetail/apiDesc"/>
			</xsl:call-template>
			
			<!-- missing method description -->
			<xsl:if test="normalize-space(apiOperationDetail/apiDesc) = ''">
				<xsl:call-template name="paragraph">
					<xsl:with-param name="text">
						<xsl:call-template name="missing" />
					</xsl:with-param>
				</xsl:call-template>		
			</xsl:if>
			
			<xsl:call-template name="parameter-list" />
			<xsl:call-template name="method-return" />
			<xsl:call-template name="exceptions-list" />
			

			<xsl:call-template name="start-paragraph" />
			<xsl:call-template name="method-signature" />
			<xsl:call-template name="end-paragraph" />
			
			<!-- SEE ALSO XREF -->
			<xsl:call-template name="list-see" />			
		</xsl:for-each>
	</xsl:template>
	
	<!-- lists properties - omitting the constants -->
	<xsl:template name="list-properties">
		<xsl:param name="input" select="''" />	
		<xsl:for-each select="$input">
			<xsl:sort select="apiName"/>
			<xsl:if test="apiValueDetail/apiValueDef/apiProperty">
				
				<xsl:call-template name="subsubsection">
					<xsl:with-param name="title" select="apiName"/>
					<xsl:with-param name="label" select="@id"/>
				</xsl:call-template>
				
				<xsl:variable name="description" select="apiValueDetail/apiDesc" />
				
				<!-- handle missing property descriptions -->
				<xsl:choose>
					<xsl:when test="normalize-space($description) != ''">
						<xsl:call-template name="description-paragraph">
							<xsl:with-param name="input" select="$description"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="paragraph">
							<xsl:with-param name="text">
								<xsl:call-template name="missing">
									<xsl:with-param name="type" select="'property'" />
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>				
				
				<xsl:call-template name="property-signature" />
				
				<!-- SEE ALSO XREF -->
				<xsl:call-template name="list-see" />				
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<!--
	<related-links>
		<link href="com.ffsys.asdoc.xml#AsdocSuper">
			<linktext>com.ffsys.asdoc.AsdocSuper</linktext>
		</link>
	</related-links>	
	-->
	
	<xsl:template name="list-see">
		<xsl:param name="input" select="related-links/link" />
		
		<xsl:if test="count($input) &gt; 0">
			
			<xsl:call-template name="subtitle">
				<xsl:with-param name="input" select="'See Also'" />
			</xsl:call-template>			
			
			<xsl:call-template name="start-itemize" />
		
			<xsl:for-each select="$input">
				<xsl:sort select="linktext" />
				<xsl:choose>
					<xsl:when test="@href != ''">
						
						<!-- valid href attribute we should have a valid xref -->
						<xsl:variable name="xref">
							<xsl:call-template name="search-and-replace">
								<xsl:with-param name="input" select="@href" />
								<xsl:with-param name="search-string" select="'\.xml$'" />
								<xsl:with-param name="replace-string" select="''" />
							</xsl:call-template>
						</xsl:variable>
						
						<xsl:variable name="xref">
							<xsl:call-template name="search-and-replace">
								<xsl:with-param name="input" select="$xref" />
								<xsl:with-param name="search-string" select="'\.xml#'" />
								<xsl:with-param name="replace-string" select="':'" />
							</xsl:call-template>
						</xsl:variable>

						<xsl:variable name="xref">
							<xsl:call-template name="search-and-replace">
								<xsl:with-param name="input" select="$xref" />
								<xsl:with-param name="search-string" select="'#'" />
								<xsl:with-param name="replace-string" select="':'" />
							</xsl:call-template>
						</xsl:variable>
						
						<xsl:variable name="xref">
							<xsl:call-template name="search-and-replace">
								<xsl:with-param name="input" select="$xref" />
								<xsl:with-param name="search-string" select="'/'" />
								<xsl:with-param name="replace-string" select="':'" />
							</xsl:call-template>
						</xsl:variable>
						
						<xsl:call-template name="item">
							<xsl:with-param name="input">
								<xsl:call-template name="xref">
									<xsl:with-param name="input" select="$xref" />
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						
						<!-- also output the full path to the symbol when we have an xref -->
						
						<!-- TODO: move to class-path template -->
						<xsl:value-of select="' -- '" />
						<xsl:call-template name="emph">
							<xsl:with-param name="input">
								<xsl:call-template name="search-and-replace">
									<xsl:with-param name="input" select="$xref" />
									<xsl:with-param name="search-string" select="':'" />
									<xsl:with-param name="replace-string" select="'.'" />
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						
						<!-- no valid href available show the invalid one -->
						<xsl:variable name="xref">
							<xsl:call-template name="search-and-replace">
								<xsl:with-param name="input" select="@invalidHref" />
								<xsl:with-param name="search-string" select="'\.xml'" />
								<xsl:with-param name="replace-string" select="''" />
							</xsl:call-template>
						</xsl:variable>
						
						<xsl:call-template name="item">
							<xsl:with-param name="input" select="$xref" />
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		
			<xsl:call-template name="end-itemize" />
		</xsl:if>
	</xsl:template>	

	<xsl:template name="property-signature">
		<xsl:param name="access" select="apiValueDetail/apiValueDef/apiAccess/@value" />
		<xsl:param name="name" select="apiName" />
		<xsl:param name="alltt" select="true()" />
		<xsl:param name="abbreviated" select="false()" />
		<xsl:param name="title" select="'Implementation'" />
		<xsl:param name="type">
			<xsl:if test="apiValueDetail/apiValueDef/apiType/@value">
				<xsl:value-of select="apiValueDetail/apiValueDef/apiType/@value"/>
			</xsl:if>
			<xsl:if test="not(apiValueDetail/apiValueDef/apiType/@value) and apiValueDetail/apiValueDef/apiValueClassifier">
				<xsl:value-of select="apiValueDetail/apiValueDef/apiValueClassifier"/>
			</xsl:if>
		</xsl:param>
		
		<xsl:param name="api-data" select="apiValueDetail/apiValueDef/apiData" />
		<xsl:param name="accessor" select="contains(@id,':get') or contains(@id,':set')" />
		<xsl:param name="is-getter" select="contains(@id,':get')" />
		<xsl:param name="api-value-access" select="apiValueDetail/apiValueDef/apiValueAccess/@value" />
		<xsl:param name="static" select="apiValueDetail/apiValueDef/apiStatic" />
		<xsl:param name="constant" select="not(apiValueDetail/apiValueDef/apiProperty)" />
		
		<xsl:if test="$title != ''">
			<xsl:call-template name="subtitle">
				<xsl:with-param name="input" select="$title" />
			</xsl:call-template>
		</xsl:if>
		
		<xsl:value-of select="'\scriptsize{'" />
		
		<xsl:choose>
			<xsl:when test="$alltt">
				<xsl:value-of select="$start-alltt" />				
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$start-tt" />
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="not($abbreviated)">
			<xsl:value-of select="$access" />
		
			<xsl:if test="$static">
				<xsl:value-of select="' static'" />
			</xsl:if>
		
			<xsl:if test="not($accessor) and not(apiValueDetail/apiValueDef/apiProperty)">
				<xsl:value-of select="' const'" />
			</xsl:if>
		
			<xsl:if test="not($accessor) and apiValueDetail/apiValueDef/apiProperty">
				<xsl:value-of select="' var'" />
			</xsl:if>
			
			<xsl:text> </xsl:text>
		</xsl:if>	
		
		<xsl:if test="not($accessor)">
			
			<xsl:call-template name="getter-parameters">
				<xsl:with-param name="name" select="$name" />
				<xsl:with-param name="accessor" select="$accessor" />
				<xsl:with-param name="type" select="$type" />
			</xsl:call-template>
			
			<xsl:if test="$api-data != '' and $alltt and not($abbreviated)">
				<xsl:value-of select="$newline" />
				<xsl:text> = </xsl:text>
				<xsl:call-template name="escape">
					<xsl:with-param name="input" select="$api-data" />
					<xsl:with-param name="plain-tilde" select="true()" />
					<xsl:with-param name="plain-circumflex" select="true()" />
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		
		<xsl:if test="$accessor">
			
			<!-- override candidate -->
			<xsl:if test="apiValueDetail/apiValueDef/apiIsOverride and not($abbreviated)">
				<xsl:variable name="getter-fullname" select="concat(../@id,'/',apiName,'/get')" />
				<xsl:variable name="setter-fullname" select="concat(../@id,'/',apiName,'/set')" />
				
				<xsl:variable name="getter-override" select="$toplevel//*[@fullname = $getter-fullname]" />
				<xsl:variable name="setter-override" select="$toplevel//*[@fullname = $setter-fullname]" />
				
				<xsl:if test="$getter-override">
					<xsl:if test="not($abbreviated)">
						<xsl:value-of select="'override function get '" />
					</xsl:if>
					<xsl:call-template name="getter-parameters">
						<xsl:with-param name="name" select="$name" />
						<xsl:with-param name="type" select="$type" />				
					</xsl:call-template>
				</xsl:if>
				
				<xsl:if test="$setter-override">
					
					<!-- only break on a newline if there is an existing getter override -->
					<xsl:if test="$getter-override">
						<xsl:value-of select="$newline" />
						<xsl:value-of select="$access" />
					</xsl:if>
					
					<xsl:if test="not($abbreviated)">
						<xsl:value-of select="'override function set '" />
					</xsl:if>
					
					<xsl:call-template name="setter-parameters">
						<xsl:with-param name="name" select="$name" />
						<xsl:with-param name="type" select="$type" />				
					</xsl:call-template>					
				</xsl:if>
			</xsl:if>
			
			<!-- not dealing with an override -->
			<xsl:if test="not(apiValueDetail/apiValueDef/apiIsOverride) or $abbreviated">
				<xsl:choose>
					<xsl:when test="$api-value-access = 'write'">
						
						<xsl:if test="not($abbreviated)">
							<xsl:value-of select="'function set '" />
						</xsl:if>
						<xsl:call-template name="setter-parameters">
							<xsl:with-param name="name" select="$name" />
							<xsl:with-param name="type" select="$type" />	
						</xsl:call-template>						
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="not($abbreviated)">
							<xsl:value-of select="'function get '" />
						</xsl:if>
						
						<xsl:call-template name="getter-parameters">
							<xsl:with-param name="name" select="$name" />
							<xsl:with-param name="accessor" select="$accessor" />
							<xsl:with-param name="type" select="$type" />
						</xsl:call-template>						
					</xsl:otherwise>
				</xsl:choose>

				<!-- also add a setter for readwrite -->
				<xsl:if test="$accessor and not($abbreviated) and $api-value-access = 'readwrite' and not(apiValueDetail/apiValueDef/apiIsOverride)">
					<xsl:value-of select="$newline" />
					<xsl:value-of select="$access" />
					<xsl:value-of select="' function set '" />
					<xsl:call-template name="setter-parameters">
						<xsl:with-param name="name" select="$name" />
						<xsl:with-param name="type" select="$type" />			
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
		</xsl:if>
		
		<xsl:choose>
			<xsl:when test="$alltt">
				<xsl:value-of select="$end-alltt" />				
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$end-tt" />
			</xsl:otherwise>
		</xsl:choose>
		<!-- end size block -->
		<xsl:value-of select="'}'" />
	</xsl:template>
	
	<xsl:template name="getter-parameters">
		<xsl:param name="name" select="''" />
		<xsl:param name="accessor" select="true()" />
		<xsl:param name="type" select="''" />
		<xsl:param name="xref" select="true()" />
		
		<xsl:choose>
			<xsl:when test="$xref">
				<xsl:call-template name="nameref">
					<xsl:with-param name="input" select="@id" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$name" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$accessor">
			<xsl:value-of select="'()'" />
		</xsl:if>
		<xsl:if test="$type != ''">
			<xsl:text>:</xsl:text>
			<xsl:variable name="xref" select="$toplevel//*[@fullname = $type]" />			
			<xsl:call-template name="handle-type">
				<xsl:with-param name="type" select="$type" />
				<xsl:with-param name="tt" select="true()" />
				<xsl:with-param name="xref" select="$xref" />
				<xsl:with-param name="fullname" select="$xref/@fullname" />				
			</xsl:call-template>			
			
			<!--
			<xsl:variable name="xref" select="$toplevel//*[@fullname = $type]" />
			<xsl:if test="$xref">
				<xsl:call-template name="xref">
					<xsl:with-param name="input" select="$xref/@fullname" />
					<xsl:with-param name="tt" select="true()" />
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="not($xref)">
				<xsl:call-template name="escape">
					<xsl:with-param name="input" select="$type" />
				</xsl:call-template>
			</xsl:if>
			
			-->
			
			
			
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="handle-type">
		<xsl:param name="type" select="''" />
		<xsl:param name="xref" select="$toplevel//*[@fullname = $type]" />
		<xsl:param name="fullname" select="$xref/@fullname" />
		<xsl:param name="tt" select="true()" />				
		
		<xsl:choose>
			<xsl:when test="$type != 'any'">
				<xsl:if test="$xref">
					<xsl:call-template name="xref">
						<xsl:with-param name="input" select="$fullname" />
						<xsl:with-param name="tt" select="$tt" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not($xref)">
					<xsl:call-template name="escape">
						<xsl:with-param name="input" select="$type" />
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'*'" />
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	<xsl:template name="setter-parameters">
		<xsl:param name="name" select="''" />
		<xsl:param name="type" select="''" />
		<xsl:param name="xref" select="true()" />

		<xsl:choose>
			<xsl:when test="$xref">
				<xsl:call-template name="nameref">
					<xsl:with-param name="input" select="@id" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$name" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="'(value'" />
		<xsl:if test="$type != ''">
			<xsl:text>:</xsl:text>
			
			<xsl:variable name="xref" select="$toplevel//*[@fullname = $type]" />			
			<xsl:call-template name="handle-type">
				<xsl:with-param name="type" select="$type" />
				<xsl:with-param name="tt" select="true()" />
				<xsl:with-param name="xref" select="$xref" />
				<xsl:with-param name="fullname" select="$xref/@fullname" />				
			</xsl:call-template>			
			
			<!--
			<xsl:variable name="xref" select="$toplevel//*[@fullname = $type]" />
			<xsl:if test="$xref">
				<xsl:call-template name="xref">
					<xsl:with-param name="input" select="$xref/@fullname" />
					<xsl:with-param name="tt" select="true()" />
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="not($xref)">
				<xsl:call-template name="escape">
					<xsl:with-param name="input" select="$type" />
				</xsl:call-template>				
			</xsl:if>
			-->
		</xsl:if>
		<xsl:value-of select="'):void'" />		
	</xsl:template>
	
	<xsl:template name="constructor-signature">
		<xsl:for-each select="apiConstructor">
			<xsl:call-template name="start-paragraph" />
			<xsl:call-template name="method-signature">
				<xsl:with-param name="access" select="apiConstructorDetail/apiConstructorDef/apiAccess/@value" />
				<xsl:with-param name="name" select="apiName" />
				<xsl:with-param name="return-type" select="''" />
				<xsl:with-param name="params" select="apiConstructorDetail/apiConstructorDef/apiParam" />
			</xsl:call-template>
			<xsl:call-template name="end-paragraph" />
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="method-signature">
		<xsl:param name="params" select="apiOperationDetail/apiOperationDef/apiParam" />
		<xsl:param name="access" select="apiOperationDetail/apiOperationDef/apiAccess/@value" />
		<xsl:param name="prefix" select="''" />
		<xsl:param name="name" select="apiName" />
		<xsl:param name="xref" select="true()" />
		<xsl:param name="break" select="true()" />
		<xsl:param name="alltt" select="true()" />
		<xsl:param name="abbreviated" select="false()" />
		<xsl:param name="title" select="'Implementation'" />
		<xsl:param name="static" select="apiOperationDetail/apiOperationDef/apiStatic" />
		<xsl:param name="return-type">
			<xsl:if test="apiOperationDetail/apiOperationDef/apiReturn/apiType/@value">
				<xsl:value-of select="apiOperationDetail/apiOperationDef/apiReturn/apiType/@value"/>
			</xsl:if>
			<xsl:if test="not(apiOperationDetail/apiOperationDef/apiReturn/apiType/@value) and apiOperationDetail/apiOperationDef/apiReturn/apiOperationClassifier">
				<xsl:value-of select="apiOperationDetail/apiOperationDef/apiReturn/apiOperationClassifier"/>
			</xsl:if>
		</xsl:param>
		
		<xsl:if test="$title != ''">
			<xsl:call-template name="subtitle">
				<xsl:with-param name="input" select="$title" />
			</xsl:call-template>
		</xsl:if>
		
		<xsl:value-of select="'\scriptsize{'" />
		
		<xsl:choose>
			<xsl:when test="$alltt">
				<xsl:value-of select="$start-alltt" />				
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$start-tt" />
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="not($abbreviated)">
			
			<xsl:if test="apiOperationDetail/apiOperationDef/apiIsOverride">	
				<xsl:value-of select="'override '" />
			</xsl:if>
		
			<xsl:value-of select="$access" />
		
			<xsl:if test="$static">
				<xsl:value-of select="' static'" />
			</xsl:if>
		
			<xsl:if test="$prefix != ''">
				<xsl:value-of select="concat(' ', $prefix)" />
			</xsl:if>
		
			<xsl:value-of select="' function'" />
		
			<xsl:value-of select="' '" />
		
		</xsl:if>
		
		<xsl:choose>
			<!-- xref the name -->
			<xsl:when test="$xref">				
				<xsl:call-template name="nameref">
					<xsl:with-param name="input" select="@id" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$name" />
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:choose>
			<xsl:when test="count(.//apiParam) = 0">
				<xsl:value-of select="'()'" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'('" />	
				<xsl:call-template name="get-parameters">
					<xsl:with-param name="params" select="$params" />
					<xsl:with-param name="break" select="$break" />
				</xsl:call-template>
				<xsl:value-of select="')'" />
			</xsl:otherwise>
		</xsl:choose>
		
		<!-- TODO: more generic type handling -->
		<xsl:if test="$return-type != ''">
			<xsl:value-of select="':'" />
			<xsl:choose>
				<xsl:when test="$return-type != 'any'">
					<xsl:variable name="xref" select="$toplevel//*[@fullname = $return-type]" />
					<xsl:if test="$xref">
						<xsl:call-template name="xref">
							<xsl:with-param name="input" select="$xref/@fullname" />
							<xsl:with-param name="tt" select="true()" />
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="not($xref)">
						<xsl:call-template name="escape">
							<xsl:with-param name="input" select="$return-type" />
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>	
					<xsl:value-of select="'*'" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
			
		<xsl:choose>
			<xsl:when test="$alltt">
				<xsl:value-of select="$end-alltt" />			
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$end-tt" />
			</xsl:otherwise>
		</xsl:choose>		
		
		<xsl:value-of select="'}'" />
	</xsl:template>
	
	<xsl:template name="get-parameters">
		<xsl:param name="break" select="true()" />
		<xsl:param name="params" select=".//apiParam" />
		<xsl:if test="$break">
			<xsl:value-of select="$tab" />
		</xsl:if>		
		<xsl:for-each select="$params">
			<xsl:if test="position()>1">
				<xsl:text>, </xsl:text>
			</xsl:if>
			<xsl:if test="$break">
				<xsl:value-of select="$newline" />
				<xsl:value-of select="$tab" />
			</xsl:if>
			<xsl:variable name="type-name">
				<xsl:if test="./apiType and not(./apiOperationClassifier)">
					<xsl:value-of select="./apiType/@value"/>
				</xsl:if>
				<xsl:if test="./apiOperationClassifier and not(./apiType)">
					<xsl:value-of select="./apiOperationClassifier"/>
				</xsl:if>
			</xsl:variable>
			
			<xsl:if test="@optional='true'">
				<xsl:text>[</xsl:text>
			</xsl:if>

			<xsl:if test="($type-name != 'restParam')">
				<xsl:value-of select="./apiItemName"/>
				<xsl:if test="($type-name != '')">
					<xsl:text>:</xsl:text>	
					
					<xsl:variable name="xref" select="$toplevel//*[@fullname = $type-name]" />
					<xsl:call-template name="handle-type">
						<xsl:with-param name="type" select="$type-name" />
						<xsl:with-param name="tt" select="true()" />
						<xsl:with-param name="xref" select="$xref" />
						<xsl:with-param name="fullname" select="$xref/@fullname" />				
					</xsl:call-template>
					
					<!--		
					<xsl:variable name="xref" select="$toplevel//*[@fullname = $type-name]" />
					<xsl:if test="$xref">
						<xsl:call-template name="xref">
							<xsl:with-param name="input" select="$xref/@fullname" />
							<xsl:with-param name="tt" select="true()" />							
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="not($xref)">
						<xsl:call-template name="escape">
							<xsl:with-param name="input" select="$type-name" />
						</xsl:call-template>
					</xsl:if>
					-->
					
				</xsl:if>
			</xsl:if>
			<xsl:if test="($type-name = 'restParam')">
				<xsl:text>... </xsl:text>
				<xsl:if test="apiItemName">
					<xsl:value-of select="apiItemName" />
				</xsl:if>
				<xsl:if test="not(apiItemName)">
					<xsl:value-of select="'rest'" />
				</xsl:if>
			</xsl:if>
			<xsl:if test="@optional='true'">
				<xsl:text>]</xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>	
	
	<xsl:template name="begin-verbatimtab">
		<xsl:text>\begin{verbatimtab}[2]</xsl:text>	
	</xsl:template>
	
	<xsl:template name="end-verbatimtab">
		<xsl:text>\end{verbatimtab}</xsl:text>
	</xsl:template>		
	
	<xsl:template name="subtitle">
		<xsl:param name="input" select="''" />
		<xsl:call-template name="start-paragraph" />
		<xsl:call-template name="start-textsc" />
		<xsl:call-template name="start-textbf" />
		<xsl:call-template name="escape">
			<xsl:with-param name="input" select="$input" />
		</xsl:call-template>
		<xsl:value-of select="$end-tag" />
		<xsl:value-of select="$end-tag" />
		<xsl:call-template name="end-paragraph" />
	</xsl:template>
	
	<xsl:template name="parameter-list">
		<xsl:param name="params" select="apiOperationDetail/apiOperationDef/apiParam" />
		
		<xsl:if test="count($params) &gt; 0">
			
			<xsl:call-template name="subtitle">
				<xsl:with-param name="input" select="'Parameters'" />
			</xsl:call-template>
			
			<xsl:call-template name="start-description" />
			<xsl:for-each select="$params">
				
				<xsl:variable name="description">
					<xsl:call-template name="sanitize">
						<xsl:with-param name="input" select="./apiDesc" />
					</xsl:call-template>
				</xsl:variable>
				
				<xsl:choose>
					<!-- handle missing parameter descriptions -->
					<xsl:when test="normalize-space($description) = ''">
						<xsl:call-template name="item">
							<xsl:with-param name="input">
								<xsl:call-template name="missing">
									<xsl:with-param name="type" select="'parameter'" />
								</xsl:call-template>								
							</xsl:with-param>
							<xsl:with-param name="prefix" select="./apiItemName" />
							<xsl:with-param name="description" select="true()" />
						</xsl:call-template>				
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="item">
							<xsl:with-param name="input" select="$description" />
							<xsl:with-param name="prefix" select="./apiItemName" />
							<xsl:with-param name="description" select="true()" />
						</xsl:call-template>						
					</xsl:otherwise>
				</xsl:choose>				
			</xsl:for-each>
			<xsl:call-template name="end-description" />
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="exceptions-list">
		<xsl:param name="params" select="apiOperationDetail/apiOperationDef/apiException" />
		
		<xsl:if test="count($params) &gt; 0">
			
			<xsl:call-template name="subtitle">
				<xsl:with-param name="input" select="'Throws'" />
			</xsl:call-template>
			
			<xsl:call-template name="start-description" />
			<xsl:for-each select="$params">
				
				<xsl:variable name="description">
					<xsl:call-template name="sanitize">
						<xsl:with-param name="input" select="./apiDesc" />
					</xsl:call-template>
				</xsl:variable>
				
				<xsl:call-template name="item">
					<xsl:with-param name="input" select="$description" />
					<xsl:with-param name="prefix" select="./apiItemName" />
					<xsl:with-param name="description" select="true()" />
				</xsl:call-template>
			</xsl:for-each>
			<xsl:call-template name="end-description" />
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="deprecated">
		<!-- ./apiOperationDetail/apiOperationDef/apiDeprecated -->
		<xsl:param name="text" select="'Deprecated'" />
		<xsl:param name="input">
			<xsl:choose>
				<xsl:when test=".//prolog/asCustoms/deprecated">
					<xsl:value-of select="normalize-space(.//prolog/asCustoms/deprecated)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=".//apiDeprecated" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="replacement">
			<xsl:choose>
				<xsl:when test=".//prolog/asCustoms/deprecated">
					<xsl:value-of select="normalize-space(.//prolog/asCustoms/deprecated)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=".//apiDeprecated/@replacement" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		
		<xsl:if test="count($input) &gt; 0">
			
			<!-- title -->
			
			<xsl:call-template name="textsc">
				<xsl:with-param name="input">
					<xsl:call-template name="textcolor">
						<xsl:with-param name="input" select="$text" />
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="$replacement">
				<xsl:value-of select="' -- '" />
				
				<xsl:choose>
					<!-- look for the corresponding replacement in the same class to xref -->
					<xsl:when test="../*/apiName = $replacement">
						
						<xsl:call-template name="xref">
							<xsl:with-param name="input" select="$replacement" />
							<xsl:with-param name="scope" select=".." />
							<xsl:with-param name="prefix" select="'See '" />
						</xsl:call-template>
						
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="paragraph">
							<xsl:with-param name="text">
								<xsl:call-template name="emph">
									<xsl:with-param name="input" select="$replacement" />
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<!-- performs lookup for xref id data -->
	<xsl:template name="xref">
		<xsl:param name="input" select="''" />
		<xsl:param name="scope" select="''" />
		<xsl:param name="prefix" select="''" />
		<xsl:param name="tt" select="false()" />
		
		<xsl:if test="$input != ''">
			<xsl:if test="$prefix != ''">
				<xsl:value-of select="$prefix" />
			</xsl:if>
			
			<xsl:if test="$scope != ''">
				<xsl:variable name="target" select="$scope//*[apiName = $input]" />
				<xsl:choose>
					<xsl:when test="not($tt)">
						<xsl:call-template name="nameref">
							<xsl:with-param name="input" select="$target/@id" />
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>					
						<xsl:call-template name="texttt">
							<xsl:with-param name="input">
								<xsl:call-template name="nameref">
									<xsl:with-param name="input" select="$target/@id" />
								</xsl:call-template>							
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			
			<xsl:if test="$scope = ''">
				
				<xsl:choose>
					<xsl:when test="not($tt)">
						<xsl:call-template name="nameref">
							<xsl:with-param name="input" select="$input" />
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>					
						<xsl:call-template name="texttt">
							<xsl:with-param name="input">
								<xsl:call-template name="nameref">
									<xsl:with-param name="input" select="$input" />
								</xsl:call-template>							
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
		
	</xsl:template>
	
	<xsl:template name="method-return">
		<xsl:param name="input" select="apiOperationDetail/apiOperationDef/apiReturn/apiDesc" />
		
		<xsl:if test="apiOperationDetail/apiOperationDef/apiReturn/apiType[@value != 'void']">
			
			<xsl:call-template name="subtitle">
				<xsl:with-param name="input" select="'Returns'" />
			</xsl:call-template>
			<xsl:choose>
				<!-- handle missing return descriptions -->
				<xsl:when test="normalize-space($input) = ''">
					<xsl:call-template name="paragraph">
						<xsl:with-param name="text">
							<xsl:call-template name="missing">
								<xsl:with-param name="type" select="'return'" />
							</xsl:call-template>								
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="description-paragraph">
						<xsl:with-param name="input" select="$input" />
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="label">
		<xsl:param name="title" />
		<xsl:value-of select="$newline" />		
		<xsl:text>\label{</xsl:text>
		<xsl:call-template name="escape-label">
			<xsl:with-param name="input" select="$title"/>
		</xsl:call-template>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="nameref">
		<xsl:param name="input" select="''" />
		<xsl:text>\nameref{</xsl:text>
		<xsl:call-template name="escape-label">
			<xsl:with-param name="input" select="$input"/>
		</xsl:call-template>
		<xsl:text>}</xsl:text>
	</xsl:template>
	
	<xsl:template name="start-description">
		<xsl:text>\begin{description}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="end-description">
		<xsl:text>\end{description}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="start-itemize">
		<xsl:text>\begin{itemize}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="item">
		<xsl:param name="input" select="''" />
		<xsl:param name="prefix" select="''" />
		<xsl:param name="escaped" select="false()" />
		<xsl:param name="description" select="false()" />
		<xsl:param name="delimiter" select="' -- '" />
		<xsl:text>\item</xsl:text>
		
		<xsl:choose>
			<xsl:when test="$escaped">
				<xsl:text> </xsl:text>
				<xsl:value-of select="$input" />
				<xsl:value-of select="$newline" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not($description)">
					<xsl:text> </xsl:text>
				</xsl:if>
		
				<xsl:if test="$prefix != '' and not($description)">
					<xsl:call-template name="escape">
						<xsl:with-param name="input" select="$prefix"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter" />
				</xsl:if>
		
				<xsl:if test="$prefix != '' and $description">
					<xsl:text>[</xsl:text>
					<xsl:call-template name="escape">
						<xsl:with-param name="input" select="$prefix"/>
					</xsl:call-template>
					<xsl:text>]</xsl:text>
					<xsl:text> </xsl:text>
				</xsl:if>
		
				<xsl:value-of select="$input" />
				<xsl:value-of select="$newline" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="end-itemize">
		<xsl:text>\end{itemize}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="part">
		<xsl:param name="title" />
		<xsl:param name="label" select="''" />
		<xsl:param name="escaped" select="false()" />
		<xsl:value-of select="$newline" />		
		<xsl:text>\part{</xsl:text>		
		<xsl:choose>
			<xsl:when test="$escaped">
				<xsl:value-of select="$title"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="escape">
					<xsl:with-param name="input" select="$title"/>
				</xsl:call-template>				
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
		
		<xsl:if test="$label != ''">
			<xsl:call-template name="label">
				<xsl:with-param name="title" select="$label"/>
			</xsl:call-template>
		</xsl:if>	
	</xsl:template>
	
	<xsl:template name="section">
		<xsl:param name="title" />
		<xsl:param name="label" select="''" />
		<xsl:param name="escaped" select="false()" />	
		
		<xsl:value-of select="$newline" />	
		<xsl:text>\section{</xsl:text>
		<xsl:choose>
			<xsl:when test="$escaped">
				<xsl:value-of select="$title"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="escape">
					<xsl:with-param name="input" select="$title"/>
				</xsl:call-template>				
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
		
		<xsl:if test="$label != ''">
			<xsl:call-template name="label">
				<xsl:with-param name="title" select="$label"/>
			</xsl:call-template>
		</xsl:if>		
	</xsl:template>	
	
	<xsl:template name="subsection">
		<xsl:param name="title" />
		<xsl:param name="label" select="''" />	
		<xsl:param name="escaped" select="false()" />	
		
		<xsl:value-of select="$newline" />		
		<xsl:text>\subsection{</xsl:text>
		<xsl:choose>
			<xsl:when test="$escaped">
				<xsl:value-of select="$title"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="escape">
					<xsl:with-param name="input" select="$title"/>
				</xsl:call-template>				
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
		
		<xsl:if test="$label != ''">
			<xsl:call-template name="label">
				<xsl:with-param name="title" select="$label"/>
			</xsl:call-template>
		</xsl:if>		
	</xsl:template>
	
	<xsl:template name="subsubsection">
		<xsl:param name="title" />
		<xsl:param name="label" select="''" />	
		<xsl:param name="escaped" select="false()" />
			
		<xsl:value-of select="$newline" />		
		<xsl:text>\subsubsection{</xsl:text>
		<xsl:choose>
			<xsl:when test="$escaped">
				<xsl:value-of select="$title"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="escape">
					<xsl:with-param name="input" select="$title"/>
				</xsl:call-template>				
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
		
		<xsl:if test="$label != ''">
			<xsl:call-template name="label">
				<xsl:with-param name="title" select="$label"/>
			</xsl:call-template>
		</xsl:if>		
	</xsl:template>	
	
	<xsl:template name="classifier-listing">
		<xsl:param name="input" select="''" />
		
		<xsl:if test="count($input) &gt; 0">
			
			<xsl:value-of select="$newline" />
			<xsl:text>{\scriptsize</xsl:text>
			<xsl:value-of select="$newline" />		
			<xsl:call-template name="start-itemize" />

			<xsl:for-each select="$input">
				<xsl:sort select="name" />
				
				<xsl:value-of select="$newline" />
				<xsl:value-of select="'\item '" />
				
				<xsl:call-template name="xref">
					<xsl:with-param name="input" select="@fullname"/>
				</xsl:call-template>
				<xsl:text>\\</xsl:text>
				
				<xsl:variable name="doc" select="document(concat($dita-dir,$delimiter,@namespace,'.xml'))" />
				<xsl:variable name="fullname" select="@fullname" />
				<xsl:variable name="found" select="$doc//apiClassifier[@id = $fullname]" />
				
				<xsl:if test="$found">
					
					<xsl:choose>
						<xsl:when test="normalize-space($found/shortdesc) = ''">
							<xsl:call-template name="missing" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="auto-xref">
								<xsl:with-param name="input">
									<xsl:call-template name="escape">
										<xsl:with-param name="input" select="normalize-space($found/shortdesc)" />
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>					
					
					<!--
					<xsl:call-template name="escape">
						<xsl:with-param name="input" select="$found/shortdesc" />
					</xsl:call-template>
					-->
					
				</xsl:if>

			</xsl:for-each>
			
			<xsl:call-template name="end-itemize" />
			<!-- end size block -->
			<xsl:text>}</xsl:text>		
			<xsl:value-of select="$newline" />			
			
		</xsl:if>		
	</xsl:template>
	
	<xsl:template name="class-details">
		<xsl:param name="package" />
		<xsl:param name="author" select="prolog/author"/>
		<xsl:param name="langversion" select="prolog/asMetadata/apiVersion/apiLanguage/@version"/>
		<xsl:param name="playerversion" select="prolog/asMetadata/apiVersion/apiPlatform/@version"/>
		<xsl:param name="since" select="prolog/asMetadata/apiVersion/apiSince/@version"/>
		
		<xsl:variable name="list-delimiter" select="', '" />
		<xsl:variable name="class-id" select="@id" />
		<xsl:variable name="access" select="apiClassifierDetail/apiClassifierDef/apiAccess/@value" />		
		
		<xsl:value-of select="$newline" />
		<xsl:text>\begin{tabularx}{\textwidth}{@{\extracolsep{\fill}}XR@{}}</xsl:text>
		<xsl:value-of select="$newline" />
		
		<xsl:if test="$package != ''">
			<xsl:text>\scriptsize{Package:} &amp; </xsl:text>
			<xsl:text>\scriptsize{</xsl:text>
			<xsl:call-template name="nameref">
				<xsl:with-param name="input" select="$package" />
			</xsl:call-template>
			<xsl:text>}</xsl:text>
			<xsl:text>\\</xsl:text>
			<xsl:value-of select="$newline" />
		</xsl:if>
		
		<!-- implementation signature -->		
		<xsl:choose>
			<!-- class -->		
			<xsl:when test="not(apiClassifierDetail/apiClassifierDef/apiInterface)">
				<xsl:text>\scriptsize{Class:} &amp; </xsl:text>
				<xsl:text>\scriptsize{\verb|</xsl:text>
				<xsl:if test="apiClassifierDetail/apiClassifierDef/apiDynamic">
					<xsl:text>dynamic </xsl:text>
				</xsl:if>
				<xsl:value-of select="$access" />
				<xsl:if test="apiClassifierDetail/apiClassifierDef/apiFinal">
					<xsl:text> final</xsl:text>
				</xsl:if>		
				<xsl:text> class</xsl:text>
			</xsl:when>
			<!-- interface -->
			<xsl:otherwise>
				<xsl:text>\scriptsize{Interface:} &amp; </xsl:text>
				<xsl:text>\scriptsize{\verb|</xsl:text>
				<xsl:value-of select="$access" />								
				<xsl:text> interface</xsl:text>				
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="' '" />
		<xsl:value-of select="apiName" />
		<xsl:value-of select="'|'" />		
		<xsl:text>}</xsl:text>
		<xsl:text>\\</xsl:text>
		<xsl:value-of select="$newline" />		
	
		<!-- inheritance -->
		<xsl:if test="apiClassifierDetail/apiClassifierDef/apiBaseClassifier != '' or apiClassifierDetail/apiClassifierDef/apiBaseInterface != ''">
			<xsl:text>\scriptsize{Inheritance:} &amp; </xsl:text>
		
			<xsl:text>\scriptsize{</xsl:text>
			<xsl:choose>			
				<!-- class inheritance -->
				<xsl:when test="not(apiClassifierDetail/apiClassifierDef/apiInterface)">
					<xsl:value-of select="apiName" />
					<xsl:call-template name="inheritance">
						<xsl:with-param name="input" select="apiClassifierDetail/apiClassifierDef/apiBaseClassifier" />
					</xsl:call-template>
				</xsl:when>
			
				<!-- interface inheritance -->
				<xsl:otherwise>
					<xsl:variable name="interfaces" select="apiClassifierDetail/apiClassifierDef/apiBaseInterface" />
					<xsl:for-each select="$interfaces">
						<xsl:choose>
							<xsl:when test="position() = 1">
								<xsl:call-template name="inheritance">
									<xsl:with-param name="input" select="." />
									<xsl:with-param name="prefix" select="''" />
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="inheritance">
									<xsl:with-param name="input" select="." />
									<xsl:with-param name="prefix" select="$list-delimiter" />
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		
			<xsl:text>}</xsl:text>
			<xsl:text>\\</xsl:text>
		</xsl:if>
		
		<!-- implements for classes -->
		<xsl:if test="not(apiClassifierDetail/apiClassifierDef/apiInterface) and apiClassifierDetail/apiClassifierDef/apiBaseInterface">
			<xsl:value-of select="$newline" />
			<xsl:text>\scriptsize{Implements:} &amp; </xsl:text>
			<xsl:text>\scriptsize{</xsl:text>
			<xsl:call-template name="implements" />
			<xsl:text>}</xsl:text>
			<xsl:text>\\</xsl:text>
			<xsl:value-of select="$newline" />
		</xsl:if>
		
		<!-- sub classes & interfaces listings -->
		<xsl:choose>
			<!-- sub classes -->			
			<xsl:when test="not(apiClassifierDetail/apiClassifierDef/apiInterface)">
				<xsl:variable name="sub-classes" select="$toplevel//classRec[@baseclass = $class-id]" />
				<xsl:if test="count($sub-classes) &gt; 0">
					<xsl:text>\scriptsize{Sub classes:} &amp; </xsl:text>
					<xsl:text>\scriptsize{</xsl:text>
					<xsl:for-each select="$sub-classes">
						<xsl:if test="position() &gt; 1">
							<xsl:value-of select="$list-delimiter" />
						</xsl:if>
						<xsl:call-template name="xref">
							<xsl:with-param name="input" select="@fullname" />
						</xsl:call-template>
					</xsl:for-each>
					<xsl:text>}</xsl:text>
					<xsl:text>\\</xsl:text>
				</xsl:if>				
			</xsl:when>
			<!-- sub interfaces -->
			<xsl:otherwise>
				<xsl:variable name="sub-interfaces" select="$toplevel//interfaceRec[contains(@baseClasses, $class-id)]" />
				<xsl:if test="count($sub-interfaces) &gt; 0">
					<xsl:text>\scriptsize{Sub interfaces:} &amp; </xsl:text>
					<xsl:text>\scriptsize{</xsl:text>
					<xsl:for-each select="$sub-interfaces">
						<xsl:if test="position() &gt; 1">
							<xsl:value-of select="$list-delimiter" />
						</xsl:if>
						<xsl:call-template name="xref">
							<xsl:with-param name="input" select="@fullname" />
						</xsl:call-template>
					</xsl:for-each>
					<xsl:text>}</xsl:text>
					<xsl:text>\\</xsl:text>
				</xsl:if>				
			</xsl:otherwise>
		</xsl:choose>
		
		
		<xsl:if test="$include-class-meta">
			<xsl:if test="$author != ''">
				<xsl:text>\scriptsize{Author:} &amp; </xsl:text>
				<xsl:text>\scriptsize{</xsl:text>
				<xsl:call-template name="emph">
					<xsl:with-param name="input" select="normalize-space($author)" />
				</xsl:call-template>
				<xsl:text>}</xsl:text>
				<xsl:text>\\</xsl:text>
				<xsl:value-of select="$newline" />
			</xsl:if>
		
			<xsl:if test="$since != ''">
				<xsl:text>\scriptsize{Since:} &amp; </xsl:text>
				<xsl:text>\scriptsize{</xsl:text>
				<xsl:call-template name="emph">
					<xsl:with-param name="input" select="normalize-space($since)" />
				</xsl:call-template>
				<xsl:text>}</xsl:text>
				<xsl:text>\\</xsl:text>
				<xsl:value-of select="$newline" />
			</xsl:if>
		
			<xsl:if test="$langversion != ''">
				<xsl:text>\scriptsize{Language version:} &amp; </xsl:text>
				<xsl:text>\scriptsize{</xsl:text>
				<xsl:call-template name="emph">
					<xsl:with-param name="input" select="normalize-space($langversion)" />
				</xsl:call-template>
				<xsl:text>}</xsl:text>
				<xsl:text>\\</xsl:text>
				<xsl:value-of select="$newline" />
			</xsl:if>
		
			<xsl:if test="$playerversion != ''">
				<xsl:text>\scriptsize{Runtime version:} &amp; </xsl:text>
				<xsl:text>\scriptsize{</xsl:text>
				<xsl:call-template name="emph">
					<xsl:with-param name="input" select="normalize-space($playerversion)" />
				</xsl:call-template>
				<xsl:text>}</xsl:text>
				<xsl:text>\\</xsl:text>
				<xsl:value-of select="$newline" />
			</xsl:if>
		</xsl:if>

		<xsl:text>\end{tabularx}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="class-summary">
		<xsl:param name="constants" select="''"/>
		<xsl:param name="public-methods" select="''"/>
		<xsl:param name="protected-methods" select="''"/>
		<xsl:param name="public-properties" select="''"/>
		<xsl:param name="protected-properties" select="''"/>
		
		<xsl:if test="count($constants) &gt; 0 or count($public-methods) &gt; 0 or count($protected-methods) &gt; 0 or count($public-properties) &gt; 0 or count($protected-properties) &gt; 0">
			<xsl:call-template name="subtitle">
				<xsl:with-param name="input" select="'Summary'" />
			</xsl:call-template>
		</xsl:if>
		
		<xsl:if test="count($constants) &gt; 0">
			<xsl:call-template name="summary-listing">
				<xsl:with-param name="input" select="$constants" />
				<xsl:with-param name="title" select="'Constants'" />
				<xsl:with-param name="listing-xref" select="concat(@id,$constants-xref-id)" />
			</xsl:call-template>
		</xsl:if>
		
		<xsl:if test="count($public-methods) &gt; 0">
			<xsl:call-template name="summary-listing">
				<xsl:with-param name="input" select="$public-methods" />
				<xsl:with-param name="title" select="'Public methods'" />
				<xsl:with-param name="property" select="false()" />				
				<xsl:with-param name="listing-xref" select="concat(@id,$public-methods-xref-id)" />				
			</xsl:call-template>
		</xsl:if>
		
		<xsl:if test="count($protected-methods) &gt; 0">
			<xsl:call-template name="summary-listing">
				<xsl:with-param name="input" select="$protected-methods" />
				<xsl:with-param name="title" select="'Protected methods'" />
				<xsl:with-param name="property" select="false()" />
				<xsl:with-param name="listing-xref" select="concat(@id,$protected-methods-xref-id)" />	
			</xsl:call-template>
		</xsl:if>
		
		<xsl:if test="count($public-properties) &gt; 0">
			<xsl:call-template name="summary-listing">
				<xsl:with-param name="input" select="$public-properties" />
				<xsl:with-param name="title" select="'Public properties'" />
				<xsl:with-param name="listing-xref" select="concat(@id,$public-properties-xref-id)" />				
			</xsl:call-template>
		</xsl:if>
		
		<xsl:if test="count($protected-properties) &gt; 0">
			<xsl:call-template name="summary-listing">
				<xsl:with-param name="input" select="$protected-properties" />
				<xsl:with-param name="title" select="'Protected properties'" />
				<xsl:with-param name="listing-xref" select="concat(@id,$protected-properties-xref-id)" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="summary-listing">
		<xsl:param name="input" select="''"/>
		<xsl:param name="title" select="''"/>
		<xsl:param name="listing-xref" select="''"/>
		<xsl:param name="property" select="true()"/>
		<xsl:param name="defined-by" select="'Defined by'"/>
		
		<xsl:value-of select="$newline" />
		<xsl:text>{\scriptsize</xsl:text>
		<xsl:value-of select="$newline" />
		
		<xsl:if test="$title != ''">
			<xsl:choose>
				<xsl:when test="$listing-xref != ''">
					<xsl:call-template name="xref">
						<xsl:with-param name="input" select="$listing-xref" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="escape">
						<xsl:with-param name="input" select="$title" />
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- TODO: move the hspace to a template -->
			<xsl:text>\hspace{\stretch{1}}</xsl:text>
			
			<xsl:text>Defined by</xsl:text>
			<xsl:text>\\</xsl:text>
			<xsl:value-of select="$newline" />
			
			<!-- TODO: move the rule to a template -->
			<xsl:value-of select="'\rule[0cm]{\textwidth}{0.01cm}'" />
			<xsl:value-of select="$newline" />
		</xsl:if>
		
		<xsl:for-each select="$input">
			
			<!--
			<xsl:call-template name="xref">
				<xsl:with-param name="input" select="@id" />
			</xsl:call-template>
			-->
			
			<xsl:choose>
				<xsl:when test="$property">
					<xsl:call-template name="property-summary-listing-title" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="method-summary-listing-title" />
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- TODO: defined by look up -->
			<xsl:text>\hspace{\stretch{1}}</xsl:text>
			
			<xsl:call-template name="escape">
				<xsl:with-param name="input" select="../apiName" />
			</xsl:call-template>			
			
			<xsl:if test=".//apiDeprecated | .//prolog/asCustoms/deprecated">
				<xsl:text>\\</xsl:text>
				<xsl:value-of select="$newline" />
				<xsl:call-template name="deprecated" />
			</xsl:if>
			<xsl:text>\\</xsl:text>
			<xsl:value-of select="$newline" />
			
			<xsl:choose>
				<xsl:when test="normalize-space(shortdesc) = ''">
					<xsl:call-template name="missing" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="auto-xref">
						<xsl:with-param name="input">					
							<xsl:call-template name="escape">
								<xsl:with-param name="input" select="normalize-space(shortdesc)" />
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:text>\\</xsl:text>
			<xsl:value-of select="$newline" />				
		</xsl:for-each>
		
		<!-- end size block -->
		<xsl:text>}</xsl:text>		
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="property-summary-listing-title">
		
		<!--
		<xsl:call-template name="xref">
			<xsl:with-param name="input" select="@id" />
		</xsl:call-template>
		-->
		
		<xsl:call-template name="property-signature">
			<xsl:with-param name="title" select="''" />
			<xsl:with-param name="abbreviated" select="true()" />
			<xsl:with-param name="alltt" select="false()" />
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="method-summary-listing-title">
		
		<!--
		<xsl:call-template name="xref">
			<xsl:with-param name="input" select="@id" />
		</xsl:call-template>
		-->
		
		<xsl:call-template name="method-signature">
			<xsl:with-param name="title" select="''" />
			<xsl:with-param name="abbreviated" select="true()" />
			<xsl:with-param name="break" select="false()" />			
			<xsl:with-param name="alltt" select="false()" />
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="textcolor">
		<xsl:param name="input" select="''" />
		<xsl:param name="color" select="'red'" />
		<xsl:text>\textcolor{</xsl:text>
		<xsl:value-of select="$color" />
		<xsl:text>}{</xsl:text>
		<xsl:value-of select="$input" />
		<xsl:text>}</xsl:text>
	</xsl:template>	
	
	<xsl:template name="start-paragraph">
		<xsl:value-of select="$newline" />	
		<xsl:text>\paragraph{</xsl:text>
	</xsl:template>
	
	<xsl:template name="end-paragraph">
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="start-emph">
		<xsl:text>\emph{</xsl:text>
	</xsl:template>
	
	<xsl:template name="start-textbf">
		<xsl:text>\textbf{</xsl:text>
	</xsl:template>	
	
	<xsl:template name="start-textsc">
		<xsl:text>\textsc{</xsl:text>
	</xsl:template>

	<xsl:template name="start-tt">
		<xsl:text>\texttt{</xsl:text>
	</xsl:template>
	
	<xsl:template name="start-all-tt">
		<xsl:text>\begin{alltt}</xsl:text>
	</xsl:template>	
	
	<xsl:template name="end-all-tt">
		<xsl:text>\end{alltt}</xsl:text>
	</xsl:template>	
	
	<xsl:template name="start-section">
		<xsl:text>\section{</xsl:text>
	</xsl:template>	
	
	<xsl:template name="start-subsection">
		<xsl:text>\subsection{</xsl:text>
	</xsl:template>
	
	<xsl:template name="start-subsubsection">
		<xsl:text>\subsubsection{</xsl:text>
	</xsl:template>
		
	<xsl:template name="start-tag">
		<xsl:param name="input" />
		<xsl:if test="matches($input,'^i|em$')">
			<xsl:call-template name="start-emph" />
		</xsl:if>
		<xsl:if test="matches($input,'^b|strong$')">
			<xsl:call-template name="start-textbf" />
		</xsl:if>
		<xsl:if test="matches($input,'^code|codeph$')">
			<xsl:call-template name="start-tt" />
		</xsl:if>
		
		<xsl:if test="matches($input,'^h1$')">
			<xsl:call-template name="start-section" />
		</xsl:if>
		<xsl:if test="matches($input,'^h2$')">
			<xsl:call-template name="start-subsection" />
		</xsl:if>
		<xsl:if test="matches($input,'^h3$')">
			<xsl:call-template name="start-subsubsection" />
		</xsl:if>

		<xsl:if test="matches($input,'^p$')">
			<xsl:call-template name="start-paragraph" />
		</xsl:if>
		
		<xsl:if test="matches($input,'^ul|ol$')">
			<xsl:call-template name="start-itemize" />
		</xsl:if>
		
		<xsl:if test="matches($input,'^li$')">
			<xsl:value-of select="'\item '" />
		</xsl:if>
		
		<xsl:if test="matches($input,'^pre$')">
			<xsl:call-template name="start-all-tt" />
		</xsl:if>										
	</xsl:template>
	
	<xsl:template name="end-tag">
		<xsl:param name="input" />
		<xsl:param name="default-output" select="'}'" />
		<xsl:if test="matches($input,'^i|em$')">
			<xsl:value-of select="$default-output" />
		</xsl:if>
		<xsl:if test="matches($input,'^b|strong$')">
			<xsl:value-of select="$default-output" />
		</xsl:if>		
		<xsl:if test="matches($input,'^code|codeph$')">
			<xsl:value-of select="$default-output" />
		</xsl:if>		
		<xsl:if test="matches($input,'^h1|h2|h3$')">
			<xsl:value-of select="$default-output" />
		</xsl:if>
		<xsl:if test="matches($input,'^p$')">
			<xsl:value-of select="$default-output" />
		</xsl:if>			
		
		<xsl:if test="matches($input,'^ul|ol$')">
			<xsl:call-template name="end-itemize" />
		</xsl:if>	
		
		<xsl:if test="matches($input,'^pre$')">
			<xsl:call-template name="end-all-tt" />
		</xsl:if>		
	</xsl:template>

	<xsl:template name="auto-xref">	
		<xsl:param name="input" />
		
		<xsl:variable name="lines" select="tokenize($input,'\n')" />
		<xsl:for-each select="$lines">
			<xsl:variable name="line" select="string(.)" />
			
			<xsl:variable name="words" select="tokenize($line, ' ')" />
			<xsl:if test="position() &gt; 1">
				<xsl:value-of select="$newline" />
			</xsl:if>
			<xsl:for-each select="$words">
				<xsl:variable name="word" select="string(.)" />
				
				<!-- Test for the word matching a known class or interface -->
				<xsl:variable name="match"
					select="$toplevel//classRec[@name = replace($word,'^!{1}','')] | $toplevel//interfaceRec[@name = replace($word,'^!{1}','')]" />
				<xsl:variable name="negated-xref" select="matches($word,'^!') and $match" />
				
				<!-- negated xrefs that would match are stripped
					of the negation '!' and output with no xref -->
				<xsl:if test="$negated-xref">
					<xsl:value-of select="replace($word,'^!{1}','')" />
				</xsl:if>
				
				<!-- hash characters may have been escaped for latex output -->
				<xsl:variable name="nameref" select="matches($word,'^(\\)?#([^#;]+);?$')" />
				<xsl:variable name="inline-nameref" select="matches($word,'^(\\)?#([^#;]+);')" />
				
				<!-- an explicit \nameref, for example: #prefix:lib:category:feature -->
				<xsl:if test="$nameref or $inline-nameref">
					<xsl:variable name="word" select="substring-after($word,'#')" />
					<!-- <xsl:value-of select="concat( 'ADDING MANUAL NAME REF: ', $word )" /> -->
					<xsl:choose>
						<xsl:when test="$nameref">
							<!-- strip any trailing delimiter -->
							<xsl:variable name="word" select="replace($word,';{1}$','')" />
							<xsl:call-template name="nameref">
								<xsl:with-param name="input" select="$word" />
							</xsl:call-template>
						</xsl:when>
						<!-- handle *inline* namerefs that have been terminated with a semi-colon
							For example: #lib:term;'s -->
						<xsl:otherwise>
							<xsl:variable name="remainder" select="substring-after($word,';')" />
							<xsl:variable name="word" select="substring-before($word,';')" />
							<xsl:call-template name="nameref">
								<xsl:with-param name="input" select="$word" />
							</xsl:call-template>
							<xsl:if test="$remainder != ''">
								<!-- TODO: xref the remainder -->							
								<xsl:value-of select="$remainder" />
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				
				<!-- try to automatically xref to a documented class/interface -->
				<xsl:if test="not($negated-xref)">
					<xsl:choose>
						<xsl:when test="$match and not($nameref) and not($inline-nameref)">
							<xsl:call-template name="nameref">
								<xsl:with-param name="input" select="$match/@fullname" />
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="not($nameref) and not($inline-nameref)">
								<xsl:value-of select="$word" />
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				
				<!-- add intermediary whitespace that we tokenized on -->
				<xsl:if test="position() &lt; count( $words )">
					<xsl:value-of select="' '" />
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="sanitize-item">
		<xsl:param name="input" />
		
		<!-- <xsl:value-of select="concat( '[SANITIZE ITEM]: ', count( $input/text() ), ':', count( $input/* ), $newline )" /> -->
		
		<xsl:for-each select="$input/text() | $input/*">
			<xsl:variable name="plain-circumflex" select="name() = 'pre' or ../name() = 'pre'" />
			<xsl:choose>
				<!-- pass text elements through escaped and cross-referenced -->
				<xsl:when test="self::text()">
					<xsl:call-template name="auto-xref">
						<xsl:with-param name="input">
							<xsl:call-template name="escape">
								<xsl:with-param name="input" select="." />
								<xsl:with-param name="plain-circumflex" select="$plain-circumflex" />
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<!-- handle tag to latex conversion -->
				<xsl:otherwise>
					<xsl:variable name="isLabel" select="name() = 'a' and @name != '' and starts-with( @name, '#' )" />
					<xsl:variable name="isXref" select="name() = 'a' and @href != '' and starts-with( @href, '#' )" />
					<xsl:choose>
						<xsl:when test="$isLabel or $isXref">
							<xsl:if test="$isLabel">
								<xsl:call-template name="label">
									<xsl:with-param name="title" select="substring-after( @name, '#' )" />
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="$isXref">
								<xsl:call-template name="nameref">
									<xsl:with-param name="input" select="substring-after( @href, '#' )" />
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<!-- open the tag -->
							<xsl:call-template name="start-tag">
								<xsl:with-param name="input" select="name()" />
							</xsl:call-template>

							<!-- cross referenced and escaped content for the tag -->
							<xsl:variable name="contents">
								<xsl:call-template name="auto-xref">
									<xsl:with-param name="input">	
										<xsl:call-template name="escape">
											<xsl:with-param name="input" select="." />
											<xsl:with-param name="plain-circumflex" select="$plain-circumflex" />
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:variable>

							<xsl:choose>
								<!-- sanitize child elements -->
								<xsl:when test="count( ./text() | ./* ) &gt; 0">
									<!-- <xsl:value-of select="concat( '[RECURSE THROUGH CHILD NODES]', name() , $newline )" /> -->
									<xsl:call-template name="sanitize-item">
										<xsl:with-param name="input" select="." />
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$contents" />
								</xsl:otherwise>
							</xsl:choose>

							<!-- close the tag -->
							<xsl:call-template name="end-tag">
								<xsl:with-param name="input" select="name()" />
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="sanitize">	
		<xsl:param name="input" />
		
		<!--
		<xsl:variable name="input" select="replace($input,'^\s+','')" />
		<xsl:variable name="input" select="replace($input,'\s+$','')" />
		-->
		
		<!-- <xsl:value-of select="concat( '[SANITIZE ESCAPED]: ', $input, $newline, $newline )" /> -->
		
		<!-- handle escaped markup by parsing into a document using saxon:parse() -->
		<xsl:variable name="x" select="saxon:parse(concat('&lt;root&gt;',string($input),'&lt;/root&gt;'))" />
		<!-- <xsl:for-each select="$x/root/text() | $x/root/*"> -->
			<xsl:call-template name="sanitize-item">
				<xsl:with-param name="input" select="$x/root" />
			</xsl:call-template>
		<!-- </xsl:for-each> -->
	</xsl:template>
	
	<xsl:template name="description-paragraph">
		<xsl:param name="input" />
		<xsl:param name="end" select="true()" />
		<xsl:call-template name="start-paragraph" />
		<xsl:call-template name="sanitize">
			<xsl:with-param name="input" select="$input" />
		</xsl:call-template>
		<xsl:if test="$end">
			<xsl:call-template name="end-paragraph" />
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="paragraph">
		<xsl:param name="text" />
		<xsl:call-template name="start-paragraph" />
		<xsl:value-of select="$text"/>
		<xsl:call-template name="end-paragraph" />
	</xsl:template>
	
	<xsl:template name="textsc">
		<xsl:param name="input" />
		<xsl:text>\textsc{</xsl:text>
		<xsl:value-of select="$input" />
		<xsl:text>}</xsl:text>
	</xsl:template>
	
	<xsl:template name="textbf">
		<xsl:param name="input" />
		<xsl:text>\textbf{</xsl:text>
		<xsl:value-of select="$input" />
		<xsl:text>}</xsl:text>
	</xsl:template>	
	
	<xsl:template name="texttt">
		<xsl:param name="input" />
		<xsl:text>\texttt{</xsl:text>
		<xsl:value-of select="$input" />
		<xsl:text>}</xsl:text>
	</xsl:template>
	
	<xsl:template name="emph">
		<xsl:param name="input" />
		<xsl:call-template name="start-emph" />
		<xsl:value-of select="$input" />
		<xsl:text>}</xsl:text>
	</xsl:template>
	
	<xsl:template name="footer">
		<xsl:text>
\end{document}
		</xsl:text>
	</xsl:template>
	
	<xsl:template name="escape">
		<xsl:param name="input" />
		
		<xsl:param name="plain-tilde" select="false()" />
		<xsl:param name="plain-circumflex" select="false()" />		
		
		<!-- <xsl:value-of select="'\begin{math}'" /> -->

		<!-- backslash characters must be escaped first using placeholder for the curly braces -->
		<xsl:variable name="backslash">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$input" />
				<xsl:with-param name="search-string" select="'([^\\]?)\\(!(\{|\}))*'" />
				<xsl:with-param name="replace-string" select="'$1\\textbackslash[]$2'" />
			</xsl:call-template>
		</xsl:variable>
		<!-- curly braces must be escaped next -->	
		<xsl:variable name="left-brace">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$backslash" />
				<xsl:with-param name="search-string" select="'([^\\]?)\{'" />
				<xsl:with-param name="replace-string" select="'$1\\{'" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="right-brace">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$left-brace" />
				<xsl:with-param name="search-string" select="'([^\\]?)\}'" />
				<xsl:with-param name="replace-string" select="'$1\\}'" />
			</xsl:call-template>
		</xsl:variable>	
		<!-- change the backslash placeholder -->
		<xsl:variable name="backslash-replace">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$right-brace" />
				<xsl:with-param name="search-string" select="'\\textbackslash\[\]'" />
				<xsl:with-param name="replace-string" select="'\\textbackslash{}'" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="percent">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$backslash-replace" />
				<xsl:with-param name="search-string" select="'([^\\]?)%'" />
				<xsl:with-param name="replace-string" select="'$1\\%'" />
			</xsl:call-template>
		</xsl:variable>	
		<xsl:variable name="circumflex">			
			<xsl:choose>
				<xsl:when test="not($plain-circumflex)">
					<xsl:call-template name="search-and-replace">
						<xsl:with-param name="input" select="$percent" />
						<xsl:with-param name="search-string" select="'([^\\]?)\^'" />
						<xsl:with-param name="replace-string" select="'$1\\char`\\^'" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$percent" />
				</xsl:otherwise>				
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tilde">
			<xsl:choose>
				<xsl:when test="not($plain-tilde)">
					<xsl:call-template name="search-and-replace">
						<xsl:with-param name="input" select="$circumflex" />
						<xsl:with-param name="search-string" select="'([^\\]?)~'" />
						<xsl:with-param name="replace-string" select="'$1\\char`\\~\\'" />
					</xsl:call-template>					
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$circumflex" />
				</xsl:otherwise>				
			</xsl:choose>
		</xsl:variable>	
		<xsl:variable name="underscore">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$tilde" />
				<xsl:with-param name="search-string" select="'([^\\]?)_'" />
				<xsl:with-param name="replace-string" select="'$1\\_'" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="hash">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$underscore" />
				<xsl:with-param name="search-string" select="'([^\\]?)#'" />
				<xsl:with-param name="replace-string" select="'$1\\#'" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:call-template name="search-and-replace">
			<xsl:with-param name="input" select="$hash" />
			<xsl:with-param name="search-string" select="'([^\\]?)\$'" />
			<xsl:with-param name="replace-string" select="'$1\\\$'" />
		</xsl:call-template>
		
		<!-- <xsl:value-of select="'\end{math}'" />	-->
	</xsl:template>	
	
	<xsl:template name="escape-label">
		<xsl:param name="input" />
		<xsl:param name="label" select="$input" />
		
		<!--
		<xsl:variable name="label">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$input" />
				<xsl:with-param name="search-string" select="':get$'" />
				<xsl:with-param name="replace-string" select="''" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="label">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$label" />
				<xsl:with-param name="search-string" select="':set$'" />
				<xsl:with-param name="replace-string" select="''" />
			</xsl:call-template>
		</xsl:variable>
		-->
		
		<xsl:variable name="underscore">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$label" />
				<xsl:with-param name="search-string" select="'_'" />
				<xsl:with-param name="replace-string" select="'.'" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="hash">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$underscore" />
				<xsl:with-param name="search-string" select="'#'" />
				<xsl:with-param name="replace-string" select="':'" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:call-template name="search-and-replace">
			<xsl:with-param name="input" select="$hash" />
			<xsl:with-param name="search-string" select="'\$'" />
			<xsl:with-param name="replace-string" select="'::'" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="search-and-replace">
		<xsl:param name="input"/>
		<xsl:param name="search-string"/>
		<xsl:param name="replace-string"/>
		<xsl:value-of select="replace($input,$search-string,$replace-string)" />
	</xsl:template>	
	
	<xsl:template name="header">
		
		<xsl:call-template name="header-preamble" />
		<xsl:call-template name="header-packages" />
		<xsl:text><![CDATA[
\hypersetup{
	colorlinks,
	linkcolor=blue,
	urlcolor=blue,
	bookmarks=true,
	bookmarksopen=true,
	%pdftoolbar=true,
	%pdfmenubar=true,
	pdffitwindow=true,
	pdftitle={Actionscript Documentation},
	pdfkeywords={Flash, Actionscript},
	pdfauthor={Mischa Williamson}
}
\urlstyle{rm}
\pdfpagewidth=\paperwidth
\pdfpageheight=\paperheight

\renewcommand{\paragraph}{\small}
]]></xsl:text>

<!--
\title{\paragraph{\textbf{\huge{Fluid Ecosystem}}
\\
\vspace{2em}
\small{"Empty your mind, be formless. Shapeless, like water. If you put water into a cup, it becomes the cup. You put water into a bottle and it becomes the bottle. You put it in a teapot, it becomes the teapot. Now, water can flow or it can crash. Be water, my friend." - Bruce Lee}}\vfill}
-->

<xsl:value-of select="concat('\title{\paragraph{\textbf{\huge{',$title,'}}',$newline,'\\',$newline,'\vspace{2em}')" />
<xsl:value-of select="$newline" />
<xsl:if test="$sub-title != ''">
	<xsl:value-of select="concat('\small{', $sub-title),'}'" />
</xsl:if>

<!-- close the document title and child paragraph -->
<xsl:value-of select="'\vfill}}'" />

<!-- clear date output if necessary -->
<xsl:choose>
	<xsl:when test="$date = ''">
		<xsl:value-of select="concat('\date{}',$newline)" />
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="$date" />
	</xsl:otherwise>
</xsl:choose>

<!-- output author information for a title page -->
<xsl:if test="$author != ''">
	<xsl:value-of select="concat($newline,'\author{',$author,'}')" />
</xsl:if>

<xsl:text><![CDATA[
\makeindex

%fix for the toc overlap problem
\makeatletter
  \renewcommand\l@subsubsection{\@dottedtocline{2}{1.5em}{4em}}
\makeatother

\begin{document} 

\maketitle

\fancyhead{}
\fancyfoot{}
]]></xsl:text>

<xsl:call-template name="left-page-header" />
<xsl:call-template name="right-page-header" />

<xsl:text><![CDATA[
\lfoot{\scriptsize{\textsc{\thepage\ of \pageref{LastPage}}}}
\rfoot{\scriptsize{\textsc{Last updated \today}}}

\scriptsize{\tableofcontents}

\clearpage
]]></xsl:text>
	</xsl:template>	
	
	<xsl:template name="header-preamble">
		<xsl:text><![CDATA[\documentclass[a4paper,titlepage,oneside]{article}
]]></xsl:text>
	</xsl:template>	
	
	<xsl:template name="header-packages">
		<xsl:text><![CDATA[% Palatino for rm and math | Helvetica for ss | Courier for tt
\usepackage{mathpazo}

% math & rm
\linespread{1.25} 

% Palatino needs more leading (space between lines)
\usepackage[scaled]{helvet} 

% ss
\usepackage{courier}

% tt
\normalfont 
\usepackage[T1]{fontenc} 
\usepackage{array}
\usepackage{setspace}
\usepackage{alltt}
\usepackage{geometry} 
\usepackage[parfill]{parskip} 
\usepackage{graphicx} 
\usepackage{bookmark}
\usepackage{amssymb} 
\usepackage{epstopdf} 
\usepackage{makeidx}
\usepackage{showidx}
\usepackage{lastpage}
\usepackage{url} 
\usepackage{moreverb}
\usepackage{listings}
\usepackage{tabularx}
\usepackage{longtable}
\usepackage{wallpaper}
\usepackage{hyperref}

\usepackage{fancyhdr}
%\setlength{\headheight}{15.2pt}
\pagestyle{fancy}

\lstset{breaklines=true,basicstyle=\ttfamily}

% increase table row top padding
\setlength{\extrarowheight}{2.5pt}

\newcolumntype{L}{>{\raggedright\arraybackslash}X}%
\newcolumntype{C}{>{\centering\arraybackslash}X}%
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}%
]]></xsl:text>
	</xsl:template>	
	
	<xsl:template name="left-page-header">
		<xsl:text><![CDATA[
\lhead{\textbf{\textsc{
]]></xsl:text>
	<xsl:value-of select="$page-header-left" />
	<xsl:text><![CDATA[}}}]]></xsl:text>
	</xsl:template>	
	
	<xsl:template name="right-page-header">
		<xsl:text><![CDATA[
\rhead{\textbf{\textsc{
]]></xsl:text>
	<xsl:value-of select="$page-header-right" />
	<xsl:text><![CDATA[}}}]]></xsl:text>
	</xsl:template>	
	
</xsl:stylesheet>
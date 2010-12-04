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
	<xsl:param name="page-header-right" select="'API Documentation'"/>
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
	
	<xsl:variable name="packages" select="document($packages-map-path)" />
	<xsl:variable name="toplevel" select="document($toplevel-path)" />
	
	<xsl:variable name="start-verb" select="'\verb|'" />
	<xsl:variable name="end-verb" select="'|'" />

	<xsl:variable name="newline">
		<xsl:text>
</xsl:text>
	</xsl:variable>
	<xsl:variable name="tab" select="'  '" />
	
	<xsl:template match="/">

		<xsl:call-template name="header" />
		
		<!--  PACKAGES-->
		<xsl:for-each select="$packages//apiItemRef">
			
			<!--  PACKAGE-->
			<xsl:variable name="package-path" select="concat($dita-dir,$delimiter,@href)" />
			<xsl:variable name="package" select="document($package-path)" />
			<xsl:variable name="package-id" select="$package/apiPackage/@id"/>
			<xsl:variable name="package-id-null" select="concat($package-id,'.null')"/>
			
			<xsl:variable name="package-interfaces" select="$toplevel//interfaceRec[@namespace = $package-id]"/>
			<xsl:variable name="package-classes" select="$toplevel//classRec[@namespace = $package-id]"/>
			
			<xsl:call-template name="part">
				<xsl:with-param name="title" select="$package-id"/>
				<xsl:with-param name="label" select="$package-id"/>
			</xsl:call-template>
			
			<!-- package description if available -->
			<xsl:variable name="package-description" select="$toplevel//packageRec[@fullname = $package-id or @fullname = $package-id-null]" />
			<xsl:if test="$package-description">
				<xsl:call-template name="paragraph">
					<xsl:with-param name="text" select="$package-description/description"/>
				</xsl:call-template>
			</xsl:if>
			
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
				
				<xsl:call-template name="section">
					<xsl:with-param name="title" select="apiName"/>
					<xsl:with-param name="label" select="$class-id"/>
				</xsl:call-template>
				
				<xsl:call-template name="class-details">
					<xsl:with-param name="package" select="$package-id"/>
				</xsl:call-template>
				
				<!-- CLASS DESCRIPTION -->
				<xsl:call-template name="paragraph">
					<xsl:with-param name="text" select="apiClassifierDetail/apiDesc"/>
				</xsl:call-template>
				
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
						<xsl:with-param name="title" select="'Constructor'"/>
						<xsl:with-param name="label" select="concat($class-id,':constructor')"/>
					</xsl:call-template>
					<xsl:call-template name="paragraph">
						<xsl:with-param name="text" select="apiConstructor/apiConstructorDetail/apiDesc"/>
					</xsl:call-template>
					
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
							<xsl:call-template name="paragraph">
								<xsl:with-param name="text" select="apiValueDetail/apiDesc"/>
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
	
	<xsl:template name="appendix">
		
		<xsl:variable name="classes" select="$toplevel//classRec" />
		<xsl:variable name="interfaces" select="$toplevel//interfaceRec" />		
		
		<xsl:call-template name="part">
			<xsl:with-param name="title" select="'Appendix'"/>
			<xsl:with-param name="label" select="'appendix'"/>
		</xsl:call-template>
		
		<!-- ALL CLASSES -->
		<xsl:if test="count($classes) &gt; 0">
			<xsl:call-template name="section">
				<xsl:with-param name="title" select="'Class Index'"/>
				<xsl:with-param name="label" select="'class:index'"/>
			</xsl:call-template>
			<xsl:for-each select="$packages//apiItemRef">
				<xsl:variable name="package-path" select="concat($dita-dir,$delimiter,@href)" />
				<xsl:variable name="package" select="document($package-path)" />
				<xsl:variable name="package-id" select="$package/apiPackage/@id"/>
				<xsl:variable name="package-id-null" select="concat($package-id,'.null')"/>
				<xsl:variable name="package-classes" select="$toplevel//classRec[@namespace = $package-id]"/>
				<xsl:if test="count($package-classes) &gt; 0">
					<xsl:call-template name="subsection">
						<xsl:with-param name="title">
							<xsl:call-template name="xref">
								<xsl:with-param name="input" select="$package-id"/>
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
			<xsl:call-template name="section">
				<xsl:with-param name="title" select="'Interface Index'"/>
				<xsl:with-param name="label" select="'interface:index'"/>
			</xsl:call-template>
			<xsl:for-each select="$packages//apiItemRef">
				<xsl:variable name="package-path" select="concat($dita-dir,$delimiter,@href)" />
				<xsl:variable name="package" select="document($package-path)" />
				<xsl:variable name="package-id" select="$package/apiPackage/@id"/>
				<xsl:variable name="package-id-null" select="concat($package-id,'.null')"/>
				<xsl:variable name="package-interfaces" select="$toplevel//interfaceRec[@namespace = $package-id]"/>
				<xsl:if test="count($package-interfaces) &gt; 0">
					<xsl:call-template name="subsection">
						<xsl:with-param name="title">
							<xsl:call-template name="xref">
								<xsl:with-param name="input" select="$package-id"/>
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
			
			<xsl:call-template name="begin-paragraph" />
			<xsl:call-template name="deprecated" />
			<xsl:call-template name="end-paragraph" />
									
			<xsl:call-template name="paragraph">
				<xsl:with-param name="text" select="apiOperationDetail/apiDesc"/>
			</xsl:call-template>
			<xsl:call-template name="parameter-list" />
			<xsl:call-template name="method-return" />
			<xsl:call-template name="exceptions-list" />
			<xsl:call-template name="method-signature" />
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
				<xsl:call-template name="paragraph">
					<xsl:with-param name="text" select="apiValueDetail/apiDesc"/>
				</xsl:call-template>
				<xsl:call-template name="property-signature" />						
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
			
			<xsl:call-template name="begin-itemize" />
		
			<xsl:for-each select="$input">
				<xsl:sort select="linktext" />
				<xsl:choose>
					<xsl:when test="@href != ''">
						
						<!-- valid href attribute we should have a valid xref -->
						<xsl:variable name="xref">
							<xsl:call-template name="search-and-replace">
								<xsl:with-param name="input" select="@href" />
								<xsl:with-param name="search-string" select="'.xml'" />
								<xsl:with-param name="replace-string" select="''" />
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
								<xsl:with-param name="search-string" select="'.xml'" />
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
		<xsl:param name="type" select="apiValueDetail/apiValueDef/apiType/@value" />
		<xsl:param name="api-data" select="apiValueDetail/apiValueDef/apiData" />
		<xsl:param name="accessor" select="contains(@id,':get') or contains(@id,':set')" />
		<xsl:param name="api-value-access" select="apiValueDetail/apiValueDef/apiValueAccess/@value" />
		<xsl:param name="static" select="apiValueDetail/apiValueDef/apiStatic" />
		<xsl:param name="constant" select="apiValueDetail/apiValueDef/apiProperty" />
		
		<xsl:call-template name="subtitle">
			<xsl:with-param name="input" select="'Implementation'" />
		</xsl:call-template>		
		
		<xsl:value-of select="$newline" />
		<xsl:value-of select="'\scriptsize{'" />
		<xsl:value-of select="$start-verb" />
		
		<xsl:value-of select="$access" />
		
		<xsl:if test="apiValueDetail/apiValueDef/apiStatic">
			<xsl:text> </xsl:text><xsl:value-of select="'static'" />
		</xsl:if>
		
		<xsl:if test="not(apiValueDetail/apiValueDef/apiProperty)">
			<xsl:text> </xsl:text><xsl:value-of select="'const'" />
		</xsl:if>
		
		<xsl:if test="not($accessor) and apiValueDetail/apiValueDef/apiProperty">
			<xsl:text> </xsl:text><xsl:value-of select="'var'" />
		</xsl:if>
		
		<xsl:if test="$accessor">
			<xsl:choose>
				<xsl:when test="$api-value-access = 'write'">
					<xsl:text> </xsl:text><xsl:value-of select="'function set'" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> </xsl:text><xsl:value-of select="'function get'" />				
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		
		<xsl:text> </xsl:text>
		<xsl:value-of select="$name" />
		
		<xsl:if test="$accessor">
			<xsl:value-of select="'()'" />
		</xsl:if>
		
		<xsl:if test="$type != ''">
			<xsl:text>:</xsl:text><xsl:value-of select="$type" />
		</xsl:if>
		<xsl:if test="$api-data != ''">
			<xsl:value-of select="$end-verb" />
			<xsl:value-of select="'\\'" />
			<xsl:value-of select="$newline" />
			<xsl:value-of select="$start-verb" />
			<xsl:text> = </xsl:text>
			<xsl:value-of select="$api-data" />
		</xsl:if>
		
		<!-- also add a setter for readwrite -->
		<xsl:if test="$api-value-access = 'readwrite'">
			<xsl:value-of select="$end-verb" />
			<xsl:value-of select="'\\'" />
			<xsl:value-of select="$newline" />
			<xsl:value-of select="$start-verb" />
			<xsl:value-of select="$access" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="'function set'" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="$name" />
			<xsl:value-of select="'(value:'" />
			<xsl:value-of select="$type" />
			<xsl:value-of select="'):void'" />
		</xsl:if>
		<xsl:value-of select="$end-verb" />
		<xsl:value-of select="'}'" />	
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="constructor-signature">		
		<xsl:call-template name="method-signature">
			<xsl:with-param name="access" select="apiConstructor/apiConstructorDetail/apiConstructorDef/apiAccess/@value" />
			<xsl:with-param name="name" select="apiName" />
			<xsl:with-param name="return-type" select="''" />
			<xsl:with-param name="params" select="apiConstructor/apiConstructorDetail/apiConstructorDef/apiParam" />
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="method-signature">
		<xsl:param name="params" select="apiOperationDetail/apiOperationDef/apiParam" />
		<xsl:param name="access" select="apiOperationDetail/apiOperationDef/apiAccess/@value" />
		<xsl:param name="name" select="apiName" />
		<xsl:param name="return-type" select="apiOperationDetail/apiOperationDef/apiReturn/apiType/@value" />
		
		<xsl:call-template name="subtitle">
			<xsl:with-param name="input" select="'Implementation'" />
		</xsl:call-template>				
		
		<xsl:call-template name="begin-paragraph" />
		<xsl:value-of select="'{\scriptsize'" />
		<xsl:value-of select="$start-verb" />
		<xsl:value-of select="$access" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="'function'" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="$name" />
		
		<xsl:choose>
			<xsl:when test="count(.//apiParam) = 0">
				<xsl:value-of select="'()'" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'('" />	
				<xsl:call-template name="get-parameters">
					<xsl:with-param name="params" select="$params" />
				</xsl:call-template>
				<xsl:value-of select="')'" />
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="$return-type != ''">
			
			
			<xsl:choose>
				<xsl:when test="$return-type != 'any'">
					
					<!-- TODO: xref on return type -->
					
					<xsl:value-of select="concat(':',$return-type)" />
				</xsl:when>
				<xsl:otherwise>	
					<xsl:value-of select="':*'" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:value-of select="$end-verb" />
		<xsl:value-of select="'}'" />
		<xsl:call-template name="end-paragraph" />
	</xsl:template>
	
	<xsl:template name="begin-verbatimtab">
		<xsl:text>\begin{verbatimtab}[2]</xsl:text>	
	</xsl:template>
	
	<xsl:template name="end-verbatimtab">
		<xsl:text>\end{verbatimtab}</xsl:text>
	</xsl:template>		
	
	<xsl:template name="subtitle">
		<xsl:param name="input" select="''" />
		<xsl:call-template name="paragraph">
			<xsl:with-param name="text">
				<xsl:call-template name="textbf">
					<xsl:with-param name="input">
						<xsl:call-template name="textsc">
							<xsl:with-param name="input" select="$input" />
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="parameter-list">
		<xsl:param name="params" select="apiOperationDetail/apiOperationDef/apiParam" />
		
		<xsl:if test="count($params) &gt; 0">
			
			<xsl:call-template name="subtitle">
				<xsl:with-param name="input" select="'Parameters'" />
			</xsl:call-template>
			
			<xsl:call-template name="begin-description" />
			<xsl:for-each select="$params">
				<xsl:call-template name="item">
					<xsl:with-param name="input" select="./apiDesc" />
					<xsl:with-param name="prefix" select="./apiItemName" />
					<xsl:with-param name="description" select="true()" />
				</xsl:call-template>
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
			
			<xsl:call-template name="begin-description" />
			<xsl:for-each select="$params">
				<xsl:call-template name="item">
					<xsl:with-param name="input" select="./apiDesc" />
					<xsl:with-param name="prefix" select="./apiItemName" />
					<xsl:with-param name="description" select="true()" />
				</xsl:call-template>
			</xsl:for-each>
			<xsl:call-template name="end-description" />
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="deprecated">
		<!-- ./apiOperationDetail/apiOperationDef/apiDeprecated -->
		<xsl:param name="input" select=".//apiDeprecated" />
		
		<xsl:if test="count($input) &gt; 0">

			<xsl:variable name="text" select="'Deprecated'" />
			<xsl:variable name="replacement" select="$input/@replacement" />
			
			<!-- title -->
			
			<xsl:call-template name="textsc">
				<xsl:with-param name="input">
					<xsl:call-template name="textcolor">
						<xsl:with-param name="input" select="$text" />
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="$input/@replacement">
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
		
		<xsl:if test="$input != ''">
			<xsl:if test="$prefix != ''">
				<xsl:value-of select="$prefix" />
			</xsl:if>
			
			<xsl:if test="$scope != ''">
				<xsl:variable name="target" select="$scope//*[apiName = $input]" />
				
				<xsl:call-template name="nameref">
					<xsl:with-param name="input" select="$target/@id" />
				</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="$scope = ''">
				<xsl:call-template name="nameref">
					<xsl:with-param name="input" select="$input" />
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		
	</xsl:template>
	
	<xsl:template name="method-return">
		<xsl:param name="input" select="apiOperationDetail/apiOperationDef/apiReturn/apiDesc" />
		<xsl:if test="$input != ''">
			<xsl:call-template name="subtitle">
				<xsl:with-param name="input" select="'Returns'" />
			</xsl:call-template>
			<xsl:call-template name="paragraph">
				<xsl:with-param name="text" select="$input" />
			</xsl:call-template>
		</xsl:if>
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
				<xsl:value-of select="$end-verb" />
				<xsl:value-of select="'\\'" />
				<xsl:value-of select="$newline" />
				<xsl:value-of select="$start-verb" />				
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
					
					<!-- TODO: cross-referencing -->
					
					<xsl:variable name="xref" select="$toplevel//*[@fullname = $type-name]" />
					<xsl:if test="$xref">
						<xsl:value-of select="$end-verb" />
						<xsl:call-template name="xref">
							<xsl:with-param name="input" select="$xref/@fullname" />
						</xsl:call-template>
						<xsl:value-of select="$start-verb" />
					</xsl:if>
					<xsl:if test="not($xref)">
						<xsl:value-of select="$type-name" />
					</xsl:if>
				</xsl:if>
			</xsl:if>
			<xsl:if test="($type-name = 'restParam')">
				<xsl:text>... rest</xsl:text>
			</xsl:if>
			<xsl:if test="@optional='true'">
				<xsl:text>]</xsl:text>
			</xsl:if>
			
		</xsl:for-each>
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
	
	<xsl:template name="begin-description">
		<xsl:text>\begin{description}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="end-description">
		<xsl:text>\end{description}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="begin-itemize">
		<xsl:text>\begin{itemize}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="item">
		<xsl:param name="input" select="''" />
		<xsl:param name="prefix" select="''" />
		<xsl:param name="description" select="false()" />
		<xsl:param name="delimiter" select="' -- '" />
		<xsl:text>\item</xsl:text>
		
		<xsl:if test="not($description)">
			<xsl:text> </xsl:text>
		</xsl:if>
		
		<xsl:if test="$prefix != '' and not($description)">
			<xsl:call-template name="clean">
				<xsl:with-param name="input" select="$prefix"/>
			</xsl:call-template>
			<xsl:value-of select="$delimiter" />
		</xsl:if>
		
		<xsl:if test="$prefix != '' and $description">
			<xsl:text>[</xsl:text>
			<xsl:call-template name="clean">
				<xsl:with-param name="input" select="$prefix"/>
			</xsl:call-template>
			<xsl:text>]</xsl:text>
			<xsl:text> </xsl:text>
		</xsl:if>
		
		<xsl:call-template name="clean">
			<xsl:with-param name="input" select="$input"/>
		</xsl:call-template>	
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="end-itemize">
		<xsl:text>\end{itemize}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="part">
		<xsl:param name="title" />
		<xsl:param name="label" select="''" />
		<xsl:value-of select="$newline" />		
		<xsl:text>\part{</xsl:text>
		<xsl:call-template name="escape">
			<xsl:with-param name="input" select="$title"/>
		</xsl:call-template>
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
		<xsl:value-of select="$newline" />		
		<xsl:text>\section{</xsl:text>
		<xsl:call-template name="escape">
			<xsl:with-param name="input" select="$title"/>
		</xsl:call-template>
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
		<xsl:value-of select="$newline" />		
		<xsl:text>\subsection{</xsl:text>
		<xsl:call-template name="escape">
			<xsl:with-param name="input" select="$title"/>
		</xsl:call-template>
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
		<xsl:value-of select="$newline" />		
		<xsl:text>\subsubsection{</xsl:text>
		<xsl:call-template name="escape">
			<xsl:with-param name="input" select="$title"/>
		</xsl:call-template>
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
			<xsl:call-template name="begin-itemize" />

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
					<xsl:call-template name="escape">
						<xsl:with-param name="input" select="$found/shortdesc" />
					</xsl:call-template>
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
				<xsl:value-of select="$access" />
				<xsl:text> class </xsl:text>
			</xsl:when>
			<!-- interface -->
			<xsl:otherwise>
				<xsl:text>\scriptsize{Interface:} &amp; </xsl:text>
				<xsl:text>\scriptsize{\verb|</xsl:text>
				<xsl:value-of select="$access" />								
				<xsl:text> interface </xsl:text>				
			</xsl:otherwise>
		</xsl:choose>
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
				<xsl:with-param name="listing-xref" select="concat(@id,$public-methods-xref-id)" />				
			</xsl:call-template>
		</xsl:if>
		
		<xsl:if test="count($protected-methods) &gt; 0">
			<xsl:call-template name="summary-listing">
				<xsl:with-param name="input" select="$protected-methods" />
				<xsl:with-param name="title" select="'Protected methods'" />
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
		<xsl:param name="defined-by" select="'Defined by'"/>
		
		<xsl:value-of select="$newline" />
		<xsl:text>{\scriptsize</xsl:text>
		<xsl:value-of select="$newline" />		
		<xsl:text>\begin{tabularx}{\textwidth}{@{}XR@{}}</xsl:text>
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
			<xsl:text> &amp; </xsl:text>
			<xsl:value-of select="$defined-by" />
			<xsl:text>\\</xsl:text>
			<xsl:value-of select="$newline" />	
			<xsl:value-of select="'\hline'" />
			<xsl:value-of select="$newline" />		
		</xsl:if>
		
		<xsl:for-each select="$input">
			<xsl:call-template name="xref">
				<xsl:with-param name="input" select="@id" />
			</xsl:call-template>
			<xsl:if test=".//apiDeprecated">
				<xsl:value-of select="$newline" />
				<xsl:call-template name="deprecated" />
			</xsl:if>
			<xsl:value-of select="$newline" />
			<xsl:call-template name="escape">
				<xsl:with-param name="input" select="shortdesc" />
			</xsl:call-template>
				
			<xsl:text> &amp; </xsl:text>
			<xsl:call-template name="escape">
				<xsl:with-param name="input" select="../apiName" />
			</xsl:call-template>
			<xsl:text>\\</xsl:text>
			<xsl:value-of select="$newline" />
		</xsl:for-each>
		
		<xsl:text>\end{tabularx}</xsl:text>
		<!-- end size block -->
		<xsl:text>}</xsl:text>		
		<xsl:value-of select="$newline" />
		
	</xsl:template>	
	
	<xsl:template name="clean">
		<xsl:param name="input" />
		<xsl:call-template name="escape">
			<xsl:with-param name="input">
				<xsl:call-template name="sanitize">
					<xsl:with-param name="input" select="$input"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="textcolor">
		<xsl:param name="input" select="''" />
		<xsl:param name="color" select="'red'" />
		<xsl:text>\textcolor{</xsl:text>
		<xsl:value-of select="$color" />
		<xsl:text>}{</xsl:text>
		<xsl:call-template name="clean">
			<xsl:with-param name="input" select="$input"/>
		</xsl:call-template>
		<xsl:text>}</xsl:text>
	</xsl:template>	
	
	<xsl:template name="begin-paragraph">
		<xsl:value-of select="$newline" />	
		<xsl:text>\paragraph{</xsl:text>
	</xsl:template>	
	
	<xsl:template name="end-paragraph">
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
	</xsl:template>
	
	<xsl:template name="paragraph">
		<xsl:param name="text" />
		<xsl:call-template name="begin-paragraph" />
		<xsl:call-template name="clean">
			<xsl:with-param name="input" select="$text"/>
		</xsl:call-template>
		<xsl:call-template name="end-paragraph" />
	</xsl:template>
	
	<xsl:template name="textsc">
		<xsl:param name="input" />
		<xsl:text>\textsc{</xsl:text>
		<xsl:call-template name="clean">
			<xsl:with-param name="input" select="$input"/>
		</xsl:call-template>
		<xsl:text>}</xsl:text>
	</xsl:template>
	
	<xsl:template name="textbf">
		<xsl:param name="input" />
		<xsl:text>\textbf{</xsl:text>
		<xsl:call-template name="clean">
			<xsl:with-param name="input" select="$input"/>
		</xsl:call-template>
		<xsl:text>}</xsl:text>
	</xsl:template>	
	
	<xsl:template name="emph">
		<xsl:param name="input" />
		<xsl:text>\emph{</xsl:text>
		<xsl:call-template name="clean">
			<xsl:with-param name="input" select="$input"/>
		</xsl:call-template>
		<xsl:text>}</xsl:text>
	</xsl:template>
	
	<xsl:template name="footer">
		<xsl:text>
\end{document}
		</xsl:text>
	</xsl:template>
	
	<xsl:template name="escape">
		<xsl:param name="input" />
		
		<xsl:variable name="underscore">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$input" />
				<xsl:with-param name="search-string" select="'_'" />
				<xsl:with-param name="replace-string" select="'\_'" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="hash">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$underscore" />
				<xsl:with-param name="search-string" select="'#'" />
				<xsl:with-param name="replace-string" select="'\#'" />
			</xsl:call-template>
		</xsl:variable>		
		
		<xsl:call-template name="search-and-replace">
			<xsl:with-param name="input" select="$hash" />
			<xsl:with-param name="search-string" select="'$'" />
			<xsl:with-param name="replace-string" select="'\$'" />
		</xsl:call-template>		
	</xsl:template>	
	
	<xsl:template name="escape-label">
		<xsl:param name="input" />
		
		<xsl:variable name="label">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$input" />
				<xsl:with-param name="search-string" select="':get'" />
				<xsl:with-param name="replace-string" select="''" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="label">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$label" />
				<xsl:with-param name="search-string" select="':set'" />
				<xsl:with-param name="replace-string" select="''" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="underscore">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$label" />
				<xsl:with-param name="search-string" select="'_'" />
				<xsl:with-param name="replace-string" select="'-'" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="hash">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$underscore" />
				<xsl:with-param name="search-string" select="'#'" />
				<xsl:with-param name="replace-string" select="''" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:call-template name="search-and-replace">
			<xsl:with-param name="input" select="$hash" />
			<xsl:with-param name="search-string" select="'$'" />
			<xsl:with-param name="replace-string" select="''" />
		</xsl:call-template>
	</xsl:template>	

	<xsl:template name="sanitize">
		<xsl:param name="input" />

		<!-- replace 'codeph' tags with inline verb elements -->
		<xsl:variable name="codeph">
			<xsl:call-template name="replace-tag">
				<xsl:with-param name="input" select="$input" />
				<xsl:with-param name="tag" select="'codeph'" />
				<xsl:with-param name="replacement-start" select="'\verb|'" />
				<xsl:with-param name="replacement-end" select="'|'" />
			</xsl:call-template>
		</xsl:variable>
		
		<!-- replace 'pre' tags with verbatimtab elements -->
		<xsl:variable name="pre">
			<xsl:call-template name="replace-tag">
				<xsl:with-param name="input" select="$codeph" />
				<xsl:with-param name="tag" select="'pre'" />
				<xsl:with-param name="replacement-start" select="concat('\begin{verbatimtab}[2]',$newline)" />
				<xsl:with-param name="replacement-end" select="concat($newline,'\end{verbatimtab}')" />
			</xsl:call-template>
		</xsl:variable>
		
		<!-- b : note the dita conversion performs 'strong' > 'b' translation -->
		<xsl:variable name="b">
			<xsl:call-template name="replace-tag">
				<xsl:with-param name="input" select="$pre" />
				<xsl:with-param name="tag" select="'b'" />
				<xsl:with-param name="replacement-start" select="'\textbf{'" />
				<xsl:with-param name="replacement-end" select="'}'" />
			</xsl:call-template>
		</xsl:variable>
		
		<!-- i : note the dita conversion performs 'em' > 'i' translation -->
		<xsl:call-template name="replace-tag">
			<xsl:with-param name="input" select="$b" />
			<xsl:with-param name="tag" select="'i'" />
			<xsl:with-param name="replacement-start" select="'\emph{'" />
			<xsl:with-param name="replacement-end" select="'}'" />
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="replace-tag">
		<xsl:param name="input" />
		<xsl:param name="tag" />
		<xsl:param name="replacement-start" />
		<xsl:param name="replacement-end" />

		<xsl:variable name="start-replaced">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$input" />
				<xsl:with-param name="search-string" select="concat('&lt;',$tag,'&gt;')" />
				<xsl:with-param name="replace-string" select="$replacement-start" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:call-template name="search-and-replace">
			<xsl:with-param name="input" select="$start-replaced" />
			<xsl:with-param name="search-string" select="concat('&lt;','/',$tag,'&gt;')" />
			<xsl:with-param name="replace-string" select="$replacement-end" />
		</xsl:call-template>
	</xsl:template>
	
	<!-- utility functions - to be moved -->
	<xsl:template name="duplicateString">
		<xsl:param name="input"/>
		<xsl:param name="count" select="1"/>
		<xsl:choose>
			<xsl:when test="not($count) or not($input)"/>
			<xsl:when test="$count=1">
				<xsl:value-of select="$input"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$count mod 2">
					<xsl:value-of select="$input"/>
				</xsl:if>
				<xsl:call-template name="duplicateString">
					<xsl:with-param name="input" select="concat($input,$input)"/>
					<xsl:with-param name="count" select="floor($count div 2)"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="substring-before-last">
		<xsl:param name="input"/>
		<xsl:param name="substr"/>
		<xsl:if test="$substr and contains($input,$substr)">
			<xsl:variable name="tmp" select="substring-after($input,$substr)"/>
			<xsl:value-of select="substring-before($input,$substr)"/>
			<xsl:if test="contains($tmp,$substr)">
				<xsl:value-of select="$substr"/>
				<xsl:call-template name="substring-before-last">
					<xsl:with-param name="input" select="$tmp"/>
					<xsl:with-param name="substr" select="$substr"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="substring-after-last">
		<xsl:param name="input"/>
		<xsl:param name="substr"/>
		<xsl:variable name="tmp" select="substring-after($input,$substr)"/>
		<xsl:choose>
			<xsl:when test="$substr and contains($tmp,$substr)">
				<xsl:call-template name="substring-after-last">
					<xsl:with-param name="input" select="$tmp"/>
					<xsl:with-param name="substr" select="$substr"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$tmp"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="search-and-replace">
		<xsl:param name="input"/>
		<xsl:param name="search-string"/>
		<xsl:param name="replace-string"/>
		<xsl:choose>
			<xsl:when test="$search-string and contains($input,$search-string)">
				<xsl:value-of select="substring-before($input,$search-string)"/>
				<xsl:value-of select="$replace-string"/>
				<xsl:call-template name="search-and-replace">
					<xsl:with-param name="input" select="substring-after($input,$search-string)"/>
					<xsl:with-param name="search-string" select="$search-string"/>
					<xsl:with-param name="replace-string" select="$replace-string"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$input" disable-output-escaping="no"/>
			</xsl:otherwise>
		</xsl:choose>
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

\title{Actionscript Documentation}
\author{Mischa Williamson}
\makeindex

\begin{document} 
\maketitle

\fancyhead{}
\fancyfoot{}
]]></xsl:text>

<xsl:call-template name="left-page-header" />
<xsl:call-template name="right-page-header" />

<xsl:text><![CDATA[
\lfoot{\thepage}
\rfoot{\textsc{Last updated \today}}

\tableofcontents
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
\usepackage{geometry} 
\usepackage[parfill]{parskip} 
\usepackage{graphicx} 
\usepackage{amssymb} 
\usepackage{epstopdf} 
\usepackage{makeidx}
\usepackage{showidx}
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
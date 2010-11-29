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
	<xsl:output cdata-section-elements="description" method="text" encoding="UTF-8" omit-xml-declaration="yes" use-character-maps="disable" indent="no"/>
	<xsl:strip-space elements="apiDesc" />
	<xsl:param name="page-header-left" select="'Freeform Systems'"/>
	<xsl:param name="page-header-right" select="'API Documentation'"/>
	<xsl:param name="dita-dir" select="'tempdita'"/>	
	<xsl:param name="delimiter" select="system-property('file.separator')"/>
	<xsl:param name="packages-map-path" select="concat($dita-dir,$delimiter,'packagemap.xml')"/>
	<xsl:variable name="newline">
		<xsl:text>
</xsl:text>
	</xsl:variable>
	<xsl:template match="/">
		<xsl:call-template name="header" />
		
		<!--  PACKAGES-->
		<xsl:variable name="packages" select="document($packages-map-path)" />
		<xsl:for-each select="$packages//apiPackage">
			<xsl:sort select="@id"/>
			<xsl:variable name="package-id" select="@id"/>
			<xsl:call-template name="part">
				<xsl:with-param name="title" select="@id"/>
			</xsl:call-template>
			<xsl:variable name="package-path" select="concat($dita-dir,$delimiter,@id,'.xml')" />
			<xsl:variable name="package" select="document($package-path)" />
			<!--  PACKAGE-->
			<xsl:for-each select="$package//apiClassifier">
				<xsl:sort select="apiName"/>
				<xsl:variable name="class-id" select="@id"/>
				<xsl:call-template name="section">
					<xsl:with-param name="title" select="apiName"/>
				</xsl:call-template>
				
				<xsl:call-template name="details">
					<xsl:with-param name="package" select="@id"/>
					<xsl:with-param name="author" select="prolog/author"/>
					<xsl:with-param name="langversion" select="prolog/asMetadata/apiVersion/apiLanguage[@version]"/>
					<xsl:with-param name="playerversion" select="prolog/asMetadata/apiVersion/apiPlatform[@version]"/>
					<xsl:with-param name="since" select="prolog/asMetadata/apiVersion/apiSince[@version]"/>
				</xsl:call-template>
				
				<xsl:call-template name="paragraph">
					<xsl:with-param name="text" select="shortdesc"/>
				</xsl:call-template>
				
				<!-- PUBLIC METHODS -->
				<xsl:if test="apiOperation/apiOperationDetail/apiOperationDef/apiAccess[@value = 'public']">
					<xsl:call-template name="subsection">
						<xsl:with-param name="title" select="'Public methods'"/>
						<xsl:with-param name="label" select="concat($class-id,':','public:methods')"/>
					</xsl:call-template>
				</xsl:if>
								
				<xsl:for-each select="apiOperation">
					<xsl:sort select="apiName"/>
					<xsl:if test="apiOperationDetail/apiOperationDef/apiAccess[@value = 'public']">
						<xsl:call-template name="subsubsection">
							<xsl:with-param name="title" select="apiName"/>
							<xsl:with-param name="label" select="@id"/>
						</xsl:call-template>
						<xsl:call-template name="paragraph">
							<xsl:with-param name="text" select="apiOperationDetail/apiDesc"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>

				
				<!-- PROTECTED METHODS -->
				<xsl:if test="apiOperation/apiOperationDetail/apiOperationDef/apiAccess[@value = 'protected']">
					<xsl:call-template name="subsection">
						<xsl:with-param name="title" select="'Protected methods'"/>
						<xsl:with-param name="label" select="concat($class-id,':','protected:methods')"/>
					</xsl:call-template>
				</xsl:if>
								
				<xsl:for-each select="apiOperation">
					<xsl:sort select="apiName"/>
					<xsl:if test="apiOperationDetail/apiOperationDef/apiAccess[@value = 'protected']">
						<xsl:call-template name="subsubsection">
							<xsl:with-param name="title" select="apiName"/>
							<xsl:with-param name="label" select="@id"/>
						</xsl:call-template>
						<xsl:call-template name="paragraph">
							<xsl:with-param name="text" select="apiOperationDetail/apiDesc"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>												
				
				<!-- PUBLIC PROPERTIES -->
				<xsl:if test="apiValue/apiValueDetail/apiValueDef/apiAccess[@value = 'public']">
					<xsl:call-template name="subsection">
						<xsl:with-param name="title" select="'Public properties'"/>
						<xsl:with-param name="label" select="concat($class-id,':','properties')"/>
					</xsl:call-template>
				</xsl:if>
								
				<xsl:for-each select="apiValue">
					<xsl:sort select="apiName"/>
					<xsl:if test="apiValueDetail/apiValueDef/apiAccess[@value = 'public']">
						<xsl:call-template name="subsubsection">
							<xsl:with-param name="title" select="apiName"/>
							<xsl:with-param name="label" select="@id"/>
						</xsl:call-template>
						<xsl:call-template name="paragraph">
							<xsl:with-param name="text" select="apiValueDetail/apiDesc"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>
				
				<!-- PROTECTED PROPERTIES -->
				<xsl:if test="apiValue/apiValueDetail/apiValueDef/apiAccess[@value = 'protected']">
					<xsl:call-template name="subsection">
						<xsl:with-param name="title" select="'Protected properties'"/>
						<xsl:with-param name="label" select="concat($class-id,':','properties')"/>
					</xsl:call-template>
				</xsl:if>
								
				<xsl:for-each select="apiValue">
					<xsl:sort select="apiName"/>
					<xsl:if test="apiValueDetail/apiValueDef/apiAccess[@value = 'protected']">
						<xsl:call-template name="subsubsection">
							<xsl:with-param name="title" select="apiName"/>
							<xsl:with-param name="label" select="@id"/>
						</xsl:call-template>
						<xsl:call-template name="paragraph">
							<xsl:with-param name="text" select="apiValueDetail/apiDesc"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:for-each>
		
		<!-- INTERFACES -->
		
		<!--
		<xsl:call-template name="section">
			<xsl:with-param name="title" select="'Interfaces'"/>
		</xsl:call-template>
		<xsl:for-each select="//interfaceRec[@access = 'public']">
			<xsl:sort select="@name"/>
			<xsl:variable name="name" select="@name"/>
			<xsl:variable name="fullname" select="@fullname"/>
			<xsl:variable name="package" select="substring-before( $fullname, ':' )" />
			
			<xsl:call-template name="section">
				<xsl:with-param name="title" select="$name"/>
			</xsl:call-template>
			<xsl:call-template name="details">
				<xsl:with-param name="package" select="$package"/>
				<xsl:with-param name="author" select="./author"/>
				<xsl:with-param name="langversion" select="./langversion"/>
				<xsl:with-param name="playerversion" select="./playerversion"/>
				<xsl:with-param name="since" select="./since"/>
			</xsl:call-template>			
			<xsl:call-template name="paragraph">
				<xsl:with-param name="text" select="./description"/>
			</xsl:call-template>
	
			<xsl:apply-templates select="//method[contains(@fullname,concat($package,':',$name))]">
				<xsl:sort select="@name"/>				
			</xsl:apply-templates>
		</xsl:for-each>
		-->
		
		<!-- CLASSES -->
		
		<!--
		<xsl:call-template name="section">
			<xsl:with-param name="title" select="'Classes'"/>
		</xsl:call-template>
		<xsl:for-each select="//classRec[@access = 'public']">
			<xsl:sort select="@name"/>			
			<xsl:variable name="name" select="@name"/>
			<xsl:variable name="fullname" select="@fullname"/>
			<xsl:variable name="package" select="substring-before( $fullname, ':' )" />
			
			<xsl:call-template name="section">
				<xsl:with-param name="title" select="$name"/>
			</xsl:call-template>
			<xsl:call-template name="details">
				<xsl:with-param name="package" select="$package"/>
				<xsl:with-param name="author" select="./author"/>
				<xsl:with-param name="langversion" select="./langversion"/>
				<xsl:with-param name="playerversion" select="./playerversion"/>
				<xsl:with-param name="since" select="./since"/>
			</xsl:call-template>
			<xsl:call-template name="paragraph">
				<xsl:with-param name="text" select="./description"/>
			</xsl:call-template>
			
			<xsl:apply-templates select="//method[contains(@fullname,concat($package,':',$name))]">
				<xsl:sort select="@name"/>				
			</xsl:apply-templates>							
		</xsl:for-each>		
		-->
		
		<xsl:call-template name="footer"/>
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
	
	<xsl:template name="details">
		<xsl:param name="package" />
		<xsl:param name="author" />
		<xsl:param name="langversion" />
		<xsl:param name="playerversion" />
		<xsl:param name="since" />
		<xsl:value-of select="$newline" />
		<xsl:text>\paragraph{\scriptsize{</xsl:text>
		
		<xsl:if test="$package != ''">
			<xsl:text>Package: \emph{</xsl:text><xsl:value-of select="$package" /><xsl:text>}</xsl:text>
		</xsl:if>
		
		<xsl:if test="$author != ''">
			<xsl:text>\\</xsl:text>
			<xsl:value-of select="$newline" />
			<xsl:text>Author: \emph{</xsl:text><xsl:value-of select="$author" /><xsl:text>}</xsl:text>
		</xsl:if>
		<xsl:if test="$since != ''">
			<xsl:text>\\</xsl:text>
			<xsl:value-of select="$newline" />
			<xsl:text>Since: \emph{</xsl:text><xsl:value-of select="$since" /><xsl:text>}</xsl:text>
		</xsl:if>
		<xsl:if test="$langversion != ''">
			<xsl:text>\\</xsl:text>
			<xsl:value-of select="$newline" />
			<xsl:text>Language version: \emph{</xsl:text><xsl:value-of select="$langversion" /><xsl:text>}</xsl:text>
		</xsl:if>
		<xsl:if test="$playerversion != ''">
			<xsl:text>\\</xsl:text>
			<xsl:value-of select="$newline" />
			<xsl:text>Player version: \emph{</xsl:text><xsl:value-of select="$playerversion" /><xsl:text>}</xsl:text>
		</xsl:if>				
	
		<xsl:text>}}</xsl:text>
		<xsl:value-of select="$newline" />
		<!-- TODO : add label for namerefs -->
	</xsl:template>
	
	<xsl:template match="method">		
		<xsl:if test="not(contains( @fullname, '/private:' ))">
			<xsl:call-template name="subsection">
				<xsl:with-param name="title" select="@name"/>
			</xsl:call-template>
		
			<!--
			<xsl:call-template name="paragraph">
				<xsl:with-param name="text" select="description"/>
			</xsl:call-template>
			-->
		
			<xsl:apply-templates select="description" />
		
			<xsl:value-of select="$newline" />
			<!-- TODO : add label for namerefs -->
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="paragraph">
		<xsl:param name="text" />
		<xsl:value-of select="$newline" />	
		<xsl:text>\paragraph{</xsl:text>
		
		<xsl:call-template name="escape">
			<xsl:with-param name="input">
				<xsl:call-template name="sanitize">
					<xsl:with-param name="input" select="$text"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<!-- <xsl:value-of select="$text" /> -->
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
		<!-- TODO : add label for namerefs -->
	</xsl:template>
	
	<xsl:template match="description">
		<xsl:call-template name="paragraph">
			<xsl:with-param name="text" select="."/>
		</xsl:call-template>
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
		
		<xsl:call-template name="search-and-replace">
			<xsl:with-param name="input" select="$underscore" />
			<xsl:with-param name="search-string" select="'$'" />
			<xsl:with-param name="replace-string" select="'\$'" />
		</xsl:call-template>		
	</xsl:template>	
	
	<xsl:template name="escape-label">
		<xsl:param name="input" />
		
		<xsl:variable name="underscore">
			<xsl:call-template name="search-and-replace">
				<xsl:with-param name="input" select="$input" />
				<xsl:with-param name="search-string" select="'_'" />
				<xsl:with-param name="replace-string" select="'-'" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:call-template name="search-and-replace">
			<xsl:with-param name="input" select="$underscore" />
			<xsl:with-param name="search-string" select="'$'" />
			<xsl:with-param name="replace-string" select="''" />
		</xsl:call-template>
	</xsl:template>	

	<xsl:template name="sanitize">
		<xsl:param name="input" />
		
		<!-- replace 'code' tags with inline verb elements -->
		
		<!-- <xsl:value-of select="$input" /> -->
		
		<!--
		<xsl:call-template name="replace-tag">
			<xsl:with-param name="input" select="$input" />
			<xsl:with-param name="tag" select="'code'" />
			<xsl:with-param name="replacement-start" select="'\verb|'" />
			<xsl:with-param name="replacement-end" select="'|'" />
		</xsl:call-template>
		-->
		
		<!-- replace 'codeph' tags with inline verb elements -->
		<xsl:variable name="codeph">
			<xsl:call-template name="replace-tag">
				<xsl:with-param name="input" select="$input" />
				<xsl:with-param name="tag" select="'codeph'" />
				<xsl:with-param name="replacement-start" select="'\verb|'" />
				<xsl:with-param name="replacement-end" select="'|'" />
			</xsl:call-template>
		</xsl:variable>
		
		
		
		<!-- strong -->
		<xsl:variable name="strong">
			<xsl:call-template name="replace-tag">
				<xsl:with-param name="input" select="$codeph" />
				<xsl:with-param name="tag" select="'strong'" />
				<xsl:with-param name="replacement-start" select="'\textbf{'" />
				<xsl:with-param name="replacement-end" select="'}'" />
			</xsl:call-template>
		</xsl:variable>
		
		<!-- em -->
		<xsl:call-template name="replace-tag">
			<xsl:with-param name="input" select="$strong" />
			<xsl:with-param name="tag" select="'em'" />
			<xsl:with-param name="replacement-start" select="'\emph{'" />
			<xsl:with-param name="replacement-end" select="'}'" />
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="replace-tag">
		<xsl:param name="input" />
		<xsl:param name="tag" />
		<xsl:param name="replacement-start" />
		<xsl:param name="replacement-end" />
		
		<xsl:if test="contains( $input, concat('&lt;',$tag,'&gt;') )">
			
			<!-- <xsl:text>GOT TAG!!!</xsl:text> -->
			
		</xsl:if>
		
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
\usepackage{wallpaper}
\usepackage{hyperref}

\usepackage{fancyhdr}
%\setlength{\headheight}{15.2pt}
\pagestyle{fancy}
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
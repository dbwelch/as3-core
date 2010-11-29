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
	<xsl:param name="titleBarFile" select="''"/>
	<xsl:param name="index-file" select="''"/>
	<xsl:param name="package-frame" select="''"/>
	<xsl:param name="liveDocsTitleBarFile" select="''"/>
	<xsl:param name="packages_map_name" select="'packagemap.xml'"/>
	<xsl:param name="prog_language_name" select="''"/>
	<xsl:variable name="newline">
		<xsl:text>
</xsl:text>
	</xsl:variable>
	
	<xsl:template match="/">
		<xsl:text><![CDATA[\documentclass[a4paper,titlepage,oneside]{article}

% Palatino for rm and math | Helvetica for ss | Courier for tt
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

\lhead{\textbf{\textsc{...TODO}}}
\rhead{\textbf{\textsc{Actionscript Documentation}}}
\lfoot{\thepage}
\rfoot{\textsc{Last updated \today}}

\tableofcontents

\clearpage]]></xsl:text>
		
		<!-- INTERFACES -->
		<xsl:call-template name="part">
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
		
		<!-- CLASSES -->
		<xsl:call-template name="part">
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
		
		<xsl:call-template name="footer"/>
	</xsl:template>
	
	<xsl:template name="part">
		<xsl:param name="title" />
		<xsl:value-of select="$newline" />		
		<xsl:text>\part{</xsl:text>
		<xsl:value-of select="$title" />
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
		<!-- TODO : add label for namerefs -->
	</xsl:template>
	
	<xsl:template name="section">
		<xsl:param name="title" />
		<xsl:value-of select="$newline" />		
		<xsl:text>\section{</xsl:text>
		<xsl:value-of select="$title" />
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
		<!-- TODO : add label for namerefs -->
	</xsl:template>	
	
	<xsl:template name="subsection">
		<xsl:param name="title" />
		<xsl:value-of select="$newline" />		
		<xsl:text>\subsection{</xsl:text>
		<xsl:value-of select="$title" />
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
		<!-- TODO : add label for namerefs -->
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
		<xsl:call-template name="sanitize">
			<xsl:with-param name="input" select="$text"/>
		</xsl:call-template>
		<!-- <xsl:value-of select="$text" /> -->
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline" />
		<!-- TODO : add label for namerefs -->
	</xsl:template>
	
	<xsl:template match="comment()">
		<xsl:value-of select="'COMMENT:'" /><xsl:value-of select="." />
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

	<xsl:template name="sanitize">
		<xsl:param name="input" />
		
		<!-- replace 'code' tags with inline verb elements -->
		<xsl:call-template name="replace-tag">
			<xsl:with-param name="input" select="$input" />
			<xsl:with-param name="tag" select="'code'" />
			<xsl:with-param name="replacement-start" select="'\verb|'" />
			<xsl:with-param name="replacement-end" select="'|'" />
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
</xsl:stylesheet>
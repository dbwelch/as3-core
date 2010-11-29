<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://saxon.sf.net/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ifn="urn:internal:functions" version="2.0" exclude-result-prefixes="saxon xs ifn">
	<xsl:character-map name="disable">
		<xsl:output-character character="&amp;" string="&amp;"/>
		<xsl:output-character character="&lt;" string="&lt;"/>
		<xsl:output-character character="&gt;" string="&gt;"/>
		<xsl:output-character character="" string="&amp;lsquo;"/>
		<xsl:output-character character="" string="&amp;apos;"/>
		<xsl:output-character character="" string="&amp;mdash;"/>
		<xsl:output-character character="—" string="&amp;mdash;"/>
		<xsl:output-character character=" " string="&amp;thinsp;"/>
		<xsl:output-character character="®" string="&amp;reg;"/>
		<xsl:output-character character="°" string="&amp;deg;"/>
		<xsl:output-character character="™" string="&amp;trade;"/>
	</xsl:character-map>
	<xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes" use-character-maps="disable" indent="no"/>
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
		<xsl:for-each select="//interfaceRec">
			<xsl:variable name="name" select="@name"/>
			<xsl:variable name="fullname" select="@fullname"/>
			<!-- <xsl:value-of select="$name"/> -->
			
			<xsl:call-template name="section">
				<xsl:with-param name="title" select="$name"/>
			</xsl:call-template>			
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
	
	<xsl:template name="footer">
		<xsl:text>
\end{document}			
		</xsl:text>
	</xsl:template>
</xsl:stylesheet>

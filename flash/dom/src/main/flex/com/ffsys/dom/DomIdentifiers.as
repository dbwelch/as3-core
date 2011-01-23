package com.ffsys.dom
{
	
	/*
	
	//XHTML 1
	
	<!--...-->	Defines a comment	STF
	<!DOCTYPE> 	Defines the document type	STF
	<a>	Defines an anchor	STF
	<abbr>	Defines an abbreviation	STF
	<acronym>	Defines an acronym	STF
	<address>	Defines contact information for the author/owner of a document	STF
	<area />	Defines an area inside an image-map	STF
	<b>	Defines bold text	STF
	<base />	Defines a default address or a default target for all links on a page	STF
	<bdo>	Defines the text direction	STF
	<big>	Defines big text	STF
	<blockquote>	Defines a long quotation	STF
	<body>	Defines the document's body	STF
	<br />	Defines a single line break	STF
	<button>	Defines a push button	STF
	<caption>	Defines a table caption	STF
	<cite>	Defines a citation	STF
	<code>	Defines computer code text	STF
	<col />	Defines attribute values for one or more columns in a table 	STF
	<colgroup>	Defines a group of columns in a table for formatting	STF
	<dd>	Defines a description of a term in a definition list	STF
	<del>	Defines deleted text	STF
	<dfn>	Defines a definition term	STF
	<div>	Defines a section in a document	STF
	<dl>	Defines a definition list	STF
	<dt>	Defines a term (an item) in a definition list	STF
	<em>	Defines emphasized text 	STF
	<fieldset>	Defines a border around elements in a form	STF
	<form>	Defines an HTML form for user input	STF
	<frame />	 Defines a window (a frame) in a frameset	F
	<frameset>	Defines a set of frames	F
	<h1> to <h6>	 Defines HTML headings	STF
	<head>	Defines information about the document	STF
	<hr />	 Defines a horizontal line	STF
	<html>	Defines an HTML document	STF
	<i>	Defines italic text	STF
	<iframe>	Defines an inline frame	TF
	<img />	Defines an image	STF
	<input />	Defines an input control	STF
	<ins>	Defines inserted text	STF
	<kbd>	Defines keyboard text	STF
	<label>	Defines a label for an input element	STF
	<legend>	Defines a caption for a fieldset element	STF
	<li>	Defines a list item	STF
	<link />	Defines the relationship between a document and an external resource	STF
	<map>	Defines an image-map 	STF
	<meta />	Defines metadata about an HTML document	STF
	<noframes>	Defines an alternate content for users that do not support frames	TF
	<noscript>	Defines an alternate content for users that do not support client-side scripts	STF
	<object>	Defines an embedded object	STF
	<ol>	Defines an ordered list	STF
	<optgroup>	Defines a group of related options in a select list	STF
	<option>	Defines an option in a select list	STF
	<p>	Defines a paragraph	STF
	<param />	Defines a parameter for an object	STF
	<pre>	Defines preformatted text	STF
	<q>	Defines a short quotation	STF
	<samp>	Defines sample computer code	STF
	<script>	Defines a client-side script	STF
	<select>	Defines a select list (drop-down list)	STF
	<small>	Defines small text	STF
	<span>	Defines a section in a document	STF
	<strong>	Defines strong text	STF
	<style>	Defines style information for a document	STF
	<sub>	Defines subscripted text	STF
	<sup>	Defines superscripted text	STF
	<table>	Defines a table	STF
	<tbody>	Groups the body content in a table	STF
	<td>	Defines a cell in a table	STF
	<textarea>	Defines a multi-line text input control	STF
	<tfoot>	Groups the footer content in a table	STF
	<th>	Defines a header cell in a table	STF
	<thead>	Groups the header content in a table	STF
	<title>	Defines the title of a document	STF
	<tr>	Defines a row in a table	STF
	<tt>	Defines teletype text	STF
	<ul>	Defines an unordered list	STF
	<var>	Defines a variable part of a text	STF
	
	
	
	
	
	
	
	*/

	public class DomIdentifiers extends Object
	{
		//NON DOM ELEMENTS
		
		/**
		* 	The identifier for the style manager.
		*/
		public static const STYLE_MANAGER:String = "style-manager";
		
		//CORE DOM ELEMENTS
		
		/**
		* 	The identifier for <code>DOM</code> attributes.
		*/
		public static const ATTR:String = "attr";
		
		/**
		* 	The identifier for <code>DOM</code> document fragments.
		*/
		public static const DOCUMENT_FRAGMENT:String = "fragment";
		
		/**
		* 	The identifier for <code>DOM</code> text nodes.
		*/
		public static const TEXT:String = "text";
		
		/**
		* 	The identifier for <code>DOM</code> processing instructions.
		*/
		public static const PROCESSING_INSTRUCTION:String = "processing-instruction";
		
		/**
		* 	The identifier for <code>DOM</code> comments.
		*/
		public static const COMMENT:String = "comment";
		
		/**
		* 	The identifier for <code>DOM</code> CDATA sections.
		*/
		public static const CDATA_SECTION:String = "cdata-section";
		
		/**
		* 	The identifier for <code>DOM</code> entities.
		*/
		public static const ENTITY:String = "entity";
		
		/**
		* 	The identifier for <code>DOM</code> entity references.
		*/
		public static const ENTITY_REFERENCE:String = "entity-reference";
		
		//ABSTRACT ELEMENTS
		
		/**
		* 	Represents the top level document element.
		*/
		public static const DOCUMENT:String = "html";
		
		/**
		* 	Represents the document head element.
		*/
		public static const HEAD:String = "head";
		
		/**
		* 	Represents the document body element.
		*/
		public static const BODY:String = "body";
		
		/**
		* 	Represents the base element.
		*/
		public static const BASE:String = "base";
		
		/**
		* 	Represents the caption element.
		*/
		public static const CAPTION:String = "caption";
		
		/**
		* 	Represents the dd element.
		*/
		public static const DD:String = "dd";
		
		/**
		* 	Represents the dt element.
		*/
		public static const DT:String = "dt";
		
		/**
		* 	Represents the form element.
		*/
		public static const FORM:String = "form";
		
		/**
		* 	Represents the legend element.
		*/
		public static const LEGEND:String = "legend";
		
		/**
		* 	Represents the li element.
		*/
		public static const LI:String = "li";
		
		/**
		* 	Represents the noscript element.
		*/
		public static const NOSCRIPT:String = "noscript";
		
		/**
		* 	Represents the optgroup element.
		*/
		public static const OPTGROUP:String = "optgroup";
		
		/**
		* 	Represents the option element.
		*/
		public static const OPTION:String = "option";
		
		/**
		* 	Represents the param element.
		*/
		public static const PARAM:String = "param";
		
		/**
		* 	Represents the td element.
		*/
		public static const TD:String = "td";
		
		/**
		* 	Represents the th element.
		*/
		public static const TH:String = "th";
		
		/**
		* 	Represents the tr element.
		*/
		public static const TR:String = "tr";
		
		/**
		* 	Represents the style element.
		*/
		public static const STYLE:String = "style";
		
		/**
		* 	Represents the title element.
		*/
		public static const TITLE:String = "title";
		
		/**
		* 	Represents the link element.
		*/
		public static const LINK:String = "link";
		
		/**
		* 	Represents the meta element.
		*/
		public static const META:String = "meta";
		
		/**
		* 	Represents the script element.
		*/
		public static const SCRIPT:String = "script";
		
		//BLOCK ELEMENTS
	
		/**
		* 	Represents the div element.
		*/
		public static const DIV:String = "div";		
		
		/**
		* 	Represents the p element.
		*/
		public static const PARAGRAPH:String = "p";
		
		/**
		* 	Represents the <code>h1</code> element.
		*/
		public static const HEADING_1:String = "h1";
		
		/**
		* 	Represents the <code>h1</code> element.
		*/
		public static const HEADING_2:String = "h2";
		
		/**
		* 	Represents the <code>h1</code> element.
		*/
		public static const HEADING_3:String = "h3";
		
		/**
		* 	Represents the <code>h1</code> element.
		*/
		public static const HEADING_4:String = "h4";
		
		/**
		* 	Represents the <code>h1</code> element.
		*/
		public static const HEADING_5:String = "h5";
		
		/**
		* 	Represents the <code>h1</code> element.
		*/
		public static const HEADING_6:String = "h6";
		
		/**
		* 	Represents the object element.
		*/
		public static const OBJECT:String = "object";
		
		/**
		* 	Represents the fieldset element.
		*/
		public static const FIELDSET:String = "fieldset";
		
		/**
		* 	Represents the blockquote element.
		*/
		public static const BLOCKQUOTE:String = "blockquote";
		
		/**
		* 	Represents the address element.
		*/
		public static const ADDRESS:String = "address";
		
		/**
		* 	Represents the dl element.
		*/
		public static const DL:String = "dl";
		
		/**
		* 	Represents the hr element.
		*/
		public static const HR:String = "hr";
		
		/**
		* 	Represents the hr element.
		*/
		public static const PRE:String = "pre";
		
		/**
		* 	Represents the table element.
		*/
		public static const TABLE:String = "table";
		
		/**
		* 	Represents the ul element.
		*/
		public static const UL:String = "ul";
		
		/**
		* 	Represents the ol element.
		*/
		public static const OL:String = "ol";
		
		//INLINE ELEMENTS		
		
		/**
		* 	Represents the anchor element.
		*/
		public static const ANCHOR:String = "a";
		
		/**
		* 	Represents the em element.
		*/
		public static const EM:String = "em";
		
		/**
		* 	Represents the strong element.
		*/
		public static const STRONG:String = "strong";
		
		/**
		* 	Represents the span element.
		*/
		public static const SPAN:String = "span";	
		
		/**
		* 	Represents the label element.
		*/
		public static const LABEL:String = "label";
		
		/**
		* 	Represents the input element.
		*/
		public static const INPUT:String = "input";		
		
		//TODO: complete the inline elements
		
		//ATTRIBUTES
		
		//TODO: add attribute names
	}
}
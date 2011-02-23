package org.w3c.dom.html
{
	/**
	* 	Defines the contract for HTML document body
	* 	implementations.
	*/
	public interface HTMLBodyElement extends HTMLElement
	{
		
		/*
		
		background = uri [CT]
		Deprecated. The value of this attribute is a URI that designates an image resource. The image generally tiles the background (for visual browsers).
		text = color [CI]
		Deprecated. This attribute sets the foreground color for text (for visual browsers).
		link = color [CI]
		Deprecated. This attribute sets the color of text marking unvisited hypertext links (for visual browsers).
		vlink = color [CI]
		Deprecated. This attribute sets the color of text marking visited hypertext links (for visual browsers).
		alink = color [CI]
		Deprecated. This attribute sets the color of text marking hypertext links when selected by the user (for visual browsers).		
		
		<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
		   "http://www.w3.org/TR/html4/loose.dtd">
		<HTML>
		<HEAD>
		 <TITLE>A study of population dynamics</TITLE>
		</HEAD>
		<BODY bgcolor="white" text="black"
		  link="red" alink="fuchsia" vlink="maroon">
		  ... document body...
		</BODY>
		</HTML>
		
		*/
		
		/**
		* 	Color of active links (after mouse-button down, but before mouse-button up).
		* 
		* 	This attribute is deprecated in HTML 4.01.
		*/
		function get aLink():String;
		function set aLink( link:String ):void;
		
		/**
		* 	Color of links that are not active and unvisited.
		* 
		* 	This attribute is deprecated in HTML 4.01.
		*/
		function get link():String;
		function set link( link:String ):void;		
		
		/**
		* 	Color of links that have been visited by the user.
		* 
		* 	This attribute is deprecated in HTML 4.01.
		*/
		function get vLink():String;
		function set vLink( link:String ):void;
		
		/**
		* 	Document text color.
		* 	
		* 	This attribute is deprecated in HTML 4.01.
		*/
		function get text():String;
		function set text( text:String ):void;
		
		/**
		* 	URI [IETF RFC 2396] of the background texture tile image.
		* 
		* 	This attribute is deprecated in HTML 4.01.
		*/
		function get background():String;
		function set background( background:String ):void;
		
		/**
		* 	Document background color.
		* 
		*	This attribute is deprecated in HTML 4.01.
		*/
		function get bgColor():String;
		function set bgColor( bgColor:String ):void;
	}
}
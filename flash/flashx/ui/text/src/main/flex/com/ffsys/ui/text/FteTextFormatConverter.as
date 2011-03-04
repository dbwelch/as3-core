package com.ffsys.ui.text
{
	import flash.display.*;
	
	import flash.text.*;
	import flash.text.engine.*;	
	
	import flash.geom.*;

	public class FteTextFormatConverter extends Object
	{
		
		/**
		* 	Creates a <code>FteTextFormatConverter</code> instance.
		*/
		public function FteTextFormatConverter()
		{
			super();
		}
		
		private function displayTextBlock(
			block:TextBlock,
			container:FteTextArea,
			width:Number,
			format:TextFormat ):void
		{
			container.removeAllChildren();
			var line:TextLine;
			var previousLine:TextLine;
			for (;;)
			{
				line = block.createTextLine( previousLine, width );
				if( !line )
				{
					break;
				}
				line.y = previousLine ? previousLine.y + line.height : line.ascent;
				if( previousLine != null )
				{	
					line.y += format.leading;
				}
				container.addChild( line );
				previousLine = line;
			}
		}		
		
		public function convert(
			text:String, format:TextFormat, width:Number = 2048 ):FteTextArea
		{
			var area:FteTextArea = new FteTextArea();			
			var block:TextBlock = getContent( text, format );
			displayTextBlock( block, area, width, format );
			return area;
		}
		
		private function getContent( text:String, format:TextFormat ):TextBlock
		{
			var font:FontDescription = new FontDescription();
			
			/*
			if (Capabilities.os.search("Mac OS") > -1) 
			font.fontName = String.fromCharCode(0x5C0F, 0x585A, 0x660E, 0x671D) + " Pro R"; // "Kozuka Mincho Pro R"                    koFont.fontName = "Adobe " + String.fromCharCode(0xBA85, 0xC870) + " Std M"; // "Adobe Myungjo Std M"
			else 
			*/
			
			/*
			var myEmbeddedFonts:Array = Font.enumerateFonts(false);
			var f:Font = myEmbeddedFonts[0];
			trace(FontDescription.isFontCompatible(f.fontName, "normal", "normal"));
			trace(FontDescription.isFontCompatible(f.fontName, "bold", "normal"));
			trace(FontDescription.isFontCompatible(f.fontName, "normal", "italic"));
			*/
			
			//font.fontName = "Arial";
			
			font.fontName = format.font;
			
			//TODO
			//font.fontLookup = FontLookup.DEVICE;
			
			var fteFormat:ElementFormat = new ElementFormat();
			fteFormat.fontDescription = font;
			fteFormat.fontSize = Number( format.size );
			//fteFormat.locale = "ja";
			fteFormat.color = uint( format.color );
			//if (!vertical) 
			//fteFormat.textRotation = TextRotation.ROTATE_0;
			
			//trace("FteTextFormatConverter::getContent() LINE BREAK OPPURTUNITY: ", fteFormat.breakOpportunity );
			
			var txt:TextElement = new TextElement(
				text, fteFormat );
			
			var content:Vector.<ContentElement> = new Vector.<ContentElement>();
			content.push( txt );			
			var block:TextBlock = createBlock( content );
			return block;
		}
		
		/**
		* 	@private
		*/
		private function createBlock( content:Vector.<ContentElement> ):TextBlock
		{
			var block:TextBlock = new TextBlock( new GroupElement( content ) );
			//block.textJustifier = new SpaceJustifier();
			//block.baselineZero = TextBaseline.IDEOGRAPHIC_CENTER;
			//block.textJustifier = new EastAsianJustifier("ja", LineJustification.ALL_BUT_LAST);
			//block.lineRotation = vertical? TextRotation.ROTATE_90: TextRotation.ROTATE_0;
			return block;
		}
	}
}
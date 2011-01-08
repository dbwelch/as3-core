package com.ffsys.ui.text
{
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
		
		public function convert(
			text:String, format:TextFormat, width:Number = 300 ):FteTextArea
		{
			var whitespace:RegExp = /^\s+$/;
			var block:TextBlock = getContent( text, format );

			/*
			
			var font:FontDescription = new FontDescription();
            if (Capabilities.os.search("Mac OS") > -1) 
                font.fontName = String.fromCharCode(0x5C0F, 0x585A, 0x660E, 0x671D) + " Pro R"; // "Kozuka Mincho Pro R"                    koFont.fontName = "Adobe " + String.fromCharCode(0xBA85, 0xC870) + " Std M"; // "Adobe Myungjo Std M"
            else 
                font.fontName = "Kozuka Mincho Pro R";
			
			var format:ElementFormat = new ElementFormat();
			            format.fontDescription = font;
			            format.fontSize = 12;
			            format.locale = "ja";
			            format.color = 0x000000;			
			
			*/
			
			var area:FteTextArea = new FteTextArea();
			
			var output:Vector.<TextLine> = new Vector.<TextLine>();
			
			if( text != null
				&& text.length > 0
				&& format != null )
			{
				var lines:Array = text.split( "\n" );
				var content:String = null;
				var line:TextLine = null;
				var previousLine:TextLine = null;
				var metrics:FontMetrics = null;
				for( var i:int = 0;i < lines.length;i++ )
				{
					content = lines[ i ];
					
					trace("FteTextFormatConverter::covnert() GOT LINE: ", content );
					
					//if( !whitespace.test( content ) )
					//{
						line = block.createTextLine( previousLine );
						
						trace("FteTextFormatConverter::covnert() CREATING LINE: ", line );
						
						metrics = block.content.elementFormat.getFontMetrics();
						
						trace("FteTextFormatConverter::convert()", metrics, metrics.emBox );
						
						if( metrics.emBox.y < 0 )
						{
							line.y += Math.abs( metrics.emBox.y );
						}
						
						if( previousLine != null )
						{
							line.y += previousLine.textHeight;
							line.y += format.leading;
						}
						
						area.addChild( line );						
						
						previousLine = line;
						
						//output.push( line );
					//}
				}
			}
			
			return area;
		}
		
		private function getContent( text:String, format:TextFormat ):TextBlock
		{
			var block:TextBlock = createBlock();
			
			var font:FontDescription = new FontDescription();
			
			/*
			if (Capabilities.os.search("Mac OS") > -1) 
			font.fontName = String.fromCharCode(0x5C0F, 0x585A, 0x660E, 0x671D) + " Pro R"; // "Kozuka Mincho Pro R"                    koFont.fontName = "Adobe " + String.fromCharCode(0xBA85, 0xC870) + " Std M"; // "Adobe Myungjo Std M"
			else 
			*/
			
			//font.fontName = "Arial";
			
			font.fontName = format.font;
			
			var fteFormat:ElementFormat = new ElementFormat();
			fteFormat.fontDescription = font;
			fteFormat.fontSize = Number( format.size );
			//fteFormat.locale = "ja";
			fteFormat.color = uint( format.color );
			//if (!vertical) 
			//fteFormat.textRotation = TextRotation.ROTATE_0;
			
			block.content = new TextElement(
				text, fteFormat );
			return block;
		}
		
		/**
		* 	@private
		*/
		private function createBlock():TextBlock
		{
			var textBlock:TextBlock = new TextBlock();
			//textBlock.baselineZero = TextBaseline.IDEOGRAPHIC_CENTER;
			//textBlock.textJustifier = new EastAsianJustifier("ja", LineJustification.ALL_BUT_LAST);
			//textBlock.lineRotation = vertical? TextRotation.ROTATE_90: TextRotation.ROTATE_0;
			return textBlock;
		}
	}
}
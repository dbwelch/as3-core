package com.ffsys.di
{
	import com.ffsys.io.loaders.types.ImageLoader;
	import com.ffsys.io.loaders.types.MovieLoader;
	import com.ffsys.io.loaders.types.SoundLoader;
	
	public class BeanMediaParser extends BeanParser
	{
		/**
		* 	Creates a <code>BeanMediaParser</code> instance.
		* 
		* 	@param document A bean document to parse into.
		*/
		public function BeanMediaParser( document:IBeanDocument = null )
		{
			super( document );
		}
		
		/**
		* 	Adds extensions for rich media expression types.
		*/
		override public function get expressions():Object
		{
			var output:Object = super.expressions;
			
			/*
			output[ BeanConstants.BITMAP ] = Imageloader;
			output[ BeanConstants.SOUND ] = SoundLoader;
			output[ BeanConstants.SWF ] = MovieLoader;
			*/
			
			return output;
		}
	}
}
package com.ffsys.swat.configuration.rsls
{
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	import com.ffsys.swat.configuration.IPaths;
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	
	public class ViewComponentCollection extends ComponentResourceCollection
	{
		private var _xml:XmlCollection;
		
		/**
		* 	Creates a <code>ViewComponentCollection</code> instance.
		*/
		public function ViewComponentCollection()
		{
			super();
		}
		
		/**
		* 	Gets a loader queue for the resources associated with this
		* 	component.
		* 
		* 	@param paths The path configuration to use.
		* 	@param locale A locale that resources should be loaded
		* 	relative to.
		* 
		* 	@return A loader queue for all the resources.
		*/
		override public function getLoaderQueue(
			paths:IPaths = null,
			locale:IConfigurationLocale = null ):ILoaderQueue
		{
			//include any normal resource definitions as prerequisites
			var queue:ILoaderQueue = super.getLoaderQueue();

			if( this.xml != null )
			{
				queue.addLoader(
					this.xml.getLoaderQueue( paths, locale ) );
			}

			return queue;
		}
		
		/**
		* 	A collection of xml documents associated with this
		* 	view.
		*/
		public function get xml():XmlCollection
		{
			return _xml;
		}
		
		public function set xml( value:XmlCollection ):void
		{
			_xml = value;
		}
	}
}
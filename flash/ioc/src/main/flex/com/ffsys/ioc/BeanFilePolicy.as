package com.ffsys.ioc
{
	
	
	public class BeanFilePolicy extends Object
	{
		/**
		*	Indicates that file reference expressions are evaluated
		* 	at the document level.
		* 
		* 	This means the file dependencies will be loaded immediately
		* 	after the bean document has been loaded and parsed.
		* 
		* 	This is the default policy for all beans.
		*/
		public static const DOCUMENT_FILE_POLICY:String = "document";
		
		/**
		*	Indicates that file reference expressions are evaluated
		* 	at the bean level
		* 
		* 	When file expressions are evaluated at the bean level
		* 	no attempt is made to load the file dependencies until
		* 	the bean is instantiated.
		* 
		* 	If the instantiated bean implements the <code>IBeanLoaderObserver</code>
		* 	interface it can defer the load process until a later time
		* 	and interact with the load process.
		*/
		public static const BEAN_FILE_POLICY:String = "bean";
	}
}
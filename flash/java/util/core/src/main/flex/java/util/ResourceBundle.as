package java.util
{

	public class ResourceBundle extends Object
	{
		
		//protected  ResourceBundle	parent 
		          //The parent bundle of this bundle.
	
		public function ResourceBundle()
		{
			super();
		}
		
		
		/*
		
		static void	clearCache() 
		          Removes all resource bundles from the cache that have been loaded using the caller's class loader.
		static void	clearCache(ClassLoader loader) 
		          Removes all resource bundles from the cache that have been loaded using the given class loader.
		 boolean	containsKey(String key) 
		          Determines whether the given key is contained in this ResourceBundle or its parent bundles.
		static ResourceBundle	getBundle(String baseName) 
		          Gets a resource bundle using the specified base name, the default locale, and the caller's class loader.
		static ResourceBundle	getBundle(String baseName, Locale locale) 
		          Gets a resource bundle using the specified base name and locale, and the caller's class loader.
		static ResourceBundle	getBundle(String baseName, Locale locale, ClassLoader loader) 
		          Gets a resource bundle using the specified base name, locale, and class loader.
		static ResourceBundle	getBundle(String baseName, Locale targetLocale, ClassLoader loader, ResourceBundle.Control control) 
		          Returns a resource bundle using the specified base name, target locale, class loader and control.
		static ResourceBundle	getBundle(String baseName, Locale targetLocale, ResourceBundle.Control control) 
		          Returns a resource bundle using the specified base name, target locale and control, and the caller's class loader.
		static ResourceBundle	getBundle(String baseName, ResourceBundle.Control control) 
		          Returns a resource bundle using the specified base name, the default locale and the specified control.
		abstract  Enumeration<String>	getKeys() 
		          Returns an enumeration of the keys.
		 Locale	getLocale() 
		          Returns the locale of this resource bundle.
		 Object	getObject(String key) 
		          Gets an object for the given key from this resource bundle or one of its parents.
		 String	getString(String key) 
		          Gets a string for the given key from this resource bundle or one of its parents.
		 String[]	getStringArray(String key) 
		          Gets a string array for the given key from this resource bundle or one of its parents.
		protected abstract  Object	handleGetObject(String key) 
		          Gets an object for the given key from this resource bundle.
		protected  Set<String>	handleKeySet() 
		          Returns a Set of the keys contained only in this ResourceBundle.
		 Set<String>	keySet() 
		          Returns a Set of all keys contained in this ResourceBundle and its parent bundles.
		protected  void	setParent(ResourceBundle parent) 
		          Sets the parent bundle of this bundle.
		
		*/
	}
}
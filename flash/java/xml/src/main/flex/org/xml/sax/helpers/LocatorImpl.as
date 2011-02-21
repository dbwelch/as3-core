package org.xml.sax.helpers
{
	import org.xml.sax.Locator;
	
	/**
	* 	Provide an optional convenience implementation of Locator.
	* 
	* 	<p>This class is available mainly for application writers,
	* 	who can use it to make a persistent snapshot of a locator
	* 	at any point during a document parse:</p>
	* 
	* 	<pre>Locator locator;
	*   Locator startloc;
	*   
	*   public void setLocator (Locator locator)
	*   {
	*     // note the locator
	*     this.locator = locator;
	*   }
	*   
	*   public void startDocument ()
	*   {
	*     // save the location of the start of the document
	*     // for future use.
	*     Locator startloc = new LocatorImpl(locator);
	*   }</pre>
	* 
	* 	<p>Normally, parser writers will not use this class, since
	* 	it is more efficient to provide location information only
	* 	when requested, rather than constantly updating a Locator object.</p>
	*/
	public class LocatorImpl extends Object
		implements Locator
	{		
		/**
		* 	Creates a <code>LocatorImpl</code> instance.
		*/
		public function LocatorImpl()
		{
			super();
		}
	}
}
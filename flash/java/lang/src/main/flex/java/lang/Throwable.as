package java.lang
{
	
	/**
	* 	The Throwable class is the superclass of all errors
	* 	and exceptions in the Java language.
	* 
	* 	Only objects that are instances of this class
	* 	(or one of its subclasses) are thrown by the
	* 	Java Virtual Machine or can be thrown by the
	* 	Java throw statement. Similarly, only this class
	* 	or one of its subclasses can be the argument
	* 	type in a catch clause.
	* 
	* 	Instances of two subclasses, Error and Exception,
	* 	are conventionally used to indicate that exceptional
	* 	situations have occurred. Typically, these instances
	* 	are freshly created in the context of the exceptional
	* 	situation so as to include relevant information (such
	* 	as stack trace data).
	* 
	* 	A throwable contains a snapshot of the execution
	* 	stack of its thread at the time it was created. It
	* 	can also contain a message string that gives more
	* 	information about the error. Finally, it can contain
	* 	a cause: another throwable that caused this throwable
	* 	to get thrown. The cause facility is new in release 1.4.
	* 	It is also known as the chained exception facility,
	* 	as the cause can, itself, have a cause, and so on,
	* 	leading to a "chain" of exceptions, each caused by another.
	* 
	* 	One reason that a throwable may have a cause is that
	* 	the class that throws it is built atop a lower layered
	* 	abstraction, and an operation on the upper layer fails
	* 	due to a failure in the lower layer. It would be bad
	* 	design to let the throwable thrown by the lower layer
	* 	propagate outward, as it is generally unrelated to
	* 	the abstraction provided by the upper layer. Further,
	* 	doing so would tie the API of the upper layer to the
	* 	details of its implementation, assuming the lower layer's
	* 	exception was a checked exception. Throwing a "wrapped exception"
	* 	(i.e., an exception containing a cause) allows the upper layer
	* 	to communicate the details of the failure to its caller
	* 	without incurring either of these shortcomings. It preserves
	* 	the flexibility to change the implementation of the upper
	* 	layer without changing its API (in particular, the set of
	* 	exceptions thrown by its methods).
	* 
	* 	A second reason that a throwable may have a cause is
	* 	that the method that throws it must conform to a
	* 	general-purpose interface that does not permit the
	* 	method to throw the cause directly. For example,
	* 	suppose a persistent collection conforms to the
	* 	Collection interface, and that its persistence is
	* 	implemented atop java.io. Suppose the internals of
	* 	the add method can throw an IOException. The implementation
	* 	can communicate the details of the IOException to its caller
	* 	while conforming to the Collection interface by wrapping
	* 	the IOException in an appropriate unchecked exception. (The
	* 	specification for the persistent collection should indicate
	* 	that it is capable of throwing such exceptions.)
	*/
	public class Throwable extends Error
	{
		private var _cause:Throwable;
		
		/**
		* 	Creates a <code>Throwable</code> instance.
		* 
		* 	@param message The detail message.
		* 	@param couse The cause, a null value is permitted,
		* 	and indicates that the cause is nonexistent or unknown.
		* 	@param id An identifier for the exception.
		*/
		public function Throwable(
			message:String = null,
			cause:Throwable = null,
			id:int = 0 )
		{
			super( message, id );
			this.cause = cause;
		}
		
		/**
		* 	Returns the cause of this throwable or null if
		* 	the cause is nonexistent or unknown. (The cause
		* 	is the throwable that caused this throwable to get thrown.)
		* 
		* 	This implementation returns the cause that was supplied
		* 	via one of the constructors requiring a Throwable, or
		* 	that was set after creation with the initCause(Throwable)
		* 	method. While it is typically unnecessary to override this
		* 	method, a subclass can override it to return a cause set
		* 	by some other means. This is appropriate for a
		* 	"legacy chained throwable" that predates the addition
		* 	of chained exceptions to Throwable. Note that it is not
		* 	necessary to override any of the PrintStackTrace methods,
		* 	all of which invoke the getCause method to determine
		* 	the cause of a throwable.
		* 
		* 	@return The cause of this throwable or null if the
		* 	cause is nonexistent or unknown.
		*/
		public function get cause():Throwable
		{
			return _cause;
		}
		
		public function set cause( value:Throwable ):void
		{
			_cause = value;
		}
		
		/**
		* 	Sets a message with replacement values '%s'
		* 	replaced with each entry from the replacements
		* 	array.
		* 
		* 	@param message The message.
		* 	@param replacments The array of replacement values.
		*/
		public function setMessage( message:String, ... replacements ):void
		{
			//
		}
	}
}
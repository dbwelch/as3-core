package java.util
{
	
	import java.lang.Iterable;

	/**
	* 
	*/
	public interface Collection extends Iterable
	{
		
		/**
		* 	
		*/
		function add( e:Object ):Boolean;
		
		/**
		* 	
		*/
		function addAll( c:Collection ):Boolean;
		
		/**
		* 
		*/
		function clear():void;
		
		/**
		* 	
		*/
		function contains():Boolean;
		
		/**
		* 	
		*/
		function containsAll( c:Collection ):Boolean;
		
		/**
		* 	
		*/
		function isEmpty():Boolean;
		
		/**
		* 
		*/
		function remove( o:Object ):Boolean;
		
		/**
		* 	
		*/
		function removeAll( c:Collection ):Boolean;
		
		/**
		* 
		*/
		function retainAll( c:Collection ):Boolean;
		
		/**
		* 	
		*/
		function size():int;
		
		/**
		* 	
		*/
		//function toArray():Array;
		
		/**
		* 	
		*/
		function toVector( c:Class ):Vector;
		
		/*
		
		 boolean	add(E e) 
		          Ensures that this collection contains the specified element (optional operation).
		 boolean	addAll(Collection<? extends E> c) 
		          Adds all of the elements in the specified collection to this collection (optional operation).
		 void	clear() 
		          Removes all of the elements from this collection (optional operation).
		 boolean	contains(Object o) 
		          Returns true if this collection contains the specified element.
		 boolean	containsAll(Collection<?> c) 
		          Returns true if this collection contains all of the elements in the specified collection.
		
		 boolean	equals(Object o) 		
		          Compares the specified object with this collection for equality.
		 int	hashCode() 
		          Returns the hash code value for this collection.
		
		 boolean	isEmpty() 
		          Returns true if this collection contains no elements.
		 boolean	remove(Object o) 
		          Removes a single instance of the specified element from this collection, if it is present (optional operation).
		 boolean	removeAll(Collection<?> c) 
		          Removes all of this collection's elements that are also contained in the specified collection (optional operation).
		 boolean	retainAll(Collection<?> c) 
		          Retains only the elements in this collection that are contained in the specified collection (optional operation).
		 int	size() 
		          Returns the number of elements in this collection.
		 Object[]	toArray() 
		          Returns an array containing all of the elements in this collection.
		<T> T[]
		toArray(T[] a) 
		          Returns an array containing all of the elements in this collection; the runtime type of the returned array is that of the specified array.
		
		*/
	}
}


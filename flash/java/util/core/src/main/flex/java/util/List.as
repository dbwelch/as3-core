package java.util
{

	public interface List extends Collection
	{
		
		/**
		* 	
		*/
		function item( index:uint ):Object;
		
		/*
			
			boolean	add(E e) 
			          Appends the specified element to the end of this list (optional operation).
			 void	add(int index, E element) 
			          Inserts the specified element at the specified position in this list (optional operation).
			 boolean	addAll(Collection<? extends E> c) 
			          Appends all of the elements in the specified collection to the end of this list, in the order that they are returned by the specified collection's iterator (optional operation).
			 boolean	addAll(int index, Collection<? extends E> c) 
			          Inserts all of the elements in the specified collection into this list at the specified position (optional operation).
			 void	clear() 
			          Removes all of the elements from this list (optional operation).
			 boolean	contains(Object o) 
			          Returns true if this list contains the specified element.
			 boolean	containsAll(Collection<?> c) 
			          Returns true if this list contains all of the elements of the specified collection.
			 boolean	equals(Object o) 
			          Compares the specified object with this list for equality.
			 E	get(int index) 
			          Returns the element at the specified position in this list.
			 int	hashCode() 
			          Returns the hash code value for this list.
			 int	indexOf(Object o) 
			          Returns the index of the first occurrence of the specified element in this list, or -1 if this list does not contain the element.
			 boolean	isEmpty() 
			          Returns true if this list contains no elements.
			 Iterator<E>	iterator() 
			          Returns an iterator over the elements in this list in proper sequence.
			 int	lastIndexOf(Object o) 
			          Returns the index of the last occurrence of the specified element in this list, or -1 if this list does not contain the element.
			 ListIterator<E>	listIterator() 
			          Returns a list iterator over the elements in this list (in proper sequence).
			 ListIterator<E>	listIterator(int index) 
			          Returns a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list.
			 E	remove(int index) 
			          Removes the element at the specified position in this list (optional operation).
			 boolean	remove(Object o) 
			          Removes the first occurrence of the specified element from this list, if it is present (optional operation).
			 boolean	removeAll(Collection<?> c) 
			          Removes from this list all of its elements that are contained in the specified collection (optional operation).
			 boolean	retainAll(Collection<?> c) 
			          Retains only the elements in this list that are contained in the specified collection (optional operation).
			 E	set(int index, E element) 
			          Replaces the element at the specified position in this list with the specified element (optional operation).
			 int	size() 
			          Returns the number of elements in this list.
			 List<E>	subList(int fromIndex, int toIndex) 
			          Returns a view of the portion of this list between the specified fromIndex, inclusive, and toIndex, exclusive.
			 Object[]	toArray() 
			          Returns an array containing all of the elements in this list in proper sequence (from first to last element).
			<T> T[]
			toArray(T[] a) 
			          Returns an array containing all of the elements in this list in proper sequence (from first to last element); the runtime type of the returned array is that of the specified array.
			
		*/
	}
}
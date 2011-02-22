package org.w3c.dom.events
{
	
	/**
	* 	The MouseEvent interface provides specific
	* 	contextual information associated with Mouse events.
	* 
	* 	The detail attribute inherited from UIEvent indicates
	* 	the number of times a mouse button has been pressed and
	* 	released over the same screen location during a user action.
	* 
	* 	The attribute value is 1 when the user begins this action
	* 	and increments by 1 for each full sequence of pressing
	* 	and releasing. If the user moves the mouse between the
	* 	mousedown and mouseup the value will be set to 0,
	* 	indicating that no click is occurring.
	* 
	* 	In the case of nested elements mouse events are
	* 	always targeted at the most deeply nested element.
	* 
	* 	Ancestors of the targeted element may use bubbling
	* 	to obtain notification of mouse events which occur
	* 	within its descendent elements.
	* 
	* 	
	*/
	public interface DOMMouseEvent extends UIEvent
	{
		/*
		
		readonly attribute long            screenX;
		  readonly attribute long            screenY;
		  readonly attribute long            clientX;
		  readonly attribute long            clientY;
		  readonly attribute boolean         ctrlKey;
		  readonly attribute boolean         shiftKey;
		  readonly attribute boolean         altKey;
		  readonly attribute boolean         metaKey;
		  readonly attribute unsigned short  button;  
		  readonly attribute unsigned short  buttons;
		  readonly attribute                 EventTarget     relatedTarget;
		  void                               initMouseEvent(in DOMString typeArg, 
		                                                in boolean canBubbleArg, 
		                                                in boolean cancelableArg, 
		                                                in views::AbstractView viewArg, 
		                                                in long detailArg, 
		                                                in long screenXArg, 
		                                                in long screenYArg, 
		                                                in long clientXArg, 
		                                                in long clientYArg, 
		                                                in boolean ctrlKeyArg, 
		                                                in boolean altKeyArg, 
		                                                in boolean shiftKeyArg, 
		                                                in boolean metaKeyArg, 
		                                                in unsigned short buttonArg, 
		                                                in EventTarget relatedTargetArg);
		  // Introduced in DOM Level 3:
		  boolean                            getModifierState(in DOMString keyArg);		
		
		
		*/
	}
}
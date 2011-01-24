package com.ffsys.dom
{
	import com.ffsys.ioc.*;
	import com.ffsys.dom.xhtml.*;
	import com.ffsys.ui.css.*;

	/**
	*	Defines the core beans for <code>DOM</code> based documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	public class DomBeanDocument extends BeanDocument
	{
		/**
		* 	The default name for <code>DOM</code> bean documents.
		*/
		public static const NAME:String = "dom";
		
		/**
		* 	Creates a <code>DomBeanDocument</code> instance.
		* 
		* 	@param id A specific id to use for this document.
		*/
		public function DomBeanDocument( id:String = null )
		{
			super();
			this.id  = id != null ? id : NAME;
			this.locked = false;
			this.policy = BeanCreationPolicy.MERGE;
			doWithBeans( this );
		}
		
		/**
		* 	Initialies the components beans on the specified document.
		* 
		* 	@param beans The document to initialize with the bean definitions.
		*/
		public function doWithBeans(
			beans:IBeanDocument ):void
		{
			var data:Object = null;
			
			//CORE DOM ELEMENTS
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				DomIdentifiers.ATTR );
			descriptor.instanceClass = Attr;
			beans.addBeanDescriptor( descriptor );
			
			//hook in the style manager
			descriptor = new BeanDescriptor( 
				DomIdentifiers.STYLE_MANAGER );
			descriptor.instanceClass = StyleManager;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			
			//bean manager type injector
			beans.types.push( new BeanTypeInjector(
				DomIdentifiers.STYLE_MANAGER,
				DomIdentifiers.STYLE_MANAGER,
				IStyleManagerAware,
				descriptor ) );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.TEXT );
			descriptor.instanceClass = Text;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.DOCUMENT_FRAGMENT );
			descriptor.instanceClass = DocumentFragment;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.PROCESSING_INSTRUCTION );
			descriptor.instanceClass = ProcessingInstruction;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.COMMENT );
			descriptor.instanceClass = Comment;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.CDATA_SECTION );
			descriptor.instanceClass = CDATASection;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.ENTITY );
			descriptor.instanceClass = Entity;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.ENTITY_REFERENCE );
			descriptor.instanceClass = EntityReference;
			beans.addBeanDescriptor( descriptor );
			
			//COMMON NON-VISUAL ELEMENTS
			descriptor = new BeanDescriptor(
				DomIdentifiers.HEAD );
			descriptor.instanceClass = Head;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.META );
			descriptor.instanceClass = MetaElement;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.TITLE );
			descriptor.instanceClass = TitleElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.LINK );
			descriptor.instanceClass = LinkElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.BASE );
			descriptor.instanceClass = BaseElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.SCRIPT );
			descriptor.instanceClass = ScriptElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.PARAM );
			descriptor.instanceClass = ParamElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.STYLE );
			descriptor.instanceClass = StyleElement;
			beans.addBeanDescriptor( descriptor );
			
			//COMMON VISUAL ELEMENTS
			descriptor = new BeanDescriptor(
				DomIdentifiers.BODY );
			descriptor.instanceClass = Body;
			beans.addBeanDescriptor( descriptor );
			
			//ABSTRACT VISUAL
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.NOSCRIPT );
			descriptor.instanceClass = NoScriptElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.LEGEND );
			descriptor.instanceClass = LegendElement;
			beans.addBeanDescriptor( descriptor );	
			
			//BLOCK
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.DIV );
			descriptor.instanceClass = DivElement;
			beans.addBeanDescriptor( descriptor );
			
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.PRE );
			descriptor.instanceClass = PreformattedTextElement;
			beans.addBeanDescriptor( descriptor );
			
			//INLINE
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.SELECT );
			descriptor.instanceClass = SelectElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.OPTGROUP );
			descriptor.instanceClass = OptionGroupElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.OPTION );
			descriptor.instanceClass = OptionElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.STRONG );
			descriptor.instanceClass = StrongElement;
			beans.addBeanDescriptor( descriptor );								
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.EM );
			descriptor.instanceClass = EmElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.I );
			descriptor.instanceClass = ItalicElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.B );
			descriptor.instanceClass = BoldElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.SMALL );
			descriptor.instanceClass = SmallElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.BIG );
			descriptor.instanceClass = BigElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.SPAN );
			descriptor.instanceClass = SpanElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.SUB );
			descriptor.instanceClass = SubElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.SUP );
			descriptor.instanceClass = SupElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.VAR );
			descriptor.instanceClass = VarElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.TT );
			descriptor.instanceClass = TeleTypeTextElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.Q );
			descriptor.instanceClass = QuotationElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.KBD );
			descriptor.instanceClass = KeyboardElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.SAMP );
			descriptor.instanceClass = SampleElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.INPUT );
			descriptor.instanceClass = InputElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.LABEL );
			descriptor.instanceClass = LabelElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.DL );
			descriptor.instanceClass = DefinitionListElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.DFN );
			descriptor.instanceClass = DefiningElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.DT );
			descriptor.instanceClass = DefinitionTermElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.DD );
			descriptor.instanceClass = DefinitionElement;
			beans.addBeanDescriptor( descriptor );
		}
	}
}
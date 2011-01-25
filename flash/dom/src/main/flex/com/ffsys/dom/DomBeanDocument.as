package com.ffsys.dom
{
	import com.ffsys.ioc.*;
	import com.ffsys.dom.xhtml.*;	
	import com.ffsys.css.CssBeanDocument;

	/**
	*	Defines the core beans for <code>DOM</code> based documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	public class DomBeanDocument extends DomCoreBeanDocument
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
			this.id  = id != null ? id : NAME;
			this.locked = false;
			this.policy = BeanCreationPolicy.MERGE;			
			super();
		}
		
		/**
		* 	Initialies the components beans on the specified document.
		* 
		* 	@param beans The document to initialize with the bean definitions.
		*/
		override public function doWithBeans(
			beans:IBeanDocument ):void
		{
			super.doWithBeans( beans );
			
			var data:Object = null;
			
			//add a css bean document xref by default
			beans.xrefs.push( new CssBeanDocument() );
			
			//COMMON NON-VISUAL ELEMENTS
			var descriptor:IBeanDescriptor = new BeanDescriptor(
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
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.CAPTION );
			descriptor.instanceClass = CaptionElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.TR );
			descriptor.instanceClass = TableRowElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.TH );
			descriptor.instanceClass = TableHeaderElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.TD );
			descriptor.instanceClass = TableCellElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.AREA );
			descriptor.instanceClass = AreaElement;
			beans.addBeanDescriptor( descriptor );
			
			//BLOCK
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.HEADING_1 );
			descriptor.instanceClass = HeadingElement;
			descriptor.names.push(
				DomIdentifiers.HEADING_2,
				DomIdentifiers.HEADING_3,
				DomIdentifiers.HEADING_4,
				DomIdentifiers.HEADING_5,
				DomIdentifiers.HEADING_6 );
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.UL );
			descriptor.instanceClass = UnorderedListElement;
			beans.addBeanDescriptor( descriptor );

			descriptor = new BeanDescriptor(
				DomIdentifiers.OL );
			descriptor.instanceClass = OrderedListElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.ADDRESS );
			descriptor.instanceClass = AddressElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.DIV );
			descriptor.instanceClass = DivElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.BLOCKQUOTE );
			descriptor.instanceClass = BlockQuoteElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.PRE );
			descriptor.instanceClass = PreformattedTextElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.TABLE );
			descriptor.instanceClass = TableElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.FIELDSET );
			descriptor.instanceClass = FieldSetElement;
			beans.addBeanDescriptor( descriptor );
			
			//INLINE
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.ABBR );
			descriptor.instanceClass = AbbreviationElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.ACRONYM );
			descriptor.instanceClass = AcronymElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.ANCHOR );
			descriptor.instanceClass = AnchorElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.BUTTON );
			descriptor.instanceClass = ButtonElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.IMG );
			descriptor.instanceClass = ImageElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.BR );
			descriptor.instanceClass = LineBreakElement;
			beans.addBeanDescriptor( descriptor );			
			
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
				DomIdentifiers.CODE );
			descriptor.instanceClass = CodeElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.CITE );
			descriptor.instanceClass = CiteElement;
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
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.TEXTAREA );
			descriptor.instanceClass = TextAreaElement;
			beans.addBeanDescriptor( descriptor );
		}
	}
}
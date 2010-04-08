package com.ffsys.utils.reflection.members {
	
	import com.ffsys.utils.reflection.Reflection;
	import com.ffsys.utils.reflection.AbstractReflection;
	import com.ffsys.utils.reflection.meta.MetaData;
	
	/**
	*	Represents an instance member, whether it be a method, property
	*	or accessor member.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class InstanceMember extends AbstractReflection
		implements IMember {
		
		private var _name:String;
		private var _metaData:MetaData;
		private var _declaredBy:Class;
		private var _uri:String;
		private var _memberType:String;	
		
		/**
		*	@private
		*/
		public function InstanceMember()
		{
			super();
		}
		
		public function set memberType( val:String ):void
		{
			_memberType = val;
		}
		
		public function get memberType():String
		{
			return _memberType;
		}		
		
		/**
		*	@private
		*/		
		public function set declaredBy( val:String ):void
		{
			_declaredBy = getClassDefinition( val );
		}
		
		/**
		*	@private
		*/		
		public function get declaredBy():String
		{
			return null;
		}		
		
		/**
		*	@private
		*/		
		public function set metadata( val:MetaData ):void
		{
			_metaData = val;	
		}
		
		/**
		*	@private
		*/		
		public function get metadata():MetaData
		{
			return null;
		}
		
		public function get meta():MetaData
		{
			return _metaData;
		}				
		
		//-->
		
		public function set name( val:String ):void
		{
			_name = val;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set uri( val:String ):void
		{
			_uri = val;
		}
		
		public function get uri():String
		{
			return _uri;
		}			
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function getCommonStringOutputProperties():Object
		{
			var output:Object = super.getCommonStringOutputProperties();
			
			if( parent )
			{
				output.qualifiedClassPath = parent.getQualifiedClassPath();
				output.getClassName = parent.getClassName();
			}
			
			if( uri )
			{
				output.uri = uri;
			}			
			
			return output;
		}	
		/* END OBJECT_INSPECTOR REMOVAL */
	}
	
}

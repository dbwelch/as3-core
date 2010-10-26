var swat = swat ? swat : {};

/**
*	Switches the locale for the application.
*
*	@param lang A string that represents the language for the locale.
*/
swat.locale = function( lang )
{
	var config = swat.config;
	
	if( !config )
	{
		alert( "Application embedding configuration not found." );
	}
	
	config.flashvars.lang = lang;
	swat.embed( config );
	return false;
}

/**
*	Embeds the flash movie for the application based on the
*	current configuration if no configuration is specified.
*/
swat.embed = function( config )
{
	if( config == null )
	{
		config = swat.config;
	}
	
	if( config == null )
	{
		alert( "No valid configuration data found." );
	}
	
	swfobject.embedSWF( config.url, config.id, config.width, config.height, config.version, config.express, config.flashvars );
}

/**
*	Initializes the application by writing out links that will switch
*	to different locales.
*/
swat.init = function( id, locales )
{
	var div = document.getElementById( id );
	
	if( div && locales )
	{
		var html = "<ul>"
		var locale;
		var clazz = "";
		for( var i= 0;i < locales.length;i++ )
		{
			locale = locales[i];
			if( i == locales.length - 1 )
			{
				clazz = " class=\"last\"";
			}
			html += "<li" + clazz + "><a href=\"#\" onclick=\"return swat.locale( '" + locale + "' )\">" + locale + "</a></li>";
		}
		
		html += "<ul>";
		div.innerHTML = html;
	}
}
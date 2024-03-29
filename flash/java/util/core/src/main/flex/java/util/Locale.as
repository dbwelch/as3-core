package java.util
{
	
	/**
	* 	
	*/
	public class Locale extends Object
	{
		
		
		/*
		


		Field Summary
		static Locale	CANADA 
		          Useful constant for country.
		static Locale	CANADA_FRENCH 
		          Useful constant for country.
		static Locale	CHINA 
		          Useful constant for country.
		static Locale	CHINESE 
		          Useful constant for language.
		static Locale	ENGLISH 
		          Useful constant for language.
		static Locale	FRANCE 
		          Useful constant for country.
		static Locale	FRENCH 
		          Useful constant for language.
		static Locale	GERMAN 
		          Useful constant for language.
		static Locale	GERMANY 
		          Useful constant for country.
		static Locale	ITALIAN 
		          Useful constant for language.
		static Locale	ITALY 
		          Useful constant for country.
		static Locale	JAPAN 
		          Useful constant for country.
		static Locale	JAPANESE 
		          Useful constant for language.
		static Locale	KOREA 
		          Useful constant for country.
		static Locale	KOREAN 
		          Useful constant for language.
		static Locale	PRC 
		          Useful constant for country.
		static Locale	ROOT 
		          Useful constant for the root locale.
		static Locale	SIMPLIFIED_CHINESE 
		          Useful constant for language.
		static Locale	TAIWAN 
		          Useful constant for country.
		static Locale	TRADITIONAL_CHINESE 
		          Useful constant for language.
		static Locale	UK 
		          Useful constant for country.
		static Locale	US 
		          Useful constant for country.

		Constructor Summary
		Locale(String language) 
		          Construct a locale from a language code.
		Locale(String language, String country) 
		          Construct a locale from language, country.
		Locale(String language, String country, String variant) 
		          Construct a locale from language, country, variant.

		Method Summary
		 Object	clone() 
		          Overrides Cloneable
		 boolean	equals(Object obj) 
		          Returns true if this Locale is equal to another object.
		static Locale[]	getAvailableLocales() 
		          Returns an array of all installed locales.
		 String	getCountry() 
		          Returns the country/region code for this locale, which will either be the empty string or an uppercase ISO 3166 2-letter code.
		static Locale	getDefault() 
		          Gets the current value of the default locale for this instance of the Java Virtual Machine.
		 String	getDisplayCountry() 
		          Returns a name for the locale's country that is appropriate for display to the user.
		 String	getDisplayCountry(Locale inLocale) 
		          Returns a name for the locale's country that is appropriate for display to the user.
		 String	getDisplayLanguage() 
		          Returns a name for the locale's language that is appropriate for display to the user.
		 String	getDisplayLanguage(Locale inLocale) 
		          Returns a name for the locale's language that is appropriate for display to the user.
		 String	getDisplayName() 
		          Returns a name for the locale that is appropriate for display to the user.
		 String	getDisplayName(Locale inLocale) 
		          Returns a name for the locale that is appropriate for display to the user.
		 String	getDisplayVariant() 
		          Returns a name for the locale's variant code that is appropriate for display to the user.
		 String	getDisplayVariant(Locale inLocale) 
		          Returns a name for the locale's variant code that is appropriate for display to the user.
		 String	getISO3Country() 
		          Returns a three-letter abbreviation for this locale's country.
		 String	getISO3Language() 
		          Returns a three-letter abbreviation for this locale's language.
		static String[]	getISOCountries() 
		          Returns a list of all 2-letter country codes defined in ISO 3166.
		static String[]	getISOLanguages() 
		          Returns a list of all 2-letter language codes defined in ISO 639.
		 String	getLanguage() 
		          Returns the language code for this locale, which will either be the empty string or a lowercase ISO 639 code.
		 String	getVariant() 
		          Returns the variant code for this locale.
		 int	hashCode() 
		          Override hashCode.
		static void	setDefault(Locale newLocale) 
		          Sets the default locale for this instance of the Java Virtual Machine.
		 String	toString() 
		          Getter for the programmatic name of the entire locale, with the language, country and variant separated by underbars.		
		
		
		*/
		
		
		/**
		* 	Creates a <code>Locale</code> instance.
		*/
		public function Locale()
		{
			super();
		}
	}
}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umb="urn:umbraco.library"  
	exclude-result-prefixes="msxml umb">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
	<xsl:param name="currentPage"/>

	<!-- Tag Clouds - Laurie, 15th July 2011 -->
	
	<xsl:template match="/">

		<meta name="keywords" content="{$currentPage/metaKeywords} {$currentPage/ancestor-or-self::* [@isDoc and @level= 1]/metaKeywords}" />		
		<meta name="description" content="$currentPage/metaDescription" />

</xsl:template>

</xsl:stylesheet>
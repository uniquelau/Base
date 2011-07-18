<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY larr "&#x2190;" > <!ENTITY rarr "&#8594;" > ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:umb="urn:umbraco.library"  
	exclude-result-prefixes="msxml msxsl umb">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
	<xsl:param name="currentPage"/>
	
	<!-- Navigation Sibling Step 'Next' / 'Previous' - Laurie, 18th July 2011   -->
	
	<!-- Create XML fragment for brother and sister pages -->
	<xsl:variable name="xml">
		<nodes>
			<xsl:for-each select="$currentPage/parent::*/child::* [@isDoc]">
				<xsl:sort select="contentDate" data-type="number" order="descending" />
				<node contentHeader="{contentHeader}" id="{@id}" />
			</xsl:for-each>
		</nodes>
	</xsl:variable>
	
	<!-- Convert XML into Nodeset -->
	<xsl:variable name="xmlNodeSet" select="msxsl:node-set($xml)" />
	<!-- Get Prev/Next page Id's -->	
	<xsl:variable name="prev">
		<xsl:if test="$xmlNodeSet/nodes/node[@id=$currentPage/@id]/preceding-sibling::*[1]">
			<xsl:value-of select="umb:NiceUrl($xmlNodeSet/nodes/node[@id=$currentPage/@id]/preceding-sibling::*[1]/@id)" />
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="next">
		<xsl:if test="$xmlNodeSet/nodes/node[@id=$currentPage/@id]/following-sibling::*[1]">
			<xsl:value-of select="umb:NiceUrl($xmlNodeSet/nodes/node[@id=$currentPage/@id]/following-sibling::*[1]/@id)" />
		</xsl:if>
	</xsl:variable>
	
	<!-- Spit out Pagination -->
	<xsl:template match="/">
		<ul>
			<li><a rel="prev" href="{$prev}" title="Previous">&larr;</a></li>
			<li><a rel="next" href="{$next}" title="Next">&rarr;</a></li>
		</ul>
	</xsl:template>
    
</xsl:stylesheet>
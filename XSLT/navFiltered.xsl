<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:umb="urn:umbraco.library"  
	exclude-result-prefixes="umb"
>

	<xsl:output method="xml" omit-xml-declaration="yes"/>
	<xsl:param name="currentPage"/>

	<!-- Filtered Navigation - Laurie, 14th July 2011   -->

	<xsl:template match="/">
		<xsl:variable name="filter" select="/macro/filter" />
  	<xsl:apply-templates select="$currentPage/ancestor-or-self::* [@isDoc and @level= 1]/* [@isDoc] [contains(layoutNavigation, $filter)]" />
	</xsl:template>
    
	<xsl:template match="* [@isDoc]">
		<li>
			<a href="{umb:NiceUrl(@id)}">
				<xsl:if test="$currentPage/ancestor-or-self::*/@id = current()/@id">
					<xsl:attribute name="class">active</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="@nodeName" />
			</a>
		</li>
	</xsl:template>

</xsl:stylesheet>
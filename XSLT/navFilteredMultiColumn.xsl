<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umb="urn:umbraco.library"  
	exclude-result-prefixes="msxml umb">

	<xsl:output method="xml" omit-xml-declaration="yes"/>
	<xsl:param name="currentPage"/>

	<!-- Filtered Navigation, with Multi Column Dropdowns - Laurie, 15th July 2011   -->

	<xsl:template match="/">
		<xsl:variable name="filter" select="/macro/filter" />
  	<xsl:apply-templates select="$currentPage/ancestor-or-self::* [@isDoc and @level= 1]/* [@isDoc] [contains(layoutNavigation, $filter)]" />
	</xsl:template>
    
	<xsl:template match="* [@isDoc]">
		<xsl:call-template name="list-item" />
	</xsl:template>
	
	<xsl:template name="list-item">
		<li>
			<a href="{umb:NiceUrl(@id)}">
				<xsl:if test="$currentPage/ancestor-or-self::*/@id = current()/@id">
					<xsl:attribute name="class">active</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="@nodeName" />
				<xsl:call-template name="test-node" />
			</a>
		</li>
	</xsl:template>
	
	<xsl:template name="test-node">
		
	</xsl:template>
	
	<xsl:template name="create-sub-list">
		<div class="{$col $push}">
			<xsl:call-template name="populate-sub-list" />
		</div>
	</xsl:template>
	
	<xsl:template name="populate-sub-list">
		<!-- clever logic here, that does the split, can't be too hard -->
		<xsl:call-template name="list-item" />
	</xsl:template>

</xsl:stylesheet>

<!-- For HTML/CSS examples please see https://github.com/uniquelau/Base/tree/master/HTML/Navigation/2%20Column%20Dropdown -->
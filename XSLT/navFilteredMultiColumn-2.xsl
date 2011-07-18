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

	<!-- Filtered Navigation, with Multi Column Dropdowns - Laurie, 15th July 2011   -->
	<xsl:variable name="itemLimit" select="'3'" />
	<xsl:variable name="pushLimit" select="'2'" />
	<xsl:variable name="maxDepth" select="'3'" />

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
		<xsl:if test="@level &lt; $maxDepth and @isDoc">
			<xsl:variable name="total" select="count(ancestor-or-self::* [@isDoc and @level= 1]/* [@isDoc])" />
			<xsl:variable name="childCount" select="count(descendant::* [@isDoc and @level &lt;= $maxDepth + 1])" />
			<xsl:if test="$childCount &gt; 0">
				<xsl:call-template name="create-sub-list">
					<xsl:with-param name="push"> 
						<xsl:if test="position() &lt; $pushLimit">fixLeft</xsl:if>
						<xsl:if test="position() &gt; ($total - $pushLimit)">fixRight</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="childCount" select="$childCount" />
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="create-sub-list">
		<xsl:param name="push" />		
		<xsl:param name="childCount" />
		<xsl:variable name="col" select="round($childCount div $itemLimit)" />
		<xsl:variable name="colFix">
			<xsl:if test="$col = 0">1</xsl:if>
			<xsl:if test="$col &gt; 0"><xsl:value-of select="$col" /></xsl:if>
		</xsl:variable>
		<div class="col{$colFix} {$push}">
			<xsl:call-template name="column-first">
				<xsl:with-param name="childCount" select="$childCount" />
			</xsl:call-template>
		</div>
	</xsl:template>
	
	<xsl:template name="column-first">
		<div>
			<xsl:for-each select="* [@isDoc]">
				<xsl:if test="1 = 1">
					<xsl:call-template name="create-sub-sub-list" />
				</xsl:if>
			</xsl:for-each>
		</div>
		<xsl:if test="1 = 2">
			<xsl:call-template name="column-additional" />
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="column-additional">
		<div>
		</div>
	</xsl:template>
	
	<xsl:template name="create-sub-sub-list">
		<ul>
			<lh><xsl:value-of select="@nodeName" /></lh>
			<xsl:for-each select="* [@isDoc]">
				<li><xsl:value-of select="@nodeName" /></li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	


</xsl:stylesheet>

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
	
	<xsl:template name="renderTagCloud">
		<xsl:param name="currentPage" select="/.." /><!-- That selector makes the param default to an empty node-set -->
		<!-- Create the XML required -->
		<xsl:variable name="xml">
		<!-- Loop Over Tags -->
		<tags>
			<xsl:for-each select="$currentPage/ancestor-or-self::* [@isDoc and @level= 1]/publicSearch/publicSearchTags/publicSearchTag">
				<xsl:variable name="count">
				<!-- How many times has the tag been used? -->
					<xsl:for-each select="umb:GetRelatedNodesAsXml(@id)/relations/relation">
						<xsl:if test="position() = last()">
							<xsl:value-of select="position()" />
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<!-- Process each tag and create XML -->
				<tag name="{@nodeName}" id="{@id}" count="{('0'[not(normalize-space($count))] | $count)[1])}" />
				</xsl:for-each>
			</tags>
		</xsl:variable>
		
		<!-- Convert XML into Nodeset -->
		<xsl:variable name="xmlNodeSet" select="msxsl:node-set($xml)" />
		
		<!-- Find total number of Related/Tagged Nodes -->
		<xsl:variable name="totalRelatedNodes" select="count($currentPage/ancestor-or-self::* [@isDoc and @level= 1]/publicBlogGroup/publicBlog/publicBlogPost)" />
		
		<xsl:call-template name="displayTags">
			<xsl:with-param name="xmlNodeSet" select="$xmlNodeSet" />
			<xsl:with-param name="totalRelatedNodes" select="$totalRelatedNodes" />
		</xsl:call-template>
	
	</xsl:template>
	
	<xsl:template name="displayTags">
		<xsl:param name="xmlNodeSet" />
		<xsl:param name="totalRelatedNodes" />
		<!-- Now we're cooking with gas! -->
		<xsl:for-each select="$xmlNodeSet/tags/tag [@count &gt; 0]">
			<li>
				<span>
					<xsl:value-of select="@count" />
					<xsl:text> blogs are tagged with </xsl:text>
				</span>
				<a href="{umbraco.library:NiceUrl(@id)}">
					<xsl:attribute name="class">
						<xsl:call-template name="getRelativeFontSize">
							<xsl:with-param name="currentValue" select="@count" />
							<xsl:with-param name="totalRelatedNodes" select="$totalRelatedNodes" />
						</xsl:call-template>
					</xsl:attribute>
					<xsl:value-of select="@name" />
				</a>
			</li>
		</xsl:for-each>
	</xsl:template>
	
  <!-- Work out the Correct Font Size -->
	<xsl:template name="getRelativeFontSize">
		<xsl:param name="currentValue"/>
		<xsl:param name="totalRelatedNodes"/>
		<xsl:param name="relativeValue" select="($currentValue div $totalRelatedNodes)*100"/>
		<xsl:choose>
			<xsl:when test="$relativeValue &lt; 14">tag1x</xsl:when>
			<xsl:when test="$relativeValue &lt; 28">tag2x</xsl:when>
			<xsl:when test="$relativeValue &lt; 42">tag3x</xsl:when>
			<xsl:when test="$relativeValue &lt; 56">tag4x</xsl:when>
			<xsl:when test="$relativeValue &lt; 70">tag5x</xsl:when>
			<xsl:when test="$relativeValue &lt; 84">tag6x</xsl:when>
			<xsl:otherwise>tag7x</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
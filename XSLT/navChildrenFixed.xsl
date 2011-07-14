<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:umb="urn:umbraco.library"
	exclude-result-prefixes="umb"
>

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
	<xsl:param name="currentPage" />
	
	<!-- Children 'Fixed' Navigation - Laurie 14th July -->
	
	<xsl:template match="/">
		<xsl:apply-templates select="$currentPage/ancestor-or-self::* [@isDoc and @level= 2]/* [@isDoc]"/>
	</xsl:template>
	
	<xsl:template match="*">
		<xsl:call-template name="list-item" />
	</xsl:template>
	
	<xsl:template name="list-item">
		<li>
			<a href="{umb:NiceUrl(@id)}">
				<xsl:if test="@id = $currentPage/@id">
					<xsl:attribute name="class">active</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="@nodeName" />
				<!-- If at Level4, display children -->
				<xsl:if test="@id = $currentPage/parent::*/@id">
					<ul>
						<xsl:for-each select="* [@isDoc]">
							<xsl:call-template name="list-item" />
						</xsl:for-each>
					</ul>
				</xsl:if>
			</a>
		</li>
	</xsl:template>
	
	<!-- This macro provides navigation, that always remains at the set level (see apply-templates) -->
	<!-- However when a page is active at Level4, it will list the other child pages -->
	
</xsl:stylesheet>
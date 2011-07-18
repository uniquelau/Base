<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:umb="urn:umbraco.library"
	exclude-result-prefixes="umb"
>

	<xsl:output method="xml" omit-xml-declaration="yes" />
	<xsl:param name="currentPage" />
	
	<!-- Breadcrumbs - Laurie 14th July -->
	
	<xsl:template match="/">
		<xsl:apply-templates select="$currentPage/ancestor-or-self::* [@isDoc]"/>
	</xsl:template>
	
	<xsl:template match="* [@isDoc]">
		<a>
			<xsl:if test="@id != $currentPage/@id">
				<xsl:attribute name="href">
					<xsl:value-of select="umb:NiceUrl(@id)" />
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="@nodeName" />
		</a>
	</xsl:template>
	
</xsl:stylesheet>
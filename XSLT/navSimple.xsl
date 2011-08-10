<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:umb="urn:umbraco.library"
	exclude-result-prefixes="umb"
>

	<xsl:output method="xml" omit-xml-declaration="yes" />
	<xsl:param name="currentPage" />
	
	<!-- Navigation Sitemap, Laurie 18th July, 2011 -->
	<xsl:variable name="maxLevel" select="4"/>
	
	<xsl:template match="/">
		<xsl:call-template name="drawNodes">
			<xsl:with-param name="parent" select="$currentPage/ancestor-or-self::* [@isDoc and @level=1]"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="drawNodes">
		<xsl:param name="parent"/>
		<ul>
			<xsl:for-each select="$parent/* [@isDoc and @level &lt;= $maxLevel]">
				<li>
					<a href="{umb:NiceUrl(@id)}"><xsl:value-of select="@nodeName"/></a>
					<!-- Does this node have children? and if so are the below the max level? -->
					<xsl:if test="count(./* [@isDoc and @level &lt;= $maxLevel]) &gt; 0">
						<xsl:call-template name="drawNodes">
							<!-- If so call the template! -->
							<xsl:with-param name="parent" select="."/>
						</xsl:call-template>
					</xsl:if>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
</xsl:stylesheet>
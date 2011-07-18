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
		<xsl:if test="umb:IsProtected($parent/@id, $parent/@path) = 0 or (umb:IsProtected($parent/@id, $parent/@path) = 1 and umb:IsLoggedOn() = 1)">
			<ul>
				<xsl:for-each select="$parent/* [@isDoc and metaSitemap !='Hide Page,Hide Children' and metaSitemap !='Hide Page' and @level &lt;= $maxLevel]">
					<li>
						<a href="{umb:NiceUrl(@id)}"><xsl:value-of select="@nodeName"/></a>
						<xsl:if test="count(./* [@isDoc and parent::*/metaSitemap !='Hide Children' and parent::*/metaSitemap !='Hide Page,Hide Children' and @level &lt;= $maxLevel]) &gt; 0">
							<xsl:call-template name="drawNodes">
								<xsl:with-param name="parent" select="."/>
							</xsl:call-template>
						</xsl:if>
					</li>
				</xsl:for-each>
			</ul>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
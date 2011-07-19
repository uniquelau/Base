<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:umb="urn:umbraco.library"
	exclude-result-prefixes="umb"
>

	<xsl:output method="xml" omit-xml-declaration="yes" />
	<xsl:param name="currentPage" />
	
	<!-- Navigation Sitemap XML (for search engines), Laurie 18th July, 2011 -->
	<xsl:variable name="maxLevel" select="4"/>
	<xsl:variable name="urlPrefix">
		<xsl:text>http://</xsl:text>
		<xsl:value-of select="umb:RequestServerVariables('HTTP_HOST')" />
	</xsl:variable>
	
	<xsl:template match="/">
		<xsl:call-template name="drawNodes">
			<xsl:with-param name="parent" select="$currentPage/ancestor-or-self::*[@level=1 and @isDoc]"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="drawNodes">
		<xsl:param name="parent"/>
		<xsl:if test="umb:IsProtected($parent/@id, $parent/@path) = 0 or (umb:IsProtected($parent/@id, $parent/@path) = 1 and umb:IsLoggedOn() = 1) and @level &lt;= $maxLevel ">
			<xsl:for-each select="$parent/* [@isDoc and metaSitemap !='Hide Page,Hide Children' and metaSitemap !='Hide Page' and @level &lt;= $maxLevel]">
			<!-- If the document does not have a template, nothing is shown in the frontend anyway. -->
				<xsl:if test="@template &gt; 0">
					<url>
						<loc>
							<xsl:value-of select="$urlPrefix" />
							<xsl:value-of select="umb:NiceUrl(@id)" />
						</loc>
						<lastmod>
							<xsl:value-of select="@updateDate" />+00:00
						</lastmod>
						<xsl:if test="metaSitemapChangeFreq">
							<changefreq><xsl:value-of select="metaSitemapChangeFreq" /></changefreq>
						</xsl:if>
						<xsl:if test="metaSitemapPriority">
							<priority><xsl:value-of select="metaSitemapPriority" /></priority>
						</xsl:if>
					</url>
				</xsl:if>
				<xsl:if test="count(./* [@isDoc and parent::*/metaSitemap !='Hide Children' and parent::*/metaSitemap !='Hide Page,Hide Children' and @level &lt;= $maxLevel]) &gt; 0">
					<xsl:call-template name="drawNodes">
						<xsl:with-param name="parent" select="."/>
					</xsl:call-template>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>

<!-- Inspired by Cultiv's Brilliant Sitemap Package -->
<!-- Reference - http://our.umbraco.org/projects/website-utilities/cultiv-search-engine-sitemap -->
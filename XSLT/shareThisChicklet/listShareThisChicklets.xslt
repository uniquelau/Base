<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:umb="urn:umbraco.library"
	xmlns:eStrings="urn:Exslt.ExsltStrings"
	exclude-result-prefixes="umb eStrings"
>

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
	<xsl:param name="currentPage" />
	
	<!-- List ShareThis Chicklets - Laurie 14th July -->
	
	<xsl:template match="/">
		<xsl:apply-templates select="$currentPage/ancestor-or-self::*[@isDoc and @level= 1]/layoutFooterChicklets/*"/>
	</xsl:template>
	
	<xsl:template match="nodeId">
		<xsl:variable name="node" select="umb:GetXmlNodeById(.)" />
		<xsl:if test="$node/self::* [@isDoc]">
			<xsl:call-template name="chicklet">
				<xsl:with-param name="node" select="$node" />
				<xsl:with-param name="style">
					<xsl:if test="$node/chickletStyle != 'small'">
						<xsl:text>_</xsl:text>
						<xsl:value-of select="$node/chickletStyle" />
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="chicklet">
		<xsl:param name="node" />
		<xsl:param name="style" />
		<!-- There must be a better way, please please please! -->
		<span class="t_{eStrings:lowercase(($node/@nodeName[not(normalize-space(../chickletID))] | $node/chickletID)[1])}{$style}">
			<xsl:if test="$node/chickletImage[normalize-space()]">
				<img src="{$node/chickletImage}" alt="Share with {$node/@nodeName}"/> 
			</xsl:if>
			<!-- Crappy Fix Below, otherwise span tags nest (would ideally like <span class="value"></span>) -->
			<xsl:text> </xsl:text>
		</span>
	</xsl:template>
	
</xsl:stylesheet>

<!-- See Documentation.txt -->




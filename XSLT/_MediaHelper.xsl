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

	<!-- Media Helper - Laurie, 15th July 2011   -->
	
	<!-- All media goes through here -->
	<xsl:template match="*" mode="media">
		<xsl:variable name="mediaNode" select="umb:GetMedia(., false())" />
			<xsl:apply-templates select="$mediaNode[not(error)]" mode="media" />
		</xsl:template>
		
		<!-- Image file  -->
		<xsl:template match="Image" mode="media">
			<img src="{umbracoFile}" width="{umbracoWidth}" height="{umbracoHeight}" alt="{imageAlt}" />
		</xsl:template>
		
		<!-- Flash file -->
		<xsl:template match="File[umbracoExtension = 'swf']" mode="media">
			<!-- Go nuts with <object> and <embed> etc. -->
		</xsl:template>
		
		<!-- Downloadable File -->
		<xsl:template match="File[umbracoExtension = 'swf']" mode="media">
			<xsl:variable name="fileSize">
				<xsl:call-template name="fileSize" />
			</xsl:call-template>
			<a href="{umbracoFile}" title="Download {@nodeName}, {$fileSize}">
				<xsl:value-of select="@nodeName" />
			</a>
		</xsl:template>
		
		<!-- Video file -->
		<xsl:template match="Video" mode="media">
			<!-- Nice HTML5 Video Embed -->
		</xsl:template>
		
		<!------------------|¯¯¯|---------------------------------------->
		<!----------------__\ \------------------------------------------>
		<!---------------|____|------------------------------------------>
		
		<xsl:template name="fileSize">
			<xsl:variable name="size" select="umbracoBytes" />
			<xsl:variable name="sizeAndSuffix">
				<xsl:choose>
					<xsl:when test="$size &gt;= 1073741824">
						<xsl:value-of select="format-number($size div 1073741824,'#,###')"/>
						<xsl:text>GB</xsl:text>
					</xsl:when>
					<xsl:when test="$size &gt;= 1048576">
						<xsl:value-of select="format-number($size div 1048576,'#,###')"/>
						<xsl:text>MB</xsl:text>
					</xsl:when>
					<xsl:when test="$size &gt;= 1024">
						<xsl:value-of select="format-number($size div 1024,'#,###')"/>
						<xsl:text>KB</xsl:text>
					</xsl:when>
					<xsl:when test="$size &gt; 0 and $size &lt; 1024">
						<xsl:value-of select="format-number($size div 0,'#,###')"/>
						<xsl:text> Bytes</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>0 Bytes</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:value-of select="$sizeAndSuffix" />
		</xsl:template>
		
</xsl:stylesheet>

<!-- Based on a great article at 'Pimp My Xslt' - http://pimpmyxslt.com/articles/include-or-import/ - :-D -->

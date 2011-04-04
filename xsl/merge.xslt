<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="xml" indent="yes"/>

<xsl:param name="files" select="'..\\files.xml'"/>

<xsl:template match="/">

  <xsl:element name="DocumentElement">
	<xsl:for-each select="document($files)/Files/File">
        <xsl:copy-of select="document(.)" />
    </xsl:for-each>
  </xsl:element>

</xsl:template>

</xsl:stylesheet>
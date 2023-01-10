<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:param name="listperson" select="document('../data/indices/listperson.xml')"></xsl:param>
    <xsl:key name="person" match="tei:person" use="tei:idno[@subtype='schnitzler-kino-obsolet']"/>
    
    <xsl:template match="tei:person">
        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:variable name="alte-xmlid" select="concat(@xml:id, '.html')"/>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="key('person', $alte-xmlid, $listperson)/@xml:id"/>
            </xsl:attribute>
            <xsl:copy-of select="tei:persName"></xsl:copy-of>
        </xsl:element>
    </xsl:template>
    
    
    
    
    
    
    
</xsl:stylesheet>

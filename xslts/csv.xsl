<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:output indent="no" method="text" encoding="utf-8" omit-xml-declaration="true"/>
    
    <xsl:template match="tei:TEI">
        <xsl:apply-templates select="descendant::tei:body/descendant::tei:listPerson/tei:person"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="tei:person">
        <xsl:variable name="wert" select="replace(@xml:id, 'pmb','')"/>
        <xsl:value-of select="$wert"/>
        <xsl:text>;</xsl:text>
        <xsl:value-of select="concat('https://schnitzler-kino.acdh.oeaw.ac.at/', @xml:id, '.html')"/>
        <xsl:text>&#xA;</xsl:text>
        
        
    </xsl:template>
</xsl:stylesheet>

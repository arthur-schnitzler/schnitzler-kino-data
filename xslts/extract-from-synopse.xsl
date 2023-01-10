<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:param name="polli" select="document('../data/synopse-tei.xml')"></xsl:param>
    <xsl:key name="pily" match="tei:event" use="@key"/>
    
    <xsl:template match="tei:div[@type='anmerkung']">
        <xsl:copy-of select="."/>
        <xsl:variable name="datum" select="ancestor::tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/@when-iso[1]"/>
        <xsl:copy-of select="key('pily', $datum, $polli)/tei:note[@type='kommentar']"/>
        
    </xsl:template>
    
    


</xsl:stylesheet>

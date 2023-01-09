<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:param name="polli" select="document('../data/konkordanz-haupt.xml')"></xsl:param>
    <xsl:key name="pily" match="item" use="@when-iso"/>
    
    <xsl:template match="tei:div[@type='as']">
        <xsl:variable name="datum" select="ancestor::tei:TEI[1]/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:title[3]/@when-iso"/>
        <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="source">
                <xsl:choose>
                    <xsl:when test="key('pily', $datum, $polli)">
                        <xsl:value-of select="key('pily', $datum, $polli)/ref[@type='schnitzler-tagebuch']/@target"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>SUXSIC</xsl:text><xsl:value-of select="$datum"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            
                <xsl:copy-of select="*" copy-namespaces="false"/>
            
            
            
        </xsl:element>
        
        
    </xsl:template>
    
    <xsl:template match="tei:div[@type='ckp']">
        <xsl:variable name="datum" select="ancestor::tei:TEI[1]/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:title[3]/@when-iso"/>
        <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="source">
                <xsl:choose>
                    <xsl:when test="key('pily', $datum, $polli)">
                        <xsl:value-of select="key('pily', $datum, $polli)/ref[@type='pollaczek']/@target"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>SUXSIC</xsl:text><xsl:value-of select="$datum"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            
            <xsl:copy-of select="*" copy-namespaces="false"/>
            
            
            
        </xsl:element>
        
        
    </xsl:template>
    
    
    


</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    
    <xsl:template match="tei:title[@type='alternative' and @when-iso]">
        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="format-date(xs:date(@when-iso),'[FNn], [D01]. [MNn] [Y0001]')"/>
            
            
            
            
        </xsl:element>
        
        
    </xsl:template>
    
    
    
    
    
    
    
</xsl:stylesheet>

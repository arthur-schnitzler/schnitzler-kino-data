<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="tei:table[tei:head='Filme']">
        <xsl:element name="table">
            <xsl:attribute name="type">
                <xsl:text>movies</xsl:text>
            </xsl:attribute>
        <xsl:element name="row" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="tei:row[@role='data']/tei:cell[@role='data']">
                <xsl:element name="cell" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:copy-of select="@*"/>
                    <xsl:attribute name="ana">
                        <xsl:choose>
                            <xsl:when test="position()= 1">
                                <xsl:text>Filmtitel</xsl:text>
                            </xsl:when>
                            <xsl:when test="position()= 2">
                                <xsl:text>Jahr</xsl:text>
                            </xsl:when>
                            <xsl:when test="position()= 3">
                                <xsl:text>Genre</xsl:text>
                            </xsl:when>
                            <xsl:when test="position()= 4">
                                <xsl:text>Land</xsl:text>
                            </xsl:when>
                            <xsl:when test="position()= 5">
                                <xsl:text>Regie</xsl:text>
                            </xsl:when>
                            <xsl:when test="position()= 6">
                                <xsl:text>Buch</xsl:text>
                            </xsl:when>
                            <xsl:when test="position()= 7">
                                <xsl:text>Produktion</xsl:text>
                            </xsl:when>
                            <xsl:when test="position()= 8">
                                <xsl:text>Darsteller_innen</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>ERROR</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </xsl:attribute>
                    <xsl:copy-of select="text()|*"></xsl:copy-of>
                    
                </xsl:element>
                
                
            </xsl:for-each>
            
            
            
        </xsl:element>
        
        </xsl:element>
        
    </xsl:template>
    
    <xsl:template match="tei:back">
        <xsl:element name="back" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="tei:listPerson"/>
        <xsl:choose>
            <xsl:when test="tei:listPlace">
                <xsl:apply-templates select="tei:listPlace"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="listPlace">
                    <xsl:apply-templates select="tei:listOrg/tei:org"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:listOrg"/>
    
    <xsl:template match="tei:listPlace">
        <xsl:element name="listPlace" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="*"/>
            <xsl:for-each select="ancestor::tei:back/tei:listOrg/tei:org">
                <xsl:element name="place">
                    <xsl:copy-of select="@*"/>
                    <xsl:copy-of select="*"/>
                    
                </xsl:element>
                
            </xsl:for-each>
            
            
            
        </xsl:element>
        
        
    </xsl:template>
    
    
</xsl:stylesheet>

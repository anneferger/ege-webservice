<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
                xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:html="http://www.w3.org/1999/xhtml"

                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0"
                exclude-result-prefixes="#default a fo rng tei teix">
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p> TEI stylesheet dealing with elements from the header module,
      making HTML output. </p>
         <p> This library is free software; you can redistribute it and/or
      modify it under the terms of the GNU Lesser General Public License as
      published by the Free Software Foundation; either version 2.1 of the
      License, or (at your option) any later version. This library is
      distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
      without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
      PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
      details. You should have received a copy of the GNU Lesser General Public
      License along with this library; if not, write to the Free Software
      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA </p>
         <p>Author: See AUTHORS</p>
         <p>Id: $Id: header.xsl 7138 2010-01-25 09:57:19Z rahtz $</p>
         <p>Copyright: 2008, TEI Consortium</p>
      </desc>
   </doc>

  <xsl:key name="ALL-RENDITION" match="@rendition[not(starts-with(.,'#'))]" use="1"/>

  <xsl:key name="RENDITION" match="@rendition[not(starts-with(.,'#'))]" use="."/>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Process element teiHeader</desc>
   </doc>
  <xsl:template match="tei:teiHeader"/>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>make a style section from rendition elements in the header</desc>
   </doc>
  
  <xsl:template name="generateLocalCSS">
      <xsl:if test="ancestor-or-self::tei:TEI/tei:teiHeader/tei:encodingDesc/tei:tagsDecl/tei:rendition">
         <style type="text/css">
	           <xsl:for-each select="ancestor-or-self::tei:TEI/tei:teiHeader/tei:encodingDesc/tei:tagsDecl/tei:rendition">
	              <xsl:text>
.</xsl:text>
	              <xsl:value-of select="@xml:id"/>
	              <xsl:text> {
	</xsl:text>
	              <xsl:value-of select="."/>
	              <xsl:text>
}</xsl:text>
	           </xsl:for-each>
	           <xsl:text>
</xsl:text>
         </style>
      </xsl:if>
      <xsl:if test="count(key('ALL-RENDITION',1))&gt;0">
         <style type="text/css">
	           <xsl:for-each select="key('ALL-RENDITION',1)">
	              <xsl:variable name="pointer">
	                 <xsl:value-of select="."/>
	              </xsl:variable>
	              <xsl:for-each select="key('RENDITION',$pointer)[1]">
	                 <xsl:for-each select="document($pointer)">
	                    <xsl:text>
.</xsl:text>
	                    <xsl:value-of select="@xml:id"/>
	                    <xsl:text> {
	</xsl:text>
	                    <xsl:value-of select="."/>
	                    <xsl:text>
}</xsl:text>
	                 </xsl:for-each>
	              </xsl:for-each>
	           </xsl:for-each>
         </style>
      </xsl:if>
  </xsl:template>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>rendition elements in the header</desc>
   </doc>
  


</xsl:stylesheet>
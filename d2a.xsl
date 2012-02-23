<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 >

<xsl:output method="text" />

<xsl:template match="indexterm" />

<xsl:template match="para/text()">
<xsl:sequence select="replace(replace(., '\n\s+', ' ', 'm'), 'C\+\+', '\$\$C++\$\$', 'm')"/>
</xsl:template>

<xsl:template match="phrase/text()"><xsl:text/><xsl:sequence select="replace(., '\n\s+', ' ', 'm')"/><xsl:text/></xsl:template>

<xsl:template match="ulink/text()">
<xsl:sequence select="replace(., '\n\s+', ' ', 'm')"/>
</xsl:template>

<xsl:template match="title/text()">
<xsl:sequence select="replace(., '\n\s+', ' ', 'm')"/>
</xsl:template>

<xsl:template match="term/text()">
<xsl:sequence select="replace(replace(., '^\s+', '', 'm'), '\s+$', '', 'm')"/>
</xsl:template>

<xsl:template match="member/text()">
<xsl:sequence select="replace(., '^\s+', '', 'm')"/>
</xsl:template>

<xsl:template match="chapter">
[[<xsl:value-of select="@id"/>]]
== <xsl:apply-templates select="title"/>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:apply-templates select="*[not(self::title)]"/>
</xsl:template>

<xsl:template match="preface">
[[<xsl:value-of select="@id"/>]]
== <xsl:apply-templates select="title"/>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:apply-templates select="*[not(self::title)]"/>
</xsl:template>

<xsl:template match="sect1">
[[<xsl:value-of select="@id"/>]]
=== <xsl:apply-templates select="title"/>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:apply-templates select="*[not(self::title)]"/>
</xsl:template>

<xsl:template match="sect2">
[[<xsl:value-of select="@id"/>]]
==== <xsl:apply-templates select="title"/>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:apply-templates select="*[not(self::title)]"/>
</xsl:template>

<xsl:template match="sect3">
[[<xsl:value-of select="@id"/>]]
===== <xsl:apply-templates select="title"/>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:apply-templates select="*[not(self::title)]"/>
</xsl:template>

<xsl:template match="para">
<xsl:if test="@id">
[[<xsl:value-of select="@id"/>]]
</xsl:if>
<xsl:apply-templates select="node()"/>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:text xml:space="preserve">&#10;</xsl:text>
</xsl:template>

<xsl:template match="tip">
<xsl:if test="@id">[[<xsl:value-of select="@id"/>]]</xsl:if>
[TIP]
====
<xsl:apply-templates select="node()"/>
====
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:text xml:space="preserve">&#10;</xsl:text>
</xsl:template>

<xsl:template match="note">
<xsl:if test="@id">[[<xsl:value-of select="@id"/>]]</xsl:if>
[NOTE]
====
<xsl:apply-templates select="node()"/>
====
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:text xml:space="preserve">&#10;</xsl:text>
</xsl:template>

<xsl:template match="warning">
<xsl:if test="@id">
[[<xsl:value-of select="@id"/>]]
</xsl:if>
[WARNING]
====
<xsl:apply-templates select="node()"/>
====
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:text xml:space="preserve">&#10;</xsl:text>
</xsl:template>

<xsl:template match="term"><xsl:apply-templates select="node()"/>:: </xsl:template>

<xsl:template match="listitem">
<xsl:apply-templates select="node()"/>
</xsl:template>

<xsl:template match="phrase"><xsl:apply-templates /></xsl:template>

<xsl:template match="emphasis [@role='bold']">*<xsl:value-of select="." />*</xsl:template>

<xsl:template match="filename">_<xsl:if test="contains(., '~') or contains(., '_')">$$</xsl:if><xsl:value-of select="normalize-space(.)" /><xsl:if test="contains(., '~') or contains(., '_')">$$</xsl:if>_<xsl:if test="not(following-sibling::node()[1][self::userinput]) and matches(following-sibling::node()[1], '^[a-zA-Z]')"><xsl:text> </xsl:text></xsl:if></xsl:template>

<xsl:template match="emphasis">_<xsl:if test="contains(., '~') or contains(., '_')">$$</xsl:if><xsl:value-of select="normalize-space(.)" /><xsl:if test="contains(., '~') or contains(., '_')">$$</xsl:if>_<xsl:if test="not(following-sibling::node()[1][self::userinput]) and matches(following-sibling::node()[1], '^[a-zA-Z]')"><xsl:text> </xsl:text></xsl:if></xsl:template>

<xsl:template match="literal"><xsl:if test="following-sibling::node()[1][self::emphasis] or substring(following-sibling::node()[1],1,1) = 's' or substring(following-sibling::node()[1],1,1) = '’'">+</xsl:if>+<xsl:if test="contains(., '+')">$$</xsl:if><xsl:value-of select="." /><xsl:if test="contains(., '+')">$$</xsl:if>+<xsl:if test="following-sibling::node()[1][self::emphasis] or substring(following-sibling::node()[1],1,1) = 's' or substring(following-sibling::node()[1],1,1) = '’'">+</xsl:if></xsl:template>

<xsl:template match="userinput">**+<xsl:value-of select="normalize-space(.)" />+**</xsl:template>

<xsl:template match="replaceable">_++<xsl:value-of select="normalize-space(.)" />++_</xsl:template>

<xsl:template match="ulink">link:$$<xsl:value-of select="@url" />$$[<xsl:apply-templates/>]</xsl:template>

<xsl:template match="email"><xsl:value-of select="normalize-space(.)" /></xsl:template>

<xsl:template match="xref">&lt;&lt;<xsl:value-of select="@linkend" />&gt;&gt;</xsl:template>

<xsl:template match="variablelist">
<xsl:if test="@id">
[[<xsl:value-of select="@id"/>]]
</xsl:if>
<xsl:for-each select="varlistentry">
<xsl:apply-templates select="term,listitem"/>
</xsl:for-each>
</xsl:template>

<xsl:template match="itemizedlist">
<xsl:if test="@id">
[[<xsl:value-of select="@id"/>]]
</xsl:if>
<xsl:for-each select="listitem">
* <xsl:apply-templates/>
</xsl:for-each>
</xsl:template>

<xsl:template match="orderedlist">
<xsl:if test="@id">
[[<xsl:value-of select="@id"/>]]
</xsl:if>
<xsl:for-each select="listitem">
. <xsl:apply-templates/>
</xsl:for-each>
</xsl:template>

<xsl:template match="calloutlist">
<xsl:if test="@id">
[[<xsl:value-of select="@id"/>]]
</xsl:if>
<xsl:for-each select="callout">
&lt;<xsl:value-of select="position()"/>&gt; <xsl:apply-templates/>
</xsl:for-each>
</xsl:template>

<xsl:template match="simplelist">
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:if test="@id">
[[<xsl:value-of select="@id"/>]]
</xsl:if>
<xsl:for-each select="member">
<xsl:apply-templates/><xsl:if test="position() &lt; last()"> +
</xsl:if>
</xsl:for-each>
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:text xml:space="preserve">&#10;</xsl:text>
</xsl:template>

<xsl:template match="figure">
<xsl:if test="@id">[[<xsl:value-of select="@id"/>]]</xsl:if>
.<xsl:apply-templates select="title"/>
image::<xsl:value-of select="mediaobject/imageobject[@role='web']/imagedata/@fileref"/>[]
<xsl:text xml:space="preserve">&#10;</xsl:text>
</xsl:template>

<xsl:template match="informalfigure">
<xsl:text xml:space="preserve">&#10;</xsl:text>
<xsl:if test="@id">[[<xsl:value-of select="@id"/>]]</xsl:if>
image::<xsl:value-of select="mediaobject/imageobject[@role='web']/imagedata/@fileref"/>[]
<xsl:text xml:space="preserve">&#10;</xsl:text>
</xsl:template>

<xsl:template match="inlinemediaobject">image:<xsl:value-of select="imageobject[@role='web']/imagedata/@fileref"/>[]</xsl:template>

<xsl:template match="example">
<xsl:if test="@id">[[<xsl:value-of select="@id"/>]]</xsl:if>
<xsl:if test="title">
.<xsl:apply-templates select="title"/>
</xsl:if>
<xsl:apply-templates select="screen"/>
</xsl:template>

<xsl:template match="screen">
----
<xsl:apply-templates/>
----
<xsl:text xml:space="preserve">&#10;</xsl:text>
</xsl:template>


<xsl:template match="co"><xsl:variable name="curr" select="@id"/>&lt;<xsl:value-of select="count(//calloutlist/callout[@arearefs=$curr]/preceding-sibling::callout)+1"/>&gt;</xsl:template>

<xsl:template match="table">
<xsl:if test="@id">
[[<xsl:value-of select="@id"/>]]
</xsl:if>
.<xsl:apply-templates select="title"/>
|===============
<xsl:apply-templates select="*[not(self::title)]"/>
|===============
</xsl:template>

<xsl:template match="tgroup">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="thead/row">
<xsl:for-each select="entry">|<xsl:apply-templates/></xsl:for-each>
<xsl:text xml:space="preserve">&#10;</xsl:text>
</xsl:template>

<xsl:template match="tbody/row">
<xsl:for-each select="entry">|<xsl:value-of select="para"/></xsl:for-each>
<xsl:text xml:space="preserve">&#10;</xsl:text>
</xsl:template>

</xsl:stylesheet>

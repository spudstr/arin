<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:bwi="http://www.arin.net/bulkwhois/core/v1">
    
<xsl:output method="text" />
<xsl:template match="bwi:limitExceeded"/>

<xsl:template match="bwi:asn">
ASHandle:       <xsl:value-of select="bwi:handle"/>
OrgID:          <xsl:value-of select="bwi:orgHandle"/>
ASName:         <xsl:value-of select="bwi:name"/>
ASNumber:       <xsl:value-of select="bwi:startAsNumber"/><xsl:if test="not( bwi:startAsNumber/text() = bwi:endAsNumber/text() )"> - <xsl:value-of select="bwi:endAsNumber"/></xsl:if>
RegDate:        <xsl:call-template name="date"><xsl:with-param name="date" select="bwi:registrationDate"/></xsl:call-template>
<xsl:for-each select="bwi:comment/bwi:line">
Comment:        <xsl:value-of select="."/>
</xsl:for-each>
Updated:        <xsl:call-template name="date"><xsl:with-param name="date" select="bwi:updateDate"/></xsl:call-template>
<xsl:for-each select="bwi:pocLinks/bwi:pocLink">
<xsl:if test="@function = 'T'">
TechHandle:     <xsl:value-of select="@handle"/>
</xsl:if>
<xsl:if test="@function = 'AB'">
AbuseHandle:    <xsl:value-of select="@handle"/>
</xsl:if>
<xsl:if test="@function = 'AD'">
AdminHandle:    <xsl:value-of select="@handle"/>
</xsl:if>
<xsl:if test="@function = 'N'">
NOCHandle:      <xsl:value-of select="@handle"/>
</xsl:if>
</xsl:for-each>
Source:         ARIN
</xsl:template>

<xsl:template match="bwi:poc">
POCHandle:      <xsl:value-of select="bwi:handle"/>
IsRole:         <xsl:value-of select="bwi:isRoleAccount"/>
LastName:       <xsl:value-of select="bwi:lastName"/>
FirstName:      <xsl:value-of select="bwi:firstName"/>
<xsl:for-each select="bwi:streetAddress/bwi:line">
Street:         <xsl:value-of select="."/>
</xsl:for-each>
City:           <xsl:value-of select="bwi:city" />
State/Prov:     <xsl:value-of select="bwi:iso3166-2" />
Country:        <xsl:value-of select="bwi:iso3166-1/bwi:code2" />
PostalCode:     <xsl:value-of select="bwi:postalCode" />
<xsl:for-each select="bwi:comment/bwi:line">
Comment:        <xsl:value-of select="."/>
</xsl:for-each>
RegDate:        <xsl:call-template name="date"><xsl:with-param name="date" select="bwi:registrationDate"/></xsl:call-template>
Updated:        <xsl:call-template name="date"><xsl:with-param name="date" select="bwi:updateDate"/></xsl:call-template>
<xsl:for-each select="bwi:phones/bwi:phone">
<xsl:text>
</xsl:text><xsl:value-of select="bwi:type/bwi:description"/>Phone:    <xsl:if test="bwi:type/bwi:description = 'Fax'"><xsl:text>   </xsl:text></xsl:if><xsl:value-of select="bwi:number/bwi:phoneNumber"/>
</xsl:for-each>
<xsl:for-each select="bwi:emails/bwi:email">
Mailbox:        <xsl:value-of select="."/>
</xsl:for-each>
Source:         ARIN
</xsl:template>

<xsl:template match="bwi:org">
OrgID:          <xsl:value-of select="bwi:handle"/>
OrgName:        <xsl:value-of select="bwi:name"/>
CanAllocate:    <xsl:value-of select="bwi:canAllocate"/>
<xsl:for-each select="bwi:streetAddress/bwi:line">
Street:         <xsl:value-of select="."/>
</xsl:for-each>
City:           <xsl:value-of select="bwi:city" />
State/Prov:     <xsl:value-of select="bwi:iso3166-2" />
Country:        <xsl:value-of select="bwi:iso3166-1/bwi:code2" />
PostalCode:     <xsl:value-of select="bwi:postalCode" />
<xsl:for-each select="bwi:comment/bwi:line">
Comment:        <xsl:value-of select="."/>
</xsl:for-each>
RegDate:        <xsl:call-template name="date"><xsl:with-param name="date" select="bwi:registrationDate"/></xsl:call-template>
Updated:        <xsl:call-template name="date"><xsl:with-param name="date" select="bwi:updateDate"/></xsl:call-template>
<xsl:if test="bwi:referralServer">
ReferralServer: <xsl:value-of select="bwi:referralServer" />
</xsl:if>
<xsl:for-each select="bwi:pocLinks/bwi:pocLink">
<xsl:if test="@function = 'T'">
OrgTechHandle:  <xsl:value-of select="@handle"/>
</xsl:if>
<xsl:if test="@function = 'AB'">
OrgAbuseHandle: <xsl:value-of select="@handle"/>
</xsl:if>
<xsl:if test="@function = 'AD'">
OrgAdminHandle: <xsl:value-of select="@handle"/>
</xsl:if>
<xsl:if test="@function = 'N'">
OrgNOCHandle:   <xsl:value-of select="@handle"/>
</xsl:if>
</xsl:for-each>
Source:         ARIN
</xsl:template>

<xsl:template match="bwi:net">
<xsl:if test="bwi:version = 4">    
NetHandle:      <xsl:value-of select="bwi:handle"/>
</xsl:if>
<xsl:if test="bwi:version = 6">    
V6NetHandle:    <xsl:value-of select="bwi:handle"/>
</xsl:if>
OrgID:          <xsl:value-of select="bwi:orgHandle"/>
Parent:         <xsl:value-of select="bwi:parentNetHandle"/>
NetName:        <xsl:value-of select="bwi:name"/>
NetRange:       <xsl:value-of select="bwi:startAddress"/> - <xsl:value-of select="bwi:endAddress"/>
NetType:        <xsl:call-template name="nettype"><xsl:with-param name="type" select="bwi:netBlocks/bwi:netBlock/bwi:type"/></xsl:call-template>
<xsl:if test="bwi:originASes">
OriginAS:       <xsl:call-template name="comma-join"><xsl:with-param name="list" select="bwi:originASes/bwi:originAS"/></xsl:call-template>
</xsl:if>
<xsl:for-each select="bwi:comment/bwi:line">
Comment:        <xsl:value-of select="."/>
</xsl:for-each>
RegDate:        <xsl:call-template name="date"><xsl:with-param name="date" select="bwi:registrationDate"/></xsl:call-template>
Updated:        <xsl:call-template name="date"><xsl:with-param name="date" select="bwi:updateDate"/></xsl:call-template>
<xsl:for-each select="bwi:nameservers/bwi:nameserver">
Nameserver:     <xsl:value-of select="."/>
</xsl:for-each>
<xsl:for-each select="bwi:pocLinks/bwi:pocLink">
<xsl:if test="@function = 'T'">
TechHandle:     <xsl:value-of select="@handle"/>
</xsl:if>
<xsl:if test="@function = 'AB'">
AbuseHandle:    <xsl:value-of select="@handle"/>
</xsl:if>
<xsl:if test="@function = 'AD'">
AdminHandle:    <xsl:value-of select="@handle"/>
</xsl:if>
<xsl:if test="@function = 'N'">
NOCHandle:      <xsl:value-of select="@handle"/>
</xsl:if>
</xsl:for-each>
Source:         ARIN
</xsl:template>

<xsl:template name="date">
    <xsl:param name="date" />
    <xsl:value-of select="substring($date, 1, 10)" />
</xsl:template>
    
<xsl:template name="nettype">
    <xsl:param name="type" />
    <xsl:if test="$type = 'DS'">assignment</xsl:if>
    <xsl:if test="$type = 'DA'">allocation</xsl:if>
    <xsl:if test="$type = 'A'">reallocation</xsl:if>
    <xsl:if test="$type = 'S'">reassignment</xsl:if>
    <xsl:if test="$type = 'IU'">assignment</xsl:if>
    <xsl:if test="$type = 'IR'">reserved</xsl:if>
    <xsl:if test="$type = 'AR'">rir</xsl:if>
    <xsl:if test="$type = 'AF'">rir</xsl:if>
    <xsl:if test="$type = 'FX'">rir</xsl:if>
    <xsl:if test="$type = 'AP'">rir</xsl:if>
    <xsl:if test="$type = 'PV'">rir</xsl:if>
    <xsl:if test="$type = 'PX'">rir</xsl:if>
    <xsl:if test="$type = 'LN'">rir</xsl:if>
    <xsl:if test="$type = 'LX'">rir</xsl:if>
    <xsl:if test="$type = 'RN'">rir</xsl:if>
    <xsl:if test="$type = 'RV'">rir</xsl:if>
    <xsl:if test="$type = 'RX'">rir</xsl:if>
</xsl:template>

<xsl:template name="comma-join">
    <xsl:param name="list" />

    <xsl:for-each select="$list">
        <xsl:value-of select="." />
        <xsl:if test="position() != last()">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

</xsl:stylesheet>

import lxml.etree as ET

dom = ET.parse('arintst.xml')
xslt = ET.parse('legacy.xsl')
transform = ET.XSLT(xslt)
newdom = transform(dom)
print(ET.tostring(newdom, pretty_print=True))

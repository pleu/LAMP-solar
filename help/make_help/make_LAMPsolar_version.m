function make_LAMPsolar_version

dom = com.mathworks.xml.XMLUtils.createDocument('LAMP-solar');

struct2DOMnode(dom, dom.getDocumentElement,get_LAMPsolar_option('version'),'version')

xmlwrite('LAMPsolar_version.xml',dom)
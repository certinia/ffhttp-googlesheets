/**
 * Copyright (c) 2014, FinancialForce.com, inc
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the FinancialForce.com, inc nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

/**
 * ffhttp_GoogleSheetsModelUrlLink
 *
 * An object that represents the meta data for a URL in Google Sheets.
 * 
 * Example response:
 *
 * <link rel='http://schemas.google.com/spreadsheets/2006#worksheetsfeed' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full'/>
 */
public with sharing class ffhttp_GoogleSheetsModelUrlLink implements ffhttp_IXmlSerializable
{
	//Statics
	//XML tag names
	public static final String XML_ELEMENT_REL = 'rel';
	public static final String XML_ELEMENT_TYPE = 'type';
	public static final String XML_ELEMENT_HREF = 'href';
	
	//Instance variables
    private String m_rel;
    private String m_type;
    private String m_href;
	
	/**
	 * ffhttp_IXmlSerializable implementation
	 */
	public void readXml(Dom.XmlNode node)
	{
		m_rel = node.getAttributeValue(XML_ELEMENT_REL, null);
		m_type = node.getAttributeValue(XML_ELEMENT_TYPE, null);
		m_href = node.getAttributeValue(XML_ELEMENT_HREF, null);
	}	 
	
	public Dom.XmlNode writeXml(Dom.XmlNode node)
	{
		node.setAttribute(XML_ELEMENT_REL, m_rel);
		node.setAttribute(XML_ELEMENT_TYPE, m_type);
		node.setAttribute(XML_ELEMENT_HREF, m_href);
		return node;
	}
	
	/**
	 * Get/Sets
	 */
	public String getRel() 
	{
		return m_rel;
	}
	public ffhttp_GoogleSheetsModelUrlLink setRel(String rel) 
	{
		m_rel = rel;
		return this;
	}
	public String getType() 
	{
		return m_type;
	}
	public ffhttp_GoogleSheetsModelUrlLink setType(String type) 
	{
		m_type = type;
		return this;
	}
	public String getHRef() 
	{
		return m_href;
	}
	public ffhttp_GoogleSheetsModelUrlLink setHRef(String href) 
	{
		m_href = href;
		return this;
	}
}

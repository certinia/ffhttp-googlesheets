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
 * ffhttp_GoogleSheetsModelAuthor
 *
 * An object that represents the meta data for an author in Google Sheets.
 * 
 * Example response:
 *
 * <author>
 *     <name>Joe Blogss</name>
       <email>joebloggs@hotmail.com</email>
 * </author>
 */
public with sharing class ffhttp_GoogleSheetsModelAuthor implements ffhttp_IXmlSerializable
{
	//Statics
	//XML tag names
	public static final String XML_ELEMENT_NAME = 'name';
	public static final String XML_ELEMENT_EMAIL = 'email';
	
	//Instance variables
    private String m_name;			//A plain text displayable name for the author.
    private String m_email;			//The email address of the author.
	
	/**
	 * ffhttp_IXmlSerializable implementation
	 */
	public void readXml(Dom.XmlNode node)
	{
		Dom.XmlNode[] nodeChildren = node.getChildren();
		
		for (Dom.XmlNode n : nodeChildren)
		{
			String name = n.getName();
			if (name.equals(XML_ELEMENT_NAME))
			{
				m_name = n.getText();
			}
			else if (name.equals(XML_ELEMENT_EMAIL))
			{
				m_email = n.getText();
			}
		}
	}	 
	
	public Dom.XmlNode writeXml(Dom.XmlNode node)
	{
		node.addChildElement(XML_ELEMENT_NAME, node.getNamespace(), null).addTextNode(m_name);
		node.addChildElement(XML_ELEMENT_EMAIL, node.getNamespace(), null).addTextNode(m_email);
		return node;
	}
	
	/**
	 * Get/Sets
	 */
	public String getName() 
	{
		return m_name;
	}
	public ffhttp_GoogleSheetsModelAuthor setName(String name) 
	{
		m_name = name;
		return this;
	}
	public String getEmail() 
	{
		return m_email;
	}
	public ffhttp_GoogleSheetsModelAuthor setEmail(String email) 
	{
		m_email = email;
		return this;
	}
}

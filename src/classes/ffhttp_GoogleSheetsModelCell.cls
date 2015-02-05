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
 * ffhttp_GoogleSheetsModelCell
 * 
 * An object that represents a single cell within a Google Sheet worksheet.
 *
 * Example Response:
 *
 * <entry gd:etag='"ImA9D1APFyp7"'>
 *     <id>https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/full/R1C1</id>
 *     <updated>2006-11-17T18:27:32.543Z</updated>
 *     <category scheme="http://schemas.google.com/spreadsheets/2006" term="http://schemas.google.com/spreadsheets/2006#cell"/>
 *     <title type="text">A1</title>
 *     <content type="text">Name</content>
 *     <link rel="self" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/cells/key/worksheetId/private/full/R1C1"/>
 *     <link rel="edit" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/cells/key/worksheetId/private/full/R1C1/bgvjf"/>
 *     <gs:cell row="1" col="1" inputValue="Name">Name</gs:cell>
 * </entry>
 */
public with sharing class ffhttp_GoogleSheetsModelCell extends ffhttp_GoogleSheetsModelAbstractObject
{
	//Instance variables
	private Integer m_row;
	private Integer m_col;
	private String m_inputValue;
	private Decimal m_numericValue;
	private String m_value;
	
	/**
	 * ffhttp_GoogleSheetsModelAbstractObject implementation
	 */
	public override void readXml(Dom.XmlNode node)
	{
		super.readXml(node);
		
		Dom.XmlNode cellNode = node.getChildElement(XML_ELEMENT_CELL, XML_NAMESPACE_VALUE_GOOGLE_SHEETS);
		if (cellNode == null)
		{		
			return;
		}
	
		Object rowAttr = cellNode.getAttribute(XML_ELEMENT_CELL_ROW, null);
		if (rowAttr != null)
		{
			m_row = Integer.valueOf(rowAttr);
		}
		
		Object colAttr = cellNode.getAttribute(XML_ELEMENT_CELL_COL, null);
		if (colAttr != null)
		{
			m_col = Integer.valueOf(colAttr);
		}		
		
		Object inputValueAttr = cellNode.getAttribute(XML_ELEMENT_CELL_INPUT_VALUE, null);
		if (inputValueAttr != null)
		{
			m_inputValue = (String)inputValueAttr;
		}
		
		String numericValueAttr = (String)cellNode.getAttribute(XML_ELEMENT_CELL_NUMERIC_VALUE, null);
		if (numericValueAttr != null)
		{
			m_numericValue = Decimal.valueOf(numericValueAttr);
		}
		
		String value = cellNode.getText();
		if (value != null)
		{
			m_Value = value;
		}
	}
	public override Dom.XmlNode writeXml(Dom.XmlNode node)
	{
		super.writeXml(node);
		
		//Add the relevant namespaces if this is the top level node.
		if (node.getParent() == null)
		{
			node.setAttribute(XML_NAMESPACE_FULL_GOOGLE_SHEETS, XML_NAMESPACE_VALUE_GOOGLE_SHEETS);
			node.setAttribute(XML_NAMESPACE_FULL_BATCH, XML_NAMESPACE_VALUE_BATCH);
		}
		
		Dom.XmlNode cellNode = node.addChildElement(XML_NAMESPACE_GOOGLE_SHEETS + ':' + XML_ELEMENT_CELL, node.getNamespace(), null);
		if (m_row != null)
		{
			cellNode.setAttribute(XML_ELEMENT_CELL_ROW, String.valueOf(m_row));
		}
		
		if (m_col != null)
		{
			cellNode.setAttribute(XML_ELEMENT_CELL_COL, String.valueOf(m_col));
		}
		
		if (m_inputValue != null)
		{
			cellNode.setAttribute(XML_ELEMENT_CELL_INPUT_VALUE, m_inputValue);
		}
		
		if (m_numericValue != null)
		{
			cellNode.setAttribute(XML_ELEMENT_CELL_NUMERIC_VALUE, String.valueOf(m_numericValue));
		}
		
		if (m_Value != null)
		{
			cellNode.addTextNode(m_Value);
		}
		
		return node;
	}
	
	/**
	 * Get/Sets
	 */
	public Integer getRow() 
	{
		return m_row;
	}
	public ffhttp_GoogleSheetsModelCell setRow(Integer row) 
	{
		m_row = row;
		return this;
	}
	public Integer getCol() 
	{
		return m_col;
	}
	public ffhttp_GoogleSheetsModelCell setCol(Integer col) 
	{
		m_col = col;
		return this;
	}
	public String getInputValue() 
	{
		return m_inputValue;
	}
	public ffhttp_GoogleSheetsModelCell setInputValue(String inputValue) 
	{
		m_inputValue = inputValue;
		return this;
	}
	public Decimal getNumericValue() 
	{
		return m_numericValue;
	}
	public ffhttp_GoogleSheetsModelCell setNumericValue(Decimal numericValue) 
	{
		m_numericValue = numericValue;
		return this;
	}
	public String getValue() 
	{
		return m_value;
	}
	public ffhttp_GoogleSheetsModelCell setValue(String value) 
	{
		m_value = value;
		return this;
	}	
}

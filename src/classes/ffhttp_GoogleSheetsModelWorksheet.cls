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
 * ffhttp_GoogleSheetsModelWorksheet
 * 
 * An object that represents a worksheet within a Google Sheet spreadsheet. 
 *
 * Example response:
 * 
 * <entry>
 *     <id>https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6</id>
 *     <updated>2014-11-05T11:55:22.076Z</updated>
 *     <category scheme='http://schemas.google.com/spreadsheets/2006' term='http://schemas.google.com/spreadsheets/2006#worksheet'/>
 *     <title type='text'>Sheet1</title>
 *     <content type='text'>Sheet1</content>
 *     <link rel='http://schemas.google.com/spreadsheets/2006#listfeed' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/list/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values'/>
 *     <link rel='http://schemas.google.com/spreadsheets/2006#cellsfeed' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values'/>
 *     <link rel='http://schemas.google.com/visualization/2008#visualizationApi' type='application/atom+xml' href='https://docs.google.com/a/financialforce.com/spreadsheets/d/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/gviz/tq?gid=0'/>
 *     <link rel='http://schemas.google.com/spreadsheets/2006#exportcsv' type='text/csv' href='https://docs.google.com/a/financialforce.com/spreadsheets/d/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/export?gid=0&amp;format=csv'/>
 *     <link rel='self' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6'/>
 *     <link rel='edit' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6/-u3c64m'/>
 *     <gs:colCount>26</gs:colCount>
 *     <gs:rowCount>1000</gs:rowCount>
 * </entry>
 */
public with sharing class ffhttp_GoogleSheetsModelWorksheet extends ffhttp_GoogleSheetsModelAbstractObject
{
	//Instance Variables
	private Integer m_rowCount;
	private Integer m_colCount;
	
	/**
	 * ffhttp_GoogleSheetsModelAbstractObject implementation
	 */
	public override void readXml(Dom.XmlNode node)
	{
		super.readXml(node);
		
		m_colCount = Integer.valueOf(node.getChildElement(XML_ELEMENT_CELL_COL_COUNT, ffhttp_GoogleSheetsModelAbstractObject.XML_NAMESPACE_VALUE_GOOGLE_SHEETS).getText());
		m_rowCount = Integer.valueOf(node.getChildElement(XML_ELEMENT_CELL_ROW_COUNT, ffhttp_GoogleSheetsModelAbstractObject.XML_NAMESPACE_VALUE_GOOGLE_SHEETS).getText());
	}
	public override Dom.XmlNode writeXml(Dom.XmlNode node)
	{
		super.writeXml(node);
		
		node.setAttribute(XML_NAMESPACE_FULL_GOOGLE_SHEETS, ffhttp_GoogleSheetsModelAbstractObject.XML_NAMESPACE_VALUE_GOOGLE_SHEETS);
		node.addChildElement(XML_ELEMENT_GS_CELL_COL_COUNT, null, null).addTextNode(String.valueOf(m_colCount));
		node.addChildElement(XML_ELEMENT_GS_CELL_ROW_COUNT, null, null).addTextNode(String.valueOf(m_rowCount));
	
		return node;
	}
	
	/**
	 * Get/Sets
	 */
	public Integer getRowCount() 
	{
		return m_rowCount;
	}
	public ffhttp_GoogleSheetsModelWorksheet setRowCount(Integer rowCount) 
	{
		m_rowCount = rowCount;
		return this;
	}
	public Integer getColCount() 
	{
		return m_colCount;
	}
	public ffhttp_GoogleSheetsModelWorksheet setColCount(Integer colCount) 
	{
		m_colCount = colCount;
		return this;
	} 
}

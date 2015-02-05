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
 * ffhttp_GoogleSheetsModelBatch
 *
 * Wrapper for cell batch requests. Allows multiple cells to be queried and/or updated simultaneously.
 */
public with sharing class ffhttp_GoogleSheetsModelBatch extends ffhttp_GoogleSheetsModelAbstractObject
{	
	//Statics
	//Batch operations
	public static final String BATCH_OPERATION_QUERY = 'query';
	public static final String BATCH_OPERATION_UPDATE = 'update';
	
	//Status Codes
	public static final String STATUS_CODE_SUCCESS = '200';
	
	//Instance variables
	private Map<String, List<ffhttp_GoogleSheetsModelCell>> m_hmOperationToCellList;
	
	private Map<String, List<ffhttp_GoogleSheetsModelCell>> m_hmErrorToCellList;
	
	/**
	 * Constructor
	 */
	public ffhttp_GoogleSheetsModelBatch()
	{
		m_hmOperationToCellList = new Map<String, List<ffhttp_GoogleSheetsModelCell>>();
		m_hmErrorToCellList = new Map<String, List<ffhttp_GoogleSheetsModelCell>>();
	}
	
	/**
	 * Helper methods
	 */
	public void addCell(String operation, ffhttp_GoogleSheetsModelCell cell)
	{
		List<ffhttp_GoogleSheetsModelCell> cells = getCellsForOperation(operation);
		if (cells == null)
		{
			cells = new List<ffhttp_GoogleSheetsModelCell>();
			m_hmOperationToCellList.put(operation, cells);
		}
		cells.add(cell);
	}
	public List<ffhttp_GoogleSheetsModelCell> getCellsForOperation(String operation)
	{
		return (List<ffhttp_GoogleSheetsModelCell>)m_hmOperationToCellList.get(operation);
	}
	
	public void addError(String error, ffhttp_GoogleSheetsModelCell cell)
	{
		List<ffhttp_GoogleSheetsModelCell> cells = getCellsForError(error);
		if (cells == null)
		{
			cells = new List<ffhttp_GoogleSheetsModelCell>();
			m_hmErrorToCellList.put(error, cells);
		}
		cells.add(cell);
	}
	public List<ffhttp_GoogleSheetsModelCell> getCellsForError(String error)
	{
		return (List<ffhttp_GoogleSheetsModelCell>)m_hmErrorToCellList.get(error);
	}
	
	public boolean hasError()
	{
		return !m_hmErrorToCellList.isEmpty();
	}
	
	/**
	 * ffhttp_GoogleSheetsModelAbstractObject implementation
	 */
	public override String getRootElementName()
	{
		return XML_ELEMENT_FEED;
	}
	
	public override void readXml(Dom.XmlNode node)
	{
		super.readXml(node);
		
		Dom.XmlNode[] nodeChildren = node.getChildren();
		for (Dom.XmlNode childNode : nodeChildren)
		{
			String name = childNode.getName();
			if (!name.equals(XML_ELEMENT_ENTRY))
			{
				continue;
			}
			
			ffhttp_GoogleSheetsModelCell entry = new ffhttp_GoogleSheetsModelCell();
			entry.readXml(childNode);
			
			Dom.XmlNode operationNode = childNode.getChildElement(XML_ELEMENT_OPERATION, XML_NAMESPACE_VALUE_BATCH);
			String operation = operationNode.getAttribute(XML_ELEMENT_TYPE, null);
			
			//Parse the status as well keeping track of the cells for which we had an error.
			Dom.XmlNode statusNode = childNode.getChildElement(XML_ELEMENT_STATUS, XML_NAMESPACE_VALUE_BATCH);
			if (statusNode != null)
			{
				String code = statusNode.getAttribute(XML_ELEMENT_CODE, null);
				if (!STATUS_CODE_SUCCESS.equals(code))
				{
					String reason = statusNode.getAttribute(XML_ELEMENT_REASON, null);
					addError(reason, entry);
				}
				else
				{
					addCell(operation, entry);
				}
			}	
			else
			{
				addCell(operation, entry);
			}
		}
	}
	public override Dom.XmlNode writeXml(Dom.XmlNode node)
	{
		super.writeXml(node);
		
		//Add the relevant namespaces
		node.setAttribute(XML_NAMESPACE_FULL_BATCH, XML_NAMESPACE_VALUE_BATCH);
		node.setAttribute(XML_NAMESPACE_FULL_GOOGLE_SHEETS, XML_NAMESPACE_VALUE_GOOGLE_SHEETS);
		
		//Add the cell information with the relevant operation type.
		Set<String> operations = m_hmOperationToCellList.keySet();
		for (String operation : operations)
		{
			Integer i = 1;
			List<ffhttp_GoogleSheetsModelCell> cells = (List<ffhttp_GoogleSheetsModelCell>)m_hmOperationToCellList.get(operation);
			for (ffhttp_GoogleSheetsModelCell cell : cells)
			{
				Dom.XmlNode cellNode = node.addChildElement(XML_ELEMENT_ENTRY, node.getNamespace(), null);
				
				//Add the batch information
				cellNode.addChildElement(XML_ELEMENT_BATCH_ID, null, null).addTextNode(operation + i);
				cellNode.addChildElement(XML_ELEMENT_BATCH_OPERATION, null, null).setAttribute(XML_ELEMENT_TYPE, operation);
				
				//Now write the xml for the cell
				cell.writeXml(cellNode);
				
				i++;
			}
		}
	
		return node;
	}
	
	/**
	 * Gets/Sets
	 */
	public Map<String, List<ffhttp_GoogleSheetsModelCell>> getOperationToCellList()
	{
		return m_hmOperationToCellList;
	}
	public  Map<String, List<ffhttp_GoogleSheetsModelCell>> getErrorToCellList()
	{
		return m_hmErrorToCellList;
	}
}

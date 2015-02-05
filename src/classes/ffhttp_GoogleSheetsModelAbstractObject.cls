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
 * ffhttp_GoogleSheetsModelAbstractObject
 *
 * Base Google Sheet object returned via the Google Sheet Response.
 * All other Google Sheet objects extend this class.
 */
public abstract with sharing class ffhttp_GoogleSheetsModelAbstractObject implements ffhttp_IHttpContent,
																					 ffhttp_IDeserialize,
																	   				 ffhttp_IXmlSerializable
{
	//Statics
	//Content type
	public static final String HTTP_CONTENT_TYPE_ATOM_XML = 'application/atom+xml';
	
	//Namespace Values
	public static final String XML_NAMESPACE_VALUE_DEFAULT = 'http://www.w3.org/2005/Atom';
	public static final String XML_NAMESPACE_VALUE_BATCH = 'http://schemas.google.com/gdata/batch';
	public static final String XML_NAMESPACE_VALUE_OPEN_SEARCH = 'http://a9.com/-/spec/opensearchrss/1.0/';
	public static final String XML_NAMESPACE_VALUE_GOOGLE_SHEETS = 'http://schemas.google.com/spreadsheets/2006';
	
	//Feeds
	public static final String FEED_WORKSHEET = 'http://schemas.google.com/spreadsheets/2006#worksheetsfeed';
	public static final String FEED_LIST = 'http://schemas.google.com/spreadsheets/2006#listfeed';
	public static final String FEED_CELLS = 'http://schemas.google.com/spreadsheets/2006#cellsfeed';
	
	//Visualization api
	public static final String VISUALIZATION_API = 'http://schemas.google.com/visualization/2008#visualizationApi';
	
	//Export url
	public static final String EXPORT_CSV = 'http://schemas.google.com/spreadsheets/2006#exportcsv';
	
	//Separators
	public static final String SEPARTOR_NAMESPACE = ':';
	public static final String SEPARATOR_URL = '/';
	
	//XML namespace tag names
	public static final String XML_NAMESPACE = 'xmlns';
	
	public static final String XML_NAMESPACE_BATCH = 'batch';
	public static final String XML_NAMESPACE_GOOGLE_SHEETS = 'gs';
	public static final String XML_NAMESPACE_OPEN_SEARCH = 'openSearch';
	
	public static final String XML_NAMESPACE_FULL_BATCH = XML_NAMESPACE + SEPARTOR_NAMESPACE + XML_NAMESPACE_BATCH;
	public static final String XML_NAMESPACE_FULL_GOOGLE_SHEETS = XML_NAMESPACE + SEPARTOR_NAMESPACE + XML_NAMESPACE_GOOGLE_SHEETS;
	public static final String XML_NAMESPACE_FULL_OPEN_SEARCH = XML_NAMESPACE + SEPARTOR_NAMESPACE + XML_NAMESPACE_OPEN_SEARCH;
	
	//XML tag names
	public static final String XML_ELEMENT_AUTHOR = 'author';
	public static final String XML_ELEMENT_CATEGORY = 'category';
	public static final String XML_ELEMENT_CELL = 'cell';
	public static final String XML_ELEMENT_CELL_COL = 'col';
	public static final String XML_ELEMENT_CELL_COL_COUNT = 'colCount';
	public static final String XML_ELEMENT_CELL_INPUT_VALUE = 'inputValue';
	public static final String XML_ELEMENT_CELL_NUMERIC_VALUE = 'numericValue';
	public static final String XML_ELEMENT_CELL_ROW = 'row';
	public static final String XML_ELEMENT_CELL_ROW_COUNT = 'rowCount';
	public static final String XML_ELEMENT_CODE = 'code';
	public static final String XML_ELEMENT_CONTENT = 'content';
	public static final String XML_ELEMENT_ENTRY = 'entry';
	public static final String XML_ELEMENT_FEED = 'feed';
	public static final String XML_ELEMENT_ID = 'id';
	public static final String XML_ELEMENT_LINK = 'link';
	public static final String XML_ELEMENT_OPERATION = 'operation';
	public static final String XML_ELEMENT_REASON = 'reason';
	public static final String XML_ELEMENT_SCHEME = 'scheme';
	public static final String XML_ELEMENT_START_INDEX = 'startIndex';
	public static final String XML_ELEMENT_STATUS = 'status';
	public static final String XML_ELEMENT_TERM = 'term';
	public static final String XML_ELEMENT_TITLE = 'title';
	public static final String XML_ELEMENT_TOTAL_RESULTS = 'totalResults';
	public static final String XML_ELEMENT_TYPE = 'type';
	public static final String XML_ELEMENT_UPDATED = 'updated';
	
	public static final String XML_ELEMENT_BATCH_ID = XML_NAMESPACE_BATCH + SEPARTOR_NAMESPACE + XML_ELEMENT_ID;
	public static final String XML_ELEMENT_BATCH_OPERATION = XML_NAMESPACE_BATCH + SEPARTOR_NAMESPACE + XML_ELEMENT_OPERATION;
	public static final String XML_ELEMENT_GS_CELL_ROW_COUNT = XML_NAMESPACE_GOOGLE_SHEETS + SEPARTOR_NAMESPACE + XML_ELEMENT_CELL_ROW_COUNT;
	public static final String XML_ELEMENT_GS_CELL_COL_COUNT = XML_NAMESPACE_GOOGLE_SHEETS + SEPARTOR_NAMESPACE + XML_ELEMENT_CELL_COL_COUNT;
	public static final String XML_ELEMENT_OPEN_SEARCH_TOTAL_RESULTS = XML_NAMESPACE_OPEN_SEARCH + SEPARTOR_NAMESPACE + XML_ELEMENT_TOTAL_RESULTS;
	public static final String XML_ELEMENT_OPEN_SEARCH_START_INDEX = XML_NAMESPACE_OPEN_SEARCH + SEPARTOR_NAMESPACE + XML_ELEMENT_START_INDEX;
	
	//URL Link types
	public static final String URL_LINK_TYPE_EDIT = 'edit';
	public static final String URL_LINK_TYPE_SELF = 'self';
	
	//Instance variables
	private String m_id;
	private String m_updated;
	private String m_title;
	private String m_content;
	private String m_scheme;
	private String m_term;
	private ffhttp_GoogleSheetsModelAuthor m_author;
	private String m_version;
	
	private Map<String, ffhttp_GoogleSheetsModelUrlLink> m_hmRelToUrlLinks = new Map<String, ffhttp_GoogleSheetsModelUrlLink>();
	
	/**
	 * Helper methods
	 */
	public String getShortId()
	{
		if (String.isEmpty(m_id))
		{
			return m_id;
		}
		
		List<String> idParts = m_id.split(SEPARATOR_URL, 0);
		return idParts[idParts.size() - 1];
	}
	public String findVersion()
	{
		if (m_version != null)
		{
			return m_version;
		}
		
		ffhttp_GoogleSheetsModelUrlLink urlLink = getUrlLinkForRel(URL_LINK_TYPE_EDIT);
		if (urlLink == null)
		{	
			return null;
		}
		
		List<String> urlParts = urlLink.getHRef().split(SEPARATOR_URL, 0);
		m_version = urlParts[urlParts.size() - 1];
		return m_version;
	}
	
	public ffhttp_GoogleSheetsModelUrlLink getUrlLinkForRel(String rel)
	{
		return (ffhttp_GoogleSheetsModelUrlLink)m_hmRelToUrlLinks.get(rel);
	}
	
	public ffhttp_GoogleSheetsModelAbstractObject addUrlLink(String rel, String type, String href)
    {
    	ffhttp_GoogleSheetsModelUrlLink urlLink = new ffhttp_GoogleSheetsModelUrlLink();
    	urlLink.setRel(rel);
    	urlLink.setType(type);
    	urlLink.setHRef(href);
    	return addUrlLink(urlLink);
    }
	public ffhttp_GoogleSheetsModelAbstractObject addUrlLink(ffhttp_GoogleSheetsModelUrlLink urlLink)
	{
		m_hmRelToUrlLinks.put(urlLink.getRel(), urlLink);
		return this;
	}
	public ffhttp_GoogleSheetsModelAbstractObject removeUrlLink(String rel)
	{
		m_hmRelToUrlLinks.remove(rel);
		return this;
	}
	
	public virtual String getRootElementName()
	{
		return XML_ELEMENT_ENTRY;
	}
	
	/**
	 * ffhttp_IXmlSerializable implementation
	 */
	public virtual void readXml(Dom.XmlNode root)
	{
		Dom.XmlNode[] rootChildren = root.getChildren();
		
		for (Dom.XmlNode node : rootChildren)
		{
			String name = node.getName();
			if (name == null)
			{
				throw new ffhttp_XmlParseException('Null name for node');
			}
			
			String namespace = node.getNamespace();
			
			if (root.getNamespace() != null && !root.getNamespace().equals(namespace))
			{
				continue;
			}
			
			if (name.equals(XML_ELEMENT_ID))
			{
				m_id = node.getText();	
			}
			else if (name.equals(XML_ELEMENT_UPDATED))
			{
				m_updated = node.getText();
			}
			else if (name.equals(XML_ELEMENT_CATEGORY))
			{
				m_scheme = node.getAttributeValue(XML_ELEMENT_SCHEME, null);
				m_term = node.getAttributeValue(XML_ELEMENT_TERM, null);
			}
			else if (name.equals(XML_ELEMENT_TITLE))
			{
				m_title = node.getText();
			}
			else if (name.equals(XML_ELEMENT_CONTENT))
			{
				m_content = node.getText();
			}
			else if (name.equals(XML_ELEMENT_LINK))
			{
				ffhttp_GoogleSheetsModelUrlLink urlLink = new ffhttp_GoogleSheetsModelUrlLink();
				urlLink.readXml(node);
				addUrlLink(urlLink);
			}
			else if (name.equals(XML_ELEMENT_AUTHOR))
			{
				m_author = new ffhttp_GoogleSheetsModelAuthor();
				m_author.readXml(node);
			}
		}
	}
	
	public virtual Dom.XmlNode writeXml(Dom.XmlNode node)
	{
		if (!String.isEmpty(m_id))
		{
			node.addChildElement(XML_ELEMENT_ID, node.getNameSpace(), null).addTextNode(m_id);
		}
		
		if (!String.isEmpty(m_updated))
		{
			node.addChildElement(XML_ELEMENT_UPDATED, node.getNamespace(), null).addTextNode(m_updated);
		}
		
		if (!String.isEmpty(m_scheme) || !String.isEmpty(m_term))
		{
			Dom.XmlNode categoryNode = node.addChildElement(XML_ELEMENT_CATEGORY, node.getNamespace(), null);
			categoryNode.setAttribute(XML_ELEMENT_SCHEME, m_scheme);
			categoryNode.setAttribute(XML_ELEMENT_TERM, m_term);
		}
		
		if (!String.isEmpty(m_title))
		{
			Dom.XmlNode titleNode = node.addChildElement(XML_ELEMENT_TITLE, node.getNamespace(), null);
			titleNode.addTextNode(m_title);
			titleNode.setAttribute(XML_ELEMENT_TYPE, 'text');
		}
		
		if (!String.isEmpty(m_content))
		{
			Dom.XmlNode contentNode = node.addChildElement(XML_ELEMENT_CONTENT, node.getNamespace(), null);
			contentNode.addTextNode(m_content);
			contentNode.setAttribute(XML_ELEMENT_TYPE, 'text');
		}
		
		Set<String> keys = m_hmRelToUrlLinks.keySet();
		for (String key : keys) 
		{
			ffhttp_GoogleSheetsModelUrlLink link = (ffhttp_GoogleSheetsModelUrlLink)m_hmRelToUrlLinks.get(key);
			Dom.XmlNode urlLinkNode = node.addChildElement(XML_ELEMENT_LINK, node.getNamespace(), null);
			link.writeXml(urlLinkNode);
		}
		
		if (m_author != null)
		{
			Dom.XmlNode authorNode = node.addChildElement(XML_ELEMENT_AUTHOR, node.getNamespace(), null);
			m_author.writeXml(authorNode);
		}
		
		return node;
	}
	
	/**
	 * ffhttp_IDeserialize implementation
	 */
	public Object deserialize(String xmlStr)
	{
		Dom.Document doc = new Dom.Document();
		doc.load(xmlStr);
		
		Dom.XmlNode root = doc.getRootElement();
		readXml(root);
		
		return this;
	}
	
	/**
	 * ffhttp_IHttpContent implementation
	 */
	public String getHttpContentType()
	{
		return HTTP_CONTENT_TYPE_ATOM_XML;
	}
	
	public Object getHttpContent()
	{
		Dom.Document document = new Dom.Document();
		
		Dom.XmlNode root = document.createRootElement(getRootElementName(), null, null);
		root.setAttribute(XML_NAMESPACE, XML_NAMESPACE_VALUE_DEFAULT);
		
		writeXml(root);
		
		return document.toXmlString();
	}
	
	/**
	 * Get/Sets
	 */
	public String getId()
	{
		return m_id;
	}
	public ffhttp_GoogleSheetsModelAbstractObject setId(String id)
	{
		m_id = id;
		return this;
	}
	public String getUpdated()
	{
		return m_updated;
	}
	public ffhttp_GoogleSheetsModelAbstractObject setUpdated(String updated)
	{
		m_updated = updated;
		return this;
	}
	public String getTitle()
	{
		return m_title;
	}
	public ffhttp_GoogleSheetsModelAbstractObject setTitle(String title)
	{
		m_title = title;
		return this;
	}
	public String getContent()
	{
		return m_content;
	}
	public ffhttp_GoogleSheetsModelAbstractObject setContent(String content)
	{
		m_content = content;
		return this;
	}
	public String getScheme()
	{
		return m_scheme;
	}
	public ffhttp_GoogleSheetsModelAbstractObject setScheme(String scheme)
	{
		m_scheme = scheme;
		return this;
	}
	public String getTerm()
	{
		return m_term;
	}
	public ffhttp_GoogleSheetsModelAbstractObject setTerm(String term)
	{
		m_term = term;
		return this;
	}
	public ffhttp_GoogleSheetsModelAuthor getAuthor()
	{
		return m_author;
	}
	public ffhttp_GoogleSheetsModelAbstractObject setAuthor(ffhttp_GoogleSheetsModelAuthor author)
	{
		m_author = author;
		return this;
	}
	public String getVersion()
	{
		return m_version;
	}
	public ffhttp_GoogleSheetsModelAbstractObject setVersion(String version)
	{
		m_version = version;
		return this;
	}
	
	/**
	 * ffhttp_GoogleSheetsModelAbstractObject.SheetsList
	 */
	public class SheetsList extends ffhttp_GoogleSheetsModelAbstractObject
	{	
		private Integer m_totalResults;
		private Integer m_startIndex;
		
		private System.Type m_listEntryApexType;
		
		private List<ffhttp_IXmlSerializable> m_items;
		
		public SheetsList(System.Type listEntryApexType)
		{
			m_listEntryApexType = listEntryApexType;
			m_items = new List<ffhttp_IXmlSerializable>();
		}
		
		public SheetsList addItem(ffhttp_IXmlSerializable item)
		{																			
			m_items.add(item);
			return this;
		}
		
		/**
		 * ffhttp_GoogleSheetsModelAbstractObject implementation
		 */
		public override void readXml(Dom.XmlNode node)
		{
			super.readXml(node);
			
			m_totalResults = Integer.valueOf(node.getChildElement(XML_ELEMENT_TOTAL_RESULTS, XML_NAMESPACE_VALUE_OPEN_SEARCH).getText());
			m_startIndex = Integer.valueOf(node.getChildElement(XML_ELEMENT_START_INDEX, XML_NAMESPACE_VALUE_OPEN_SEARCH).getText());
			
			Dom.XmlNode[] nodeChildren = node.getChildren();
			for (Dom.XmlNode childNode : nodeChildren)
			{
				String name = childNode.getName();
				if (name.equals(XML_ELEMENT_ENTRY))
				{
					ffhttp_IXmlSerializable entry = (ffhttp_IXmlSerializable)m_listEntryApexType.newInstance();
					entry.readXml(childNode);
					addItem(entry);
				}	
			}
		}
		public override Dom.XmlNode writeXml(Dom.XmlNode node)
		{
			super.writeXml(node);
			
			setTotalResults(m_items.size());
			setStartIndex(1);
			
			node.setAttribute(XML_NAMESPACE_FULL_OPEN_SEARCH, XML_NAMESPACE_VALUE_OPEN_SEARCH);
			node.addChildElement(XML_ELEMENT_OPEN_SEARCH_TOTAL_RESULTS, null, null).addTextNode(String.valueOf(m_totalResults));
			node.addChildElement(XML_ELEMENT_OPEN_SEARCH_START_INDEX, null, null).addTextNode(String.valueOf(m_startIndex));
			
			for (ffhttp_IXmlSerializable item : m_items)
			{
				Dom.XmlNode entryNode = node.addChildElement(XML_ELEMENT_ENTRY, node.getNamespace(), null);
				item.writeXml(entryNode);
			}
			
			return node;
		}
		
		/**
		 * Get/Sets
		 */
		public Integer getTotalResults()
		{
			return m_totalResults;
		}
		public SheetsList setTotalResults(Integer totalResults)
		{
			m_totalResults = totalResults;
			return this;
		}
		public Integer getStartIndex()
		{
			return m_startIndex;
		}
		public SheetsList setStartIndex(Integer startIndex)
		{
			m_startIndex = startIndex;
			return this;
		}
		public List<ffhttp_IXmlSerializable> getItems()
		{
			return m_items;
		}
	}
}

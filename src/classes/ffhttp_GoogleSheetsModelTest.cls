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
 * ffhttp_GoogleSheetsModelTest
 *
 * Test class for the ffhttp_GoogleSheetsModel classes
 */
@isTest
private class ffhttp_GoogleSheetsModelTest 
{
	/**
	 * ffhttp_GoogleSheetsModelAuthor tests
	 */ 
	static testMethod void ffhttp_GoogleSheetsModelAuthor()
	{
		String xmlStr = '<?xml version="1.0" encoding="UTF-8"?><author><name>Joe Bloggs</name><email>joebloggs@hotmail.com</email></author>';
		
		ffhttp_GoogleSheetsModelAuthor author = createAuthor();
		assertAuthor(author);
		
		Dom.Document document = new Dom.Document();
		Dom.XmlNode root = document.createRootElement('author', null, null);
		author.writeXml(root);
		System.assertEquals(document.toXmlString(), xmlStr);
		
		document = new Dom.Document();
		document.load(xmlStr);
		
		ffhttp_GoogleSheetsModelAuthor deserializedAuthor = new ffhttp_GoogleSheetsModelAuthor();
		deserializedAuthor.readXml(document.getRootElement());
		assertAuthor(deserializedAuthor);
	}
	
	private static ffhttp_GoogleSheetsModelAuthor createAuthor()
	{
		ffhttp_GoogleSheetsModelAuthor author = new ffhttp_GoogleSheetsModelAuthor();
		return author.setName('Joe Bloggs').setEmail('joebloggs@hotmail.com');
	}
	
	private static void assertAuthor(ffhttp_GoogleSheetsModelAuthor author)
	{
		System.assertEquals(author.getName(), 'Joe Bloggs');
		System.assertEquals(author.getEmail(), 'joebloggs@hotmail.com');
	}
	
	/**
	 * ffhttp_GoogleSheetsModelBatch tests
	 */
	static testMethod void ffhttp_GoogleSheetsModelBatch()
	{
		ffhttp_GoogleSheetsModelSheet sheet = createSheet();
		ffhttp_GoogleSheetsModelWorksheet worksheet = createWorksheet();
		
		ffhttp_GoogleSheetsModelCell b1 = createBatchCell(sheet.getShortId(), worksheet.getShortId(), 1, 1, 'Test1');
		ffhttp_GoogleSheetsModelCell b2 = createBatchCell(sheet.getShortId(), worksheet.getShortId(), 1, 2, 'Test2');
		
		ffhttp_GoogleSheetsModelBatch batch = new ffhttp_GoogleSheetsModelBatch();
		batch.addCell('query', b1);
		batch.addCell('query', b2);
		
		String xmlStr = '<?xml version="1.0" encoding="UTF-8"?><feed xmlns="http://www.w3.org/2005/Atom" xmlns:batch="http://schemas.google.com/gdata/batch" xmlns:gs="http://schemas.google.com/spreadsheets/2006"><entry><batch:id>query1</batch:id><batch:operation type="query" /><id>https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/full/R1C1</id><gs:cell row="1" col="1" inputValue="Test1">Test1</gs:cell></entry><entry><batch:id>query2</batch:id><batch:operation type="query" /><id>https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/full/R1C2</id><gs:cell row="1" col="2" inputValue="Test2">Test2</gs:cell></entry></feed>';
		
		System.assertEquals(batch.getHttpContent(), xmlStr);
		
		ffhttp_GoogleSheetsModelBatch deserializedBatch = new ffhttp_GoogleSheetsModelBatch();
		deserializedBatch.deserialize(xmlStr);
		
		List<ffhttp_GoogleSheetsModelCell> cells = deserializedBatch.getCellsForOperation('query');
		System.assertEquals(cells.size(), 2);
		
		cells = deserializedBatch.getCellsForOperation('update');
		System.assertEquals(cells, null);
		
		System.assertEquals(batch.hasError(), false);
	}
	
	static testMethod void ffhttp_GoogleSheetsModelBatchUpdate()
	{
		String xmlStr = '<?xml version="1.0" encoding="UTF-8"?><atom:feed xmlns:atom="http://www.w3.org/2005/Atom" xmlns:openSearch="http://a9.com/-/spec/opensearchrss/1.0/" xmlns:batch="http://schemas.google.com/gdata/batch" xmlns:gs="http://schemas.google.com/spreadsheets/2006"><atom:id>https://spreadsheets.google.com/feeds/cells/1tHVyFo3zLd0wNnGrmRIn_1rwuixKyupgSMem89_KQdw/od6/private/full/batch/1423142370173</atom:id><atom:updated>2015-02-05T13:19:30.224Z</atom:updated><atom:category scheme="http://schemas.google.com/spreadsheets/2006" term="http://schemas.google.com/spreadsheets/2006#cell"/><atom:title type="text">Batch Feed</atom:title><atom:entry><atom:id>https://spreadsheets.google.com/feeds/cells/1tHVyFo3zLd0wNnGrmRIn_1rwuixKyupgSMem89_KQdw/od6/private/full/R1C1</atom:id><atom:updated>2015-02-05T13:11:01.701Z</atom:updated><atom:category scheme="http://schemas.google.com/spreadsheets/2006" term="http://schemas.google.com/spreadsheets/2006#cell"/><atom:title type="text">A1</atom:title><atom:content type="text">Testing4</atom:content><atom:link rel="self" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/cells/1tHVyFo3zLd0wNnGrmRIn_1rwuixKyupgSMem89_KQdw/od6/private/full/R1C1"/><atom:link rel="edit" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/cells/1tHVyFo3zLd0wNnGrmRIn_1rwuixKyupgSMem89_KQdw/od6/private/full/R1C1/hmnhvo"/><gs:cell row="1" col="1" inputValue="Testing4">Testing4</gs:cell><batch:id>update1</batch:id><batch:status code="200" reason="Success"/><batch:operation type="update"/></atom:entry></atom:feed>';

		Dom.Document document = new Dom.Document();
		document.load(xmlStr);
		
		ffhttp_GoogleSheetsModelBatch batch = new ffhttp_GoogleSheetsModelBatch();
		batch.readXml(document.getRootElement());
		
		System.assertEquals(batch.getCellsForOperation('query'), null);
		System.assertEquals(batch.getCellsForOperation('update').size(), 1);
		
		System.assertEquals(batch.getOperationToCellList().size(), 1);
		System.assertEquals(batch.getErrorToCellList().size(), 0);
		
		System.assertEquals(batch.hasError(), false);
	}
	
	static testMethod void ffhttp_GoogleSheetsModelBatchErrors()
	{
		ffhttp_GoogleSheetsModelSheet sheet = createSheet();
		ffhttp_GoogleSheetsModelWorksheet worksheet = createWorksheet();
		
		ffhttp_GoogleSheetsModelCell b1 = createBatchCell(sheet.getShortId(), worksheet.getShortId(), 1, 1, 'Test1');
		
		ffhttp_GoogleSheetsModelBatch batch = new ffhttp_GoogleSheetsModelBatch();
		batch.addError('Version conflict', b1);
		
		System.assertEquals(batch.getCellsForError('Version conflict').size(), 1);
		System.assertEquals(batch.hasError(), true);
		
		String xmlStr =  '<?xml version="1.0" encoding="UTF-8"?><atom:feed xmlns:atom="http://www.w3.org/2005/Atom" xmlns:openSearch="http://a9.com/-/spec/opensearchrss/1.0/" xmlns:batch="http://schemas.google.com/gdata/batch" xmlns:gs="http://schemas.google.com/spreadsheets/2006"><atom:id>https://spreadsheets.google.com/feeds/cells/1tHVyFo3zLd0wNnGrmRIn_1rwuixKyupgSMem89_KQdw/od6/private/full/batch/1423141867004</atom:id><atom:updated>2015-02-05T13:11:07.020Z</atom:updated><atom:category scheme="http://schemas.google.com/spreadsheets/2006" term="http://schemas.google.com/spreadsheets/2006#cell"/><atom:title type="text">Batch Feed</atom:title><atom:entry><atom:id>https://spreadsheets.google.com/feeds/cells/1tHVyFo3zLd0wNnGrmRIn_1rwuixKyupgSMem89_KQdw/od6/private/full/R1C1</atom:id><atom:updated>2015-02-05T13:11:07.020Z</atom:updated><atom:title type="text">Error</atom:title><atom:content type="text">Version conflict</atom:content><batch:id>update1</batch:id><batch:status code="409" reason="Version conflict"/><batch:operation type="update"/></atom:entry></atom:feed>';	
		
		Dom.Document document = new Dom.Document();
		document.load(xmlStr);
		
		batch = new ffhttp_GoogleSheetsModelBatch();
		batch.readXml(document.getRootElement());
		
		System.assertEquals(batch.getCellsForError('Version conflict').size(), 1);
		System.assertEquals(batch.hasError(), true);
		System.assertEquals(batch.getOperationToCellList().size(), 0);
		System.assertEquals(batch.getErrorToCellList().size(), 1);
	}
	
	private static ffhttp_GoogleSheetsModelCell createBatchCell(String sheetId, String worksheetId, Integer row, Integer col, String inputValue)
	{
		ffhttp_GoogleSheetsModelCell cell = new ffhttp_GoogleSheetsModelCell();
		cell.setRow(row)
			.setCol(col)
			.setInputValue(inputValue)
			.setValue(inputValue)
			.setId('https://spreadsheets.google.com/feeds/cells/' + sheetId + '/' + worksheetId + '/private/full/R' + row + 'C' + col);
		return cell;
	}
	
	/**
	 *ffhttp_GoogleSheetsModelCell tests
	 */
	static testMethod void ffhttp_GoogleSheetsModelCell()
	{
		String xmlStr = '<?xml version="1.0" encoding="UTF-8"?><entry xmlns="http://www.w3.org/2005/Atom" xmlns:gs="http://schemas.google.com/spreadsheets/2006" xmlns:batch="http://schemas.google.com/gdata/batch"><id>https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values/R9C9</id><updated>2014-11-26T11:01:23.629Z</updated><category scheme="http://schemas.google.com/spreadsheets/2006" term="http://schemas.google.com/spreadsheets/2006#cell" /><title type="text">I9</title><content type="text">Test Contents</content><link rel="edit" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values/R9C9/n7k6v8" /><link rel="self" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values/R9C9" /><gs:cell row="9" col="9" inputValue="=sum(R[-3]C[0]:R[-1]C[0])" numericValue="6.0">6</gs:cell></entry>';
		
		ffhttp_GoogleSheetsModelCell cell = createCell();
		assertCell(cell);
	
		System.assertEquals(cell.getHttpContent(), xmlStr);
		
		ffhttp_GoogleSheetsModelCell deserializedCell = new ffhttp_GoogleSheetsModelCell();
		deserializedCell.deserialize(xmlStr);
		assertCell(deserializedCell);
		
		//Check version
		cell = new ffhttp_GoogleSheetsModelCell();
		System.assertEquals(cell.findVersion(), null);
	}
	
	private static ffhttp_GoogleSheetsModelCell createCell()
	{
		ffhttp_GoogleSheetsModelCell cell = new ffhttp_GoogleSheetsModelCell();
		cell.setRow(9)
			.setCol(9)
			.setInputValue('=sum(R[-3]C[0]:R[-1]C[0])')
			.setNumericValue(6.0)
			.setValue('6')
			.setId('https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values/R9C9')
			.setUpdated('2014-11-26T11:01:23.629Z')
			.setTitle('I9')
			.setContent('Test Contents')
			.setScheme('http://schemas.google.com/spreadsheets/2006')
			.setTerm('http://schemas.google.com/spreadsheets/2006#cell')
			.setVersion('n7k6v8')
			.addUrlLink('edit', 'application/atom+xml', 'https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values/R9C9/n7k6v8')
			.addUrlLink('self', 'application/atom+xml', 'https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values/R9C9');
		return cell;
	}
	
	private static void assertCell(ffhttp_GoogleSheetsModelCell cell)
	{
		System.assertEquals(cell.getRow(), 9);
		System.assertEquals(cell.getCol(), 9);
		System.assertEquals(cell.getInputValue(), '=sum(R[-3]C[0]:R[-1]C[0])');
		System.assertEquals(cell.getNumericValue(), 6.0);
		System.assertEquals(cell.getValue(), '6');
		System.assertEquals(cell.getId(), 'https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values/R9C9');
		System.assertEquals(cell.getUpdated(), '2014-11-26T11:01:23.629Z');
		System.assertEquals(cell.getTitle(), 'I9');
		System.assertEquals(cell.getContent(), 'Test Contents');
		System.assertEquals(cell.getScheme(), 'http://schemas.google.com/spreadsheets/2006');
		System.assertEquals(cell.getTerm(), 'http://schemas.google.com/spreadsheets/2006#cell');
		System.assertEquals(cell.findVersion(), 'n7k6v8');
	}
	 
	/**
	 * ffhttp_GoogleSheetsModelSheet tests
	 */
	static testMethod void ffhttp_GoogleSheetsModelSheet()
	{
		String xmlStr = '<?xml version="1.0" encoding="UTF-8"?><entry xmlns="http://www.w3.org/2005/Atom"><id>https://spreadsheets.google.com/feeds/spreadsheets/private/full/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0</id><updated>2014-11-25T16:03:39.694Z</updated><category scheme="http://schemas.google.com/spreadsheets/2006" term="http://schemas.google.com/spreadsheets/2006#spreadsheet" /><title type="text">Test</title><content type="text">Test</content><link rel="http://schemas.google.com/spreadsheets/2006#worksheetsfeed" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full" /><link rel="alternate" type="text/html" href="https://docs.google.com/a/financialforce.com/spreadsheets/d/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/edit" /><link rel="self" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/spreadsheets/private/full/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0" /><author><name>Joe Bloggs</name><email>joebloggs@hotmail.com</email></author></entry>';
		
		ffhttp_GoogleSheetsModelSheet sheet = createSheet();
		assertSheet(sheet);
		
		System.assertEquals(sheet.getHttpContent(), xmlStr);
		
		ffhttp_GoogleSheetsModelSheet deserializedSheet = new ffhttp_GoogleSheetsModelSheet();
		deserializedSheet.deserialize(xmlStr);
		assertSheet(deserializedSheet);
		
		sheet.removeUrlLink('edit');
		System.assertEquals(sheet.getUrlLinkForRel('edit'), null);
	}
	
	private static ffhttp_GoogleSheetsModelSheet createSheet()
	{
		ffhttp_GoogleSheetsModelSheet sheet = new ffhttp_GoogleSheetsModelSheet();
		sheet.setId('https://spreadsheets.google.com/feeds/spreadsheets/private/full/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0')
			 .setUpdated('2014-11-25T16:03:39.694Z')
			 .setTitle('Test')
			 .setContent('Test')
			 .setScheme('http://schemas.google.com/spreadsheets/2006')
			 .setTerm('http://schemas.google.com/spreadsheets/2006#spreadsheet')
			 .addUrlLink('http://schemas.google.com/spreadsheets/2006#worksheetsfeed', 'application/atom+xml', 'https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full')
			 .addUrlLink('alternate', 'text/html', 'https://docs.google.com/a/financialforce.com/spreadsheets/d/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/edit')
			 .addUrlLink('self', 'application/atom+xml', 'https://spreadsheets.google.com/feeds/spreadsheets/private/full/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0')
			 .setAuthor(createAuthor());
		return sheet;
	} 
	
	private static void assertSheet(ffhttp_GoogleSheetsModelSheet sheet)
	{
		System.assertEquals(sheet.getId(), 'https://spreadsheets.google.com/feeds/spreadsheets/private/full/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0');
		System.assertEquals(sheet.getUpdated(), '2014-11-25T16:03:39.694Z');
		System.assertEquals(sheet.getTitle(), 'Test');
		System.assertEquals(sheet.getContent(), 'Test');
		System.assertEquals(sheet.getScheme(), 'http://schemas.google.com/spreadsheets/2006');
		System.assertEquals(sheet.getTerm(), 'http://schemas.google.com/spreadsheets/2006#spreadsheet');
		System.assertEquals(sheet.getVersion(), null);
		
		assertAuthor(sheet.getAuthor());
	}
	  
	/**
	 * ffhttp_GoogleSheetsModelUrlLink tests
	 */ 
	static testMethod void ffhttp_GoogleSheetsModelUrlLink()
	{ 
		String xmlStr = '<?xml version="1.0" encoding="UTF-8"?><link rel="edit" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/cells/key/worksheetId/private/full/R2C4/version" />';
		
		ffhttp_GoogleSheetsModelUrlLink urlLink = createUrlLink();
		assertUrlLink(urlLink);
		
		Dom.Document document = new Dom.Document();
		Dom.XmlNode root = document.createRootElement('link', null, null);
		urlLink.writeXml(root);
		System.assertEquals(document.toXmlString(), xmlStr);
		
		document = new Dom.Document();
		document.load(xmlStr);
		
		ffhttp_GoogleSheetsModelUrlLink deserializedUrlLink = new ffhttp_GoogleSheetsModelUrlLink();
		deserializedUrlLink.readXml(document.getRootElement());
		assertUrlLink(deserializedUrlLink);
	}
	
	private static ffhttp_GoogleSheetsModelUrlLink createUrlLink()
	{
		ffhttp_GoogleSheetsModelUrlLink urlLink = new ffhttp_GoogleSheetsModelUrlLink();
		urlLink.setRel('edit')
			   .setType('application/atom+xml')
			   .setHRef('https://spreadsheets.google.com/feeds/cells/key/worksheetId/private/full/R2C4/version');
		return urlLink;
	}
	
	private static void assertUrlLink(ffhttp_GoogleSheetsModelUrlLink urlLink)
	{
		System.assertEquals(urlLink.getRel(), 'edit');
		System.assertEquals(urlLink.getType(), 'application/atom+xml');
		System.assertEquals(urlLink.getHRef(), 'https://spreadsheets.google.com/feeds/cells/key/worksheetId/private/full/R2C4/version');
	}
	
	/**
	 * ffhttp_GoogleSheetsModelWorksheet tests
	 */ 
	static testMethod void ffhttp_GoogleSheetsModelWorksheet()
	{
		String xmlStr = '<?xml version="1.0" encoding="UTF-8"?><entry xmlns="http://www.w3.org/2005/Atom" xmlns:gs="http://schemas.google.com/spreadsheets/2006"><id>https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6</id><updated>2014-11-25T16:03:39.659Z</updated><category scheme="http://schemas.google.com/spreadsheets/2006" term="http://schemas.google.com/spreadsheets/2006#worksheet" /><title type="text">Sheet1</title><content type="text">Sheet1</content><link rel="http://schemas.google.com/spreadsheets/2006#listfeed" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/list/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values" /><link rel="http://schemas.google.com/spreadsheets/2006#cellsfeed" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values" /><link rel="http://schemas.google.com/visualization/2008#visualizationApi" type="application/atom+xml" href="https://docs.google.com/a/financialforce.com/spreadsheets/d/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/gviz/tq?gid=0" /><link rel="http://schemas.google.com/spreadsheets/2006#exportcsv" type="text/csv" href="https://docs.google.com/a/financialforce.com/spreadsheets/d/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/export?gid=0&amp;amp;format=csv" /><link rel="self" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6" /><link rel="edit" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6/-u3c64m" /><gs:colCount>26</gs:colCount><gs:rowCount>1000</gs:rowCount></entry>';
		
		ffhttp_GoogleSheetsModelWorksheet worksheet = createWorksheet();
		assertWorksheet(worksheet);
		
		System.assertEquals(worksheet.getHttpContent(), xmlStr);
		
		ffhttp_GoogleSheetsModelWorksheet deserializedWorkheet = new ffhttp_GoogleSheetsModelWorksheet();
		deserializedWorkheet.deserialize(xmlStr);
		assertWorksheet(deserializedWorkheet);
	}
	
	private static ffhttp_GoogleSheetsModelWorksheet createWorksheet()
	{
		ffhttp_GoogleSheetsModelWorksheet worksheet = new ffhttp_GoogleSheetsModelWorksheet();
		worksheet.setColCount(26)
				 .setRowCount(1000)
			 	 .setId('https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6')
			 	 .setUpdated('2014-11-25T16:03:39.659Z')
			 	 .setTitle('Sheet1')
			 	 .setContent('Sheet1')
			 	 .setScheme('http://schemas.google.com/spreadsheets/2006')
			 	 .setTerm('http://schemas.google.com/spreadsheets/2006#worksheet')
			 	 .addUrlLink('http://schemas.google.com/spreadsheets/2006#listfeed', 'application/atom+xml', 'https://spreadsheets.google.com/feeds/list/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values')
   			 	 .addUrlLink('http://schemas.google.com/spreadsheets/2006#cellsfeed', 'application/atom+xml', 'https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values')
   		 	 	 .addUrlLink('http://schemas.google.com/visualization/2008#visualizationApi', 'application/atom+xml', 'https://docs.google.com/a/financialforce.com/spreadsheets/d/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/gviz/tq?gid=0')
   		 	 	 .addUrlLink('http://schemas.google.com/spreadsheets/2006#exportcsv', 'text/csv', 'https://docs.google.com/a/financialforce.com/spreadsheets/d/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/export?gid=0&amp;format=csv')
   		 	 	 .addUrlLink('self', 'application/atom+xml', 'https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6')
   		 	 	 .addUrlLink('edit', 'application/atom+xml', 'https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6/-u3c64m');
		return worksheet;
	} 
	
	private static void assertWorkSheet(ffhttp_GoogleSheetsModelWorksheet worksheet)
	{
		System.assertEquals(worksheet.getId(), 'https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6');
		System.assertEquals(worksheet.getUpdated(), '2014-11-25T16:03:39.659Z');
		System.assertEquals(worksheet.getTitle(), 'Sheet1');
		System.assertEquals(worksheet.getContent(), 'Sheet1');
		System.assertEquals(worksheet.getScheme(), 'http://schemas.google.com/spreadsheets/2006');
		System.assertEquals(worksheet.getTerm(), 'http://schemas.google.com/spreadsheets/2006#worksheet');
		System.assertEquals(worksheet.getColCount(), 26);
		System.assertEquals(worksheet.getRowCount(), 1000);
	}
	
	static testMethod void ffhttp_GoogleSheetsModelWorksheet_SheetList()
	{
		String xmlStr = '<?xml version="1.0" encoding="UTF-8"?><entry xmlns="http://www.w3.org/2005/Atom" xmlns:openSearch="http://a9.com/-/spec/opensearchrss/1.0/"><id>https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full</id><author><name>Joe Bloggs</name><email>joebloggs@hotmail.com</email></author><openSearch:totalResults>1</openSearch:totalResults><openSearch:startIndex>1</openSearch:startIndex><entry xmlns:gs="http://schemas.google.com/spreadsheets/2006"><id>https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6</id><updated>2014-11-25T16:03:39.659Z</updated><category scheme="http://schemas.google.com/spreadsheets/2006" term="http://schemas.google.com/spreadsheets/2006#worksheet" /><title type="text">Sheet1</title><content type="text">Sheet1</content><link rel="http://schemas.google.com/spreadsheets/2006#listfeed" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/list/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values" /><link rel="http://schemas.google.com/spreadsheets/2006#cellsfeed" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values" /><link rel="http://schemas.google.com/visualization/2008#visualizationApi" type="application/atom+xml" href="https://docs.google.com/a/financialforce.com/spreadsheets/d/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/gviz/tq?gid=0" /><link rel="http://schemas.google.com/spreadsheets/2006#exportcsv" type="text/csv" href="https://docs.google.com/a/financialforce.com/spreadsheets/d/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/export?gid=0&amp;amp;format=csv" /><link rel="self" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6" /><link rel="edit" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6/-u3c64m" /><gs:colCount>26</gs:colCount><gs:rowCount>1000</gs:rowCount></entry></entry>';
		
		ffhttp_GoogleSheetsModelWorksheet worksheet = createWorksheet();
	
		ffhttp_GoogleSheetsModelAbstractObject.SheetsList worksheetList = new ffhttp_GoogleSheetsModelAbstractObject.SheetsList(ffhttp_GoogleSheetsModelWorksheet.class);
		worksheetList.addItem(worksheet)
					 .setId('https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full')
					 .setAuthor(createAuthor());
		
		System.assertEquals(worksheetList.getHttpContent(), xmlStr);
		
		ffhttp_GoogleSheetsModelAbstractObject.SheetsList deserializedWorksheetList = new ffhttp_GoogleSheetsModelAbstractObject.SheetsList(ffhttp_GoogleSheetsModelWorksheet.class);
		deserializedWorksheetList.deserialize(xmlStr);
		assertSheetsList(deserializedWorksheetList);	
	}
	
	private static void assertSheetsList(ffhttp_GoogleSheetsModelAbstractObject.SheetsList sheetList)
	{
		System.assertEquals(sheetList.getTotalResults(), 1);
		System.assertEquals(sheetList.getStartIndex(), 1);
		System.assertEquals(sheetList.getItems().size(), 1);
	}
}

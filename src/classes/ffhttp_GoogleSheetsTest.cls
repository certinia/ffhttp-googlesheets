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
 * ffhttp_GoogleSheetsTest
 *
 * Test class for the GoogleSheets 'package'.
 * 
 * This class currently provides test code coverage for this package. 
 * It checks that all base URLs are what Google Sheets requires.
 */
@isTest
private class ffhttp_GoogleSheetsTest 
{	
	/**
	 * ffhttp_GoogleSheetsCells tests
	 */
	static testMethod void ffhttp_GoogleSheetsCellsBatchRequest()
	{
		ffhttp_GoogleSheetsModelBatch batch = new ffhttp_GoogleSheetsModelBatch();
		
		ffhttp_GoogleSheetsCells cells = createGoogleSheetsCells();
		ffhttp_GoogleSheetsCells.BatchRequest batchRequest = cells.batchRequest(batch);
		assertRequestEndpointAndMethod(batchRequest, 'https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/full/batch', 'POST');
	}
	
	static testMethod void ffhttp_GoogleSheetsCellsGetRequest()
	{
		ffhttp_GoogleSheetsCells cells = createGoogleSheetsCells();
		ffhttp_GoogleSheetsCells.GetRequest getRequest = cells.getRequest('R1C1');
		assertRequestEndpointAndMethod(getRequest, 'https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values/R1C1', 'GET');
	}
	
	static testMethod void ffhttp_GoogleSheetsCellsListRequest()
	{
		ffhttp_GoogleSheetsCells cells = createGoogleSheetsCells();
		ffhttp_GoogleSheetsCells.ListRequest listRequest = cells.listRequest();
		assertRequestEndpointAndMethod(listRequest, 'https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/full', 'GET');
	
		System.assertEquals(listRequest.getMinCol(), 1);
		System.assertEquals(listRequest.getMaxCol(), 1);
		System.assertEquals(listRequest.getMinRow(), 1);
		System.assertEquals(listRequest.getMaxRow(), 1);
		
		listRequest.setMinCol(2).setMaxCol(5).setMinRow(4).setMaxRow(8);
		
		System.assertEquals(listRequest.getMinCol(), 2);
		System.assertEquals(listRequest.getMaxCol(), 5);
		System.assertEquals(listRequest.getMinRow(), 4);
		System.assertEquals(listRequest.getMaxRow(), 8);
	}
	
	static testMethod void ffhttp_GoogleSheetsCellsUpdateRequest()
	{
		ffhttp_GoogleSheetsModelCell cell = new ffhttp_GoogleSheetsModelCell();
		cell.setId('https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values/R1C1');
		cell.addUrlLink(createUrlLink());
		
		ffhttp_GoogleSheetsCells cells = createGoogleSheetsCells();
		ffhttp_GoogleSheetsCells.UpdateRequest updateRequest = cells.updateRequest(cell);
		assertRequestEndpointAndMethod(updateRequest, 'https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values/R1C1/pfs6h0', 'PUT');
	}
	
	private static ffhttp_GoogleSheetsCells createGoogleSheetsCells()
	{
		ffhttp_GoogleSheetsModelSheet sheet = new ffhttp_GoogleSheetsModelSheet();
		sheet.setId('https://spreadsheets.google.com/feeds/spreadsheets/private/full/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0');
		
		ffhttp_GoogleSheetsModelWorksheet worksheet = new ffhttp_GoogleSheetsModelWorksheet();
		worksheet.setId('https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6');
		
		ffhttp_GoogleSheets gs = createGoogleSheets();
		
		ffhttp_GoogleSheetsCells cells = gs.cells();
		System.assert(cells != null, 'Cells should not be null.');
		System.assertEquals(cells.getService(), gs);
		System.assertEquals(cells.getSheet(), null);
		System.assertEquals(cells.getWorksheet(), null);
		
		cells.setSheet(sheet);
		System.assertEquals(cells.getService(), gs);
		System.assertEquals(cells.getSheet(), sheet);
		System.assertEquals(cells.getWorksheet(), null);
		
		cells.setWorksheet(worksheet);
		System.assertEquals(cells.getService(), gs);
		System.assertEquals(cells.getSheet(), sheet);
		System.assertEquals(cells.getWorksheet(), worksheet);

		cells = new ffhttp_GoogleSheetsCells(gs);
		System.assert(cells != null, 'Cells should not be null.');
		System.assertEquals(cells.getService(), gs);
		System.assertEquals(cells.getSheet(), null);
		System.assertEquals(cells.getWorksheet(), null);
		
		cells = new ffhttp_GoogleSheetsCells(gs, sheet);
		System.assertEquals(cells.getService(), gs);
		System.assertEquals(cells.getSheet(), sheet);
		System.assertEquals(cells.getWorksheet(), null);
		
		cells = new ffhttp_GoogleSheetsCells(gs, sheet, worksheet);
		System.assertEquals(cells.getService(), gs);
		System.assertEquals(cells.getSheet(), sheet);
		System.assertEquals(cells.getWorksheet(), worksheet);
		
		return cells;
	}
	
	/**
	 * ffhttp_GoogleSheetsSpreadsheets tests
	 */
	static testMethod void ffhttp_GoogleSheetsSpreadsheetsGetRequest()
	{
		ffhttp_GoogleSheetsSpreadsheets spreadsheets = createGoogleSheetsSpreadsheets();
		ffhttp_GoogleSheetsSpreadsheets.GetRequest getRequest = spreadsheets.getRequest('tNXTXMh83yMWLVJfEgOWTvQ');
		assertRequestEndpointAndMethod(getRequest, 'https://spreadsheets.google.com/feeds/spreadsheets/private/full/tNXTXMh83yMWLVJfEgOWTvQ', 'GET');
	}
	
	static testMethod void ffhttp_GoogleSheetsSpreadsheetsListRequest()
	{
		ffhttp_GoogleSheetsSpreadsheets spreadsheets = createGoogleSheetsSpreadsheets();
		ffhttp_GoogleSheetsSpreadsheets.ListRequest listRequest = spreadsheets.listRequest();
		assertRequestEndpointAndMethod(listRequest, 'https://spreadsheets.google.com/feeds/spreadsheets/private/full', 'GET');
	}
	
	private static ffhttp_GoogleSheetsSpreadsheets createGoogleSheetsSpreadsheets()
	{
		ffhttp_GoogleSheets gs = createGoogleSheets();
		
		ffhttp_GoogleSheetsSpreadsheets spreadsheets = gs.spreadsheets();
		System.assert(spreadsheets != null, 'Spreadsheets should not be null.');
		System.assertEquals(spreadsheets.getService(), gs);
		
		spreadsheets = new ffhttp_GoogleSheetsSpreadsheets(gs);
		System.assert(spreadsheets != null, 'Spreadsheets should not be null.');
		System.assertEquals(spreadsheets.getService(), gs);
		
		return spreadsheets;
	}
	 
	/**
	 * ffhttp_GoogleSheetsWorksheets tests
	 */
	static testMethod void ffhttp_GoogleSheetsWorksheetsDeleteRequest()
	{
		ffhttp_GoogleSheetsWorksheets worksheets = createGoogleSheetsWorksheets();
		ffhttp_GoogleSheetsWorksheets.DeleteRequest deleteRequest = worksheets.deleteRequest('ootd3bk');
		assertRequestEndpointAndMethod(deleteRequest, 'https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full/ootd3bk', 'DELETE');
	}
	
	static testMethod void ffhttp_GoogleSheetsWorksheetsGetRequest()
	{
		ffhttp_GoogleSheetsWorksheets worksheets = createGoogleSheetsWorksheets();
		ffhttp_GoogleSheetsWorksheets.GetRequest getRequest = worksheets.getRequest('od6');
		assertRequestEndpointAndMethod(getRequest, 'https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/values/od6', 'GET');
	}
	
	static testMethod void ffhttp_GoogleSheetsWorksheetsInsertRequest()
	{
		ffhttp_GoogleSheetsModelWorksheet worksheet = new ffhttp_GoogleSheetsModelWorksheet();
		worksheet.setTitle('Expenses');
		worksheet.setRowCount(50);
		worksheet.setColCount(10);
		
		ffhttp_GoogleSheetsWorksheets worksheets = createGoogleSheetsWorksheets();
		ffhttp_GoogleSheetsWorksheets.InsertRequest insertRequest = worksheets.insertRequest(worksheet);
		assertRequestEndpointAndMethod(insertRequest, 'https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full', 'POST');
	
		String xmlStr = '<?xml version="1.0" encoding="UTF-8"?><entry xmlns="http://www.w3.org/2005/Atom" xmlns:gs="http://schemas.google.com/spreadsheets/2006"><title type="text">Expenses</title><gs:colCount>10</gs:colCount><gs:rowCount>50</gs:rowCount></entry>';
		System.assertEquals(insertRequest.buildHttpRequest().getBody(), xmlStr);
	}
	
	static testMethod void ffhttp_GoogleSheetsWorksheetsListRequest()
	{
		ffhttp_GoogleSheetsWorksheets worksheets = createGoogleSheetsWorksheets();
		ffhttp_GoogleSheetsWorksheets.ListRequest listRequest = worksheets.listRequest();
		assertRequestEndpointAndMethod(listRequest, 'https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full', 'GET');
	}
	
	static testMethod void ffhttp_GoogleSheetsWorksheetsUpdateRequest()
	{
		ffhttp_GoogleSheetsModelWorksheet worksheet = new ffhttp_GoogleSheetsModelWorksheet();
		worksheet.setId('https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full/o7dl0h0');
		worksheet.setTitle('Expenses');
		worksheet.setRowCount(20);
		worksheet.setColCount(20);
		worksheet.addUrlLink('edit', 'application/atom+xml', 'https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full/o7dl0h0/-uxsma0');
		
		ffhttp_GoogleSheetsWorksheets worksheets = createGoogleSheetsWorksheets();
		ffhttp_GoogleSheetsWorksheets.UpdateRequest updateRequest = worksheets.updateRequest(worksheet);
		assertRequestEndpointAndMethod(updateRequest, 'https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full/o7dl0h0/-uxsma0', 'PUT');
	}
	
	private static ffhttp_GoogleSheetsWorksheets createGoogleSheetsWorksheets()
	{
		ffhttp_GoogleSheetsModelSheet sheet = new ffhttp_GoogleSheetsModelSheet();
		sheet.setId('https://spreadsheets.google.com/feeds/spreadsheets/private/full/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0');
		
		ffhttp_GoogleSheets gs = createGoogleSheets();
		
		ffhttp_GoogleSheetsWorksheets worksheets = gs.worksheets();
		System.assert(worksheets != null, 'Worksheets should not be null.');
		System.assertEquals(worksheets.getService(), gs);
		System.assertEquals(worksheets.getSheet(), null);
		
		worksheets.setService(null);
		System.assertEquals(worksheets.getService(), null);
		
		worksheets.setService(gs);
		System.assertEquals(worksheets.getService(), gs);
		
		worksheets.setSheet(sheet);
		System.assertEquals(worksheets.getService(), gs);
		System.assertEquals(worksheets.getSheet(), sheet);
	
		worksheets = new ffhttp_GoogleSheetsWorksheets(gs);
		System.assert(worksheets != null, 'Worksheets should not be null.');
		System.assertEquals(worksheets.getService(), gs);
		System.assertEquals(worksheets.getSheet(), null);
		
		worksheets = new ffhttp_GoogleSheetsWorksheets(gs, sheet);
		System.assertEquals(worksheets.getService(), gs);
		System.assertEquals(worksheets.getSheet(), sheet);
		
		return worksheets;
	}
	 
	/**
	 * Helper methods
	 */
	private static ffhttp_GoogleSheets createGoogleSheets()
	{
		return new ffhttp_GoogleSheets(new ffhttp_Client.AccessTokenCredentials('Bearer', 'Dummy Access Token'));
	}

	private static void assertRequestEndpointAndMethod(ffhttp_GoogleSheetsResource.GoogleSheetRequest request, 
													   String endpoint, String method)
	{
		System.HttpRequest httpRequest = request.buildHttpRequest();
		System.assertEquals(httpRequest.getEndpoint(), endpoint);
		System.assertEquals(httpRequest.getMethod(), method);
	}
	
	private static ffhttp_GoogleSheetsModelUrlLink createUrlLink()
	{
		ffhttp_GoogleSheetsModelUrlLink urlLink = new ffhttp_GoogleSheetsModelUrlLink();
		urlLink.setRel('edit')
			   .setType('application/atom+xml')
			   .setHRef('https://spreadsheets.google.com/feeds/cells/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/od6/private/values/R1C1/pfs6h0');
		return urlLink;
	}
}

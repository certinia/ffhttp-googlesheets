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
 * ffhttp_GoogleSheetsWorksheets
 *
 * Provides access to the worksheet API callouts.
 */
public with sharing class ffhttp_GoogleSheetsWorksheets extends ffhttp_GoogleSheetsResource
{
	/**
	 * Constructor
	 *
	 * @param service The ffhttp_GoogleSheets service.
	 * @return Access to the Worksheet API calls.
	 */
	public ffhttp_GoogleSheetsWorksheets(ffhttp_GoogleSheets service) 
	{
		super(service);
	}

	 /**
	 * Constructor
	 *
	 * @param service The ffhttp_GoogleSheets service.
	 * @param sheet The spreadsheet that the worksheet is in.
	 * @return Access to the Worksheet API calls.
	 */
	public ffhttp_GoogleSheetsWorksheets(ffhttp_GoogleSheets service, ffhttp_GoogleSheetsModelSheet sheet) 
	{
		super(service, sheet);
	}

	/*********************************************************************************************************
	 * Requests
	 *********************************************************************************************************/
	
	public DeleteRequest deleteRequest(String id)
	{
		validateSheet();
		return new DeleteRequest(this, id);
	}
	
	public GetRequest getRequest(String id)
	{
		validateSheet();
		return new GetRequest(this, id);
	}
	
	public InsertRequest insertRequest(ffhttp_GoogleSheetsModelWorksheet worksheet)
	{
		validateSheet();
		return new InsertRequest(this, worksheet);	
	}
	
	public ListRequest listRequest()
	{
		validateSheet();
		return new ListRequest(this);
	}
	
	public UpdateRequest updateRequest(ffhttp_GoogleSheetsModelWorksheet worksheet)
	{
		validateSheet();
		return new UpdateRequest(this, worksheet);
	}
	
	/*********************************************************************************************************
	 * API Callout Inner Classes
	 *********************************************************************************************************/
	
	public class DeleteRequest extends GoogleSheetWorksheetRequest
	{
		DeleteRequest(ffhttp_GoogleSheetsWorksheets worksheets, String id) 	
		{
			super(worksheets, '/private/full/' + id, REQUEST_METHOD_DELETE, null, null);
		}
	}
	
	public class GetRequest extends GoogleSheetWorksheetRequest
	{
		GetRequest(ffhttp_GoogleSheetsWorksheets worksheets, String id) 
		{
			super(worksheets, '/private/values/' + id, REQUEST_METHOD_GET, null, new ffhttp_GoogleSheetsModelWorksheet());
		}
	}
	
	public class InsertRequest extends GoogleSheetWorksheetRequest
	{
		InsertRequest(ffhttp_GoogleSheetsWorksheets worksheets, ffhttp_GoogleSheetsModelWorksheet worksheet) 
		{
			super(worksheets, '/private/full', REQUEST_METHOD_POST, worksheet, new ffhttp_GoogleSheetsModelWorksheet());
		}
	}
	
	public class ListRequest extends GoogleSheetWorksheetRequest
	{
		ListRequest(ffhttp_GoogleSheetsWorksheets worksheets) 
		{
			super(worksheets, '/private/full', REQUEST_METHOD_GET, null, 
			 new ffhttp_GoogleSheetsModelAbstractObject.SheetsList(ffhttp_GoogleSheetsModelWorksheet.class));
		}
	}
	
	public class UpdateRequest extends GoogleSheetWorksheetRequest
	{
		UpdateRequest(ffhttp_GoogleSheetsWorksheets worksheets, ffhttp_GoogleSheetsModelWorksheet worksheet) 
		{
			super(worksheets, '/private/full/' + worksheet.getShortId() + '/' + worksheet.findVersion(),
				  REQUEST_METHOD_PUT, worksheet, new ffhttp_GoogleSheetsModelWorksheet());
		}
	}
}

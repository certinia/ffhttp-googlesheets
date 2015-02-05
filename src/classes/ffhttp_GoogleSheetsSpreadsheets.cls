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
 * ffhttp_GoogleSheetsSpreadsheets
 *
 * Provides access to the spreadsheet API callouts.
 */
public with sharing class ffhttp_GoogleSheetsSpreadsheets extends ffhttp_GoogleSheetsResource
{
	/**
	 * Constructor
	 *
	 * @param service The ffhttp_GoogleSheets service.
	 * @return Access to the Files API calls.
	 */
	public ffhttp_GoogleSheetsSpreadsheets(ffhttp_GoogleSheets service) 
	{
		super(service);
	}
	
	/*********************************************************************************************************
	 * Requests
	 *********************************************************************************************************/
	
	public GetRequest getRequest(String id)
	{
		return new GetRequest(this, id);
	}
	
	public ListRequest listRequest()
	{
		return new ListRequest(this);
	}
	
	/*********************************************************************************************************
	 * API Callout Inner Classes
	 *********************************************************************************************************/
	
	public class GetRequest extends GoogleSheetRequest
	{
		GetRequest(ffhttp_GoogleSheetsSpreadsheets spreadsheets, String id) 
		{
			super(spreadsheets, GOOGLE_SHEETS, 'feeds/spreadsheets/private/full/' + id, REQUEST_METHOD_GET, 
				  null, new ffhttp_GoogleSheetsModelSheet());
		}
	}
	 	
	public class ListRequest extends GoogleSheetRequest
	{
		ListRequest(ffhttp_GoogleSheetsSpreadsheets spreadsheets) 
		{
			super(spreadsheets, GOOGLE_SHEETS, 'feeds/spreadsheets/private/full', REQUEST_METHOD_GET, null, 
				  new ffhttp_GoogleSheetsModelAbstractObject.SheetsList(ffhttp_GoogleSheetsModelSheet.class));
		}
	}
}

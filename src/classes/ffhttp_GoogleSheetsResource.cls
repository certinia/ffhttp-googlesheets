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
 * ffhttp_GoogleSheetsResource
 *
 * Abstract class to provide the base functionality for all Google Sheet API calls.
 * 
 * Google provides a set of resources that are all extended by this class.
 *
 * Note that not all parameters are needed for all the extensions of this class i.e. the ffhttp_GoogleSheetsModelSheet parameter
 * is not required for the ffhttp_GoogleSheetsSpreadsheets class. However, to minimise code duplication and follow the conventions
 * implemented in the Google Drive the variables are defined here.
 */
public abstract class ffhttp_GoogleSheetsResource 
{
	//OAuth Scopes
	public static final String SCOPE_SHEETS_FEED = 'https://spreadsheets.google.com/feeds';
	
	//Endpoints 
	public static final String GOOGLE_SHEETS = 'https://spreadsheets.google.com/';
		
	public static final String ENDPOINT_FEEDS = 'feeds/';
	public static final String ENDPOINT_WORKSHEETS = 'worksheets/';
	public static final String ENDPOINT_CELLS = 'cells/';
	
	//Instance variables
	private ffhttp_GoogleSheets m_service;
	private ffhttp_GoogleSheetsModelSheet m_sheet;
	private ffhttp_GoogleSheetsModelWorksheet m_worksheet;
	
	/**
	 * Constructors
	 */
	public ffhttp_GoogleSheetsResource(ffhttp_GoogleSheets service) 
	{
		m_service = service;
	}
	
	public ffhttp_GoogleSheetsResource(ffhttp_GoogleSheets service, ffhttp_GoogleSheetsModelSheet sheet) 
	{
		m_service = service;
		m_sheet = sheet;
	}
	
	public ffhttp_GoogleSheetsResource(ffhttp_GoogleSheets service, ffhttp_GoogleSheetsModelSheet sheet,
									   ffhttp_GoogleSheetsModelWorksheet worksheet) 
	{
		m_service = service;
		m_sheet = sheet;
		m_worksheet = worksheet;
	}
	
	public void validateSheet() 
	{
		if (m_sheet == null) throw new ffhttp_SystemException(System.Label.ffhttp_gsheets_NullSheet);
		if (m_sheet.getId() == null) throw new ffhttp_SystemException(System.Label.ffhttp_gsheets_NullSheetId);
	}
	
	public void validateWorksheet() 
	{
		if (m_worksheet == null) throw new ffhttp_SystemException(System.Label.ffhttp_gsheets_NullWorksheet);
		if (m_worksheet.getId() == null) throw new ffhttp_SystemException(System.Label.ffhttp_gsheets_NullWorksheetId);
	}
	
	/**
	 * Get/Sets
	 */
	public ffhttp_GoogleSheets getService() 
	{
		return m_service;
	}
	public ffhttp_GoogleSheetsResource setService(ffhttp_GoogleSheets service) 
	{
		m_service = service;
		return this;
	}
	public ffhttp_GoogleSheetsModelSheet getSheet() 
	{
		return m_sheet;
	}
	public ffhttp_GoogleSheetsResource setSheet(ffhttp_GoogleSheetsModelSheet sheet) 
	{
		m_sheet = sheet;
		return this;
	}
	public ffhttp_GoogleSheetsModelWorksheet getWorksheet() 
	{
		return m_worksheet;
	}
	public ffhttp_GoogleSheetsResource setWorksheet(ffhttp_GoogleSheetsModelWorksheet worksheet) 
	{
		m_worksheet = worksheet;
		return this;
	}
	
	/*********************************************************************************************************
	 * Abstract inner classes
	 *********************************************************************************************************/
	
	/**
	 * GoogleSheetCellRequest
	 *
	 * Abstract class created for request that involve a cell in a worksheet.
	 */
	public abstract class GoogleSheetCellRequest extends GoogleSheetRequest
	{
		protected GoogleSheetCellRequest(ffhttp_GoogleSheetsResource resource, String subEndpoint, String method, 
										 ffhttp_IHttpContent content, ffhttp_IDeserialize responseDeserializer) 
		{
			super(resource, 
				  GOOGLE_SHEETS + ENDPOINT_FEEDS + ENDPOINT_CELLS + resource.getSheet().getShortId() 
				  + '/' + resource.getWorksheet().getShortId(),
				  subEndpoint, method, content, responseDeserializer);
		}
	}
	 
	/**
	 * GoogleSheetWorksheetRequest
	 *
	 * Abstract class created for requests that involve a worksheet.
	 */
	public abstract class GoogleSheetWorksheetRequest extends GoogleSheetRequest
	{
		protected GoogleSheetWorksheetRequest(ffhttp_GoogleSheetsResource resource, String subEndpoint, String method, 
										 	  ffhttp_IHttpContent content, ffhttp_IDeserialize responseDeserializer) 
		{
			super(resource, GOOGLE_SHEETS + ENDPOINT_FEEDS + ENDPOINT_WORKSHEETS + resource.getSheet().getShortId(),
				  subEndpoint, method, content, responseDeserializer);
		}
	}
	
	/**
	 * GoogleSheetRequest
	 * 
	 * Abtract class created for all Google Sheet requests.
	 */
	public abstract class GoogleSheetRequest extends ffhttp_Client.AbstractClientRequest
	{ 
	 	protected GoogleSheetRequest(ffhttp_GoogleSheetsResource resource, String mainEndpoint, String subEndpoint, String method, 
	 								 ffhttp_IHttpContent content, ffhttp_IDeserialize responseDeserializer) 
	 	{
			super(resource.getService(), mainEndpoint + subEndpoint, method, content, responseDeserializer);
		}
	}
}

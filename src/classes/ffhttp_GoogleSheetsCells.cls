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
 * ffhttp_GoogleSheetsCells
 * 
 * Provides access to the cell API callouts.
 */
public with sharing class ffhttp_GoogleSheetsCells extends ffhttp_GoogleSheetsResource
{
	/**
	 * Constructor
	 *
	 * @param service The ffhttp_GoogleSheets service.
	 * @return Access to the Cell API calls.
	 */
	public ffhttp_GoogleSheetsCells(ffhttp_GoogleSheets service) 
	{
		super(service);
	}
	
	/**
	 * Constructor
	 *
	 * @param service The ffhttp_GoogleSheets service.
	 * @param sheet The spreadsheet that the worksheet is in.
	 * @return Access to the Cell API calls.
	 */
	public ffhttp_GoogleSheetsCells(ffhttp_GoogleSheets service, ffhttp_GoogleSheetsModelSheet sheet) 
	{
		super(service, sheet);
	}
	
	/**
	 * Constructor
	 *
	 * @param service The ffhttp_GoogleSheets service.
	 * @param sheet The spreadsheet that the worksheet is in.
	 * @param worksheet The worksheet that the cell is in.
	 * @return Access to the Cell API calls.
	 */
	public ffhttp_GoogleSheetsCells(ffhttp_GoogleSheets service, ffhttp_GoogleSheetsModelSheet sheet,
									ffhttp_GoogleSheetsModelWorksheet worksheet) 
	{
		super(service, sheet, worksheet);
	}
	
	/*********************************************************************************************************
	 * Requests
	 *********************************************************************************************************/
	
	public BatchRequest batchRequest(ffhttp_GoogleSheetsModelBatch batch)
	{
		validateSheet();
		validateWorksheet();
		return new BatchRequest(this, batch);
	}
	
	public GetRequest getRequest(String id)
	{
		validateSheet();
		validateWorksheet();
		return new GetRequest(this, id);
	}
	
	public ListRequest listRequest()
	{
		validateSheet();
		validateWorksheet();
		return new ListRequest(this);
	}
	
	public UpdateRequest updateRequest(ffhttp_GoogleSheetsModelCell cell)
	{
		validateSheet();
		validateWorksheet();
		return new UpdateRequest(this, cell);
	}
	
	/*********************************************************************************************************
	 * API Callout Inner Classes
	 *********************************************************************************************************/
	
	public class BatchRequest extends GoogleSheetCellRequest
	{
		BatchRequest(ffhttp_GoogleSheetsCells cells, ffhttp_GoogleSheetsModelBatch batch) 
		{
			super(cells, '/private/full/batch', REQUEST_METHOD_POST, batch, 
				  new ffhttp_GoogleSheetsModelBatch());
		}
	}
	
	public class GetRequest extends GoogleSheetCellRequest
	{
		GetRequest(ffhttp_GoogleSheetsCells cells, String id) 
		{
			super(cells, '/private/values/' + id, REQUEST_METHOD_GET, null, new ffhttp_GoogleSheetsModelCell());
		}
	}
	
	public class ListRequest extends GoogleSheetCellRequest
	{
		ListRequest(ffhttp_GoogleSheetsCells cells) 
		{
			super(cells, '/private/full', REQUEST_METHOD_GET, null, 
			 new ffhttp_GoogleSheetsModelAbstractObject.SheetsList(ffhttp_GoogleSheetsModelCell.class));
		}
		
		/**
		 * Request Parameters
		 */
		public Integer getMinCol()
		{
			return getParam('min-col', 1);	
		}
		public ListRequest setMinCol(Integer minCol)
		{
			addParam('min-col', minCol);
			return this;
		}
		public Integer getMaxCol()
		{
			return getParam('max-col', 1);	
		}
		public ListRequest setMaxCol(Integer maxCol)
		{
			addParam('max-col', maxCol);
			return this;
		}
		public Integer getMinRow()
		{
			return getParam('min-row', 1);	
		}
		public ListRequest setMinRow(Integer minRow)
		{
			addParam('min-row', minRow);
			return this;
		}
		public Integer getMaxRow()
		{
			return getParam('max-row', 1);	
		}
		public ListRequest setMaxRow(Integer maxRow)
		{
			addParam('max-row', maxRow);
			return this;
		}
	}
	
	public class UpdateRequest extends GoogleSheetCellRequest
	{
		UpdateRequest(ffhttp_GoogleSheetsCells cells, ffhttp_GoogleSheetsModelCell cell)
		{
			super(cells, '/private/values/' + cell.getShortId() + '/' + cell.findVersion(), REQUEST_METHOD_PUT, cell, 
				  new ffhttp_GoogleSheetsModelCell());
		}
	}
}

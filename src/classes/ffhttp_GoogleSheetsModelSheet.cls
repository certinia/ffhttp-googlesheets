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
 * ffhttp_GoogleSheetsModelSheet
 *
 * An object that represents a Google Sheet Spreadsheet.
 *
 * Example response:
 *
 * <entry xmlns="http://www.w3.org/2005/Atom">
 *      <id>https://spreadsheets.google.com/feeds/spreadsheets/private/full/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0</id>
 *      <updated>2014-11-05T11:55:22.176Z</updated>
 *      <category scheme="http://schemas.google.com/spreadsheets/2006" term="http://schemas.google.com/spreadsheets/2006#spreadsheet"></category>
 *      <title type="text">Test</title>
 *      <content type="text">Test</content>
 *      <link rel="http://schemas.google.com/spreadsheets/2006#worksheetsfeed" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/worksheets/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/private/full"></link>
 *      <link rel="alternate" type="text/html" href="https://docs.google.com/a/financialforce.com/spreadsheets/d/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0/edit"></link>
 *      <link rel="self" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/spreadsheets/private/full/1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU0"></link>
 *      <author>
 *     		<name>Joe Blogss</name>
 *			<email>joebloggs@hotmail.com</email>
 * 		</author>
 * </entry>
 */
public with sharing class ffhttp_GoogleSheetsModelSheet extends ffhttp_GoogleSheetsModelAbstractObject
{
	/**
	 * ffhttp_GoogleSheetsModelAbstractObject implementation
	 */
	public override void readXml(Dom.XmlNode node)
	{
		super.readXml(node);
	}
	public override Dom.XmlNode writeXml(Dom.XmlNode node)
	{
		return super.writeXml(node);
	}
}

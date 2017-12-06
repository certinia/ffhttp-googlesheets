Apex Google Sheets API Framework
================================

<a href="https://githubsfdeploy.herokuapp.com?owner=financialforcedev&repo=ffhttp-googlesheets">
    <img alt="Deploy to Salesforce"
        src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

Overview
--------

An Apex framework has been created to provide functionality for Google Sheets API callouts. 

This library extends the [Core](https://github.com/financialforcedev/ffhttp-core) library to provide access to Google Sheets API calls found at https://developers.google.com/google-apps/spreadsheets/.

Samples demonstrating the use of this library can be found [here](https://github.com/financialforcedev/ffhttp-googlesheets-samples).

**NOTE:** Unlike the other Google libraries ([Google Cloud Print](https://github.com/financialforcedev/ffhttp-googlecloudprint), [Google Drive](https://github.com/financialforcedev/ffhttp-googledrive) & [Google Mirror](https://github.com/financialforcedev/ffhttp-googlemirror)), Google Sheets uses XML for requests rather than JSON.

Key Features
------------

+ Apex Google Sheets API


Sample Code
-----------

Each of the following code snippets demonstrate simple use cases for the spreadsheet API. 

Obtain a list of all spreadsheets the user has access to:

```
//Create the credentials
ffhttp_Client.Credentials credentials = new ffhttp_Client.Credentials('Bearer', 'Sample Token');
ffhttp_GoogleSheets sheets = new ffhttp_GoogleSheets(credentials);
ffhttp_GoogleSheetsSpreadsheets spreadsheets = sheets.spreadsheets();
ffhttp_GoogleSheetsModelAbstractObject.SheetsList sl = (ffhttp_GoogleSheetsModelAbstractObject.SheetsList)spreadsheets.listRequest().execute();
List<ffhttp_IXmlSerializable> spreadsheetList = (List<ffhttp_IXmlSerializable>)sl.getItems();
```

Adding a worksheet to a spreadsheet:

```
//A sample test spreadsheet
String id = '1-SAVlKIqt77GwXypGOC7ladRgE0dujMHrP6UxT4XjU4';

//Create GoogleSheets, get the relevant spreadsheet and then the worksheets resource.
ffhttp_GoogleSheets sheets = new ffhttp_GoogleSheets(credentials);
ffhttp_GoogleSheetsSpreadsheets spreadsheets = sheets.spreadsheets();
ffhttp_GoogleSheetsModelSheet sheet = (ffhttp_GoogleSheetsModelSheet)spreadsheets.getRequest(id).execute();
ffhttp_GoogleSheetsWorksheets worksheets = sheets.worksheets();
worksheets.setSheet(sheet);

//Create the worksheet with the appropriate metadata
ffhttp_GoogleSheetsModelWorksheet worksheet = new ffhttp_GoogleSheetsModelWorksheet();
worksheet.setTitle('Expenses');
worksheet.setRowCount(50);
worksheet.setColCount(10);

//Insert the worksheet
ffhttp_GoogleSheetsWorksheets.InsertRequest insertRequest = worksheets.insertRequest(worksheet);
worksheet = (ffhttp_GoogleSheetsModelWorksheet)insertRequest.execute();

```

Adding data to a worksheet:

```
//Following on from the last code snippet

//Get the cells resource
ffhttp_GoogleSheetsCells cells  = sheets.cells();
cells.setSheet(sheet);
cells.setWorksheet(worksheet);

//To edit any cells you must first query those cells:
ffhttp_GoogleSheetsModelBatch queryBatchCells = new ffhttp_GoogleSheetsModelBatch();

//Get the first 4 cells (2x2 grid)
for (Integer row = 1; row <= 2; row++)
{
    for (Integer column = 1; column <= 2; column++)
    {   
        ffhttp_GoogleSheetsModelCell cell = new ffhttp_GoogleSheetsModelCell();
        cell.setRow(row);
        cell.setCol(column);
        cell.setId('https://spreadsheets.google.com/feeds/cells/' + sheet.getShortId() + '/' + worksheet.getShortId() + '/private/full/R' + row + 'C' + column);
        queryBatchCells.addCell('query', cell);
    }
}

//Execute the request and reassign queryBatchCells so that they contains all the relevant metadata.
queryBatchCells = (ffhttp_GoogleSheetsModelBatch)cells.batchRequest(queryBatchCells).execute();

List<ffhttp_GoogleSheetsModelCell> queryCells = queryBatchCells.getCellsForOperation('query');

//Update all the cells to contain an integer
ffhttp_GoogleSheetsModelBatch updateBatchCells = new ffhttp_GoogleSheetsModelBatch();

Integer i = 0;
for (ffhttp_GoogleSheetsModelCell cell : queryCells)
{
    cell.setInputValue('' + i);
    updateBatchCells.addCell('update', cell);
    i++;
}

cells.batchRequest(updateBatchCells).execute();
```

Configuration
-------------

This section explains how to create a connection between Salesforce and Google Sheets using the packages described above.

Make sure that the [Core](https://githubsfdeploy.herokuapp.com?owner=financialforcedev&repo=ffhttp-core) and [Google Sheets](https://githubsfdeploy.herokuapp.com?owner=financialforcedev&repo=ffhttp-googlesheets) packages have been deployed to your Saleforce organisation.

### Create an app in Google

1. Log in to your Google account.
2. Go to https://console.developers.google.com/project and select **Create Project**.
3. Enter a project name and ok the dialog.
4. Select the hyperlink for the project name that you just created.
5. Select **Credentials**.
6. Select **Create new Client ID**.
7. Select **Web application**.
8. Set the **Authorized Javascript Origins** url to the URL of the Salesforce organisation e.g. https://eu3.salesforce.com.
9. Set the **Authorized Redirect URIs** to the same as above with *apex/connector* appended: e.g. https://eu3.salesforce.com/apex/connector.
10. Make sure you know the **Client Id** and **Client Secret** as they will be needed later.
11. Select the **Consent screen**.
12. Enter a **Product Name** and save.

### Create a Connector in Salesforce

This requires the [OAuth Sample App](https://githubsfdeploy.herokuapp.com?owner=financialforcedev&repo=ffhttp-core-samples) to be deployed.

1. Log in to your Salesforce organisation.
2. Select the **OAuth** app.
3. Select **Connector Types** then **New**.
4. Enter a **Connector Type Name** e.g. Google Sheets.
5. Set the **Authorization Endpoint** to https://accounts.google.com/o/oauth2/auth. 
6. Set the **Token Endpoint** to https://accounts.google.com/o/oauth2/token.
7. Set the **Client ID** to the client ID obtained earlier.
8. Set the **Client Secret** to the client secret obtained earlier.
9. Set the **Redirect URI** to the same URL as you set in step 12 in the Create an app in Google section.
10. Make sure that **Scope Required** is checked.
11. For full access to Google Sheets add https://spreadsheets.google.com/feeds https://docs.google.com/feeds as the scope.
12. Set the **Extra Url Parameters** to **access_type=offline&approval_prompt=force**. Setting **access_type** to offline means that Google supplies a refresh token with the access token which is required if you do not wish to reautheniticate every time the access token expires.
13. **Save** the Connector Type.
14. Select **New Connector**.
15. Set the **Connector Name** and save. 
16. Select the Connector and then **Activate**. You will be directed to another Salesforce page that activates your connector.
17. Select **Authorize**. This will prompt you to log in to your Google account (if you are not already logged in) and then authenticate the scope provided earlier. Select **Accept** to authorize. 
18. Select **Save**. The connector is now ready for use.

Note that authorization can be revoked at any point by either deleting the connector in Salesforce or revoking access to the app in Google (Select your profile then Account > Security > Account Permissions > Apps and website (View All), choose the app created and then select **Revoke Access**).

### Google Sheets Scopes

+ https://spreadsheets.google.com/feeds 
+ https://docs.google.com/feeds

Reporting Issues & Enhancements
-------------------------------

Please report any issues using the github [issues](https://github.com/financialforcedev/ffhttp-googlesheets/issues) feature. Suggestions / bug reports are welcome as are extensions containing additional functionality.

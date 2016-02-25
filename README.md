## OneNote Class Notebooks API PowerShell Sample README

Created by Microsoft Corporation, 2016. Provided as-is without warranty. Trademarks mentioned here are the property of their owners.

### API functionality demonstrated in this sample

The following aspects of the API are covered in this sample. 

* Obtain an access token using Azure PowerShell
* [GET all your existing class notebooks](https://msdn.microsoft.com/office/office365/howto/onenote-classnotebook#get)
* [POST a new class notebook](https://msdn.microsoft.com/office/office365/howto/onenote-classnotebook#create)
* [POST a new student to an existing class notebook](https://msdn.microsoft.com/office/office365/howto/onenote-classnotebook#add)
* [POST a new co-teacher to an existing class notebook](https://msdn.microsoft.com/office/office365/howto/onenote-classnotebook#add)
* [DELETE an existing student from an existing class notebook](https://msdn.microsoft.com/office/office365/howto/onenote-classnotebook#delete)
* [DELETE an existing co-teacher from an existing class notebook](https://msdn.microsoft.com/office/office365/howto/onenote-classnotebook#delete)

### Prerequisites

* [Azure PowerShell](https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure) - used to obtain an access token to talk to the OneNote Class Notebooks API.
* [An Office 365 account with OneDrive set up](https://portal.office.com) - the class notebook that this sample script creates will be located in your OneDrive. To ensure that your OneDrive is set up, log on to [Office 365](https://portal.office.com) and click the blue "OneDrive" icon in the app launcher. If you are taken to your OneDrive, you are all set.
* Four additional Office 365 accounts - this sample script will add students and co-teachers to the class notebook it creates using these accounts. 

### Using the sample

1. Obtain a client ID as described under [Authenticate using Azure AD (enterprise apps)](https://msdn.microsoft.com/office/office365/howto/onenote-auth#aad-auth). When asked for a redirect URI, "http://localhost" will suffice:

  ![Image of redirect URI](http://i.imgur.com/wfsOClm.png)

  When asked for OneNote delegated permissions, check the following:

  ![Image of permissions](http://i.imgur.com/adTLghg.png)

2. Download this repo as a ZIP file to your local computer, and extract the files. Or, clone the repository into a local copy of Git.

3. Edit OneNoteClassNotebooksApiSample.ps1. Find and replace the following tokens with real values:
   * &lt;AZURE_AD_TENANT_NAME&gt; - This is your Azure tenant, e.g. "contoso.com".
   * &lt;CLIENT_ID&gt; - This is the client ID of your app, e.g. "471afe29-4aee-4bc5-9aaf-468ee5bbe20a".
   * &lt;REDIRECT_URI&gt; - This is the redirect URI of your app, e.g. "http://localhost".
   * &lt;MY_LOGIN&gt; - This is your Office 365 login name. You will be added as the teacher to the class notebook this script creates.
   * &lt;COTEACHER_LOGIN&gt; - This is the Office 365 login name for an account that will be added as a co-teacher to the class notebook this script creates.
   * &lt;STUDENT_1_LOGIN&gt;, &lt;STUDENT_2_LOGIN&gt;, &lt;STUDENT_3_LOGIN&gt; - These are the Office 365 login names for accounts that will be added as students to the class notebook this script creates.

4. Once all the placeholders above have been replaced with real values (remember to enclose each value in double quotes), simply execute the script.

5. Once the script has successfully executed, go to your OneDrive where you will see a folder named "Class Notebooks". In this folder you will find the "Math 101" class notebook this script created.

### Next steps

This sample script demonstrated creating a class notebook in your personal OneDrive. If you are an IT administrator, you can also programmatically create class notebooks for teachers. Refer to the [Construct the request URI](https://msdn.microsoft.com/office/office365/howto/onenote-classnotebook) section, in particular the **Shared notebooks on OneDrive for Business** section. Specifically, you would issue the create request to:
```
	POST https://www.onenote.com/api/v1.0/users/<teacher_id>/notes/classnotebooks
```
where &lt;teacher_id&gt; is the Office 365 login name of the teacher you wish to create a class notebook for.

*Note that before creating class notebooks for teachers, an IT administrator needs to ensure OneDrive is provisioned and access is granted (IT administrators do not have access to users' OneDrives by default). These [OneDrive for Business setup cmdlets] (https://github.com/OneNoteDev/OneDriveForBusiness-SetupPowerShellCmdlets) should come in handy*

### Version info

This is the initial public release for this code sample.

### Learning more

* Learn about [OneNote Class Notebooks](https://www.onenote.com/classnotebook)
* Learn about the [OneNote Class Notebooks API](https://msdn.microsoft.com/office/office365/howto/onenote-classnotebook)
* Visit the [dev.onenote.com](http://dev.onenote.com) Dev Center
* Contact us at [onenoteedu@microsoft.com](mailto:onenoteedu@microsoft.com)
* Follow us on [Twitter @onenotedev](http://www.twitter.com/onenotedev)
* Read our [OneNote Developer blog](http://go.microsoft.com/fwlink/?LinkID=390183)
* [Debugging / Troubleshooting](http://msdn.microsoft.com/EN-US/library/office/dn575430.aspx)

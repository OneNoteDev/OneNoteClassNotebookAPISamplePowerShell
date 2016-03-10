# Your Azure AD tenant name. E.g. "contoso.com"
$adTenant = <AZURE_AD_TENANT_NAME>

# Your app's client ID. E.g. "471afe29-4aee-4bc5-9aaf-468ee5bbe20a"
$clientId = <CLIENT_ID>

# Your app's redirect URI. E.g. "http://localhost"
$redirectUri = <REDIRECT_URI>

# Your Office365 login name. E.g. "abigail.johnson@contoso.com"
$myLogin = <MY_LOGIN>

# Test co-teacher's Office365 login name. E.g. "robert.boyd@contoso.com"
$coteacherLogin = <COTEACHER_LOGIN>

# Test student 1's Office365 login name. E.g. "michael.lee@contoso.com"
$student1Login = <STUDENT_1_LOGIN>

# Test student 2's Office365 login name. E.g. "amanda.sullivan@contoso.com"
$student2Login = <STUDENT_2_LOGIN>

# Test student 3's Office365 login name. E.g. "benjamin.hall@contoso.com"
$student3Login = <STUDENT_3_LOGIN>

# Load Azure AD libraries
$adal = "${env:ProgramFiles(x86)}\Microsoft SDKs\Azure\PowerShell\ServiceManagement\Azure\Services\Microsoft.IdentityModel.Clients.ActiveDirectory.dll"

$adalforms = "${env:ProgramFiles(x86)}\Microsoft SDKs\Azure\PowerShell\ServiceManagement\Azure\Services\Microsoft.IdentityModel.Clients.ActiveDirectory.WindowsForms.dll"

[System.Reflection.Assembly]::LoadFrom($adal)

[System.Reflection.Assembly]::LoadFrom($adalforms)

# Set Resource URI to Azure Service Management API
$resourceAppIdURI = "https://onenote.com/"

# Set Authority to Azure AD Tenant
$authority = "https://login.windows.net/$adTenant"

# Create Authentication Context tied to Azure AD Tenant
$authContext = New-Object "Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext" -ArgumentList $authority

# Acquire token
$authResult = $authContext.AcquireToken($resourceAppIdURI, $clientId, $redirectUri, "Auto")

$accessToken = $authResult.AccessToken;

# Get existing class notebooks
$classNotebooks = Invoke-RestMethod https://www.onenote.com/api/v1.0/me/notes/classnotebooks `
    -Method GET `
    -Headers @{"Authorization" = "Bearer $accessToken"}

# Create a new class notebook
$classNotebookJson = @"
{
    name: "Math 104",
    studentSections: [ "Handout", "Class Notes", "Quizzes", "Homework"],
    teachers: [{ 
        id: "$myLogin",
        principalType: "Person"
    }],
    students: [{ 
        id: "$student1Login",
        principalType: "Person"
    },{ 
        id: "$student2Login",
        principalType: "Person"
    }]
}
"@

$classNotebook = Invoke-RestMethod https://www.onenote.com/api/v1.0/me/notes/classnotebooks `
    -Method POST `
    -ContentType "application/json; charset=utf-8" `
    -Headers @{"Authorization" = "Bearer $accessToken"} `
    -Body $classNotebookJson

# Save the ID of the newly created class notebook which will be used to construct the API request below
$classNotebookId = $classNotebook.id

# Add a student to newly created class notebook
$studentJson = @"
{
    id: "$student3Login",
    principalType: "Person"
}
"@

$student = Invoke-RestMethod https://www.onenote.com/api/v1.0/me/notes/classnotebooks/$classNotebookId/students `
    -Method POST `
    -ContentType "application/json; charset=utf-8" `
    -Headers @{"Authorization" = "Bearer $accessToken"} `
    -Body $studentJson

# Save the ID of the newly added student which will be used to construct the API request below
$studentId = $student.id;

# Add a teacher to newly created class notebook
$teacherJson = @"
{
    id: "$coteacherLogin",
    principalType: "Person"
}
"@

$teacher = Invoke-RestMethod https://www.onenote.com/api/v1.0/me/notes/classnotebooks/$classNotebookId/teachers `
    -Method POST `
    -ContentType "application/json; charset=utf-8" `
    -Headers @{"Authorization" = "Bearer $accessToken"} `
    -Body $teacherJson

# Save the ID of the newly added teacher which will be used to construct the API request below
$teacherId = $teacher.id;

# Remove the newly added student from the class notebook
Invoke-RestMethod https://www.onenote.com/api/v1.0/me/notes/classnotebooks/$classNotebookId/students/$studentId `
    -Method DELETE `
    -Headers @{"Authorization" = "Bearer $accessToken"}

# Remove the newly added teacher from the class notebook
Invoke-RestMethod https://www.onenote.com/api/v1.0/me/notes/classnotebooks/$classNotebookId/students/$teacherId `
    -Method DELETE `
    -Headers @{"Authorization" = "Bearer $accessToken"}






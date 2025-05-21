*** Settings ***
Library    RequestsLibrary
Library    BuiltIn
# Library    JSONLibrary
Library    Collections
Resource    ./generalFunct.robot
Library    ssl_helper.py

*** Variables ***
${authURL}     https://dev-apiv1.1000saudara.com/auth/access
${KEY}         DPEqC6x0Rh8eU5QhtjS1
${BASE_URL}    https://dev-apiv1.1000saudara.com/apiproyek/wb


*** Keywords ***
Get Token
    [Documentation]    Mengambil Token Bearer
    # Menonaktifkan Peringatan SSL dalam Robot Framework
    Disable SSL Warnings
    
    Create Session    api    ${authURL}    headers={"X-MSSAPI-KEY": "${KEY}"}    
        
    ${response}    POST On Session    api     url=${authURL}  
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}    Evaluate    json.loads('${response.content.decode("utf-8")}')
    ${token}    Set Variable    ${json['token']}
    Set Global Variable    ${token}    ${token}
    Log    token : ${token}


Get User Login
    Get Token
    [Documentation]    Menguji POST request pada API
    # Menonaktifkan Peringatan SSL dalam Robot Framework
    Disable SSL Warnings

    Create Session    api    ${BASE_URL}    headers={"Authorization": "Bearer ${token}"}
    # Menyusun body JSON
    ${origins}=    Create Dictionary    Source=app_mitra    Version=
    ${value}=      Create Dictionary    Username=${ROLE_ADMIN}    Password=${PASSWORD}
    ${body}=       Create Dictionary    Token=    UserCode=    Origins=${origins}    Value=${value}
    
    ${response}=    POST On Session    api    /User/login    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Response: ${response.content}
    # ${json}=    To Json    ${response.content}
    ${json}=    Set Variable    ${response.json()}
    ${user_code}=    Get From Dictionary    ${json['value']}    userCode
    Set Global Variable    ${user_code}    ${user_code}
    Log    token : ${user_code}

Get list city
    Get User Login
    [Documentation]    Menguji POST request pada API
    # Menonaktifkan Peringatan SSL dalam Robot Framework
    Disable SSL Warnings

    Create Session    api    ${BASE_URL}    headers={"Authorization": "Bearer ${token}"}
    # Ini ambil alphabet dari a - z dengan acak
    ${random_letter}=    Evaluate    chr(random.randint(97, 122))    random
    Log    Random Letter: ${random_letter}

    ${origins}=    Create Dictionary    Source=app_mitra    Version=
    ${value}=      Create Dictionary    Kecamatan=${random_letter}
    ${body}=       Create Dictionary    Token=    UserCode=${user_code}    Origins=${origins}    Value=${value}
    
    ${response}=    POST On Session    api    /Administrator/GetListCityVendorForAdmin    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    Log    Response: ${json}
    ${kecamatan_list}=    Get From Dictionary    ${json}    value
    
    # Mendapatkan jumlah kecamatan
    ${count}=    Get Length    ${kecamatan_list}
    
    # Menghasilkan indeks acak
    ${random_index}=    Evaluate    random.randint(0, ${count} - 1)    random
    ${random_kecamatan}=    Get From List    ${kecamatan_list}    ${random_index}
    ${kecamatan_name}=    Get From Dictionary    ${random_kecamatan}    kecamatanName
    
    Log    Random Kecamatan Name: ${kecamatan_name}
    Log To Console    Random Kecamatan : ${kecamatan_name}
    Set Global Variable    ${kecamatan_name}    ${kecamatan_name}


Get list User Management (SITE)
    Get User Login
    [Documentation]    Menguji POST request pada API
    # Menonaktifkan Peringatan SSL dalam Robot Framework
    Disable SSL Warnings

    Create Session    api    ${BASE_URL}    headers={"Authorization": "Bearer ${token}"}

    ${origins}=    Create Dictionary    Source=app_mitra    Version=
    ${count_per_page}=    Create Dictionary    Page=1    ItemPerPage=100
    ${value}=      Create Dictionary    Search=    Sorting=    countPerPage=${count_per_page}
    ${body}=       Create Dictionary    Token=    UserCode=${user_code}    Origins=${origins}    Value=${value}
    
    ${response}=    POST On Session    api    /User/GetListUserManagement    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}

    # Mendapatkan jumlah list Detail User Management 
    ${listUserManagement}=    Get From Dictionary    ${json}    value
    ${count}=    Get Length    ${listUserManagement}
    
    ${totalUser_management}=    Get From Dictionary    ${listUserManagement}    countData
    Set Global Variable    ${totalUser}    ${totalUser_management}
    # Set Global Variable    ${totalUser}    8
    Log    TotalUser: ${totalUser} 

    # Menghasilkan indeks acak
    ${listValue}    Get From Dictionary    ${listUserManagement}    value
    ${random_index}=    Evaluate    random.randint(1, ${totalUser_management} - 1)    random
    ${randomUserDetail}=    Get From List    ${listValue}    ${random_index}

    # Contoh ambil value name nya
    ${userManagement_name}=    Get From Dictionary    ${randomUserDetail}    name
    Set Global Variable    ${name_user_management}    ${userManagement_name}
    Log    Response: ${response.content}
    Log    resp: ${json}
    Log    resp: ${listUserManagement}
    Log    resp: ${randomUserDetail}
    Log    resp: ${userManagement_name}


Get list Project Manajemen
    Get User Login
    [Documentation]    Menguji POST request pada API
    # Menonaktifkan Peringatan SSL dalam Robot Framework
    Disable SSL Warnings

    Create Session    api    ${BASE_URL}    headers={"Authorization": "Bearer ${token}"}

    ${origins}=    Create Dictionary    Source=app_mitra    Version=
    ${count_per_page}=    Create Dictionary    Page=1    ItemPerPage=100
    ${value}=      Create Dictionary    StartDate=    EndDate=    Search=    Sorting=    StatusGroupCode=waitconfirm    countPerPage=${count_per_page}    isUserManagement=${False}
    ${body}=       Create Dictionary    Token=    UserCode=${user_code}    Origins=${origins}    Value=${value}
    
    ${response}=    POST On Session    api    /Project/GetListProjectManagement    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    Log    ${json}
    
    # Mendapatkan jumlah list Detail User Management 
    ${listProjectManajemen}=    Get From Dictionary    ${json}    value
    ${valueList}=    Get From Dictionary    ${listProjectManajemen}    value
    ${count}=    Get Length    ${listProjectManajemen}
    ${totalUser}=    Get From Dictionary    ${listProjectManajemen}    countData

    # buat fungsi untuk nge list daftar Project Name
    @{project_names}=    Get Project Names    ${valueList}

    # Ambil salah satu nama proyek, misalnya proyek pertama
    ${single_project_name}=    Get From List    ${project_names}    2 
    Set Global Variable    ${projectName}    ${single_project_name}
    Log    Single Project Name: ${single_project_name}
    Log To Console    Single Project Name: ${single_project_name}

    Log    Project Names: ${project_names}
    Log    TotalUser: ${totalUser}

Get Project Names
    # Untuk List Project Name yang ada
    [Arguments]    ${projects}
    ${project_names}=    Create List
    FOR    ${project}    IN    @{projects}
        ${project_name}=    Get From Dictionary    ${project}    projectName
        Append To List    ${project_names}    ${project_name}
    END
    RETURN    ${project_names}

# *** Test Cases ***
# Get List Kecamatan
#     Get list Project Manajemen
#     Get list city
#     Get list User Management (SITE)
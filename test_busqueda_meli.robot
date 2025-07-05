*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Abrir Navegador
Suite Teardown    Cerrar Navegador

*** Variables ***
${URL}            https://www.mercadolibre.com.ec/
${BROWSER}        Chrome
${PRODUCTO}       laptop

*** Test Cases ***

01 - Buscar Producto Y Validar Resultados
    Input Text    xpath=//input[@type="text"]    ${PRODUCTO}
    Press Keys    xpath=//input[@type="text"]    RETURN
    Wait Until Page Contains Element    xpath=//li[contains(@class, "ui-search-layout__item")]    20s
    Page Should Contain Element         xpath=//li[contains(@class, "ui-search-layout__item")]
    Sleep    5s

02 - Validar Que Existen Al Menos 5 Resultados
    Wait Until Page Contains Element    xpath=//li[contains(@class, "ui-search-layout__item")]    20s
    ${elementos}    Get Element Count    xpath=//li[contains(@class, "ui-search-layout__item")]
    Log    Número de resultados encontrados: ${elementos}
    Should Be True    ${elementos} >= 5    El número de resultados fue menor a 5
    Sleep    5s
     
03 - Aplicar Orden Por Mayor Precio
    Wait Until Element Is Visible    xpath=//span[contains(text(), "Más relevantes")]    10s
    Click Element                    xpath=//span[contains(text(), "Más relevantes")]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//li//span[contains(text(), "Mayor precio")]    10s
    Click Element                    xpath=//li//span[contains(text(), "Mayor precio")]
    Sleep    5s

04 - Acceder Al Detalle Del Primer Producto
    Run Keyword And Ignore Error    Click Element    xpath=//button[contains(text(),"Aceptar")]
    Wait Until Element Is Visible    xpath=(//li[contains(@class, "ui-search-layout__item")]//a[contains(@href, '/MEC-')])[1]    15s
    Scroll Element Into View         xpath=(//li[contains(@class, "ui-search-layout__item")]//a[contains(@href, '/MEC-')])[1]
    Click Element                    xpath=(//li[contains(@class, "ui-search-layout__item")]//a[contains(@href, '/MEC-')])[1]
    Sleep    5s

05 - Validar Precio En La Página De Detalle
    Wait Until Page Contains Element    xpath=//span[@class="andes-money-amount__fraction"]    10s
    ${precio}    Get Text    xpath=//span[@class="andes-money-amount__fraction"]
    Should Not Be Empty    ${precio}
    Sleep    5s

*** Keywords ***

Abrir Navegador
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=//input[@type="text"]    10s

Cerrar Navegador
    Close Browser
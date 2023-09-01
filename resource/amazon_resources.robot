*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${BROWSER}             edge
${URL}                 https://www.amazon.com.br/
${MENU_ELETRONICOS}    //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${TEXTO_HEADER_ELETRONICOS}    Eletrônicos e Tecnologia
${HEADER_ELETRONICOS}    //h1[contains(.,'Eletrônicos e Tecnologia')]
${PESQUISA}    //input[contains(@type,'text')]
${ICON_SUBMIT}    //input[contains(@type,'submit')]
${ADICIONAR_CARRINHO}    //input[contains(@name,'submit.add-to-cart')]
${LINK_CARRINHO}    https://www.amazon.com.br/cart/
*** Keywords ***
Abrir o navegador    
    Open Browser    browser=${BROWSER}     options=add_argument("--start-maximized")
Fechar o Navegador
    Close Browser

Acessar a homepage do site Amazon.com.br
    Go to    url=${URL} 
    Wait Until Element Is Visible    ${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"
    Click Element     locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "Eletrônicos e Tecnologia"
    Wait Until Page Contains    text=${TEXTO_HEADER_ELETRONICOS} 
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS} 

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//img[contains(@alt,'${NOME_CATEGORIA}')]

Digitar o nome de produto "${NOME_PRODUTO}" no campo de pesquisa
    Input Text    locator=${PESQUISA}    text=${NOME_PRODUTO}

Clicar no botão de pesquisa
    Click Element    locator=${ICON_SUBMIT}

Verificar o resultado da pesquisa se está listando o produto "${NOME_PRODUTO}"
    Wait Until Element Is Visible    locator=//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${NOME_PRODUTO}')]

Adicionar o produto "${NOME_PRODUTO}" no carrinho
    Click Element    locator=//a[@class='a-link-normal s-underline-text s-underline-link-text s-link-style a-text-normal'][contains(.,'${NOME_PRODUTO}')]
    Wait Until Page Contains    text=${NOME_PRODUTO}
    Wait Until Element Is Visible    locator=${ADICIONAR_CARRINHO}
    Click Element    locator=${ADICIONAR_CARRINHO}

Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso
    Go To    url=${LINK_CARRINHO}
    Wait Until Element Is Visible    locator=//span[@class='a-truncate-cut'][contains(.,'Console Xbox Series S')]
    Capture Page Screenshot
    Log To Console    message=Produto adicionado com sucesso

Remover o produto "${NOME_PRODUTO}" do carrinho
    Wait Until Element is Visible    locator=//input[contains(@aria-label,'Excluir ${NOME_PRODUTO}')]
    Click Element    locator=//input[contains(@aria-label,'Excluir ${NOME_PRODUTO}')]

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=//h1[@class='a-spacing-mini a-spacing-top-base'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]
    Capture Page Screenshot
    Log To Console    message=Produto Removido com sucesso

# GHERKIN STEPS

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa  
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"
    
E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"

Quando adicionar o produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa  
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho

Então o produto "Console Xbox Series S" deve ser mostrado no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso

E existe o produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa  
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso

Quando remover o produto "Console Xbox Series S" do carrinho
    Remover o produto "Console Xbox Series S" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio
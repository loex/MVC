
#INCLUDE "FWMVCDEF.CH" 

/*/{Protheus.doc} u_COM03AAA
Rotina responsavel por tratar as pendencias na SC. Liberação ou rejeição.
@type function
@version 12.1.25  
@author Loex
@since 25/06/2021
/*/

Function u_COM03AAA

	Local   oBrowse
	Local   aRotina   := Nil

	aRotina   := MenuDef()
	                                          	
	//-> Instanciamento da Classe de Browse
	oBrowse := FWMBrowse():New()
	        
	//-> Definição da tabela do Browse
	oBrowse:SetAlias("ZZP")
	oBrowse:SetMenuDef("COM03AAA")

	// Definição da legenda
	oBrowse:AddLegend( "ZZP_STATUS == '1' ", "DISABLE", "SC Pendente"  )
	oBrowse:AddLegend( "ZZP_STATUS == '2' ", "YELLOW" , "SC Rejeitada" )
	oBrowse:AddLegend( "ZZP_STATUS == '3'" , "BLUE"   , "SC Liberada"  ) 	
	        
	//-> Titulo da Browse
	oBrowse:SetDescription("Controle de Pendencias - SC")
	        
	//-> Ativação da Classe
	oBrowse:Activate()

Return

/*/{Protheus.doc} MenuDef
MenuDef
@type function
@version 12.1.25  
@author Loex
@since 25/06/2021
/*/

Static Function MenuDef()

	Local aRotina := {}
	
	ADD OPTION aRotina Title "Pesquisar"     Action "PesqBrw"          OPERATION 1 ACCESS 0
	ADD OPTION aRotina Title "Visualizar"    Action "ViewDef.COM03AAA" OPERATION 2 ACCESS 0
	ADD OPTION aRotina Title "Incluir"       Action "ViewDef.COM03AAA" OPERATION 3 ACCESS 0
	ADD OPTION aRotina Title "Alterar"       Action "ViewDef.COM03AAA" OPERATION 4 ACCESS 0
	ADD OPTION aRotina Title "Excluir"       Action "ViewDef.COM03AAA" OPERATION 5 ACCESS 0
 
Return(aRotina) 

/*/{Protheus.doc} ModelDef
ModelDef
@type function
@version 12.1.25  
@author Loex
@since 25/06/2021
/*/

Static Function ModelDef()

	Local oStruZZP := FWFormStruct( 1, 'ZZP' )
	Local oModel // Modelo de dados que será construído

	oModel := MPFormModel():New('OM03AAA' )
	oModel:AddFields( 'ZZPMASTER', /*cOwner*/, oStruZZP)
	oModel:SetDescription( 'Controle de Pendencias - SC' )
	oModel:GetModel( 'ZZPMASTER' ):SetDescription( 'Controle de Pendencias - SC' )

	oModel:SetPrimaryKey({"ZZP_FILIAL", "ZZP_NUM"})

Return oModel

/*/{Protheus.doc} ViewDef
ViewDef
@type function
@version 12.1.25  
@author loex
@since 25/06/2021
/*/

Static Function ViewDef()

	Local oModel   := FWLoadModel( 'COM03AAA' )
	Local oStruZZP := FWFormStruct( 2, 'ZZP' )
	Local oView

	oView := FWFormView():New()
	oView:SetModel(oModel )
	oView:AddField('VIEW_ZZP', oStruZZP, 'ZZPMASTER' )
	oView:CreateHorizontalBox( 'TELA' , 100 )
	oView:SetOwnerView( 'VIEW_ZZP', 'TELA' )

Return oView

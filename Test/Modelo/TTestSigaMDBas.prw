#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TTestSigaMDBas� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de  Test unitario da Classe de base Modelo    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


Class TTestSigaMDBas from TSigaUTest 
	method New() Constructor
	method exec()	
EndClass


Method New(oFactory) Class TTestSigaMDBas
	_Super:New(oFactory)
	::nome := "Test das func�es da classe TSigaMDBas"
return (Self)


method exec() class TTestSigaMDBas
	local xReturn
	local xProd, xPreProd

	oGrpProd := TSGrupoProduto():New()	
	// Grupo de Produto find
	xReturn := oGrpProd:find('0200')
	::dados := "Acessar grupo de produto 0200"
	//Self:assert(xReturn, .T.)
	Self:assert(Alltrim(xReturn:valor('descricao')), "BENS DE CONSUMO")
	
	// Grupo de produto setar
	oGrpProd:setar("descricao", "BENS DE CONSUMO MODIF")
	Self:assert(Alltrim(oGrpProd:valor('descricao')), "BENS DE CONSUMO MODIF")
	
	// Grupo de produto salvar atualizacao
	oGrpProd:salvar()
	oGrpProd2 := TSGrupoProduto():New()
	xReturn := oGrpProd2:find('0200') 
	//Self:assert(xReturn[1], .T.)
	Self:assert(Alltrim(xReturn:valor('descricao')), "BENS DE CONSUMO MODIF")
	
	// Colocar para descricao anterior
	//TODO
	
	// Grupo de produto salvar inser��o
	oGrpProd3 := TSGrupoProduto():New()
	oGrpProd3:setar("filial", oGrpProd3:filial())
	oGrpProd3:setar("codigo", "0202")
	oGrpProd3:setar("descricao", "TEST INSERCAO GRUPO")
	oGrpProd3:salvar()
	oGrpProd4 := TSGrupoProduto():New()
	xReturn := oGrpProd4:find('0202') 
	//Self:assert(xReturn[1], .T.)
	Self:assert(Alltrim(xReturn:valor('codigo')), "0202")
			
	// Grupo de produto deletar
	oGrpProd4:deletar()
	oGrpProd5 := TSGrupoProduto():New()
	xReturn := oGrpProd5:find('0202') 
	Self:assert(xReturn, nil)
	//Self:assert(Alltrim(xReturn[2]:valor('codigo')), "0202")	
	
	// navegar para produto //38
	colProdutos := oGrpProd:produto():obter()
	Self:assert(colProduto:length(), 38)
	
	// Produto -> Findall by grupo de produto
	oProd := TSProduto():New()
	oColProd := oProd:findAll( '0200', 4)
	Self:assert(oColProd:length(), 38)
		 
	// navegar de produto para grupo de produto
	oProd2 := TSProduto():New()
	oProd2:find('IN.PR.0006')
	oGp := oProd2:grupoProduto():obter()
	Self:assert(Alltrim(oGp:valor('descricao')), "BENS DE CONSUMO MODIF")
	
	
return
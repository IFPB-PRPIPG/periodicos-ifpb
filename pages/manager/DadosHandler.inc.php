<?php

/**
 * @file pages/admin/AdminHandler.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class AdminHandler
 * @ingroup pages_admin
 *
 * @brief Handle requests for site administration functions. 
 */

import('pages.manager.ManagerHandler');

class DadosHandler extends ManagerHandler {
	/**
	 * Display data index page.
	 */
	function dados($args, &$request) {
		$this->validate();
		$this->setupTemplate(true);
		$templateMgr =& TemplateManager::getManager();
		$jid = $args[0];
		$templateMgr->assign('jid', $jid);

		$templateMgr->display('dados/dados.tpl');
	}

	function acessosDia($args, &$request) {
		$this->validate();
		$this->setupTemplate(true);
		$templateMgr =& TemplateManager::getManager();

		$journalId = intval($_GET['id']);

		$journalDao =& DAORegistry::getDAO('JournalDAO');

		$acessos =& $journalDao->getAcessosDia($journalId);
		$acessosArray = Array();

		foreach ($acessos as $key => $value) {
			$idART = [$key => $value["articleId"]];
			$titleART = [$key => $value['title']];
			$dateEN = new \DateTime($value["dataAcesso"]);
			$dataART = [$key => $dateEN->format('d/m/Y')];
			$numART = [$key => $value["numAcessos"]];

			$acessosArray[$key] = ['id' => $idART[$key], 'title' => $titleART[$key], 'data' => $dataART[$key], 'acessos' => $numART[$key]];
		}
	
	 	header( 'Content-type: application/csv' );   
	   	header( 'Content-Disposition: attachment; filename=file.csv' );   
	   	header( 'Content-Transfer-Encoding: binary' );
	   	header( 'Pragma: no-cache');

	   	$out = fopen( 'php://output', 'w' );

	   	fputcsv($out, array('Código do artigo','Título','Data de acesso', 'Número de acessos'));


	   	foreach ($acessosArray as $k => $u) {
	   		fputcsv($out, $u);
	   	}
	   	fclose($out);

	}

}
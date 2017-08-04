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

class ArquivoHandler extends ManagerHandler {
	/**
	 * Display admin files index page.
	 */
	function arquivos() {
		$this->validate();
		$this->setupTemplate(true);
		$templateMgr =& TemplateManager::getManager();

		//carregar lista de arquivos:
		$templateMgr->assign('files', $this->listar());
		$templateMgr->display('files/files.tpl');
	}

	function upload() {
		$this->validate();
		$this->setupTemplate(true);
		$uploadOk = 1;
		$templateMgr =& TemplateManager::getManager();
		$file_tmp = $_FILES['newfile']['tmp_name'];
		$file_name = $_FILES['newfile']['name'];
		$uploadfile = $uploaddir . basename($_FILES['newfile']['name']);
		$imageFileType = pathinfo($uploadfile,PATHINFO_EXTENSION);

		// Check file size
		if ($_FILES["newfile"]["size"] > 9999999) {
		   $templateMgr->assign('msgErro', 'O arquivo é muito grande!');
		    $uploadOk = 0;
		}

		// Allow certain file formats
		if($imageFileType != "txt" && $imageFileType != "doc" && $imageFileType != "docx"
		&& $imageFileType != "pdf" && $imageFileType != "odt" && $imageFileType != "gif" && $imageFileType != "png" && $imageFileType != "jpg" && $imageFileType != "jpeg") {
		    $templateMgr->assign('msgErro', 'O formato do arquivo não é permitido!');
		    $uploadOk = 0;
		}

		if ($uploadOk == 0) {
			$templateMgr->assign('msg', 'Ocorreu um erro na inclusão do arquivo!');
		} else {
			// move_uploaded_file($file_tmp, "/var/www/ojs/novo/files/".$file_name);
			move_uploaded_file($file_tmp, "/home/rafael/Documentos/ifpb/periodicos/periodicos-alteracao-link/periodicos-ifpb/files/".$file_name);
			$templateMgr->assign('msg', 'O arquivo foi incluído com sucesso!');
		}

		//carregar lista de arquivos:
		$templateMgr->assign('files', $this->listar());
		$templateMgr->display('files/files.tpl');
	}

	function listar() {
		$lista = array();
		
		$types = array( 'png', 'jpg', 'jpeg', 'gif', 'txt', 'doc', 'docx', 'odt', 'pdf', 'csv' );
		// if ($handle = opendir("/var/www/ojs/novo/files/")) {
		if ($handle = opendir("/home/rafael/Documentos/ifpb/periodicos/periodicos-alteracao-link/periodicos-ifpb/files/")) {
		    while ($entry = readdir($handle)) {
		        $ext = strtolower(pathinfo($entry, PATHINFO_EXTENSION));
		        if(in_array($ext, $types)) {
		        	$lista[] = $entry;
		        }
		    }
		    closedir($handle);
		}  
		return $lista;
	}

	function excluir($args, $request) {
		$this->validate();
		$this->setupTemplate(true);
		$templateMgr =& TemplateManager::getManager();
		$fileName = $request->getUserVar('file');

		// $file = "/var/www/ojs/novo/files/".$fileName;
		$file = "/home/rafael/Documentos/ifpb/periodicos/periodicos-alteracao-link/periodicos-ifpb/files/".$fileName;
		if (unlink($file)) {
			$templateMgr->assign('msg', 'Arquivo excluído com sucesso!');
		} else {
			$templateMgr->assign('msg', 'Ocorreu um erro ao excluir o arquivo!');
		}

		//carregar lista de arquivos:
		$templateMgr->assign('files', $this->listar());
		$templateMgr->display('files/files.tpl');
	}

}
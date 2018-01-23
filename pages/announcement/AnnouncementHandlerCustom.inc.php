<?php

/**
 * @file pages/announcement/AnnouncementHandlerCustom.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class AnnouncementHandler
 * @ingroup pages_announcement
 *
 * @brief Handle requests for public announcement functions.
 */




import('classes.handler.Handler');
class AnnouncementHandlerCustom extends Handler {
	function PKPAnnouncementHandler() {
		parent::Handler();
	}


	function show($args, &$request) {

		$announcementId = !isset($args) || empty($args) ? null : (int) $args[0];
		$announcementDao =& DAORegistry::getDAO('AnnouncementDAO');
		$announcement =& $announcementDao->getById($announcementId);


		if ($announcement->getDateExpire() == null || strtotime($announcement->getDateExpire()) > time()) {
			$templateMgr =& TemplateManager::getManager();
			$templateMgr->assign('announcement', $announcement);
			if (!$announcement->getTypeId()) {
				$templateMgr->assign('announcementTitle', $announcement->getLocalizedTitle());
			} else {
				$templateMgr->assign('announcementTitle', $announcement->getAnnouncementTypeName() . ": " . $announcement->getLocalizedTitle());
			}
			$templateMgr->append('pageHierarchy', array($request->url(null, 'announcement'), 'announcement.announcements'));
			
			$templateMgr->assign('readNews', true);
			$templateMgr->display('portalpadrao/layout.tpl');
		} else {
			$request->redirect(null, 'announcement');
		}

	}

	function last($args, &$request) {
		// return "LISTANDO TODAS AS NOTICIAS";
		$templateMgr =& TemplateManager::getManager();
		$announcementDao =& DAORegistry::getDAO('AnnouncementDAO');
		//Função custom para pegar todas as notícias
		$announcements =& $announcementDao->getAll();
		$templateMgr->assign('announcements', $announcements);
		$templateMgr->assign('listNews', true);
		$templateMgr->display('portalpadrao/layout.tpl');
	}

}

?>

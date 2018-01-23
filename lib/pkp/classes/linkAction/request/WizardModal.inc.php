<?php
/**
 * @file classes/linkAction/request/WizardModal.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class WizardModal
 * @ingroup linkAction_request
 *
 * @brief A modal that contains a wizard retrieved via AJAX.
 */


import('lib.pkp.classes.linkAction.request.AjaxModal');

class WizardModal extends AjaxModal {
	/**
	 * Constructor
	 * @param $url string The URL of the AJAX resource to load into the wizard modal.
	 * @param $title string (optional) The localized modal title.
	 * @param $titleIcon string (optional) The icon to be used in the modal title bar.
	 * @param $canClose boolean (optional) Whether the modal will have a close button.
	 */
	function WizardModal($url, $title = null, $titleIcon = null, $canClose = true) {
		parent::AjaxModal($url, $title, $titleIcon, $canClose);
	}


	//
	// Overridden methods from LinkActionRequest
	//
	/**
	 * @see LinkActionRequest::getLocalizedOptions()
	 */
	function getLocalizedOptions() {
		$options = parent::getLocalizedOptions();
		$options['modalHandler'] = '$.pkp.controllers.modal.WizardModalHandler';
		return $options;
	}
}

?>

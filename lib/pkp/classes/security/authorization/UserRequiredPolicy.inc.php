<?php
/**
 * @file classes/security/authorization/UserRequiredPolicy.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class UserRequiredPolicy
 * @ingroup security_authorization
 *
 * @brief Policy to deny access if a context cannot be found in the request.
 */

import('lib.pkp.classes.security.authorization.AuthorizationPolicy');

class UserRequiredPolicy extends AuthorizationPolicy {
	/** @var PKPRouter */
	var $_request;

	/**
	 * Constructor
	 *
	 * @param $request PKPRequest
	 */
	function UserRequiredPolicy(&$request, $message = 'user.authorization.userRequired') {
		parent::AuthorizationPolicy($message);
		$this->_request =& $request;
	}


	//
	// Implement template methods from AuthorizationPolicy
	//
	/**
	 * @see AuthorizationPolicy::effect()
	 */
	function effect() {
		if ($this->_request->getUser()) {
			return AUTHORIZATION_PERMIT;
		} else {
			return AUTHORIZATION_DENY;
		}
	}
}

?>

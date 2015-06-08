<?php

/**
 * @file classes/notification/NotificationMailListDAO.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class NotificationMailListDAO
 * @ingroup notification
 * @see Notification
 *
 * @brief Operations for getting and setting subscriptions to the non-user notification mailing list
 */

class NotificationMailListDAO extends DAO {
	/**
	 * Constructor.
	 */
	function NotificationMailListDAO() {
		parent::DAO();
	}

	/**
	 * Generates an access key for the guest user and adds them to the notification_mail_list table
	 * @param $email string
	 * @param $contextId int
	 * @return string
	 */
	function subscribeGuest($email, $contextId) {
		$token = uniqid(rand());

		// Recurse if this token already exists
		if($this->getMailListIdByToken($token, $contextId)) return $this->subscribeGuest($email, $contextId);

		// Check that the email doesn't already exist
		$result =& $this->retrieve(
			'SELECT * FROM notification_mail_list WHERE email = ? AND context = ?',
			array(
				$email,
				(int) $contextId
			)
		);
		if ($result->RecordCount() != 0) return false;

		$this->update(
			'INSERT INTO notification_mail_list
				(email, context, token)
				VALUES
				(?, ?, ?)',
			array(
				$email,
				(int) $contextId,
				$token
			)
		);

		return $token;
	}

	/**
	 * Gets a mailing list subscription id by a token value
	 * @param $token int
	 * @param $contextId
	 * @return int
	 */
	function getMailListIdByToken($token, $contextId) {
		$result =& $this->retrieve(
			'SELECT notification_mail_list_id FROM notification_mail_list WHERE token = ? AND context = ?',
				array($token, (int) $contextId)
		);

		$row = $result->GetRowAssoc(false);
		$notificationMailListId = $row['notification_mail_list_id'];

		$result->Close();
		unset($result);

		return $notificationMailListId;
	}

	/**
	 * Removes an email address from email notifications
	 * @param $email string
	 * @param $password string
	 * @param $contextId int
	 * @return boolean
	 */
	function unsubscribeGuest($token, $contextId) {
		$notificationMailListId = $this->getMailListIdByToken($token, $contextId);

		if($notificationMailListId) {
			return $this->update(
				'DELETE FROM notification_mail_list WHERE notification_mail_list_id = ?',
				array((int) $notificationMailListId)
			);
		} else return false;
	}

	/**
	 * Confirm the mailing list subscription
	 * @param $notificationMailListId int
	 * @return boolean
	 */
	function confirmMailListSubscription($notificationMailListId) {
		return $this->update(
			'UPDATE notification_mail_list SET confirmed = 1 WHERE notification_mail_list_id = ?',
			array((int) $notificationMailListId)
		);
	}

	/**
	 * Gets a list of email addresses of users subscribed to the mailing list
	 * @param $contextId int
	 * @return array
	 */
	function getMailList($contextId) {
		$result =& $this->retrieve(
			'SELECT email, token FROM notification_mail_list WHERE context = ?',
			(int) $contextId
		);

		$mailList = array();
		while (!$result->EOF) {
			$row = $result->GetRowAssoc(false);
			$mailList[] = $row;
			$result->MoveNext();
		}

		$result->Close();
		unset($result);

		return $mailList;
	}

	/**
	 * Get the ID of the last inserted notification
	 * @return int
	 */
	function getInsertNotificationMailListId() {
		return $this->getInsertId('notification_mail_list', 'notification_mail_list_id');
	}

}

?>

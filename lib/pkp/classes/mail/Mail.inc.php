<?php

/**
 * @defgroup mail
 */

/**
 * @file classes/mail/Mail.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class Mail
 * @ingroup mail
 *
 * @brief Class defining basic operations for handling and sending emails.
 */


define('MAIL_EOL', Core::isWindows() ? "\r\n" : "\n");
define('MAIL_WRAP', 76);

class Mail extends DataObject {
	/** @var array List of key => value private parameters for this message */
	var $privateParams;

	/**
	 * Constructor.
	 */
	function Mail() {
		parent::DataObject();
		$this->privateParams = array();
		if (Config::getVar('email', 'allow_envelope_sender')) {
			$defaultEnvelopeSender = Config::getVar('email', 'default_envelope_sender');
			if (!empty($defaultEnvelopeSender)) $this->setEnvelopeSender($defaultEnvelopeSender);
		}
	}

	/**
	 * Add a private parameter to this email. Private parameters are
	 * replaced just before sending and are never available via getBody etc.
	 */
	function addPrivateParam($name, $value) {
		$this->privateParams[$name] = $value;
	}

	/**
	 * Set the entire list of private parameters.
	 * @see addPrivateParam
	 */
	function setPrivateParams($privateParams) {
		$this->privateParams = $privateParams;
	}

	/**
	 * Add a recipient.
	 * @param $email string
	 * @param $name string optional
	 */
	function addRecipient($email, $name = '') {
		if (($recipients = $this->getData('recipients')) == null) {
			$recipients = array();
		}
		array_push($recipients, array('name' => $name, 'email' => $email));

		return $this->setData('recipients', $recipients);
	}

	/**
	 * Set the envelope sender (bounce address) for the message,
	 * if supported.
	 * @param $envelopeSender string Email address
	 */
	function setEnvelopeSender($envelopeSender) {
		$this->setData('envelopeSender', $envelopeSender);
	}

	/**
	 * Get the envelope sender (bounce address) for the message, if set.
	 * Override any set envelope sender if force_default_envelope_sender config option is in effect.
	 * @return string
	 */
	function getEnvelopeSender() {
		if (Config::getVar('email', 'force_default_envelope_sender') && Config::getVar('email', 'default_envelope_sender')) {
			return Config::getVar('email', 'default_envelope_sender');
		} else {
			return $this->getData('envelopeSender');
		}
	}

	/**
	 * Get the message content type (MIME)
	 * @return string
	 */
	function getContentType() {
		return $this->getData('content_type');
	}

	/**
	 * Set the message content type (MIME)
	 * @param $contentType string
	 */
	function setContentType($contentType) {
		return $this->setData('content_type', $contentType);
	}

	/**
	 * Get the recipients for the message.
	 * @return array
	 */
	function getRecipients() {
		return $this->getData('recipients');
	}

	/**
	 * Set the recipients for the message.
	 * @param $recipients array
	 */
	function setRecipients($recipients) {
		return $this->setData('recipients', $recipients);
	}

	/**
	 * Add a carbon-copy (CC) recipient to the message.
	 * @param $email string
	 * @param $name string optional
	 */
	function addCc($email, $name = '') {
		if (($ccs = $this->getData('ccs')) == null) {
			$ccs = array();
		}
		array_push($ccs, array('name' => $name, 'email' => $email));

		return $this->setData('ccs', $ccs);
	}

	/**
	 * Get the carbon-copy (CC) recipients for the message.
	 * @return array
	 */
	function getCcs() {
		return $this->getData('ccs');
	}

	/**
	 * Set the carbon-copy (CC) recipients for the message.
	 * @param $ccs array
	 */
	function setCcs($ccs) {
		return $this->setData('ccs', $ccs);
	}

	/**
	 * Add a blind carbon copy (BCC) recipient to the message.
	 * @param $email string
	 * @param $name optional
	 */
	function addBcc($email, $name = '') {
		if (($bccs = $this->getData('bccs')) == null) {
			$bccs = array();
		}
		array_push($bccs, array('name' => $name, 'email' => $email));

		return $this->setData('bccs', $bccs);
	}

	/**
	 * Get the blind carbon copy (BCC) recipients for the message
	 * @return array
	 */
	function getBccs() {
		return $this->getData('bccs');
	}

	/**
	 * Set the blind carbon copy (BCC) recipients for the message.
	 * @param $bccs array
	 */
	function setBccs($bccs) {
		return $this->setData('bccs', $bccs);
	}

	/**
	 * If no recipients for this message, promote CC'd accounts to
	 * recipients. If recipients exist, no effect.
	 * @return boolean true iff CCs were promoted
	 */
	function promoteCcsIfNoRecipients() {
		$ccs = $this->getCcs();
		$recipients = $this->getRecipients();
		if (empty($recipients)) {
			$this->setRecipients($ccs);
			$this->setCcs(array());
			return true;
		}
		return false;
	}

	/**
	 * Clear all recipients for this message (To, CC, and BCC).
	 */
	function clearAllRecipients() {
		$this->setRecipients(array());
		$this->setCcs(array());
		$this->setBccs(array());
	}

	/**
	 * Add an SMTP header to the message.
	 * @param $name string
	 * @param $content string
	 */
	function addHeader($name, $content) {
		$updated = false;

		if (($headers = $this->getData('headers')) == null) {
			$headers = array();
		}

		foreach ($headers as $key => $value) {
			if ($headers[$key]['name'] == $name) {
				$headers[$key]['content'] = $content;
				$updated = true;
			}
		}

		if (!$updated) {
			array_push($headers, array('name' => $name,'content' => $content));
		}

		return $this->setData('headers', $headers);
	}

	/**
	 * Get the SMTP headers for the message.
	 * @return array
	 */
	function getHeaders() {
		return $this->getData('headers');
	}

	/**
	 * Set the SMTP headers for the message.
	 * @param $headers array
	 */
	function setHeaders(&$headers) {
		return $this->setData('headers', $headers);
	}

	/**
	 * Adds a file attachment to the email.
	 * @param $filePath string complete path to the file to attach
	 * @param $fileName string attachment file name (optional)
	 * @param $contentType string attachment content type (optional)
	 * @param $contentDisposition string attachment content disposition, inline or attachment (optional, default attachment)
	 */
	function addAttachment($filePath, $fileName = '', $contentType = '', $contentDisposition = 'attachment') {
		if ($attachments =& $this->getData('attachments') == null) {
			$attachments = array();
		}

		/* If the arguments $fileName and $contentType are not specified,
			then try and determine them automatically. */
		if (empty($fileName)) {
			$fileName = basename($filePath);
		}

		if (empty($contentType)) {
			$contentType = String::mime_content_type($filePath);
			if (empty($contentType)) $contentType = 'application/x-unknown-content-type';
		}

		// Open the file and read contents into $attachment
		if (is_readable($filePath) && is_file($filePath)) {
			$fp = fopen($filePath, 'rb');
			if ($fp) {
				$content = '';
				while (!feof($fp)) {
					$content .= fread($fp, 4096);
				}
				fclose($fp);
			}
		}

		if (isset($content)) {
			/* Encode the contents in base64. */
			$content = chunk_split(base64_encode($content), MAIL_WRAP, MAIL_EOL);
			array_push($attachments, array('filename' => $fileName, 'content-type' => $contentType, 'disposition' => $contentDisposition, 'content' => $content));

			return $this->setData('attachments', $attachments);
		} else {
			return false;
		}
	}

	/**
	 * Get the attachments currently on the message.
	 * @return array
	 */
	function &getAttachments() {
		$attachments =& $this->getData('attachments');
		return $attachments;
	}

	/**
	 * Return true iff attachments are included in this message.
	 * @return boolean
	 */
	function hasAttachments() {
		$attachments =& $this->getAttachments();
		return ($attachments != null && count($attachments) != 0);
	}

	/**
	 * Set the sender of the message.
	 * @param $email string
	 * @param $name string optional
	 */
	function setFrom($email, $name = '') {
		return $this->setData('from', array('name' => $name, 'email' => $email));
	}

	/**
	 * Get the sender of the message.
	 * @return array
	 */
	function getFrom() {
		return $this->getData('from');
	}

	/**
	 * Set the reply-to of the message.
	 * @param $email string or null to clear
	 * @param $name string optional
	 */
	function setReplyTo($email, $name = '') {
		if ($email === null) $this->setData('replyTo', null);
		return $this->setData('replyTo', array('name' => $name, 'email' => $email));
	}

	/**
	 * Get the reply-to of the message.
	 * @return array
	 */
	function getReplyTo() {
		return $this->getData('replyTo');
	}

	/**
	 * Return a string containing the reply-to address.
	 * @return string
	 */
	function getReplyToString($send = false) {
		$replyTo = $this->getReplyTo();
		if ($replyTo == null) {
			return null;
		} else {
			return (Mail::encodeDisplayName($replyTo['name'], $send) . ' <'.$replyTo['email'].'>');
		}
	}

	/**
	 * Set the subject of the message.
	 * @param $subject string
	 */
	function setSubject($subject) {
		return $this->setData('subject', $subject);
	}

	/**
	 * Get the subject of the message.
	 * @return string
	 */
	function getSubject() {
		return $this->getData('subject');
	}

	/**
	 * Set the body of the message.
	 * @param $body string
	 */
	function setBody($body) {
		return $this->setData('body', $body);
	}

	/**
	 * Get the body of the message.
	 * @return string
	 */
	function getBody() {
		return $this->getData('body');
	}

	/**
	 * Return a string containing the from address.
	 * Override any from address if force_default_envelope_sender config option is in effect.
	 * @return string
	 */
	function getFromString($send = false) {
		$from = $this->getFrom();
		if ($from == null) {
			return null;
		} else {
			$display = $from['name'];
			$address = $from['email'];
			if (Config::getVar('email', 'force_default_envelope_sender') && Config::getVar('email', 'default_envelope_sender')) {
				$address = Config::getVar('email', 'default_envelope_sender');
				$replyTo = $this->getReplyTo();
				if ($replyTo['name']) {
					$display = $replyTo['name'];
				}
			}
			return (Mail::encodeDisplayName($display, $send) . ' <'.$address.'>');
		}
	}

	/**
	 * Return a string from an array of (name, email) pairs.
	 * @param $includeNames boolean
	 * @return string;
	 */
	function getAddressArrayString($addresses, $includeNames = true, $send = false) {
		if ($addresses == null) {
			return null;

		} else {
			$addressString = '';

			foreach ($addresses as $address) {
				if (!empty($addressString)) {
					$addressString .= ', ';
				}

				if (Core::isWindows() || empty($address['name']) || !$includeNames) {
					$addressString .= $address['email'];

				} else {
					$addressString .= Mail::encodeDisplayName($address['name'], $send) . ' <'.$address['email'].'>';
				}
			}

			return $addressString;
		}
	}

	/**
	 * Return a string containing the recipients.
	 * @return string
	 */
	function getRecipientString() {
		return $this->getAddressArrayString($this->getRecipients());
	}

	/**
	 * Return a string containing the Cc recipients.
	 * @return string
	 */
	function getCcString() {
		return $this->getAddressArrayString($this->getCcs());
	}

	/**
	 * Return a string containing the Bcc recipients.
	 * @return string
	 */
	function getBccString() {
		return $this->getAddressArrayString($this->getBccs(), false);
	}


	/**
	 * Send the email.
	 * @return boolean
	 */
	function send() {
		$recipients = $this->getAddressArrayString($this->getRecipients(), true, true);
		$from = $this->getFromString(true);

		$subject = String::encode_mime_header($this->getSubject());
		$body = $this->getBody();

		// FIXME Some *nix mailers won't work with CRLFs
		if (Core::isWindows()) {
			// Convert LFs to CRLFs for Windows
			$body = String::regexp_replace("/([^\r]|^)\n/", "\$1\r\n", $body);
		} else {
			// Convert CRLFs to LFs for *nix
			$body = String::regexp_replace("/\r\n/", "\n", $body);
		}

		if ($this->getContentType() != null) {
			$this->addHeader('Content-Type', $this->getContentType());
		} elseif ($this->hasAttachments()) {
			// Only add MIME headers if sending an attachment
			$mimeBoundary = '==boundary_'.md5(microtime());

			/* Add MIME-Version and Content-Type as headers. */
			$this->addHeader('MIME-Version', '1.0');
			$this->addHeader('Content-Type', 'multipart/mixed; boundary="'.$mimeBoundary.'"');

		} else {
			$this->addHeader('Content-Type', 'text/plain; charset="'.Config::getVar('i18n', 'client_charset').'"');
		}

		$this->addHeader('X-Mailer', 'Public Knowledge Project Suite v2');

		$remoteAddr = Request::getRemoteAddr();
		if ($remoteAddr != '') $this->addHeader('X-Originating-IP', $remoteAddr);

		$this->addHeader('Date', date('D, d M Y H:i:s O'));

		/* Add $from, $ccs, and $bccs as headers. */
		if ($from != null) {
			$this->addHeader('From', $from);
		}

		if (($r = $this->getReplyToString()) != '') {
			$this->addHeader('Reply-To', $r);
		}

		$ccs = $this->getAddressArrayString($this->getCcs(), true, true);
		if ($ccs != null) {
			$this->addHeader('Cc', $ccs);
		}

		$bccs = $this->getAddressArrayString($this->getBccs(), false, true);
		if ($bccs != null) {
			$this->addHeader('Bcc', $bccs);
		}

		$headers = '';
		foreach ($this->getHeaders() as $header) {
			if (!empty($headers)) {
				$headers .= MAIL_EOL;
			}
			$headers .= $header['name'].': '. str_replace(array("\r", "\n"), '', $header['content']);
		}

		if ($this->hasAttachments()) {
			// Add the body
			$mailBody = 'This message is in MIME format and requires a MIME-capable mail client to view.'.MAIL_EOL.MAIL_EOL;
			$mailBody .= '--'.$mimeBoundary.MAIL_EOL;
			$mailBody .= sprintf('Content-Type: text/plain; charset=%s', Config::getVar('i18n', 'client_charset')) . MAIL_EOL.MAIL_EOL;
			$mailBody .= wordwrap($body, MAIL_WRAP, MAIL_EOL).MAIL_EOL.MAIL_EOL;

			// Add the attachments
			$attachments = $this->getAttachments();
			foreach ($attachments as $attachment) {
				$mailBody .= '--'.$mimeBoundary.MAIL_EOL;
				$mailBody .= 'Content-Type: '.$attachment['content-type'].'; name="'.str_replace('"', '', $attachment['filename']).'"'.MAIL_EOL;
				$mailBody .= 'Content-transfer-encoding: base64'.MAIL_EOL;
				$mailBody .= 'Content-disposition: '.$attachment['disposition'].MAIL_EOL.MAIL_EOL;
				$mailBody .= $attachment['content'].MAIL_EOL.MAIL_EOL;
			}

			$mailBody .= '--'.$mimeBoundary.'--';

		} else {
			// Just add the body
			$mailBody = wordwrap($body, MAIL_WRAP, MAIL_EOL);
		}

		if ($this->getEnvelopeSender() != null) {
			$additionalParameters = '-f ' . $this->getEnvelopeSender();
		} else {
			$additionalParameters = null;
		}

		if (HookRegistry::call('Mail::send', array(&$this, &$recipients, &$subject, &$mailBody, &$headers, &$additionalParameters))) return;

		// Replace all the private parameters for this message.
		if (is_array($this->privateParams)) {
			foreach ($this->privateParams as $name => $value) {
				$mailBody = str_replace($name, $value, $mailBody);
			}
		}

		if (Config::getVar('email', 'smtp')) {
			$smtp =& Registry::get('smtpMailer', true, null);
			if ($smtp === null) {
				import('lib.pkp.classes.mail.SMTPMailer');
				$smtp = new SMTPMailer();
			}
			$sent = $smtp->mail($this, $recipients, $subject, $mailBody, $headers);
		} else {
			$sent = String::mail($recipients, $subject, $mailBody, $headers, $additionalParameters);
		}

		if (!$sent) {
			if (Config::getVar('debug', 'display_errors')) {
				if (Config::getVar('email', 'smtp')) {
					fatalError("There was an error sending this email.  Please check your PHP error log for more information.");
					return false;
				} else {
					fatalError("There was an error sending this email.  Please check your mail log (/var/log/maillog).");
					return false;
				}
			} else return false;
		} else return true;
	}

	/**
	 * Encode a display name for proper inclusion with an email address.
	 * @param $displayName string
	 * @param $send boolean True to encode the results for sending
	 * @return string
	 */
	function encodeDisplayName($displayName, $send = false) {
		if (String::regexp_match('!^[-A-Za-z0-9\!#\$%&\'\*\+\/=\?\^_\`\{\|\}~]+$!', $displayName)) return $displayName;
		return ('"' . ($send ? String::encode_mime_header(str_replace(
			array('"', '\\'),
			'',
			$displayName
		)) : str_replace(
			array('"', '\\'),
			'',
			$displayName
		)) . '"');
	}
}

?>

<?php

/**
 * @file classes/controllers/listbuilder/ListbuilderList.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class ListbuilderList
 * @ingroup controllers_listbuilder
 *
 * @brief Base class for a listbuilder list. This is used by MultipleListsListbuilderHandler
 * to implement multiple lists in a single listbuilder component.
 */

class ListbuilderList {

	/** @var $_id mixed List id. */
	var $_id;

	/** @var $_title string Locale key. */
	var $_title;

	/** @var $_data array */
	var $_data;

	/**
	 * Constructor
	 * @param $id mixed
	 * @param $title string optional Locale key.
	 */
	function ListbuilderList($id, $title = null) {
		$this->setId($id);
		$this->setTitle($title);
	}


	//
	// Getters and setters
	//
	/**
	 * Get this list id.
	 * @return mixed
	 */
	function getId() {
		return $this->_id;
	}

	/**
	 * Set this list id.
	 * @param $id mixed
	 */
	function setId($id) {
		$this->_id = $id;
	}

	/**
	 * Get this list title.
	 * @return string
	 */
	function getTitle() {
		return $this->_title;
	}

	/**
	 * Set this list title.
	 * @param $title string
	 */
	function setTitle($title) {
		$this->_title = $title;
	}

	/**
	 * Get the loaded list data.
	 * @return array
	 */
	function getData() {
		return $this->_data;
	}

	/**
	 * Set the loaded list data.
	 * @param $data array
	 */
	function setData($listData) {
		assert(is_array($listData));
		$this->_data = $listData;
	}
}

?>

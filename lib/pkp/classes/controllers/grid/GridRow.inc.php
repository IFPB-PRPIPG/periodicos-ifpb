<?php

/**
 * @file classes/controllers/grid/GridRow.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class GridRow
 * @ingroup controllers_grid
 *
 * @brief Class defining basic operations for handling HTML gridRows.
 *
 * NB: If you want row-level refresh then you must override the getData() method
 *  so that it fetches data (e.g. from the database) when called. The data to be
 *  fetched can be determined from the id (=row id) which is always set.
 */

define('GRID_ACTION_POSITION_ROW_CLICK', 'row-click');
define('GRID_ACTION_POSITION_ROW_LEFT', 'row-left');

import('lib.pkp.classes.controllers.grid.GridBodyElement');

class GridRow extends GridBodyElement {

	/** @var array */
	var $_requestArgs;

	/** @var the grid this row belongs to */
	var $_gridId;

	/** @var mixed the row's data source */
	var $_data;

	/** @var $isModified boolean true if the row has been modified */
	var $_isModified;

	/**
	 * @var array row actions, the first key represents
	 *  the position of the action in the row template,
	 *  the second key represents the action id.
	 */
	var $_actions = array(GRID_ACTION_POSITION_DEFAULT => array());

	/** @var string the row template */
	var $_template;


	/**
	 * Constructor.
	 */
	function GridRow() {
		parent::GridBodyElement();

		$this->_isModified = false;
	}


	//
	// Getters/Setters
	//
	/**
	 * Set the grid id
	 * @param $gridId string
	 */
	function setGridId($gridId) {
		$this->_gridId = $gridId;
	}

	/**
	 * Get the grid id
	 * @return string
	 */
	function getGridId() {
		return $this->_gridId;
	}

	/**
	 * Set the grid request parameters.
	 * @see GridHandler::getRequestArgs()
	 * @param $requestArgs array
	 */
	function setRequestArgs($requestArgs) {
		$this->_requestArgs = $requestArgs;
	}

	/**
	 * Get the grid request parameters.
	 * @see GridHandler::getRequestArgs()
	 * @return array
	 */
	function getRequestArgs() {
		return $this->_requestArgs;
	}

	/**
	 * Set the data element(s) for this controller
	 * @param $data mixed
	 */
	function setData(&$data) {
		$this->_data =& $data;
	}

	/**
	 * Get the data element(s) for this controller
	 * @return mixed
	 */
	function &getData() {
		return $this->_data;
	}

	/**
	 * Set the modified flag for the row
	 * @param $isModified boolean
	 */
	function setIsModified($isModified) {
		$this->_isModified = $isModified;
	}

	/**
	 * Get the modified flag for the row
	 * @return boolean
	 */
	function getIsModified() {
		return $this->_isModified;
	}

	/**
	 * Get whether this row has any actions or not.
	 * @return boolean
	 */
	function hasActions() {
		$allActions = array();
		foreach($this->_actions as $actions) {
			$allActions = array_merge($allActions, $actions);
		}

		return !empty($allActions);
	}

	/**
	 * Get all actions for a given position within the controller
	 * @param $position string the position of the actions
	 * @return array the LegacyLinkActions for the given position
	 */
	function getActions($position = GRID_ACTION_POSITION_DEFAULT) {
		if(!isset($this->_actions[$position])) return array();
		return $this->_actions[$position];
	}

	/**
	 * Add an action
	 * @param $position string the position of the action
	 * @param $action mixed a single action
	 */
	function addAction($action, $position = GRID_ACTION_POSITION_DEFAULT) {
		if (!isset($this->_actions[$position])) $this->_actions[$position] = array();
		$this->_actions[$position][$action->getId()] = $action;
	}

	/**
	 * Get the row template - override base
	 * implementation to provide a sensible default.
	 * @return string
	 */
	function getTemplate() {
		return $this->_template;
	}

	/**
	 * Set the controller template
	 * @param $template string
	 */
	function setTemplate($template) {
		$this->_template = $template;
	}

	//
	// Public methods
	//
	/**
	 * Initialize a row instance.
	 *
	 * Subclasses can override this method.
	 *
	 * @param $request Request
	 * @param $template string
	 */
	function initialize($request, $template = 'controllers/grid/gridRow.tpl') {
		// Set the template.
		$this->setTemplate($template);
	}
}

?>

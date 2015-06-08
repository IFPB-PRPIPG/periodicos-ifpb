<?php

/**
 * @file classes/controllers/grid/NullGridCellProvider.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class NullGridCellProvider
 * @ingroup controllers_grid
 *
 * @brief Class to return null when render method is called by a grid handler.
 * Use this when you want to create a column with no content at all (for layout
 * purposes using flags, for example).
 */

import('lib.pkp.classes.controllers.grid.GridCellProvider');

class NullGridCellProvider extends GridCellProvider {
	/**
	 * Constructor
	 */
	function NullGridCellProvider() {
		parent::GridCellProvider();
	}

	//
	// Template methods from GridCellProvider
	//
	/**
	 * @see GridCellProvider::render()
	 */
	function render($request, $row, $column) {
		return null;
	}
}

?>

/**
 * @file js/classes/linkAction/RedirectRequest.js
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class RedirectRequest
 * @ingroup js_classes_linkAction
 *
 * @brief A simple action request that will follow the given URL.
 */
(function($) {


	/**
	 * @constructor
	 *
	 * @extends $.pkp.classes.linkAction.LinkActionRequest
	 *
	 * @param {jQuery} $linkActionElement The element the link
	 *  action was attached to.
	 * @param {Object} options Configuration of the link action
	 *  request.
	 */
	$.pkp.classes.linkAction.RedirectRequest =
			function($linkActionElement, options) {

		this.parent($linkActionElement, options);
	};
	$.pkp.classes.Helper.inherits(
			$.pkp.classes.linkAction.RedirectRequest,
			$.pkp.classes.linkAction.LinkActionRequest);


	//
	// Public methods
	//
	/**
	 * @inheritDoc
	 */
	$.pkp.classes.linkAction.RedirectRequest.prototype.activate =
			function(element, event) {

		var options = this.getOptions();
		window.location = options.url;

		return this.parent('activate', element, event);
	};


/** @param {jQuery} $ jQuery closure. */
})(jQuery);

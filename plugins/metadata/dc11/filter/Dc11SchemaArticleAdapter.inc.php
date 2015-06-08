<?php

/**
 * @file plugins/metadata/dc11/filter/Dc11SchemaArticleAdapter.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class Dc11SchemaArticleAdapter
 * @ingroup plugins_metadata_dc11_filter
 * @see Article
 * @see PKPDc11Schema
 *
 * @brief Abstract base class for meta-data adapters that
 *  injects/extracts Dublin Core schema compliant meta-data into/from
 *  an PublishedArticle object.
 */


import('lib.pkp.classes.metadata.MetadataDataObjectAdapter');

class Dc11SchemaArticleAdapter extends MetadataDataObjectAdapter {
	/**
	 * Constructor
	 * @param $filterGroup FilterGroup
	 */
	function Dc11SchemaArticleAdapter(&$filterGroup) {
		parent::MetadataDataObjectAdapter($filterGroup);
	}


	//
	// Implement template methods from Filter
	//
	/**
	 * @see Filter::getClassName()
	 */
	function getClassName() {
		return 'plugins.metadata.dc11.filter.Dc11SchemaArticleAdapter';
	}


	//
	// Implement template methods from MetadataDataObjectAdapter
	//
	/**
	 * @see MetadataDataObjectAdapter::injectMetadataIntoDataObject()
	 * @param $dc11Description MetadataDescription
	 * @param $article Article
	 * @param $authorClassName string the application specific author class name
	 */
	function &injectMetadataIntoDataObject(&$dc11Description, &$article, $authorClassName) {
		// Not implemented
		assert(false);
	}

	/**
	 * @see MetadataDataObjectAdapter::extractMetadataFromDataObject()
	 * @param $article Article
	 * @return MetadataDescription
	 */
	function &extractMetadataFromDataObject(&$article) {
		assert(is_a($article, 'Article'));

		AppLocale::requireComponents(LOCALE_COMPONENT_APPLICATION_COMMON);

		// Retrieve data that belongs to the article.
		// FIXME: Retrieve this data from the respective entity DAOs rather than
		// from the OAIDAO once we've migrated all OAI providers to the
		// meta-data framework. We're using the OAIDAO here because it
		// contains cached entities and avoids extra database access if this
		// adapter is called from an OAI context.
		$oaiDao =& DAORegistry::getDAO('OAIDAO'); /* @var $oaiDao OAIDAO */
		$journal =& $oaiDao->getJournal($article->getJournalId());
		$section =& $oaiDao->getSection($article->getSectionId());
		if (is_a($article, 'PublishedArticle')) { /* @var $article PublishedArticle */
			$issue =& $oaiDao->getIssue($article->getIssueId());
		}

		$dc11Description =& $this->instantiateMetadataDescription();

		// Title
		$this->_addLocalizedElements($dc11Description, 'dc:title', $article->getTitle(null));

		// Creator
		$authors = $article->getAuthors();
		foreach($authors as $author) {
			$authorName = $author->getFullName(true);
			$affiliation = $author->getLocalizedAffiliation();
			if (!empty($affiliation)) {
				$authorName .= '; ' . $affiliation;
			}
			$dc11Description->addStatement('dc:creator', $authorName);
			unset($authorName);
		}

		// Subject
		$subjects = array_merge_recursive(
				(array) $article->getDiscipline(null),
				(array) $article->getSubject(null),
				(array) $article->getSubjectClass(null));
		$this->_addLocalizedElements($dc11Description, 'dc:subject', $subjects);

		// Description
		$this->_addLocalizedElements($dc11Description, 'dc:description', $article->getAbstract(null));

		// Publisher
		$publisherInstitution = $journal->getSetting('publisherInstitution');
		if (!empty($publisherInstitution)) {
			$publishers = array($journal->getPrimaryLocale() => $publisherInstitution);
		} else {
			$publishers = $journal->getTitle(null); // Default
		}
		$this->_addLocalizedElements($dc11Description, 'dc:publisher', $publishers);

		// Contributor
		$contributors = (array) $article->getSponsor(null);
		foreach ($contributors as $locale => $contributor) {
			$contributors[$locale] = array_map('trim', explode(';', $contributor));
		}
		$this->_addLocalizedElements($dc11Description, 'dc:contributor', $contributors);


		// Date
		if (is_a($article, 'PublishedArticle')) {
			if ($article->getDatePublished()) $dc11Description->addStatement('dc:date', date('Y-m-d', strtotime($article->getDatePublished())));
			elseif ($issue->getDatePublished()) $dc11Description->addStatement('dc:date', date('Y-m-d', strtotime($issue->getDatePublished())));
		}

		// Type
		$driverType = 'info:eu-repo/semantics/article';
		$dc11Description->addStatement('dc:type', $driverType, METADATA_DESCRIPTION_UNKNOWN_LOCALE);
		$types = $section->getIdentifyType(null);
		$types = array_merge_recursive(
			empty($types)?array(AppLocale::getLocale() => __('rt.metadata.pkp.peerReviewed')):$types,
			(array) $article->getType(null)
		);
		$this->_addLocalizedElements($dc11Description, 'dc:type', $types);
		$driverVersion = 'info:eu-repo/semantics/publishedVersion';
		$dc11Description->addStatement('dc:type', $driverVersion, METADATA_DESCRIPTION_UNKNOWN_LOCALE);


		// Format
		if (is_a($article, 'PublishedArticle')) {
			$articleGalleyDao =& DAORegistry::getDAO('ArticleGalleyDAO'); /* @var $articleGalleyDao ArticleGalleyDAO */
			$galleys =& $articleGalleyDao->getGalleysByArticle($article->getId());
			$formats = array();
			foreach ($galleys as $galley) {
				$dc11Description->addStatement('dc:format', $galley->getFileType());
			}
		}

		// Identifier: URL
		if (is_a($article, 'PublishedArticle')) {
			$dc11Description->addStatement('dc:identifier', Request::url($journal->getPath(), 'article', 'view', array($article->getBestArticleId())));
		}

		// Source (journal title, issue id and pages)
		$sources = $journal->getTitle(null);
		$pages = $article->getPages();
		if (!empty($pages)) $pages = '; ' . $pages;
		foreach ($sources as $locale => $source) {
			if (is_a($article, 'PublishedArticle')) {
				$sources[$locale] .= '; ' . $issue->getIssueIdentification();
			}
			$sources[$locale] .=  $pages;
		}
		$this->_addLocalizedElements($dc11Description, 'dc:source', $sources);
		if ($issn = $journal->getSetting('onlineIssn')) {
			$dc11Description->addStatement('dc:source', $issn, METADATA_DESCRIPTION_UNKNOWN_LOCALE);
			unset($issn);
		}
		if ($issn = $journal->getSetting('printIssn')) {
			$dc11Description->addStatement('dc:source', $issn, METADATA_DESCRIPTION_UNKNOWN_LOCALE);
			unset($issn);
		}

		// Get galleys and supp files.
		$galleys = array();
		$suppFiles = array();
		if (is_a($article, 'PublishedArticle')) {
			$articleGalleyDao =& DAORegistry::getDAO('ArticleGalleyDAO'); /* @var $articleGalleyDao ArticleGalleyDAO */
			$galleys =& $articleGalleyDao->getGalleysByArticle($article->getId());
			$suppFiles =& $article->getSuppFiles();
		}

		// Language
		$locales = array();
		if (is_a($article, 'PublishedArticle')) {
			foreach ($galleys as $galley) {
				$galleyLocale = $galley->getLocale();
				if(!is_null($galleyLocale) && !in_array($galleyLocale, $locales)) {
					$locales[] = $galleyLocale;
					$dc11Description->addStatement('dc:language', AppLocale::getIso3FromLocale($galleyLocale));
				}
			}
		}
		$articleLanguage = $article->getLanguage();
		if (empty($locales) && !empty($articleLanguage)) {
			$dc11Description->addStatement('dc:language', strip_tags($articleLanguage));
		}

		// Relation
		// full text URLs
		foreach ($galleys as $galley) {
			$relation = Request::url($journal->getPath(), 'article', 'view', array($article->getBestArticleId($journal), $galley->getBestGalleyId($journal)));
			$dc11Description->addStatement('dc:relation', $relation);
			unset($relation);
		}
		// supp file URLs
		foreach ($suppFiles as $suppFile) {
			$relation = Request::url($journal->getPath(), 'article', 'downloadSuppFile', array($article->getBestArticleId($journal), $suppFile->getBestSuppFileId($journal)));
			$dc11Description->addStatement('dc:relation', $relation);
			unset($relation);
		}

		// Public identifiers
		$pubIdPlugins = (array) PluginRegistry::loadCategory('pubIds', true, $journal->getId());
		foreach ($pubIdPlugins as $pubIdPlugin) {
			if ($pubIssueId = $pubIdPlugin->getPubId($issue)) {
				$dc11Description->addStatement('dc:source', $pubIssueId, METADATA_DESCRIPTION_UNKNOWN_LOCALE);
				unset($pubIssueId);
			}
			if ($pubArticleId = $pubIdPlugin->getPubId($article)) {
				$dc11Description->addStatement('dc:identifier', $pubArticleId);
				unset($pubArticleId);
			}
			foreach ($galleys as $galley) {
				if ($pubGalleyId = $pubIdPlugin->getPubId($galley)) {
					$dc11Description->addStatement('dc:relation', $pubGalleyId);
					unset($pubGalleyId);
				}
			}
			foreach ($suppFiles as $suppFile) {
				if ($pubSuppFileId = $pubIdPlugin->getPubId($suppFile)) {
					$dc11Description->addStatement('dc:relation', $pubSuppFileId);
					unset($pubSuppFileId);
				}
			}
		}

		// Coverage
		$coverage = array_merge_recursive(
				(array) $article->getCoverageGeo(null),
				(array) $article->getCoverageChron(null),
				(array) $article->getCoverageSample(null));
		$this->_addLocalizedElements($dc11Description, 'dc:coverage', $coverage);

		// Rights: Add both copyright statement and license
		$copyrightHolder = $article->getLocalizedCopyrightHolder();
		$copyrightYear = $article->getCopyrightYear();
		if (!empty($copyrightHolder) && !empty($copyrightYear)) {
			$dc11Description->addStatement('dc:rights', __('submission.copyrightStatement', array('copyrightHolder' => $copyrightHolder, 'copyrightYear' => $copyrightYear)));
		}

		if ($licenseUrl = $article->getLicenseURL()) $dc11Description->addStatement('dc:rights', $licenseUrl);

		Hookregistry::call('Dc11SchemaArticleAdapter::extractMetadataFromDataObject', array(&$this, $article, $journal, $issue, &$dc11Description));

		return $dc11Description;
	}

	/**
	 * @see MetadataDataObjectAdapter::getDataObjectMetadataFieldNames()
	 * @param $translated boolean
	 */
	function getDataObjectMetadataFieldNames($translated = true) {
		// All DC fields are mapped.
		return array();
	}


	//
	// Private helper methods
	//
	/**
	 * Add an array of localized values to the given description.
	 * @param $description MetadataDescription
	 * @param $propertyName string
	 * @param $localizedValues array
	 */
	function _addLocalizedElements(&$description, $propertyName, $localizedValues) {
		foreach(stripAssocArray((array) $localizedValues) as $locale => $values) {
			if (is_scalar($values)) $values = array($values);
			foreach($values as $value) {
				$description->addStatement($propertyName, $value, $locale);
				unset($value);
			}
		}
	}
}
?>

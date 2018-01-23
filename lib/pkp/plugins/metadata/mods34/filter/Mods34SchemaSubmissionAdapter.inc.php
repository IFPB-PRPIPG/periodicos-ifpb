<?php

/**
 * @file plugins/metadata/mods34/filter/Mods34SchemaSubmissionAdapter.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class Mods34SchemaSubmissionAdapter
 * @ingroup plugins_metadata_mods34_filter
 * @see Submission
 * @see PKPMods34Schema
 *
 * @brief Abstract base class for meta-data adapters that
 *  injects/extracts MODS schema compliant meta-data into/from
 *  a Submission object.
 */


import('lib.pkp.classes.metadata.MetadataDataObjectAdapter');

class Mods34SchemaSubmissionAdapter extends MetadataDataObjectAdapter {
	/**
	 * Constructor
	 * @param $filterGroup FilterGroup
	 */
	function Mods34SchemaSubmissionAdapter(&$filterGroup) {
		parent::MetadataDataObjectAdapter($filterGroup);
	}


	//
	// Implement template methods from MetadataDataObjectAdapter
	//
	/**
	 * @see MetadataDataObjectAdapter::injectMetadataIntoDataObject()
	 * @param $mods34Description MetadataDescription
	 * @param $submission Submission
	 * @param $authorClassName string the application specific author class name
	 */
	function &injectMetadataIntoDataObject(&$mods34Description, &$submission, $authorClassName) {
		assert(is_a($submission, 'Submission'));
		assert($mods34Description->getMetadataSchemaName() == 'plugins.metadata.mods34.schema.Mods34Schema');

		// Get the cataloging language.
		$catalogingLanguage = $mods34Description->getStatement('recordInfo/languageOfCataloging/languageTerm[@authority="iso639-2b"]');
		$catalogingLocale = AppLocale::getLocaleFrom3LetterIso($catalogingLanguage);
		assert(!is_null($catalogingLocale));

		// Title
		$localizedTitles = $mods34Description->getStatementTranslations('titleInfo/title');
		if (is_array($localizedTitles)) {
			foreach($localizedTitles as $locale => $title) {
				$submission->setTitle($title, $locale);
			}
		}

		// Names: authors and sponsor
		$foundSponsor = false;
		$nameDescriptions =& $mods34Description->getStatement('name');
		if (is_array($nameDescriptions)) {
			foreach($nameDescriptions as $nameDescription) { /* @var $nameDescription MetadataDescription */
				// Check that we find the expected name schema.
				assert($nameDescription->getMetadataSchemaName() == 'lib.pkp.plugins.metadata.mods34.schema.Mods34NameSchema');

				// Retrieve the name type and role.
				$nameType = $nameDescription->getStatement('[@type]');
				$nameRoles = $nameDescription->getStatement('role/roleTerm[@type="code" @authority="marcrelator"]');

				// Transport the name into the submission depending
				// on name type and role.
				// FIXME: Move this to a dedicated adapter in the Author class.
				if (is_array($nameRoles)) {
					switch($nameType) {
						// Authors
						case 'personal':
							// Only authors go into the submission.
							if (in_array('aut', $nameRoles)) {
								// Instantiate a new author object.
								import($authorClassName);
								$author = new Author();

								// Family Name
								$author->setLastName($nameDescription->getStatement('namePart[@type="family"]'));

								// Given Names
								$givenNames = $nameDescription->getStatement('namePart[@type="given"]');
								if (!empty($givenNames)) {
									$givenNames = explode(' ', $givenNames, 2);
									if (isset($givenNames[0])) $author->setFirstName($givenNames[0]);
									if (isset($givenNames[1])) $author->setMiddleName($givenNames[1]);
								}

								// Affiliation
								// NB: Our MODS mapping currently doesn't support translation for names.
								// This can be added when required by data providers. We assume the cataloging
								// language for the record.
								$affiliation = $nameDescription->getStatement('affiliation');
								if (!empty($affiliation)) {
									$author->setAffiliation($affiliation, $catalogingLocale);
								}

								// Terms of address (unmapped field)
								$termsOfAddress = $nameDescription->getStatement('namePart[@type="termsOfAddress"]');
								if ($termsOfAddress) {
									$author->setData('nlm34:namePart[@type="termsOfAddress"]', $termsOfAddress);
								}

								// Date (unmapped field)
								$date = $nameDescription->getStatement('namePart[@type="date"]');
								if ($date) {
									$author->setData('nlm34:namePart[@type="date"]', $date);
								}

								// Add the author to the submission.
								$authorDao =& DAORegistry::getDAO('AuthorDAO'); /* @var $authorDao AuthorDAO */
								$authorDao->insertAuthor($author);
								unset($author);
							}
							break;

						// Sponsor
						// NB: Our MODS mapping currently doesn't support translation for names.
						// This can be added when required by data providers. We assume the cataloging
						// language for the record.
						case 'corporate':
							// Only the first sponsor goes into the submission.
							if (!$foundSponsor && in_array('spn', $nameRoles)) {
								$foundSponsor = true;
								$submission->setSponsor($nameDescription->getStatement('namePart'), $catalogingLocale);
							}
							break;
					}
				}

				unset($nameDescription);
			}
		}

		// Creation date
		$dateSubmitted = $mods34Description->getStatement('originInfo/dateCreated[@encoding="w3cdtf"]');
		if ($dateSubmitted) $submission->setDateSubmitted($dateSubmitted);

		// Submission language
		$submissionLanguage = $mods34Description->getStatement('language/languageTerm[@type="code" @authority="iso639-2b"]');
		$submissionLocale = AppLocale::get2LetterFrom3LetterIsoLanguage($submissionLanguage);
		if ($submissionLocale) {
			$submission->setLanguage($submissionLocale);
		}

		// Pages (extent)
		$pages = $mods34Description->getStatement('physicalDescription/extent');
		if ($pages) $submission->setPages($pages);

		// Abstract
		$localizedAbstracts = $mods34Description->getStatementTranslations('abstract');
		if (is_array($localizedAbstracts)) {
			foreach($localizedAbstracts as $locale => $abstract) {
				$submission->setAbstract($abstract, $locale);
			}
		}

		// Discipline, subject class and subject
		// FIXME: We currently ignore discipline, subject class and subject because we cannot
		// distinguish them within a list of MODS topic elements. Can we use several subject
		// statements with different authorities instead?

		// Geographical coverage
		$localizedCoverageGeos = $mods34Description->getStatementTranslations('subject/geographic');
		if (is_array($localizedCoverageGeos)) {
			foreach($localizedCoverageGeos as $locale => $localizedCoverageGeo) {
				$submission->setCoverageGeo($localizedCoverageGeo, $locale);
			}
		}

		// Chronological coverage
		$localizedCoverageChrons = $mods34Description->getStatementTranslations('subject/temporal');
		if (is_array($localizedCoverageChrons)) {
			foreach($localizedCoverageChrons as $locale => $localizedCoverageChron) {
				$submission->setCoverageChron($localizedCoverageChron, $locale);
			}
		}

		// Record identifier
		// NB: We currently don't override the submission id with the record identifier in MODS
		// to make sure that MODS records can be transported between different installations.

		// Handle unmapped fields.
		$this->injectUnmappedDataObjectMetadataFields($mods34Description, $submission);

		return $submission;
	}

	/**
	 * @see MetadataDataObjectAdapter::extractMetadataFromDataObject()
	 * @param $submission Submission
	 * @param $authorMarcrelatorRole string the marcrelator role to be used
	 *  for submission authors.
	 * @return MetadataDescription
	 */
	function &extractMetadataFromDataObject(&$submission, $authorMarcrelatorRole = 'aut') {
		assert(is_a($submission, 'Submission'));
		$mods34Description =& $this->instantiateMetadataDescription();

		// Retrieve the primary locale.
		$catalogingLocale = AppLocale::getPrimaryLocale();
		$catalogingLanguage = AppLocale::get3LetterIsoFromLocale($catalogingLocale);

		// Establish the association between the meta-data description
		// and the submission.
		$mods34Description->setAssocId($submission->getId());

		// Title
		$localizedTitles =& $submission->getTitle(null); // Localized
		$this->addLocalizedStatements($mods34Description, 'titleInfo/title', $localizedTitles);

		// Authors
		// FIXME: Move this to a dedicated adapter in the Author class.
		$authors =& $submission->getAuthors();
		foreach($authors as $author) { /* @var $author Author */
			// Create a new name description.
			$authorDescription = new MetadataDescription('lib.pkp.plugins.metadata.mods34.schema.Mods34NameSchema', ASSOC_TYPE_AUTHOR);

			// Type
			$authorType = 'personal';
			$authorDescription->addStatement('[@type]', $authorType);

			// Family Name
			$authorDescription->addStatement('namePart[@type="family"]', $author->getLastName());

			// Given Names
			$firstName = (string)$author->getFirstName();
			$middleName = (string)$author->getMiddleName();
			$givenNames = trim($firstName.' '.$middleName);
			if (!empty($givenNames)) {
				$authorDescription->addStatement('namePart[@type="given"]', $givenNames);
			}

			// Affiliation
			// NB: Our MODS mapping currently doesn't support translation for names.
			// This can be added when required by data consumers. We therefore only use
			// translations in the cataloging language.
			$affiliation = $author->getAffiliation($catalogingLocale);
			if ($affiliation) {
				$authorDescription->addStatement('affiliation', $affiliation);
			}

			// Terms of address (unmapped field)
			$termsOfAddress = $author->getData('nlm34:namePart[@type="termsOfAddress"]');
			if ($termsOfAddress) {
				$authorDescription->addStatement('namePart[@type="termsOfAddress"]', $termsOfAddress);
			}

			// Date (unmapped field)
			$date = $author->getData('nlm34:namePart[@type="date"]');
			if ($date) {
				$authorDescription->addStatement('namePart[@type="date"]', $date);
			}

			// Role
			$authorDescription->addStatement('role/roleTerm[@type="code" @authority="marcrelator"]', $authorMarcrelatorRole);

			// Add the author to the MODS schema.
			$mods34Description->addStatement('name', $authorDescription);
			unset($authorDescription);
		}

		// Sponsor
		// NB: Our MODS mapping currently doesn't support translation for names.
		// This can be added when required by data consumers. We therefore only use
		// translations in the cataloging language.
		$supportingAgency = $submission->getSponsor($catalogingLocale);
		if ($supportingAgency) {
			$supportingAgencyDescription = new MetadataDescription('lib.pkp.plugins.metadata.mods34.schema.Mods34NameSchema', ASSOC_TYPE_AUTHOR);
			$sponsorNameType = 'corporate';
			$supportingAgencyDescription->addStatement('[@type]', $sponsorNameType);
			$supportingAgencyDescription->addStatement('namePart', $supportingAgency);
			$sponsorRole = 'spn';
			$supportingAgencyDescription->addStatement('role/roleTerm[@type="code" @authority="marcrelator"]', $sponsorRole);
			$mods34Description->addStatement('name', $supportingAgencyDescription);
		}

		// Type of resource
		$typeOfResource = 'text';
		$mods34Description->addStatement('typeOfResource', $typeOfResource);

		// Creation & copyright date
		$submissionDate = $submission->getDateSubmitted();
		if (strlen($submissionDate) >= 4) {
			$mods34Description->addStatement('originInfo/dateCreated[@encoding="w3cdtf"]', $submissionDate);
			$mods34Description->addStatement('originInfo/copyrightDate[@encoding="w3cdtf"]', substr($submissionDate, 0, 4));
		}

		// Submission language
		$submissionLanguage = AppLocale::get3LetterFrom2LetterIsoLanguage($submission->getLanguage());
		if (!$submissionLanguage) {
			// Assume the cataloging language by default.
			$submissionLanguage = $catalogingLanguage;
		}
		$mods34Description->addStatement('language/languageTerm[@type="code" @authority="iso639-2b"]', $submissionLanguage);

		// Pages (extent)
		$mods34Description->addStatement('physicalDescription/extent', $submission->getPages());

		// Abstract
		$localizedAbstracts =& $submission->getAbstract(null); // Localized
		$this->addLocalizedStatements($mods34Description, 'abstract', $localizedAbstracts);

		// Discipline
		$localizedDisciplines = $submission->getDiscipline(null); // Localized
		$this->addLocalizedStatements($mods34Description, 'subject/topic', $localizedDisciplines);

		// Subject class
		$localizedSubjectClasses = $submission->getSubjectClass(null); // Localized
		$this->addLocalizedStatements($mods34Description, 'subject/topic', $localizedSubjectClasses);

		// Subject
		$localizedSubjects = $submission->getSubject(null); // Localized
		$this->addLocalizedStatements($mods34Description, 'subject/topic', $localizedSubjects);

		// Geographical coverage
		$localizedCoverageGeo = $submission->getCoverageGeo(null); // Localized
		$this->addLocalizedStatements($mods34Description, 'subject/geographic', $localizedCoverageGeo);

		// Chronological coverage
		$localizedCoverageChron = $submission->getCoverageChron(null); // Localized
		$this->addLocalizedStatements($mods34Description, 'subject/temporal', $localizedCoverageChron);

		// Record creation date
		$recordCreationDate = date('Y-m-d');
		$mods34Description->addStatement('recordInfo/recordCreationDate[@encoding="w3cdtf"]', $recordCreationDate);

		// Record identifier
		$mods34Description->addStatement('recordInfo/recordIdentifier[@source="pkp"]', $submission->getId());

		// Cataloging language
		$mods34Description->addStatement('recordInfo/languageOfCataloging/languageTerm[@authority="iso639-2b"]', $catalogingLanguage);

		// Handle unmapped fields.
		$this->extractUnmappedDataObjectMetadataFields($submission, $mods34Description);

		return $mods34Description;
	}

	/**
	 * @see MetadataDataObjectAdapter::getDataObjectMetadataFieldNames()
	 * @param $translated boolean
	 */
	function getDataObjectMetadataFieldNames($translated = true) {
		static $unmappedFields = false;

		if ($unmappedFields === false) {
			$metadataSchema =& $this->getMetadataSchema();
			$metadataSchemaNamespace = $metadataSchema->getNamespace();

			// The following properties have no mapping within this adapter.
			$unmappedFields = array(
				true => array(
					$metadataSchemaNamespace.':titleInfo/nonSort',
					$metadataSchemaNamespace.':titleInfo/subTitle',
					$metadataSchemaNamespace.':titleInfo/partNumber',
					$metadataSchemaNamespace.':titleInfo/partName',
					$metadataSchemaNamespace.':note'
				),
				false => array(
					$metadataSchemaNamespace.':subject/temporal[@encoding="w3cdtf" @point="start"]',
					$metadataSchemaNamespace.':subject/temporal[@encoding="w3cdtf" @point="end"]'
				)
			);
		}

		return ($unmappedFields[$translated]);
	}
}
?>

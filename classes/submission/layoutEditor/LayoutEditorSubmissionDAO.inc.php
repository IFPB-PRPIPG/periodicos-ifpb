<?php

/**
 * @file classes/submission/layoutEditor/LayoutEditorSubmissionDAO.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * With contributions from:
 *  - 2014 Instituto Nacional de Investigacion y Tecnologia Agraria y Alimentaria
 *
 * @class LayoutEditorSubmissionDAO
 * @ingroup submission_layoutEditor
 * @see LayoutEditorSubmission
 *
 * @brief Operations for retrieving and modifying LayoutEditorSubmission objects.
 */

import('classes.submission.layoutEditor.LayoutEditorSubmission');

class LayoutEditorSubmissionDAO extends DAO {
	/** Helper DAOs */
	var $articleDao;
	var $layoutDao;
	var $galleyDao;
	var $editAssignmentDao;
	var $suppFileDao;
	var $articleCommentDao;

	/**
	 * Constructor.
	 */
	function LayoutEditorSubmissionDAO() {
		parent::DAO();

		$this->articleDao =& DAORegistry::getDAO('ArticleDAO');
		$this->galleyDao =& DAORegistry::getDAO('ArticleGalleyDAO');
		$this->editAssignmentDao =& DAORegistry::getDAO('EditAssignmentDAO');
		$this->suppFileDao =& DAORegistry::getDAO('SuppFileDAO');
		$this->articleCommentDao =& DAORegistry::getDAO('ArticleCommentDAO');
	}

	/**
	 * Retrieve a layout editor submission by article ID.
	 * @param $articleId int
	 * @return LayoutEditorSubmission
	 */
	function &getSubmission($articleId, $journalId =  null) {
		$primaryLocale = AppLocale::getPrimaryLocale();
		$locale = AppLocale::getLocale();
		$params = array(
			'title',
			$primaryLocale,
			'title',
			$locale,
			'abbrev',
			$primaryLocale,
			'abbrev',
			$locale,
			$articleId
		);
		if ($journalId) $params[] = $journalId;
		$result =& $this->retrieve(
			'SELECT
				a.*,
				COALESCE(stl.setting_value, stpl.setting_value) AS section_title,
				COALESCE(sal.setting_value, sapl.setting_value) AS section_abbrev
			FROM articles a
				LEFT JOIN sections s ON s.section_id = a.section_id
				LEFT JOIN section_settings stpl ON (s.section_id = stpl.section_id AND stpl.setting_name = ? AND stpl.locale = ?)
				LEFT JOIN section_settings stl ON (s.section_id = stl.section_id AND stl.setting_name = ? AND stl.locale = ?)
				LEFT JOIN section_settings sapl ON (s.section_id = sapl.section_id AND sapl.setting_name = ? AND sapl.locale = ?)
				LEFT JOIN section_settings sal ON (s.section_id = sal.section_id AND sal.setting_name = ? AND sal.locale = ?)
			WHERE a.article_id = ?' .
			($journalId?' AND a.journal_id = ?':''),
			$params
		);

		$returner = null;
		if ($result->RecordCount() != 0) {
			$returner =& $this->_returnSubmissionFromRow($result->GetRowAssoc(false));
		}

		$result->Close();
		unset($result);

		return $returner;
	}

	/**
	 * Internal function to return a LayoutEditorSubmission object from a row.
	 * @param $row array
	 * @return LayoutEditorSubmission
	 */
	function &_returnSubmissionFromRow(&$row) {
		$submission = new LayoutEditorSubmission();
		$this->articleDao->_articleFromRow($submission, $row);

		// Comments
		$submission->setMostRecentLayoutComment($this->articleCommentDao->getMostRecentArticleComment($row['article_id'], COMMENT_TYPE_LAYOUT, $row['article_id']));
		$submission->setMostRecentProofreadComment($this->articleCommentDao->getMostRecentArticleComment($row['article_id'], COMMENT_TYPE_PROOFREAD, $row['article_id']));

		$submission->setSuppFiles($this->suppFileDao->getSuppFilesByArticle($row['article_id']));

		$submission->setGalleys($this->galleyDao->getGalleysByArticle($row['article_id']));

		$editAssignments =& $this->editAssignmentDao->getEditAssignmentsByArticleId($row['article_id']);
		$submission->setEditAssignments($editAssignments->toArray());

		HookRegistry::call('LayoutEditorSubmissionDAO::_returnLayoutEditorSubmissionFromRow', array(&$submission, &$row));

		return $submission;
	}

	/**
	 * Get set of layout editing assignments assigned to the specified layout editor.
	 * @param $editorId int
	 * @param $journalId int
	 * @param $searchField int SUBMISSION_FIELD_... constant
	 * @param $searchMatch String 'is' or 'contains' or 'startsWith'
	 * @param $search String Search string
	 * @param $dateField int SUBMISSION_FIELD_DATE_... constant
	 * @param $dateFrom int Search from timestamp
	 * @param $dateTo int Search to timestamp
	 * @param $active boolean true to select active assignments, false to select completed assignments
	 * @return array LayoutEditorSubmission
	 */
	function &getSubmissions($editorId, $journalId = null, $searchField = null, $searchMatch = null, $search = null, $dateField = null, $dateFrom = null, $dateTo = null, $active = true, $rangeInfo = null, $sortBy = null, $sortDirection = SORT_DIRECTION_ASC) {
		$primaryLocale = AppLocale::getPrimaryLocale();
		$locale = AppLocale::getLocale();
		$params = array(
			'title', // Section title
			$primaryLocale,
			'title',
			$locale,
			'abbrev', // Section abbrev.
			$primaryLocale,
			'abbrev',
			$locale,
			'cleanTitle', // Article clean title
			'cleanTitle',
			$locale,
			'title', // Article title
			'title',
			$locale,
			ASSOC_TYPE_ARTICLE,
			'SIGNOFF_COPYEDITING_FINAL',
			ASSOC_TYPE_ARTICLE,
			'SIGNOFF_LAYOUT',
			ASSOC_TYPE_ARTICLE,
			'SIGNOFF_PROOFREADING_LAYOUT',
			ASSOC_TYPE_ARTICLE,
			'SIGNOFF_COPYEDITING_INITIAL',
			$editorId
		);
		if (isset($journalId)) $params[] = $journalId;

		$searchSql = '';

		if (!empty($search)) switch ($searchField) {
			case SUBMISSION_FIELD_ID:
				switch ($searchMatch) {
					case 'is':
						$params[] = (int) $search;
						$searchSql = ' AND a.article_id = ?';
						break;
					case 'contains':
						$search = '%' . $search . '%';
						$params[] = $search;
						$searchSql = ' AND CONCAT(a.article_id) LIKE ?';
						break;
					case 'startsWith':
						$search = $search . '%';
						$params[] = $search;
						$searchSql = 'AND CONCAT(a.article_id) LIKE ?';
						break;
				}
				break;
			case SUBMISSION_FIELD_TITLE:
				if ($searchMatch === 'is') {
					$searchSql = ' AND LOWER(atl.setting_value) = LOWER(?)';
				} elseif ($searchMatch === 'contains') {
					$searchSql = ' AND LOWER(atl.setting_value) LIKE LOWER(?)';
					$search = '%' . $search . '%';
				} else { // $searchMatch === 'startsWith'
					$searchSql = ' AND LOWER(atl.setting_value) LIKE LOWER(?)';
					$search = $search . '%';
				}
				$params[] = $search;
				break;
			case SUBMISSION_FIELD_AUTHOR:
				$searchSql = $this->_generateUserNameSearchSQL($search, $searchMatch, 'aa.', $params);
				break;
			case SUBMISSION_FIELD_EDITOR:
				$searchSql = $this->_generateUserNameSearchSQL($search, $searchMatch, 'ed.', $params);
				break;
		}

		if (!empty($dateFrom) || !empty($dateTo)) switch($dateField) {
			case SUBMISSION_FIELD_DATE_SUBMITTED:
				if (!empty($dateFrom)) {
					$searchSql .= ' AND a.date_submitted >= ' . $this->datetimeToDB($dateFrom);
				}
				if (!empty($dateTo)) {
					$searchSql .= ' AND a.date_submitted <= ' . $this->datetimeToDB($dateTo);
				}
				break;
			case SUBMISSION_FIELD_DATE_COPYEDIT_COMPLETE:
				if (!empty($dateFrom)) {
					$searchSql .= ' AND scp.date_completed >= ' . $this->datetimeToDB($dateFrom);
				}
				if (!empty($dateTo)) {
					$searchSql .= ' AND scp.date_completed <= ' . $this->datetimeToDB($dateTo);
				}
				break;
			case SUBMISSION_FIELD_DATE_LAYOUT_COMPLETE:
				if (!empty($dateFrom)) {
					$searchSql .= ' AND sle.date_completed >= ' . $this->datetimeToDB($dateFrom);
				}
				if (!empty($dateTo)) {
					$searchSql .= ' AND sle.date_completed <= ' . $this->datetimeToDB($dateTo);
				}
				break;
			case SUBMISSION_FIELD_DATE_PROOFREADING_COMPLETE:
				if (!empty($dateFrom)) {
					$searchSql .= ' AND spr.date_completed >= ' . $this->datetimeToDB($dateFrom);
				}
				if (!empty($dateTo)) {
					$searchSql .= 'AND spr.date_completed <= ' . $this->datetimeToDB($dateTo);
				}
				break;
		}

		$sql = 'SELECT DISTINCT
				a.*,
				sle.date_notified AS notified_date,
				sle.date_completed AS completed_date,
				aap.last_name AS author_name,
				SUBSTRING(COALESCE(atl.setting_value, atpl.setting_value) FROM 1 FOR 255) AS submission_clean_title,
				SUBSTRING(COALESCE(stl.setting_value, stpl.setting_value) FROM 1 FOR 255) AS section_title,
				SUBSTRING(COALESCE(sal.setting_value, sapl.setting_value) FROM 1 FOR 255) AS section_abbrev
			FROM	articles a
				LEFT JOIN authors aa ON (aa.submission_id = a.article_id)
				LEFT JOIN authors aap ON (aap.submission_id = a.article_id AND aap.primary_contact = 1)
				LEFT JOIN sections s ON s.section_id = a.section_id
				LEFT JOIN edit_assignments e ON (e.article_id = a.article_id)
				LEFT JOIN users ed ON (e.editor_id = ed.user_id)
				LEFT JOIN section_settings stpl ON (s.section_id = stpl.section_id AND stpl.setting_name = ? AND stpl.locale = ?)
				LEFT JOIN section_settings stl ON (s.section_id = stl.section_id AND stl.setting_name = ? AND stl.locale = ?)
				LEFT JOIN section_settings sapl ON (s.section_id = sapl.section_id AND sapl.setting_name = ? AND sapl.locale = ?)
				LEFT JOIN section_settings sal ON (s.section_id = sal.section_id AND sal.setting_name = ? AND sal.locale = ?)
				LEFT JOIN article_settings actpl ON (actpl.article_id = a.article_id AND actpl.setting_name = ? AND actpl.locale = a.locale)
				LEFT JOIN article_settings actl ON (a.article_id = actl.article_id AND actl.setting_name = ? AND actl.locale = ?)
				LEFT JOIN article_settings atpl ON (atpl.article_id = a.article_id AND atpl.setting_name = ? AND atpl.locale = a.locale)
				LEFT JOIN article_settings atl ON (a.article_id = atl.article_id AND atl.setting_name = ? AND atl.locale = ?)
				LEFT JOIN signoffs scpf ON (a.article_id = scpf.assoc_id AND scpf.assoc_type = ? AND scpf.symbolic = ?)
				LEFT JOIN signoffs sle ON (a.article_id = sle.assoc_id AND sle.assoc_type = ? AND sle.symbolic = ?)
				LEFT JOIN signoffs spr ON (a.article_id = spr.assoc_id AND spr.assoc_type = ? AND spr.symbolic = ?)
				LEFT JOIN signoffs scpi ON (a.article_id = scpi.assoc_id AND scpi.assoc_type = ? AND scpi.symbolic = ?)
			WHERE
				sle.user_id = ? AND
				' . (isset($journalId)?'a.journal_id = ? AND':'') . '
				sle.date_notified IS NOT NULL';

		if ($active) {
			$sql .= ' AND a.status = ' . STATUS_QUEUED;
		} else {
			$sql .= ' AND a.status <> ' . STATUS_QUEUED;
		}

		$result =& $this->retrieveRange(
			$sql . ' ' . $searchSql . ($sortBy?(' ORDER BY ' . $this->getSortMapping($sortBy) . ' ' . $this->getDirectionMapping($sortDirection)) : ''),
			count($params)==1?array_shift($params):$params,
			$rangeInfo
		);

		$returner = new DAOResultFactory($result, $this, '_returnSubmissionFromRow');
		return $returner;
	}

	/**
	 * FIXME Move this into somewhere common (SubmissionDAO?) as this is used in several classes.
	 */
	function _generateUserNameSearchSQL($search, $searchMatch, $prefix, &$params) {
		$first_last = $this->concat($prefix.'first_name', '\' \'', $prefix.'last_name');
		$first_middle_last = $this->concat($prefix.'first_name', '\' \'', $prefix.'middle_name', '\' \'', $prefix.'last_name');
		$last_comma_first = $this->concat($prefix.'last_name', '\', \'', $prefix.'first_name');
		$last_comma_first_middle = $this->concat($prefix.'last_name', '\', \'', $prefix.'first_name', '\' \'', $prefix.'middle_name');
		if ($searchMatch === 'is') {
			$searchSql = " AND (LOWER({$prefix}last_name) = LOWER(?) OR LOWER($first_last) = LOWER(?) OR LOWER($first_middle_last) = LOWER(?) OR LOWER($last_comma_first) = LOWER(?) OR LOWER($last_comma_first_middle) = LOWER(?))";
		} elseif ($searchMatch === 'contains') {
			$searchSql = " AND (LOWER({$prefix}last_name) LIKE LOWER(?) OR LOWER($first_last) LIKE LOWER(?) OR LOWER($first_middle_last) LIKE LOWER(?) OR LOWER($last_comma_first) LIKE LOWER(?) OR LOWER($last_comma_first_middle) LIKE LOWER(?))";
			$search = '%' . $search . '%';
		} else { // $searchMatch === 'startsWith'
			$searchSql = " AND (LOWER({$prefix}last_name) LIKE LOWER(?) OR LOWER($first_last) LIKE LOWER(?) OR LOWER($first_middle_last) LIKE LOWER(?) OR LOWER($last_comma_first) LIKE LOWER(?) OR LOWER($last_comma_first_middle) LIKE LOWER(?))";
			$search = $search . '%';
		}
		$params[] = $params[] = $params[] = $params[] = $params[] = $search;
		return $searchSql;
	}

	/**
	 * Get count of active and complete assignments
	 * @param editorId int
	 * @param journalId int
	 */
	function getSubmissionsCount($layoutEditorId, $journalId) {
		$sectionEditorSubmissionDao =& DAORegistry::getDAO('SectionEditorSubmissionDAO');
		$stats = $sectionEditorSubmissionDao->getLayoutEditorStatistics($journalId, $layoutEditorId);
		return array(
			0 => isset($stats[$layoutEditorId]['incomplete'])?$stats[$layoutEditorId]['incomplete']:0,
			1 => isset($stats[$layoutEditorId]['complete'])?$stats[$layoutEditorId]['complete']:0
		);
	}

	function getProofedArticlesByIssueId($issueId) {
		$articleIds = array();

		$result =& $this->retrieve(
			'SELECT pa.article_id AS article_id FROM published_articles pa, signoffs s WHERE pa.article_id = s.assoc_id AND s.assoc_type = ? AND pa.issue_id = ? AND s.date_completed IS NOT NULL AND s.symbolic = ?',
			array(ASSOC_TYPE_ARTICLE, $issueId, 'SIGNOFF_LAYOUT')
		);

		while (!$result->EOF) {
			$row = $result->GetRowAssoc(false);
			$articleIds[] = $row['article_id'];
			$result->MoveNext();
		}

		$result->Close();
		unset($result);

		return $articleIds;
	}


	/**
	 * Map a column heading value to a database value for sorting
	 * @param string
	 * @return string
	 */
	function getSortMapping($heading) {
		switch ($heading) {
			case 'id': return 'a.article_id';
			case 'assignDate': return 'notified_date';
			case 'section': return 'section_abbrev';
			case 'authors': return 'author_name';
			case 'title': return 'submission_clean_title';
			case 'dateCompleted': return 'completed_date';
			case 'status': return 'a.status';
			default: return null;
		}
	}
}

?>

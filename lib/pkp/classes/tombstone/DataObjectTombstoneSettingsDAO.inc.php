<?php

/**
 * @file classes/tombstone/DataObjectTombstoneSettingsDAO.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class DataObjectTombstoneSettingsDAO
 * @ingroup submission
 *
 * @brief Operations for retrieving and modifying submission tombstone settings.
 */


class DataObjectTombstoneSettingsDAO extends DAO {
	/**
	 * Retrieve an submission tombstone setting value.
	 * @param $tombstoneId int
	 * @param $name
	 * @param $locale string optional
	 */
	function &getSetting($tombstoneId, $name, $locale = null) {
		$sql = 'SELECT	setting_value, setting_type, locale FROM data_object_tombstone_settings	WHERE tombstone_id = ? AND setting_name = ?';
		$params = array((int) $tombstoneId, $name);
		if ($locale !== null) {
			$sql .= ' AND locale = ?';
			$params[] = $locale;
		}
		$result =& $this->retrieve($sql, $params);

		$setting = null;
		while (!$result->EOF) {
			$row =& $result->getRowAssoc(false);
			$value = $this->convertFromDB($row['setting_value'], $row['setting_type']);
			if ($row['locale'] == '') $setting[$name] = $value;
			else $setting[$name][$row['locale']] = $value;
			$result->moveNext();
		}
		$result->close();
		unset($result);

		return $setting;
	}

	/**
	 * Add/update an submission tombstone setting.
	 * @param $tombstoneId int
	 * @param $name string
	 * @param $value mixed
	 * @param $type string data type of the setting. If omitted, type will be guessed
	 * @param $isLocalized boolean
	 * @return boolean
	 */
	function updateSetting($tombstoneId, $name, $value, $type = null, $isLocalized = false) {
		$returner = null;

		$keyFields = array('tombstone_id', 'setting_name', 'locale');

		if (!$isLocalized) {
			$value = $this->convertToDB($value, $type);
			$this->replace('data_object_tombstone_settings',
				array(
					'tombstone_id' => $tombstoneId,
					'setting_name' => $name,
					'setting_value' => $value,
					'setting_type' => $type,
					'locale' => ''
				),
				$keyFields
			);
			$returner = true;
		} else {
			if (is_array($value)) foreach ($value as $locale => $localeValue) {
				$this->update('DELETE FROM data_object_tombstone_settings WHERE tombstone_id = ? AND setting_name = ? AND locale = ?', array((int) $tombstone_id, $name, $locale));
				if (empty($localeValue)) continue;
				$type = null;
				$returner = $this->update('INSERT INTO data_object_tombstone_settings
					(tombstone_id, setting_name, setting_value, setting_type, locale)
					VALUES (?, ?, ?, ?, ?)',
					array(
						(int) $tombstoneId, $name, $this->convertToDB($localeValue, $type), $type, $locale
					)
				);
			}
		}
		return $returner;
	}

	/**
	 * Delete an submission tombstone setting.
	 * @param $tombstoneId int
	 * @param $name string
	 * @param $locale string optional
	 */
	function deleteSetting($tombstoneId, $name, $locale = null) {
		$params = array((int) $tombstoneId, $name);
		$sql = 'DELETE FROM data_object_tombstone_settings WHERE tombstone_id = ? AND setting_name = ?';
		if ($locale !== null) {
			$params[] = $locale;
			$sql .= ' AND locale = ?';
		}
		return $this->update($sql, $params);
	}

	/**
	 * Delete all settings for an submission tombstone.
	 * @param $tombstoneId int
	 */
	function deleteSettings($tombstoneId) {
		return $this->update(
			'DELETE FROM data_object_tombstone_settings WHERE tombstone_id = ?', (int) $tombstoneId
		);
	}
}

?>

<?php

/**
 * @file classes/submission/reviewer/CertificadoDAO.inc.php
 *
 *
 * @class CertificadoDAO
 * @ingroup submission
 * @see CertificadoDAO
 *
 * @brief Operations for retrieving and modifying ReviewerSubmission objects.
 */

/*
CREATE TABLE certificado(
	id int PRIMARY KEY AUTO_INCREMENT,
	user_id int,
	review_id int,
	hash_code varchar(255),
	titulo varchar(255),
	nome varchar(255),
	reviewed_at datetime,
	created_at varchar(255)
);
*/
import('classes.submission.reviewer.CertificadoDAO');

class CertificadoDAO extends DAO {

	/**
	 * Constructor.
	 */
	function CertificadoDAO() {
		parent::DAO();
	}

	/**
	 * Get the ID of the last inserted user.
	 * @return int
	 */
	function getInsertCertificadoId() {
		return $this->getInsertId('certificado', 'id');
	}

	function create($user_id, $review_id, $hash_code, $titulo, $nome, $reviewed_at, $created_at) {
		$this->update(
			sprintf('INSERT INTO certificado(user_id, review_id, hash_code, titulo, nome, reviewed_at, created_at) VALUES (%d, %d, "%s", "%s", "%s", "%s", "%s")', $user_id, $review_id, $hash_code, $titulo, $nome, $reviewed_at, $created_at)
		);

		return $this->getInsertCertificadoId();
	}

	function getByUserAndReview($user_id, $review_id) {
		$result =& $this->retrieve(
			'SELECT * FROM certificado WHERE user_id = ? and review_id = ?', array((int)$user_id, (int)$review_id)
		);

		if ($result->RecordCount() != 0) {
			return $result->GetRowAssoc(false);
		}

		return NULL;
	}
}

?>

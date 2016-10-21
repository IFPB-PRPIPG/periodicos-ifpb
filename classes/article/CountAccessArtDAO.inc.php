<?php

/**
 * @file classes/article/CountAccessArtDAO.inc.php
 *
 * @class CountAccessArtDAO
 * @ingroup article
 * @see CountAccessArtDAO
 *
 * @brief Operations for retrieving and modifying Article objects.
 */

//
// CREATE TABLE acessosArtigo (
//   journalId int,
//   articleId int,
//   access int,
//   CONSTRAINT pk_JA primary key(journalId,articleId)
// );

import('classes.article.CountAccessArtDAO');

class CountAccessArtDAO extends DAO {



  //Construtor
  function CountAccessArtDAO() {
    parent::DAO();
  }


  function create ($journalId, $articleId) {
    $acessos = 1;

    $this->update(
      sprintf('INSERT INTO acessosArtigo(journalId, articleId, access ) VALUES (%d, %d, %d)', $journalId, $articleId, $acessos)
    );

  }


  /**
  * Retorna um inteiro com a quantidade de acessos
  *
  * @return int
  **/
  function getAccessById($journalId, $articleId){
    $result =& $this->retrieve(
      'SELECT access FROM acessosArtigo WHERE journalId = ? AND articleId = ?', array((int)$journalId, (int)$articleId)
    );

    if ($result->RecordCount() == 0) {
			$returner = null;
		} else {
			$row = $result->FetchRow();
			$returner = $row['access'];
		}

    $result->Close();
		unset($result);

    return $returner;
  }


  function setUpdateAccess($journalId, $articleId, $newAccess){
    $this->update(
      'UPDATE acessosArtigo SET access = ? WHERE journalId = ? AND articleId = ?', array((int)$newAccess,(int)$journalId, (int)$articleId)
    );
  }
}
?>

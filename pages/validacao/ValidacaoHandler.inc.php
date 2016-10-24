<?php


import('classes.handler.Handler');


class ValidacaoHandler extends Handler {

  function ValidacaoHandler(){
    parent::Handler();
  }

  function validacao($args, &$request) {



    $this->validate();
    $this->setupTemplate();
    $templateMgr =& TemplateManager::getManager();


    $codigoAut = $_GET['codigoAut'];

    $certificadoDAO =& DAORegistry::getDAO('CertificadoDAO');


    if(isset($codigoAut)){
      $certificado = $certificadoDAO->getByHashCode($codigoAut);
      

      var_dump($certificado);
    }



    $templateMgr->display('validacao/validacao.tpl');
  }

}


?>

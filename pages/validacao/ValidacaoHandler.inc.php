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

      if($certificado) {
        $templateMgr->assign('codeCertificado',$certificado["hash_code"]);
        $templateMgr->assign('avaliadorCertificado', $certificado["nome"]);
        $templateMgr->assign('revistaCertificado', $certificado["titulo"]);
        $templateMgr->assign('dataAvaliacaoCertificado', $certificado["reviewed_at"]);
        $templateMgr->assign('certificado',$certificado);
      } else {
        $templateMgr->assign('certificadoInvalido', true);
      }
    }

    $templateMgr->assign('pageValidacao',true);
    $templateMgr->display('portalpadrao/layout.tpl');
  }
}
?>

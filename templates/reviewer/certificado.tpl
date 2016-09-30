<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Certificado de avaliador</title>
  <link rel="stylesheet" type="text/css" href="{$urlSite}/styles/certificado.css">
</head>
<body>
  <img class="ifpb-logo" src="{$urlSite}/img-certificado/ifpb-1.png" alt="logo-ifpb"/>
  <div class="header-content">
    <h3>INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DA PARAÍBA</h3>
  </div>
  <div class="content">
    <h1 class="tittle-declaration">Declaração</h1>
    <p>Declaro, para os devidos fins, que {$nome} exerceu atividade de avaliador(a) ad hoc de 1 (um) artigo científico, a convite do Conselho Editorial da Revista {$titulo}, no dia {$review->getDateCompleted()|date_format:"%d de %B de %Y"}, veículo de divulgação do Instituto Federal de Educação, Ciência e Tecnologia da Paraíba.</p>
    <br>
    <p class="date-declaration">João Pessoa, {$data}.</p>

  </div>
  <div class="signature">
    <div class="img-container">
      <img src="{$urlSite}/img-certificado/assinatura.png"/>
    </div>
    <p>Carlos Danilo Miranda Regis</p>
    <p>Editor Científico</p>
    <br>
  </div>
  {if $displayPageHeaderLogo != NULL}
  <div class="img-container">
    <img class="revista" src="{$urlSite}/public/journals/{$journalId}/{$displayPageHeaderLogo.uploadName|escape:"url"}" {if $displayPageHeaderLogoAltText != ''} alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
  </div>
  {/if}
  <div class="footer-content">
    <img class="fig" src="{$urlSite}/img-certificado/fig1.png" alt="" />
    <p>IFPB/PRPIPG - Av. João da Mata, 256 - Jaguaribe - João Pessoa - Paraíba - CEP: 58.015-020 - Fone: (83) 99184-4721 </p><br>
    <p>Autenticação: {$chave_autenticacao}</p>
  </div>

</body>
</html>

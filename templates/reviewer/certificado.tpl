<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Certificado de avaliador</title>
  <link rel="stylesheet" type="text/css" href="/styles/certificado.css">
</head>
<body>
  <img class="ifpb-logo" src="/img-certificado/ifpb-1.png" alt="logo-ifpb"/>
  <div class="header-content">
    <h3>INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DA PARAÍBA</h3>
    <p>Pró-Reitoria de Pesquisa, Inovação e Pós-Graduação</p>
    <p>Conselho Editorial</p>
  </div>
  <div class="content">
    <h1 class="tittle-declaration">Declaração</h1>
    <p>Declaro, para os devidos fins, que <b>{$nome}</b> exerceu atividade de avaliador ad hoc de 1 (um) artigo científico, a convite do Conselho Editorial da Revista <b>{$titulo}</b>, no dia {$review->getDateCompleted()|date_format:"%d de %B de %Y"}, veículo de divulgação científica e tecnológica do <b>Instituto Federal de Educação, Ciência e Tecnologia da Paraíba.</b></p>
    <br><br>
    <p class="date-declaration">João Pessoa, {$data}.</p>
    <br><br><br>
  </div>
  <div class="signature">
    <img src="/img-certificado/assinatura.png" alt="" />
    <p>Carlos Danilo Miranda Regis</p>
    <p><b>Editor Científico</b></p>
  </div>
  {if $displayPageHeaderLogo != NULL}
  <img class="revista" src="{$urlSite}/public/journals/{$journalId}/{$displayPageHeaderLogo.uploadName|escape:"url"}" {if $displayPageHeaderLogoAltText != ''} alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
  {/if}
  <div class="footer-content">
    <img class="fig" src="/img-certificado/fig1.png" alt="" />
    <p>IFPB/PRPIPG − Av. João da Mata, 256 - Jaguaribe - João Pessoa - Paraíba - CEP: 58.015-020 - Fone: (83) 9184-4721 </p>
  </div>
</body>
</html>

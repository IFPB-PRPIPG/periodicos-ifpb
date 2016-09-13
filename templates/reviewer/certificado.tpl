<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Certificado de avaliador</title>
    <link rel="stylesheet" type="text/css" href="/styles/certificado.css">
  </head>
  <body>
    <img src="/ifpb-1.png" alt="logo-ifpb"/>

    <div class="header-content">
      <h3>INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DA PARAÍBA</h3>
      <p>Pró-Reitoria de Pesquisa, Inovação e Pós-Graduação</p>
      <p>Conselho Editorial</p>
    </div>


    <div class="content">
      <h1 class="tittle">Declaração</h1>
      <p>Declaro, para os devidos fins, que {$nome} exerceu atividade de avaliador(a) ad hoc de 1 (um) artigo científico, a convite do Conselho Editorial da Revista {$titulo}, {$review->getDateCompleted()|date_format:$dateFormatLong}, veículo de divulgação científica e tecnológica do IFPB.    </p>
      <br><br>
      <p>João Pessoa, {$data}.</p>
      <br><br><br>
      <p>Assinatura</p>
    </div>

    <div class="footer-content">
      <p>IFPB/PRPIPG − Av. João da Mata, 256 - Jaguaribe - João Pessoa - Paraíba - CEP: 58.015-020 - Fone: (83) 9184-4721 </p>
    </div>

  </body>
</html>

<!DOCTYPE html>
<html>
<head>
  <title>Portal de Revistas Eletrônicas do IFPB</title>
  <link rel="stylesheet" href="{$baseUrl}/templates/portalpadrao/assets/stylesheet/main.css">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
  {include file="portalpadrao/base/header.tpl"}

  <main class="page-container">
    <!-- Grid -->
    <div class="page-grid">
      <!-- incluindo barra lateral -->
      {include file="portalpadrao/base/aside.tpl"}
      <!-- Parte central da página -->
      <section class="l-page-content">

      {strip}
        {assign var="pageId" value="announcement.view"}
      {/strip}

      <section class="news-inner">
        <!-- <span class="news-action">Publicação de Periódicos</span> -->
        <h2 class="news-title">{$announcement->getLocalizedTitle()|escape}</h2>
        <div class="short-description">
          {$announcement->getLocalizedDescriptionShort()|nl2br}
        </div>
        <p class="news-info">Por Fabrício Vieira - Publicado segunda, 20/05/2015</p>

        <p>{$announcement->getLocalizedDescription()|nl2br}</p>
      </section>


      </section> <!-- fim do page content -->
    </div> <!-- fim do page-grid -->
  </main> <!-- fim do page-grid geral -->
  {include file="portalpadrao/base/footer.tpl"}
</body>
</html>
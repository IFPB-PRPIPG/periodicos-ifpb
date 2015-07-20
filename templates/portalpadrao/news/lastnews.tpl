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

        <section class="lastnews-container">
          <header class="header-container">
            <h2>Últimas notícias</h2>
          </header>


      {iterate from=announcements item=announcement}
          <article class="news">
            <div class="date">
              <span>20/05/2015</span>
              <span>16:00</span>
            </div>
            {if $announcement->getLocalizedDescription() != null}
            <a href="{url page="announcement" op="show" path=$announcement->getId()}">
            {/if}
              <div class="content">
                <span class="news-info">Publicaçãode periódicos</span>
                <h3 class="news-title">{$announcement->getLocalizedTitle()|escape}</h3>
                <p>{$announcement->getLocalizedDescriptionShort()|nl2br}</p>
              </div>
            </a>
          </article>
          {if $announcement->getLocalizedDescription() != null}
          </a>
          {/if}
        {/iterate}  
        </section>    

      </section> <!-- fim do page content -->
    </div> <!-- fim do page-grid -->
  </main> <!-- fim do page-grid geral -->
  {include file="portalpadrao/base/footer.tpl"}
</body>
</html>
{if !$announcements->wasEmpty()}
<!-- Container de nóticias -->
<section class="news-container">
  <!-- Header do container -->
  <header class="news-header">
    <h3 class="header-title">Notícias </h3>
  </header>
  {iterate from=announcements item=announcement}

  {if $announcement->getLocalizedDescription() != null}
  <a href="{url page="announcement" op="show" path=$announcement->getId()}">
  {/if}
  <article class="news">
    <!-- <span class="news-information">Publicação de periódicos</span> -->
    <!-- <img class="news-image" src="http://placehold.it/250x150" alt="Nóticia um"> -->
    <h4 class="news-title">{$announcement->getLocalizedTitle()|escape}</h4>
    <p class="news-description">
      {$announcement->getLocalizedDescriptionShort()|nl2br}
    </p>
  </article>
  {if $announcement->getLocalizedDescription() != null}
  </a>
  {/if}
  {/iterate}


  <footer class="news-footer">
    <a class="more-news" href="index.php/index/announcement/last">Mais notícias</a>
  </footer>

</section> <!-- fim do container das noticias -->
{/if}
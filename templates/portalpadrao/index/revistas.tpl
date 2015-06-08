{if !$journals->wasEmpty()}
<!-- Container de Revistas -->
<section class="magazine-container" id="revistas">
  <!-- Header do container -->
  <header class="magazine-header">
    <h3 class="header-title">Revistas</h3>
  </header>
  {iterate from=journals item=journal}
  <article class="magazine">
    <a class="is-link" href="{url journal=$journal->getPath()}">
      <span class="magazine-information">Extensão</span>
      {if $site->getSetting('showThumbnail')}
        {assign var="displayJournalThumbnail" value=$journal->getLocalizedSetting('journalThumbnail')}
        {if $displayJournalThumbnail && is_array($displayJournalThumbnail)}
          <img class="magazine-image" src="{$journalFilesPath}{$journal->getId()}/{$displayJournalThumbnail.uploadName|escape:"url"}" alt="Nóticia um">
        {/if}
      {/if}
      {if $site->getSetting('showTitle')}
        <h4 class="magazine-title">{$journal->getLocalizedTitle()|escape}</h4>
      {/if}
      {if $site->getSetting('showDescription')}
        {if $journal->getLocalizedDescription()}
        <p class="magazine-description">{$journal->getLocalizedDescription()|nl2br|escape}</p>
        {/if}
      {/if}
    </a>
  </article>
  {/iterate}
  <footer class="magazine-footer"></footer>
</section> <!-- fim do container das revistas -->
{/if}
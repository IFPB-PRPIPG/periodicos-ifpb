{if !$journals->wasEmpty()}

<!-- Caixa de revistas -->
<div class="content-box mid-8">
  <div id="revistas" class="header-box alert">Periódicos</div>
  {iterate from=journals item=journal}
  <div class="xs-1 mid-6">
    <a href="{url journal=$journal->getPath()}">
      {if $site->getSetting('showThumbnail')}
        {assign var="displayJournalThumbnail" value=$journal->getLocalizedSetting('journalThumbnail')}
        {if $displayJournalThumbnail && is_array($displayJournalThumbnail)}
          <img class="image-responsible" src="{$journalFilesPath}{$journal->getId()}/{$displayJournalThumbnail.uploadName|escape:"url"}">
        {/if}
      {/if}
      {if $site->getSetting('showTitle')}
      <h3>{$journal->getLocalizedTitle()|escape}</h3>
      {/if}
      {if $site->getSetting('showDescription')}
        {if $journal->getLocalizedDescription()}
        <p>{$journal->getLocalizedDescription()|strip_tags|nl2br|truncate:150}</p>
        {/if}
      {/if}
    </a>
  </div>
  {/iterate}
  <div class="footer-box alert"></div>
</div>

{/if}

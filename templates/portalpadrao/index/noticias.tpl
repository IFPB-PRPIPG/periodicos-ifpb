{if !$announcements->wasEmpty()}
<!-- Caixa de nóticias -->
<div class="content-box">
  <div class="header-box">Notícias</div>
    <div>
      {iterate from=announcements item=announcement}
        <div class="xs-1 mid-4">
          {if $announcement->getTypeId()}
            <small class="small-type">{$announcement->getAnnouncementTypeName()|escape}</small>
          {/if}
          {if $announcement->getLocalizedDescription() != null}
          <a href="{url page="announcement" op="show" path=$announcement->getId()}">
          {/if}
            <h3>{$announcement->getLocalizedTitle()|escape}</h3>
            <p>{$announcement->getLocalizedDescriptionShort()|nl2br}</p>
          {if $announcement->getLocalizedDescription() != null}
          </a>
          {/if}
        </div>
      {/iterate}
    </div>
  <div class="footer-box">
    <div class="footer-content">
      <a href="announcement/last">Mais notícias</a>
    </div>
  </div>
</div>
{/if}

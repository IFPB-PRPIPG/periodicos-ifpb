<div class="text-box">
  <h2 class="header-title large-size border-title-light">Últimas notícias</h2>
  <ul class="date-list mid-8">
    {iterate from=announcements item=announcement}
    <!-- Entrada dos itens -->
    <li class="date-list-item">
      <div class="date mid-3">
        <span class="year">{$announcement->getDatePosted()}</span>
      </div>
      <div class="text mid-6">
        {if $announcement->getLocalizedDescription() != null}
          <a href="{url page="announcement" op="show" path=$announcement->getId()}">
        {/if}
        {if $announcement->getTypeId()}
          <small class="small-type">{$announcement->getAnnouncementTypeName()|escape}</small>
        {/if}        
        <h4 class="title">{$announcement->getLocalizedTitle()|escape}</h4>
        <p>{$announcement->getLocalizedDescriptionShort()|nl2br}</p>
        {if $announcement->getLocalizedDescription() != null}
          </a>
        {/if}
      </div>
    </li>
    {/iterate}
  </ul>
</div>
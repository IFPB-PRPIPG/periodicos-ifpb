{if $enableAnnouncementsHomepage}
<div class="content-box">
  <div class="header-box">{translate key="announcement.announcementsHome"}</div>
  {counter start=1 skip=1 assign="count"}
    <div>
      {iterate from=announcements item=announcement}
        {if !$numAnnouncementsHomepage || $count <= $numAnnouncementsHomepage}
        <div class="xs-1 mid-4">
          <!-- Se houver link -->
          {if $announcement->getLocalizedDescription() != null}
            <a href="{url page="announcement" op="view" path=$announcement->getId()}">
          {/if}
            {if $announcement->getTypeId()}  
              <h3>{$announcement->getAnnouncementTypeName()|escape}: {$announcement->getLocalizedTitle()|escape}</h3>
            {else}
              <h3>{$announcement->getLocalizedTitle()|escape}</h3>
            {/if}
            <p>{$announcement->getLocalizedDescriptionShort()|nl2br}</p>
          {if $announcement->getLocalizedDescription() != null}
            <span>{translate key="announcement.viewLink"}</span>
            </a>
          {/if}
        </div>
        {/if}
      {/iterate}
    </div>
  <div class="footer-box">
    <div class="footer-content">
      <a href="{url page="announcement"}">{translate key="announcement.moreAnnouncements"}</a>
    </div>
  </div>
</div>
{/if}

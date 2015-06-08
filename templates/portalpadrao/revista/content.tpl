  <main class="page-container">
    <!-- Grid -->
    <div class="page-grid">
      <!-- incluindo barra lateral -->
      {include file="portalpadrao/base/aside.tpl"}


      
      <!-- Parte central da página -->
      <section class="l-page-content">

{if $journalDescription}
  <div id="journalDescription">{$journalDescription}</div>
{/if}

{call_hook name="Templates::Index::journal"}

{if $homepageImage}
<br />
<div id="homepageImage"><img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" width="{$homepageImage.width|escape}" height="{$homepageImage.height|escape}" {if $homepageImageAltText != ''}alt="{$homepageImageAltText|escape}"{else}alt="{translate key="common.journalHomepageImage.altText"}"{/if} /></div>
{/if}

{if $additionalHomeContent}
<br />
<div id="additionalHomeContent">{$additionalHomeContent}</div>
{/if}

{if $enableAnnouncementsHomepage}
  {* Display announcements *}
  <div id="announcementsHome">
    <h3>{translate key="announcement.announcementsHome"}</h3>
    {include file="announcement/list.tpl"}  
    <table class="announcementsMore">
      <tr>
        <td><a href="{url page="announcement"}">{translate key="announcement.moreAnnouncements"}</a></td>
      </tr>
    </table>
  </div>
{/if}

{if $issue && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
  {* Display the table of contents or cover page of the current issue. *}
  <br />
  <h3>{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</h3>
  {include file="issue/view.tpl"}
{/if}

      </section> <!-- fim do page content -->
    </div> <!-- fim do page-grid -->
  </main> <!-- fim do page-grid geral -->
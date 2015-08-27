<a href="{url journal="index" page="index"}">
    <img src="{$baseUrl}/templates/portalpadrao/assets/images/banner_periodicos_site.png" alt="" class="image-responsible banner-content">
</a>

{if $issue}
  <div class="content-box">
    <div class="header-box">Revista</div>
    <a href="{url page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}">
    {if $coverPagePath}
      <div class="xs-1 mid-6">
        <img class="image-responsible" src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/>
      </div>
    {/if}
    <div id="issueDescription">{$issue->getLocalizedDescription()|nl2br}</div>
    </a>
    <div class="footer-box">
      <div class="footer-content">
         <a href="{url page="issue" op="archive"}">{translate key="navigation.archives"}</a>
      </div>
    </div>
  </div>
{/if}
<!-- Caixa de nóticias -->
{include file="portalpadrao/revista/index/noticias.tpl"}

{strip}
  {assign var="pageId" value="announcement.view"}
{/strip}
<div class="text-box border-box">
  <h2 class="header-title large-size">{$announcement->getLocalizedTitle()|escape}</h2>
  <h4 class="header-subtitle">{$announcement->getLocalizedDescriptionShort()|nl2br}</h4>
 <p>{$announcement->getLocalizedDescription()|nl2br}</p>
</div>
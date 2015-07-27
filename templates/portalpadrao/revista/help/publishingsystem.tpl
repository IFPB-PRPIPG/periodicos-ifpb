{strip}
{assign var="pageTitle" value="about.aboutThisPublishingSystem"}
{/strip}

{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}
<div class="text-box">
	<h2 class="header-title large-size border-box">{translate key="about.authorGuidelines"}</h2>
	{$currentJournal->getLocalizedSetting('authorGuidelines')|nl2br}
</div>
{/if}

<div class="text-box">
	<h2 class="header-title large-size border-box">Sistema de Publicação</h2>
	<p>
		{if $currentJournal}
		{translate key="about.aboutOJSJournal" ojsVersion=$ojsVersion}
		{else}
		{translate key="about.aboutOJSSite" ojsVersion=$ojsVersion}
		{/if}
	</p>
	<img src="{$baseUrl}/{$edProcessFile}" style="border: 0;" alt="{translate key="about.aboutThisPublishingSystem.altText"}" />
</div>

{if $currentJournal->getLocalizedSetting('privacyStatement') != ''}
<div class="text-box" id="privacyStatement">
	<h3 class="header-title large-size border-box">
		{translate key="about.privacyStatement"}
	</h3>
	<p>{$currentJournal->getLocalizedSetting('privacyStatement')|nl2br}</p>
</div>
{/if}

{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}
<div class="text-box" id="copyrightNotice">
	<h3 class="header-title large-size border-box">{translate key="about.copyrightNotice"}</h3>
	<p>{$currentJournal->getLocalizedSetting('copyrightNotice')|nl2br}</p>
</div>
{/if}

{include file="common/footer.tpl"}


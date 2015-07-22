{strip}
{assign var="pageTitle" value="about.aboutThisPublishingSystem"}
{/strip}

<div class="text-box">
	{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}
	<h2 class="header-title large-size border-title-light">{translate key="about.authorGuidelines"}</h2>
	{$currentJournal->getLocalizedSetting('authorGuidelines')|nl2br}
	{/if}
</div>

<div class="text-box">
	<h2 class="header-title large-size border-title-light">Sistema de Publicação</h2>
	<p>
		{if $currentJournal}
		{translate key="about.aboutOJSJournal" ojsVersion=$ojsVersion}
		{else}
		{translate key="about.aboutOJSSite" ojsVersion=$ojsVersion}
		{/if}
	</p>
	<img src="{$baseUrl}/{$edProcessFile}" style="border: 0;" alt="{translate key="about.aboutThisPublishingSystem.altText"}" />
</div>

{include file="common/footer.tpl"}


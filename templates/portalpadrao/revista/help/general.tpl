<div class="text-box" id="authorGuidelines">
	<a href="{url journal="index" page="index"}">
      <img src="{$baseUrl}/templates/portalpadrao/assets/images/banner_periodicos_site.png" alt="" class="image-responsible banner-content">
    </a>
	{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}
	<h2 class="header-title mid-size border-title-light">{translate key="about.authorGuidelines"}</h2>
	{$currentJournal->getLocalizedSetting('authorGuidelines')|nl2br}
	{/if}
</div>


{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}
<div class="text-box" id="copyrightNotice">
	<h3 class="header-title mid-size border-title-light">{translate key="about.copyrightNotice"}</h3>
	<p>{$currentJournal->getLocalizedSetting('copyrightNotice')|nl2br}</p>
</div>
{/if}

{if $currentJournal->getLocalizedSetting('privacyStatement') != ''}
<div class="text-box" id="privacyStatement">	

	<h3 class="header-title mid-size border-title-light">
		{translate key="about.privacyStatement"}
	</h3>
	<p>{$currentJournal->getLocalizedSetting('privacyStatement')|nl2br}</p>
</div>
{/if}

{if $authorFees}

<div class="text-box">
	<h3 class="header-title mid-size border-title-light">{translate key="manager.payment.authorFees"}</h3>
		<p>{translate key="about.authorFeesMessage"}</p>
		{if $currentJournal->getSetting('submissionFeeEnabled')}
			<p>{$currentJournal->getLocalizedSetting('submissionFeeName')|escape}: {$currentJournal->getSetting('submissionFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
			{$currentJournal->getLocalizedSetting('submissionFeeDescription')|nl2br}<p>
		{/if}
		{if $currentJournal->getSetting('fastTrackFeeEnabled')}
			<p>{$currentJournal->getLocalizedSetting('fastTrackFeeName')|escape}: {$currentJournal->getSetting('fastTrackFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
			{$currentJournal->getLocalizedSetting('fastTrackFeeDescription')|nl2br}<p>
		{/if}
		{if $currentJournal->getSetting('publicationFeeEnabled')}
			<p>{$currentJournal->getLocalizedSetting('publicationFeeName')|escape}: {$currentJournal->getSetting('publicationFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
			{$currentJournal->getLocalizedSetting('publicationFeeDescription')|nl2br}<p>
		{/if}
		{if $currentJournal->getLocalizedSetting('waiverPolicy') != ''}
			<p>{$currentJournal->getLocalizedSetting('waiverPolicy')|nl2br}</p>
		{/if}
</div>
{/if}

<div class="text-box">
  <a href="{url journal="index" page="index"}">
      <img src="{$baseUrl}/templates/portalpadrao/assets/images/banner_periodicos_site.png" alt="" class="image-responsible banner-content">
    </a>
	<h2 class="header-title large-size">{$journalTitle}</h2>
	<!-- Section Utilizada para descrição -->
	<div class="text-box-section border-box">
		<p>{$journalDescription}</p>
	</div>

<div class="text-box-section border-box">
		<h3 class="text-box-title large-size border-title-light">Equipe Editorial</h3>
    <!-- editores -->

      {foreach from=$groups item=group}
      <div id="group">
        <h4>{$group->getLocalizedTitle()}</h4>
        {assign var=groupId value=$group->getId()}
        {assign var=members value=$teamInfo[$groupId]}

        <ol class="editorialTeam">
          {foreach from=$members item=member}
            {assign var=user value=$member->getUser()}
            <div class="member"><a href="javascript:openRTWindow('{url op="editorialTeamBio" path=$user->getId()}')">{$user->getFullName()|escape}</a>{if $user->getLocalizedAffiliation()}, {$user->getLocalizedAffiliation()|escape}{/if}{if $user->getCountry()}{assign var=countryCode value=$user->getCountry()}{assign var=country value=$countries.$countryCode}, {$country|escape}{/if}</div>
          {/foreach}{* $members *}
        </ol>
      </div>
      {/foreach}{* $groups *}


    {if count($editors) > 0}
  		<ul class="text-list">
  			{if count($editors) == 1}
  				<li class="text-list-item-simple-header">
            {translate key="user.role.editor"}
          </li>
  			{else}
  				<li class="text-list-item-simple-header">
            {translate key="user.role.editors"}
          </li>			
  			{/if}
        {foreach from=$editors item=editor}
  			<li class="text-list-item"><a href="">{$editor->getFullName()|escape}</a>
        
        {$affiliation[$formLocale]|escape}
        
        </li>
        {/foreach}
  		</ul>
		{/if}

    <!-- editores de section-->
    {if count($sectionEditors) > 0}
      <ul class="text-list">
        {if count($sectionEditors) == 1}
          <li class="text-list-item-simple-header">
            {translate key="user.role.sectionEditor"}
          </li>
        {else}
          <li class="text-list-item-simple-header">
            {translate key="user.role.sectionEditors"}
          </li>     
        {/if}
        {foreach from=$sectionEditors item=sectionEditor}
        <li class="text-list-item">{$sectionEditors->getFullName()|escape}</li>
        {/foreach}
      </ul>
    {/if}
    
    <!-- editores de de layout (?) -->
    {if count($layoutEditors) > 0}
      <ul class="text-list">
        {if count($layoutEditors) == 1}
          <li class="text-list-item-simple-header">
            {translate key="user.role.layoutEditor"}
          </li>
        {else}
          <li class="text-list-item-simple-header">
            {translate key="user.role.layoutEditors"}
          </li>     
        {/if}
        {foreach from=$layoutEditors item=layoutEditor}
        <li class="text-list-item">{$layoutEditors->getFullName()|escape}</li>
        {/foreach}
      </ul>
    {/if}

    <!-- editores de cópia -->
    {if count($copyEditors) > 0}
      <ul class="text-list">
        {if count($copyEditors) == 1}
          <li class="text-list-item-simple-header">
            {translate key="user.role.copyEditor"}
          </li>
        {else}
          <li class="text-list-item-simple-header">
            {translate key="user.role.copyEditors"}
          </li>     
        {/if}
        {foreach from=$copyEditors item=copyEditor}
        <li class="text-list-item">{$copyEditors->getFullName()|escape}</li>
        {/foreach}
      </ul>
    {/if}

    <!-- Revisores -->
    {if count($proofreaders) > 0}
      <ul class="text-list">
        {if count($proofreaders) == 1}
          <li class="text-list-item-simple-header">
            {translate key="user.role.proofreader"}
          </li>
        {else}
          <li class="text-list-item-simple-header">
            {translate key="user.role.proofreaders"}
          </li>     
        {/if}
        {foreach from=$proofreaders item=proofreader}
        <li class="text-list-item">{$proofreaders->getFullName()|escape}</li>
        {/foreach}
      </ul>
    {/if}

	</div>
{if not ($currentJournal->getLocalizedSetting('contactTitle') == '' && $currentJournal->getLocalizedSetting('contactAffiliation') == '' && $currentJournal->getLocalizedSetting('contactMailingAddress') == '' && empty($journalSettings.contactPhone) && empty($journalSettings.contactFax) && empty($journalSettings.contactEmail))}
	<!-- Mais uma caixa -->
	<div class="text-box-section border-box">
		<h3 class="text-box-title large-size border-title-light">Contato</h3>
    {if !empty($journalSettings.mailingAddress)}
      <ul class="text-list">
        <li class="text-list-item-simple-header">{translate key="common.mailingAddress"}</li>
        <li class="text-list-item">{$journalSettings.mailingAddress|nl2br}</li>
      </ul>
    {/if}
		<ul class="text-list">
			<li class="text-list-item-simple-header">
        {translate key="about.contact.principalContact"}
      </li>
      <!-- Nome -->
      {if !empty($journalSettings.contactName)}
			<li class="text-list-item">{$journalSettings.contactName|escape}</li>
      {/if}
      <!-- titulação -->
      {assign var=s value=$currentJournal->getLocalizedSetting('contactTitle')}
      {if $s}
			 <li class="text-list-item">{$s|escape}</li>
      {/if}
      <!-- Instituição -->
      {assign var=s value=$currentJournal->getLocalizedSetting('contactAffiliation')}
      {if $s}
			 <li class="text-list-item">{$s|escape}</li>
      {/if}

      <!-- Endereço postal -->
      {assign var=s value=$currentJournal->getLocalizedSetting('contactMailingAddress')}
      {if $s}
       <li class="text-list-item">{$s|escape}</li>
      {/if}
      <!-- Telefone -->
      {if !empty($journalSettings.contactPhone)}
       <li class="text-list-item">{translate key="about.contact.phone"}: {$journalSettings.contactPhone|escape}</li>
      {/if}
      <!-- Fax -->
      {if !empty($journalSettings.contactFax)}
      <li class="text-list-item">
        {translate key="about.contact.fax"}: {$journalSettings.contactFax|escape}
      </li>
      {/if}
      <!-- Email -->
      {if !empty($journalSettings.contactEmail)}
        <li class="text-list-item">
        {translate key="about.contact.email"}: {mailto address=$journalSettings.contactEmail|escape encode="hex"}</li>
      {/if}
		</ul>
	</div>
{/if}
</div>
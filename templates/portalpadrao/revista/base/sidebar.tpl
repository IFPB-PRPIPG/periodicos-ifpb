<sidebar class="page-sidebar left">
  <div class="sidebar-top">
    <a href="http://www.ifpb.edu.br/" target="_blank">
      <img src="{$baseUrl}/templates/portalpadrao/assets/images/ifpb.png" alt="">
    </a>
  </div>
  <!-- Caixa de conteúdo -->
  {if $currentJournal}
  <ul class="box">
    <li class="item header">Sobre o periódico</li>
    <li class="item i-home">
      <a href="{url page="index"}">{translate key="navigation.home"}</a>
    </li>
    <li class="item i-editions">
      <a href="{url page="issue" op="archive"}">{translate key="issue.issues"}</a>
    </li>
    <li class="item i-search">
      <a href="{url page="search"}">{translate key="navigation.search"}</a>
    </li>
  </ul>
    <ul class="box">
      <li class="item header">Submissão</li>
      <li class="item">
        <a href="{url journal=$journalPath page="author" op="submit"}">Submissão online</a>
      </li>
      {if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}
      <li class="item"><a href="{url page="about" op="submissions" anchor="authorGuidelines"}">{translate key="about.authorGuidelines"}</a>
      </li>{/if}

      {if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}
        <li class="item"><a href="{url page="about" op="submissions" anchor="copyrightNotice"}">{translate key="about.copyrightNotice"}</a>
        </li>
      {/if}

      {if $currentJournal->getLocalizedSetting('privacyStatement') != ''}
        <li class="item"><a href="{url page="about" op="submissions" anchor="privacyStatement"}">{translate key="about.privacyStatement"}</a>
        </li>
      {/if}

      {if $authorFees}
        <li class="item"><a href="{url page="about" op="submissions" anchor="authorFees"}">{translate key="about.authorFees"}</a>
        </li>
      {/if}

      <li class="item"><a href="{url page="about" op="aboutThisPublishingSystem"}">{translate key="about.aboutThisPublishingSystem"}</a></li>
    </ul>
  {/if}

  <ul class="box">
    <li class="item header">Sobre</li>
    <li class="item">
      <a href="{url page="about"}">{translate key="navigation.about"}</a>
    </li>
    <li class="item"><a href="{url page="about"}">{translate key="about.editorialTeam"}</a></li>    
    {if not (empty($journalSettings.mailingAddress) && empty($journalSettings.contactName) && empty($journalSettings.contactAffiliation) && empty($journalSettings.contactMailingAddress) && empty($journalSettings.contactPhone) && empty($journalSettings.contactFax) && empty($journalSettings.contactEmail) && empty($journalSettings.supportName) && empty($journalSettings.supportPhone) && empty($journalSettings.supportEmail))}
      <li class="item"><a href="{url page="about"}">{translate key="about.contact"}</a></li>
    {/if}
  </ul>
{if $isUserLoggedIn}
  <!-- Menu de login-->
  <ul class="box">
    <li class="item header">Usuário</li>
    {if $hasOtherJournals}
      <li class="item">
        <a href="{url journal="index" page="user"}">{translate key="navigation.userHome"}</a>
      </li>
    {/if}
    <li class="item">
      <a href="{url page="user" op="profile"}">{translate key="plugins.block.user.myProfile"}</a>
    </li>
    <li class="item">
      <a href="{url page="login" op="signOut"}">{translate key="plugins.block.user.logout"}</a>
    </li>
  </ul>
  <!-- Fim Menu de login-->
{/if}
</sidebar>

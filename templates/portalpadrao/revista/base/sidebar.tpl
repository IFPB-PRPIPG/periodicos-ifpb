<sidebar class="page-sidebar left">
  <div class="sidebar-top">
    <img src="{$baseUrl}/templates/portalpadrao/assets/images/ifpb.png" alt="">
  </div>
  <!-- Caixa de conteúdo -->
  <ul class="box">
    <li class="item header">Submissão</li>
    <li class="item"><a href="#">Submissão online</a></li>
    <li class="item"><a href="#">Submissão online</a></li>
    <li class="item"><a href="#">Submissão online</a></li>
    <li class="item"><a href="#">Submissão online</a></li>
  </ul>
  <ul class="box">
    <li class="item header">Sobre</li>
    <li class="item">
      <a href="{url page="about"}">{translate key="navigation.about"}</a>
    </li>
    <li class="item"><a href="{url page="about"}">{translate key="about.editorialTeam"}</a></li>
    <li class="item"><a href="{url page="about" op="aboutThisPublishingSystem"}">{translate key="about.aboutThisPublishingSystem"}</a></li>
    
    {if not (empty($journalSettings.mailingAddress) && empty($journalSettings.contactName) && empty($journalSettings.contactAffiliation) && empty($journalSettings.contactMailingAddress) && empty($journalSettings.contactPhone) && empty($journalSettings.contactFax) && empty($journalSettings.contactEmail) && empty($journalSettings.supportName) && empty($journalSettings.supportPhone) && empty($journalSettings.supportEmail))}
      <li class="item"><a href="{url page="about" op="contact"}">{translate key="about.contact"}</a></li>
    {/if}
  </ul>
</sidebar>
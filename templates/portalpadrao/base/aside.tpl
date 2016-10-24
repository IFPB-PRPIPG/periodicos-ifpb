<!-- sidebar -->
<sidebar id="menu" class="page-sidebar left">
  <div class="sidebar-top">
    <a href="http://www.ifpb.edu.br/" target="_blank">
      <img src="{$baseUrl}/templates/portalpadrao/assets/images/ifpb.png" alt="Portal IFPB">
    </a>
  </div>
  <!-- Caixa de conteúdo -->
  {if $revistas}
    <ul class="box">
      <li class="item header">Periódicos</li>
      {iterate from=revistas item=revista}
        <li class="item">
          <a href="{url journal=$revista->getPath()}">{$revista->getLocalizedTitle()|escape}</a>
        </li>
      {/iterate}
    </ul>
  {/if}

  <!-- Portal -->
  <ul class="box">
    <li class="item header">Sobre o Portal</li>
    <li class="item">
      <a href="/public/Portaria de Criação do Portal.pdf" target="_blank">Portaria de Criação</a>
    </li>
    <li class="item">
      <a href="/public/Diretrizes Portal Periódicos IFPB.pdf" target="_blank">Diretrizes do Portal</a>
    </li>
    <li class="item">
      <a href="/public/Diretrizes Portal Periódicos IFPB - APẼNDICES.pdf" target="_blank">Normas</a>
    </li>
  </ul>

  <!-- Usuário -->
  {if $isUserLoggedIn}
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
  {/if}

  <!-- Links uteis -->
  <ul class="box">
    <li class="item header">Links Úteis</li>
    <li class="item">
      <a href="http://www.ifpb.edu.br">Portal IFPB</a>
    </li>
    <li class="item">
      <a href="http://repositorio.ifpb.edu.br">Repositório Digital</a>
    </li>
    <li class="item">
      <a href="http://periodicos.capes.gov.br">Portal periódicos Capes</a>
    </li>
    <li class="item">
      <a href="#">Web Qualis</a>
    </li>
    <li class="item">
      <a href="index.php/index/validacao/validacao">Validação de certificado</a>
    </li>
  </ul>
</sidebar>

<!-- sidebar -->
<sidebar id="menu" class="page-sidebar left">
  <div class="sidebar-top">
    <img src="{$baseUrl}/templates/portalpadrao/assets/images/ifpb.png" alt="Portal IFPB">
  </div>
  <!-- Caixa de conteúdo -->
  {if $revistas}
    <ul class="box">
      <li class="item header">Revistas</li>
      {iterate from=revistas item=revista}
        <li class="item">
          <a href="{url journal=$revista->getPath()}">{$revista->getLocalizedTitle()|escape}</a>
        </li>
      {/iterate}
    </ul>
  {/if}

  <!-- Usuário -->
  {if $isUserLoggedIn}
  <ul class="box">
    <li class="item header">Usuário</li>
    {if $hasOtherJournals}
      <li class="item">
        <a href="{url journal="index" page="user"}">{translate key="plugins.block.user.myJournals"}</a>
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

  <!-- Portal -->
  <ul class="box">
    <li class="item header">Política do Portal</li>
    <li class="item">
      <a href="/ojs/index.php/praxis/pages/view/portaria-de-criacao">Portaria de Criação do Portal</a>
    </li>
    <li class="item">
      <a href="#">Diretrizes do Portal</a>
    </li>
    <li class="item">
      <a href="#">Normas</a>
    </li>
  </ul>

  <!-- Links uteis -->
  <ul class="box">
    <li class="item header">Links Úteis</li>
    <li class="item">
      <a href="http://www.ifpb.edu.br">Portal IPFB</a>
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
  </ul>
</sidebar>
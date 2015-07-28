      <!-- Barra Lateral (esqueda) -->
      <aside class="l-page-left-bar" id="menu">
        <!-- Breadcrumb da localização -->
        <p class="breadcrumb">Você está aqui: <a class="location" href="#">Página inicial</a></p>
        <!-- Identidade visual -->
        <img class="logo-image" src="{$baseUrl}/templates/portalpadrao/assets/images/logo.png" alt="IFPB Logo">

        <!-- Menu da barra -->
        <ul class="menu-bar">
          <li class="header">Revistas</li>
            {iterate from=revistas item=revista}
            <li>
              <a class="item" href="{url journal=$revista->getPath()}">{$revista->getLocalizedTitle()|escape}</a>
            </li>
            {/iterate}
        </ul>

        {if $isUserLoggedIn}
          <!-- Menu de login-->
          <ul class="menu-bar">
            <li class="header">Usuário</li>
            {if $hasOtherJournals}
              <li>
                <a class="item" href="{url journal="index" page="user"}">{translate key="plugins.block.user.myJournals"}</a>
              </li>
            {/if}
            <li>
              <a class="item" href="{url page="user" op="profile"}">{translate key="plugins.block.user.myProfile"}</a>
            </li>
            <li>
              <a class="item" href="{url page="login" op="signOut"}">{translate key="plugins.block.user.logout"}</a>
            </li>
          </ul>
          <!-- Fim Menu de login-->
        {/if}


        <!-- Menu da barra -->
        <ul class="menu-bar">
          <li class="header">Política do Portal</li>
          <li>
            <a class="item" href="/ojs/index.php/praxis/pages/view/portaria-de-criacao">Portaria de Criação do Portal</a>
          </li>
          <li>
            <a class="item" href="#">Diretrizes do Portal</a>
          </li>
          <li>
            <a class="item" href="#">Normas</a>
          </li>
        </ul>

        <!-- Menu da barra -->
        <ul class="menu-bar">
          <li class="header">Links Úteis</li>
          <li>
            <a class="item" href="http://www.ifpb.edu.br">Portal IPFB</a>
          </li>
          <li>
            <a class="item" href="http://repositorio.ifpb.edu.br">Repositório Digital</a>
          </li>
          <li>
            <a class="item" href="http://periodicos.capes.gov.br">Portal periódicos Capes</a>
          </li>
          <li>
            <a class="item" href="#">Web Qualis</a>
          </li>
        </ul>
      </aside>
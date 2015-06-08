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
          <li class="header">Assuntos</li>
          <li>
            <a class="item" href="#">Regimento</a>
          </li>
          <li>
            <a class="item" href="#">Saiba como Publicar</a>
          </li>
          <li>
            <a class="item" href="#">Inscrição de Artigo</a>
          </li>
        </ul>

        <!-- Menu da barra -->
        <ul class="menu-bar">
          <li class="header">Centrais de conteúdo</li>
          <li>
            <a class="item video" href="#">Vídeos</a>
          </li>
          <li>
            <a class="item audio" href="#">Áudio</a>
          </li>
          <li>
            <a class="item infographics" href="#">Infográficos</a>
          </li>
          <li>
            <a class="item publications" href="#">Publicações</a>
          </li>
          <li>
            <a class="item apps" href="#">Aplicativos</a>
          </li>
        </ul>
      </aside>
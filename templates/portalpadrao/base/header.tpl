    <!-- header -->
    <div class="government-bar">
      <div class="content-container">
        <a href="http://brasil.gov.br/" class="brazil-flag mid-1">Brasil</a>
        <a href="http://brasil.gov.br/barra#acesso-informacao" class="mid-7">Acesso à informação</a>
        <a href="http://brasil.gov.br/barra#participe" class="mid-1">Participe</a>
        <a href="http://www.servicos.gov.br/?pk_campaign=barrabrasil" class="mid-1">Serviços</a>
        <a href="http://www.planalto.gov.br/legislacao" class="mid-1">Legislação</a>
        <a href="http://brasil.gov.br/barra#orgaos-atuacao-canais" class="mid-1">Canais</a>

      </div>
    </div>
    <header class="page-header portal">
      <div class="content-container">

        <!-- barra de idiomas -->
        <div class="accessibility-bar">
          <ul class="link-list first">
          {if $portalIndex}
            <li class="item first"><a href="#revistas">Ir para revistas</a></li>
          {/if}
            <li class="item"><a href="#menu">Ir para menu</a></li>
            <li class="item"><a href="#busca">Ir para busca</a></li>
            <li class="item"><a href="#rodape">Ir para rodapé</a></li>
          </ul>
        </div>

        <!-- barra de idiomas -->
        <div class="language-bar">
          <ul class="link-list">
            <li class="item"><a href="#">Acessibilidade</a></li>
            <li class="item"><a href="#">Contraste</a></li>
            <li class="item"><a href="#">Mapa do site</a></li>
          </ul>
          <ul class="link-list">
            <li class="item"><a href="#">English</a></li>
            <li class="item"><a href="#">Español</a></li>
          </ul>
        </div>
        
        <!-- page logo -->
        <div class="center-content">
          <div class="header-logo">
            <span>Portal de</span>
            <h1 class="page-name">Periódicos</h1>
            <span>Instituto Federal da Paraíba</span>
          </div>
          <form class="form-control form-search-header" action="#">
            <input id="busca" class="search-input-header" type="text">
            <button class="search-button"></button>
          </form>
        </div>

        <!-- social media -->
        <div class="media-container">
          <a href="https://www.flickr.com/search/?text=ifpb" target="_blank"><div class="social flikr"></div></a>
          <a href="https://www.youtube.com/user/TVIFPB" target="_blank"><div class="social youtube"></div></a>
          <a href="https://twitter.com/ifpboficial" target="_blank"><div class="social twitter"></div></a>
          <a href="https://pt-br.facebook.com/pages/IFPB-Oficial/261855270518349" target="_blank"><div class="social facebook"></div></a>
        </div>
      </div>

      <!-- actions-bar login/logout-->
      <div class="actions-bar">
        <div class="content-container">
          {if $isUserLoggedIn}
          {translate key="plugins.block.user.loggedInAs"} <strong>{$loggedInUsername|escape}</strong>
          {else}
          <span>Acesso do usuário</span>
          <form class="form-control form-login" action="{$userBlockLoginUrl}" method="post">
            <label for="login">{translate key="user.username"}
              <input id="login" type="text" name="username">
            </label>
            <label for="password">{translate key="user.password"}
              <input id="password" type="password" name="password" value="{$password|escape}">
            </label>
            <button class="btn btn-submit">Acessar</button>
          </form>
          {/if}
        </div>
      </div>
    </header> <!-- fim do header -->
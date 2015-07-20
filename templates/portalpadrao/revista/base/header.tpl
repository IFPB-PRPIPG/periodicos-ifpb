    <!-- header -->
    <header class="page-header magazine">
      <div class="content-container">
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
            {if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
            <img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogoAltText != ''}alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
            {/if}
          </div>
        </div>

        <!-- social media -->
        <div class="media-container">
          <div class="social flikr"></div>
          <div class="social youtube"></div>
          <div class="social twitter"></div>
          <div class="social facebook"></div>
        </div>
      </div>

      <!-- actions-bar login/logout-->
      <div class="actions-bar">
        <div class="content-container">
          <span>Acesso do usuário</span>
          <form class="form-control form-login" action="#">
            <label for="login">Login
              <input id="login" type="text">
            </label>
            <label for="password">Senha
              <input id="password" type="password">
            </label>
            <button class="btn btn-submit">Acessar</button>
          </form>
        </div>
      </div>
    </header> <!-- fim do header -->
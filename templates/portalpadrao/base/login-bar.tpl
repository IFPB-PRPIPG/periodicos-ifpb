  {if $isUserLoggedIn}
    <div class="page-signin">
      <div class="page-grid">
        <p>
          {translate key="plugins.block.user.loggedInAs"} <strong>{$loggedInUsername|escape}</strong>
        </p>
      </div>
    </div>
  {else}
    <div class="page-signin">
      <div class="page-grid">
        <form action="{$userBlockLoginUrl}" method="post" title="Faça o login">
          <span>Acesso do usuário</span>
          <label for="user-login">{translate key="user.username"}</label>
          <input type="text" id="user-login" name="username">
          <label for="user-password">{translate key="user.password"}</label>
          <input type="password" id="user-password" name="password" value="{$password|escape}">
          <button class="btn-signin">Acessar</button>
        </form>
      </div>
    </div>
  {/if}
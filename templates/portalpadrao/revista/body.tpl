{include file="portalpadrao/revista/base/breadcrumbs.tpl"}
    <div class="page-content">
      <div class="content-container">
        
        <!-- sidebar -->
		    {include file="portalpadrao/revista/base/sidebar.tpl"}
		
        <!-- Meio -->
        <main class="main-content">

          {* Página inicial *}
          {if $journalIndex}
            {include file="portalpadrao/revista/index/index.tpl"}
          {/if} <!-- fecha a index -->
          
          {* Página de SOBRE *}
          {if $journalAbout}
            {include file="portalpadrao/revista/sobre.tpl"}
          {/if}

          {* Página de submissão *}
          {if $journalRegister}
            {include file="portalpadrao/revista/register/register.tpl"}
          {/if}
        </main>
      </div>
   </div> <!-- /page content -->
  </div> <!-- /page-container -->

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

          {* Página de Anteriores / Atual*}
          {if $journalArchive}
            {include file="portalpadrao/revista/arquivo/list.tpl"}
          {/if}

          {* Página da edição corrente da revista + editorial*}
          {if $journalIssue}
            {include file="portalpadrao/revista/arquivo/issue.tpl"}
          {/if}

          {* Página de ajuda /diretrizes *}

          {if $journalHelp}
            {include file="portalpadrao/revista/help/general.tpl"}
          {/if}

          {* Página de visualização dos artigos*}
          {if $journalArticle}
            {include file="portalpadrao/revista/article/article.tpl"}
          {/if}

          {* Página de visualização do processo de submissão *}
          {if $journalPublishing}
            {include file="portalpadrao/revista/help/publishingsystem.tpl"}
          {/if}

          {if $registerLogin}
            {include file="portalpadrao/revista/register/register.tpl"}
          {/if}

          <!-- footer -->
	    <div class="content-box">{include file="common/footer.tpl"}</div>
		
        </main>
      </div>
   </div> <!-- /page content -->
  </div> <!-- /page-container -->

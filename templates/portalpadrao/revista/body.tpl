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

      <!-- Page footer -->
      <footer class="page-footer" id="page-footer">
        <div class="content-container">
          <ul class="footer-box">
            <li class="title"><h4>Assuntos</h4></li>
            <li class="item">Agropecuária</li>
            <li class="item">Cidadania</li>
            <li class="item">Ciência e Tecnologia</li>
            <li class="item">Comunicações</li>
            <li class="item">Cultura</li>
            <li class="item">Economia</li>
            <li class="item">Educação</li>
            <li class="item">Energia</li>
            <li class="item">Enfrentamento às drogas</li>
            <li class="item">Esporte</li>
          </ul>
          <ul class="footer-box">
            <li class="title"><h4>Sobre</h4></li>
            <li class="item">Lorem ipsum</li>
            <li class="item">Dolor sit amet</li>
            <li class="item">Consectetur adipisicing</li>
            <li class="item">Elit</li>
            <li class="item">Assumenda explicabo</li>
            <li class="item">Accusamus perferendis</li>
            <li class="item">Rerum aperiam in rem</li>
          </ul>

          <ul class="footer-box">
            <li class="title"><h4>Fale com a Lorem?!</h4></li>
            <li class="item">contato@ifpb.edu.br</li>
            <li class="item">(83) 3279-8800</li>
          </ul>

          <ul class="footer-box">
            <li class="title"><h4>Redes Sociais</h4></li>
            <li class="item">Facebook</li>
            <li class="item">Twitter</li>
            <li class="item">Youtube</li>
            <li class="item">Flickr</li>
            <li class="item">
              <ul class="footer-box">
                <li class="title"><h4>Mapa do site</h4></li>
              </ul>
            </li>
            <li class="item">
              <ul class="footer-box">
                <li class="title"><h4>RSS</h4></li>
                <li class="item">o que é RSS?</li>
                <li class="item">Assine o nosso RSS</li>
              </ul>
            </li>
          </ul>
        </div>
      </footer> <!-- /page footer -->
    </div> <!-- /page content -->
  </div> <!-- /page-container -->
</body>
</html>
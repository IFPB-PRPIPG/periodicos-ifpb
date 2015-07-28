  <main class="page-container">
    <!-- Grid -->
    <div class="page-grid">
      <!-- incluindo barra lateral -->
      {include file="portalpadrao/base/aside.tpl"}
      <!-- Parte central da página -->
      <section class="l-page-content">
        <img src="{$baseUrl}/templates/portalpadrao/assets/images/banner_periodicos site.png" style="width: 100%; margin-bottom: 5%">
        {include file="portalpadrao/index/slide.tpl"}
        {include file="portalpadrao/index/noticias.tpl"}
        {include file="portalpadrao/index/revistas.tpl"}
        {include file="portalpadrao/index/search.tpl"}
      </section> <!-- fim do page content -->
    </div> <!-- fim do page-grid -->
  </main> <!-- fim do page-grid geral -->
<section class="search-container">
  <!-- Header do container -->
  <header class="search-header">
    <h3 class="header-title">Pesquisa</h3>
  </header>
 

    <form id="simpleSearchForm" method="post" action="{url page="search" op="search"}">
    <table id="simpleSearchInput">
      <tr>
        <td>
        {capture assign="filterInput"}{call_hook name="Templates::Search::SearchResults::FilterInput" filterName="simpleQuery" filterValue="" size=15}{/capture}
        {if empty($filterInput)}
          
            
            <form action="#/search">
    <section class="search-body">
      <label for="search-magazine">Conteúdo da Revista</label>
      <input id="search-magazine" type="text">
      <span class="search-span">Filtro</span>
      <ul>
        <li>
          <input id="all-options" name="all-options" type="checkbox"> <label for="all-options">Todos</label>
        </li>
        <li>
          <input id="author-options" name="author-options" type="checkbox">
          <label for="author-options">Autor</label>
        </li>
        <li>
          <input id="title-options" name="title-options" type="checkbox">
          <label for="title-options">Título</label>
        </li>
        <li>
          <input id="summary-options" name="summary-options" type="checkbox">
          <label for="summary-options">Resumo</label>
        </li>
        <li>
          <input id="index-options" name="index-options" type="checkbox">
          <label for="index-options">Termo Indexado</label>
        </li>
        <li>
          <input id="text-options" name="text-options" type="checkbox">
          <label for="text-options">Texto Completo</label>
        </li>
      </section>
      <footer class="search-footer">
        <button>Pesquisar</button>
      </footer>
    </ul>
  </form>

        </label>
        {else}
          {$filterInput}
        {/if}
        </td>
      </tr>
      
      
    </table>
  </form>
</section>
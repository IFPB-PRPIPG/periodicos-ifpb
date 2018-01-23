<!-- caixa de pesquisa -->
<div class="mid-4 last">
  <div class="default-box">
    <div class="header-box">Pesquisa</div>
  {capture assign="filterInput"}{call_hook name="Templates::Search::SearchResults::FilterInput" filterName="simpleQuery" filterValue="" size=15}{/capture}
  {if empty($filterInput)}  
    <form class="form-control" id="simpleSearchForm" method="post" action="{url page="search" op="search"}">

      {capture assign="filterInput"}{call_hook name="Templates::Search::SearchResults::FilterInput" filterName="simpleQuery" filterValue="" size=15}{/capture}
            
            <select id="searchField" name="searchField" size="1" style="display: none;">
              {html_options_translate options=$articleSearchByOptions}
            </select>

      <fieldset>
        <label class="label-control-block label-header"> Conteúdo da pesquisa</label>
        <input type="text" class="input-control" name="query">
      </fieldset>

      <fieldset>
        <label class="label-control-block label-header">Filtro</label>
        <label class="label-control-block">
          <input id="all-options" name="searchField" type="radio"> <label for="all-options"> Todos
        </label>

        <label class="label-control-block">
          <input id="author-options" name="searchField" type="radio"> Autor
        </label>

        <label class="label-control-block">
          <input id="title-options" name="searchField" type="radio"> Título
        </label>

        <label class="label-control-block">
          <input id="summary-options" name="searchField" type="radio"> Resumo
        </label>

        <label class="label-control-block">
          <input id="index-options" name="searchField" type="radio"> Termo Indexado
        </label>

        <label class="label-control-block">
          <input id="text-options" name="searchField" type="radio"> Texto Completo
        </label>
      </fieldset>

      <div class="footer-box text-right">
        <button class="btn-default btn-large" type="submit">Pesquisar</button>
      </div>
    </form>
  {else}
    {$filterInput}
  {/if}
  </div>
</div>

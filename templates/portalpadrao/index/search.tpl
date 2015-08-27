<!-- caixa de pesquisa -->
<div class="mid-4 last">
  <div class="default-box">
    <div class="header-box">Pesquisa</div>
  {capture assign="filterInput"}{call_hook name="Templates::Search::SearchResults::FilterInput" filterName="simpleQuery" filterValue="" size=15}{/capture}
  {if empty($filterInput)}  
    <form class="form-control" method="post" action="{url page="search" op="search"}">
      <fieldset>
        <label class="label-control-block label-header"> Conteúdo da pesquisa</label>
        <input type="text" class="input-control">
      </fieldset>

      <fieldset>
        <label class="label-control-block label-header">Filtro</label>
        <label class="label-control-block">
          <input id="all-options" name="all-options" type="checkbox"> <label for="all-options"> Todos
        </label>

        <label class="label-control-block">
          <input id="author-options" name="author-options" type="checkbox"> Autor
        </label>

        <label class="label-control-block">
          <input id="title-options" name="title-options" type="checkbox"> Título
        </label>

        <label class="label-control-block">
          <input id="summary-options" name="summary-options" type="checkbox"> Resumo
        </label>

        <label class="label-control-block">
          <input id="index-options" name="index-options" type="checkbox"> Termo Indexado
        </label>

        <label class="label-control-block">
          <input id="text-options" name="text-options" type="checkbox"> Texto Completo
        </label>
      </fieldset>

      <div class="footer-box text-right">
        <button class="btn-default btn-large">Pesquisar</button>
      </div>
    </form>
  {else}
    {$filterInput}
  {/if}
  </div>
</div>

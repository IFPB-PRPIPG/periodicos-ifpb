<div class="content-box">
  <div class="header-box default">Cadastrar slides</div>
  <div class="text-box">
    <div class="content-box mid-12">
      <form action="{url page="admin" op="saveSlider"}" method="post" class="form-control">
        <fieldset>
          <legend>Configuração</legend>
          <input type="radio" name="showslide" value="true" id="Mostrar" {if $showSlide == "true"}checked{/if}>
          <label for="Mostrar">Mostrar Slide</label>
          <input type="radio" name="showslide" value="false" id="NaoMostrar" {if $showSlide == "false"}checked{/if}>
          <label for="NaoMostrar">Não Mostrar Slide</label>
        </fieldset>
        {foreach from=$slideItems key=key item=item}
          <fieldset>
            <legend>Slide {$key}</legend>
            <label for="slide-imagem-{$key}">Link da imagem</label>
            <input id="slide-imagem-{$key}" type="text" class="input-control" name="slide-imagem[]" value="{$item.imagem}">
            <label for="slide-link-{$key}">Endereço do link</label>
            <input id="slide-link" type="text" class="input-control" name="slide-link[]" name="slide-link-{$key}" value="{$item.link}">
          </fieldset>
        {/foreach}
        <input type="submit" class="btn-submit">
      </form>
    </div>
  </div>


</div>

<div class="text-box">
  <h2 class="header-title large-size">Validação de certificado</h2>
  <form action="" class="form-control">
    <fieldset>
      <legend>Dados do certificado </legend>
      <div class="input-container">
        <label class="label-control-right mid-4 required">Código da autenticação :</label>
        <input class="input-control mid-6" type="text" name="codigoAut" required>
        <div class="mid-2">
          <button style="padding: 8px 15px;" class="btn-submit">Buscar</button>
        </div>
      </div>
    </fieldset>
  </form>
</div>
{if $certificado}
<div class="text-box">
  <h2 class="header-title large-size">Este certificado é válido.</h2>
  <div class="text-box-section border-box">
    <p>Este certificado pertence a <strong>{$avaliadorCertificado}</strong> que exerceu atividade de avaliador(a) ad hoc de <strong>1 (um) artigo científico</strong>, a convite do Conselho Editorial da Revista <strong>{$revistaCertificado}</strong>, no dia <strong>{$dataAvaliacaoCertificado|date_format:"%d de %B de %Y"}</strong>.</p>
  </div>
</div>
{/if}
{ if $certificadoInvalido}
<div class="text-box">
  <h2 class="header-title large-size">Este certificado não é válido.</h2>
  <div class="text-box-section border-box">
  </div>
</div>
{/if}

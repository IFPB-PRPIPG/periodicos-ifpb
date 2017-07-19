{**
 *
 * Página para gerenciamento de arquivos do sistema
 *
 *}
{strip}
{assign var="pageTitle" value="common.files"}
{include file="common/header.tpl"}
{/strip}


	{if $msgErro}
		<p style="color:red">{$msgErro}</p>	
	{/if}

	{if $msg}
		<p>{$msg}</p>	
	{/if}
	
	<!-- O tipo de encoding de dados, enctype, DEVE ser especificado abaixo -->
	<form enctype="multipart/form-data" method="post" action="{url op="upload"}">
	    <!-- MAX_FILE_SIZE deve preceder o campo input -->
	    <input type="hidden" name="MAX_FILE_SIZE" value="9999999" />
	    <!-- O Nome do elemento input determina o nome da array $_FILES -->
	    <h4>Incluir arquivo no sistema:</h4>
	    <input name="newfile" type="file" /><br /><br />
	    <input type="submit" value="Enviar arquivo" />
	</form>


	<br/>
	<hr>
	
	<!-- Mostrar lista de arquivos -->
	{if $files}
		<div style="width: 80%;height: auto;">
		<h4>Lista de arquivos:</h4>
		<br />
		
		{foreach from=$files item=file}	
		
			<div style="border-top: 1px solid #ddd;width: 80%;height: 30px;float: left;line-height: 30px;">
				/files/{$file}
			</div>

			<div style="border-top: 1px solid #ddd;width: 20%;height: 30px;float: right;padding-top: 8px;">
				<a href="{url op="excluir" file="$file}" }"><i class="fa fa-trash-o"></i></a>
			</div>
		{/foreach}
		</div>
	{/if}


{include file="common/footer.tpl"}
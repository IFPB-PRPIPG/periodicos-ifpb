{**
 *
 * Página para acesso a dados do sistema
 *
 *}
{strip}
{assign var="pageTitle" value="common.dados"}
{include file="common/header.tpl"}
{/strip}

	<ul>
		<li><a href="{url page="manager" id="$jid" op="acessosDia"}">Artigos por dia</a></li>
	</ul>

{include file="common/footer.tpl"}
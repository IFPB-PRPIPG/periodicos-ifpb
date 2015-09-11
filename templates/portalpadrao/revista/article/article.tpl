{strip}
{if $galley}
	{assign var=pubObject value=$galley}
{else}
	{assign var=pubObject value=$article}
{/if}
	<!-- Script necessários para o view do pdf -->
	<script type="text/javascript" src="http://www.google.com/jsapi"></script>
	<script type="text/javascript">
	{literal}
			google.load("jquery", "{/literal}{$smarty.const.CDN_JQUERY_VERSION}{literal}");
			google.load("jqueryui", "{/literal}{$smarty.const.CDN_JQUERY_UI_VERSION}{literal}");
	{/literal}
	</script>
{/strip}
	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}
{if $galley}
	{if $galley->isHTMLGalley()}
		{$galley->getHTMLContents()}
	{elseif $galley->isPdfGalley()}
		{include file="article/pdfViewer.tpl"}
	{/if}
{else}
<div class="text-box">
		{if is_a($article, 'PublishedArticle')}{assign var=galleys value=$article->getGalleys()}{/if}
		{if $galleys && $subscriptionRequired && $showGalleyLinks}
			<div id="accessKey">
				<img src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
				{translate key="reader.openAccess"}&nbsp;
				<img src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
				{if $purchaseArticleEnabled}
					{translate key="reader.subscriptionOrFeeAccess"}
				{else}
					{translate key="reader.subscriptionAccess"}
				{/if}
			</div>
		{/if}
  <!-- artigo em si -->
	{if $coverPagePath}
		<div id="articleCoverImage">
      <img src="{$coverPagePath|escape}{$coverPageFileName|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}{if $width} width="{$width|escape}"{/if}{if $height} height="{$height|escape}"{/if}/>
		</div>
	{/if}
	{call_hook name="Templates::Article::Article::ArticleCoverImage"}
  <!-- titulo e sub titulo -->
  
	<a href="{url journal="index" page="index"}">
      <img src="{$baseUrl}/templates/portalpadrao/assets/images/banner_periodicos_site.png" alt="" class="image-responsible banner-content">
    </a>	

  <h2 class="header-title border-title-light mid-size">
    {$article->getLocalizedTitle()|strip_unsafe_html}
  </h2>
	  <h4 id="name-autor">
	  		{$article->getAuthorString()|escape}
	  		<div class="separator"></div>
	  </h4>

  <!-- exibição da(s) instituição(ões) do(s) autor(es)-->
	<h4 class="header-subtitle border-box">
	  	
		<div class="block" id="sidebarRTAuthorBios">
		<div>
		{foreach from=$article->getAuthors() item=author name=authors}
		<span class="authorBio">
		
			<!--<em>{$author->getFullName()|escape}</em>
			{if $author->getData('orcid')}<a href="{$author->getData('orcid')|escape}" target="_blank">{translate key="user.orcid"}</a>{/if}
			{if $author->getUrl()}<a href="{$author->getUrl()|escape:"quotes"}">{$author->getUrl()|escape}</a>
			{/if}-->
			{assign var=authorAffiliation value=$author->getLocalizedAffiliation()}
			{if $authorAffiliation}{$authorAffiliation|escape}{/if}
			<!--
			{if $author->getCountry()}{$author->getCountryLocalized()|escape}{/if}
		-->

		{$author->getLocalizedBiography()|strip_unsafe_html|nl2br}
		</span>
			<!--{if !$smarty.foreach.authors.last}<div class="separator"></div>{/if}
			-->
		{/foreach}</div>
		</div>

	</h4>
	
	{if $article->getLocalizedAbstract()}
    <div class="text-box-content border-box">
      <h3 class="text-box-title border-title-light">
        {translate key="article.abstract"}
      </h3>
		<p style="text-align:justify;">
      {$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}
    </p>
	</div>
	{/if}

	{if $article->getLocalizedSubject()}
		<div id="articleSubject">
		<h4>{translate key="article.subject"}</h4>
		<br />
		<div><p style="text-align:justify;">{$article->getLocalizedSubject()|escape}</p></div>
		<br />
		</div>
	{/if}

	{if (!$subscriptionRequired || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || $subscribedUser || $subscribedDomain)}
		{assign var=hasAccess value=1}
	{else}
		{assign var=hasAccess value=0}
	{/if}

	{if $galleys}
    <div class="text-box-section">
      <h3 class="text-box-title border-title-light">{translate key="reader.fullText"}</h3>
		{if $hasAccess || ($subscriptionRequired && $showGalleyLinks)}
			{foreach from=$article->getGalleys() item=galley name=galleyList}
				<!--a href="{url page="article" op="view" path=$article->getBestArticleId($currentJournal)|to_array:$galley->getBestGalleyId($currentJournal)}" class="file" {if $galley->getRemoteURL()}target="_blank"{else}target="_parent"{/if}>{$galley->getGalleyLabel()|escape}</a-->
				{if $subscriptionRequired && $showGalleyLinks && $restrictOnlyPdf}
				{/if}
			{/foreach}
			{if $subscriptionRequired && $showGalleyLinks && !$restrictOnlyPdf}
				{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN}
					<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
				{else}
					<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
				{/if}
			{/if}
		{else}
			&nbsp;<a href="{url page="about" op="subscriptions"}" target="_parent">{translate key="reader.subscribersOnly"}</a>
		{/if}
		</div>
	{/if}

	{if $citationFactory->getCount()}
		<div id="articleCitations">
		<h4>{translate key="submission.citations"}</h4>
		<br />
		<div>
			{iterate from=citationFactory item=citation}
				<p>{$citation->getRawCitation()|strip_unsafe_html}</p>
			{/iterate}
		</div>
		<br />
		</div>
	{/if}
{/if}

{foreach from=$pubIdPlugins item=pubIdPlugin}
	{if $issue->getPublished()}
		{assign var=pubId value=$pubIdPlugin->getPubId($pubObject)}
	{else}
		{assign var=pubId value=$pubIdPlugin->getPubId($pubObject, true)}{* Preview rather than assign a pubId *}
	{/if}
	{if $pubId}
		{$pubIdPlugin->getPubIdDisplayType()|escape}: {if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}" href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}">{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}</a>{else}{$pubId|escape}{/if}
	{/if}
{/foreach}
{*call_hook name="Templates::Article::MoreInfo"*}
{*include file="article/comments.tpl"*}

{* PDF view *}
{url|assign:"pdfUrl" op="viewFile" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal) escape=false}
{translate|assign:"noPluginText" key='article.pdf.pluginMissing'}
<script type="text/javascript"><!--{literal}
	$(document).ready(function(){
		if ($.browser.webkit) { // PDFObject does not correctly work with safari's built-in PDF viewer
			var embedCode = "<object id='pdfObject' type='application/pdf' data='{/literal}{$pdfUrl|escape:'javascript'}{literal}' width='100%' height='300px'><div id='pluginMissing'>{/literal}{$noPluginText|escape:'javascript'}{literal}</div></object>";
			$("#inlinePdf").html(embedCode);
			if($("#pluginMissing").is(":hidden")) {
				$('#fullscreenShow').show();
				$("#inlinePdf").resizable({ containment: 'parent', handles: 'se' });
			} else { // Chrome Mac hides the embed object, obscuring the text.  Reinsert.
				$("#inlinePdf").html('{/literal}<div id="pluginMissing">{$noPluginText|escape:"javascript"}</div>{literal}');
			}
		} else {
			var success = new PDFObject({ url: "{/literal}{$pdfUrl|escape:'javascript'}{literal}" }).embed("inlinePdf");
			if (success) {
				// PDF was embedded; enbale fullscreen mode and the resizable widget
				$('#fullscreenShow').show();
				$("#inlinePdfResizer").resizable({ containment: 'parent', handles: 'se' });
			}
		}
	});
{/literal}
// -->
</script>
<div id="inlinePdfResizer">
	<div id="inlinePdf" class="ui-widget-content">
		<div id='pluginMissing'>{translate key="article.pdf.pluginMissing"}</div>
	</div>
</div>


{* Tool Bar *}
{if $journalRt && $journalRt->getEnabled()}
<div class="tool-bar">
	<div class="xs-6 mid-3 tool-align">
		<a class="btn-default" target="_parent" href="{url op="download" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal)}">
			Download do PDF
		</a>
	</div>
	{* Imprimir o artigo *}
	{if $journalRt->getPrinterFriendly()}
	<div class="xs-6 mid-3">
		<a class="tool-item print" href="{if !$galley || $galley->isHtmlGalley()}javascript:openRTWindow('{url page="rt" op="printerFriendly" path=$articleId|to_array:$galleyId}');{else}{url page="article" op="download" path=$articleId|to_array:$galleyId}{/if}">{translate key="plugins.block.readingTools.printThisArticle"}</a>
	</div>
	{/if}

	{* Exibir os meta dados*}
	{if $journalRt->getViewMetadata()}
	<div class="xs-6 mid-3">
		<a class="tool-item metadata" href="javascript:openRTWindow('{url page="rt" op="metadata" path=$articleId|to_array:$galleyId}');">{translate key="rt.viewMetadata"}</a>
	</div>
	{/if}

	{* Como citar o artigo *}
	{if $journalRt->getCaptureCite()}
	<div class="xs-6 mid-3">
		<a class="tool-item document" href="javascript:openRTWindow('{url page="rt" op="captureCite" path=$articleId|to_array:$galleyId}');">{translate key="rt.captureCite"}</a>
	</div>
	{/if}
</div>
{/if}


<div class="text-box">
	<a href="{url journal="index" page="index"}">
      <img src="{$baseUrl}/templates/portalpadrao/assets/images/banner_periodicos_site.png" alt="" class="image-responsible banner-content">
    </a>
<h2 class="header-title large-size border-title-light">Editorial</h2>

<!-- Section para ser utilizada como sub section em páginas de texto -->
<div class="text-box-content border-box">

{if $issue}
	{if $issueId}
		{url|assign:"currentUrl" page="issue" op="view" path=$issueId|to_array:"showToc"}
	{else}
		{url|assign:"currentUrl" page="issue" op="current" path="showToc"}
	{/if}

	{if $coverPagePath}
	<div class="xs-1 mid-6">
		<img class="image-responsible" src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/>
	{/if}
	</div>
{/if}
  <p>{$issue->getLocalizedDescription()|strip_unsafe_html}</p>
</div>

<div class="text-box-content">
  <h3 class="text-box-title large-size border-title-light">{translate key="issue.toc"}</h3>

{foreach name=sections from=$publishedArticles item=section key=sectionId}

		<ul class="text-list">
      {if $section.title}
      <li class="text-list-item-header">{$section.title|escape}</li>
      {/if}
		{foreach from=$section.articles item=article}
			{assign var=articlePath value=$article->getBestArticleId($currentJournal)}
			{assign var=articleId value=$article->getId()}

			{if $article->getLocalizedFileName() && $article->getLocalizedShowCoverPage() && !$article->getHideCoverPageToc($locale)}
				{assign var=showCoverPage value=true}
			{else}
				{assign var=showCoverPage value=false}
			{/if}

			{if $article->getLocalizedAbstract() == ""}
				{assign var=hasAbstract value=0}
			{else}
				{assign var=hasAbstract value=1}
			{/if}

			{if (!$subscriptionRequired || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || $subscribedUser || $subscribedDomain || ($subscriptionExpiryPartial && $articleExpiryPartial.$articleId))}
				{assign var=hasAccess value=1}
			{else}
				{assign var=hasAccess value=0}
			{/if}
			
			{if $issue}
				<li class="text-list-item">
					{if !$hasAccess || $hasAbstract}
						<a href="{url page="article" op="view" path=$articlePath}">{$article->getLocalizedTitle()|strip_unsafe_html}</a>
						<a href="{url page="article" op="view" path=$articlePath}" class="file">PDF</a>
					{else}
						{$article->getLocalizedTitle()|strip_unsafe_html}

						{if $hasAccess || ($subscriptionRequired && $showGalleyLinks)}
							{foreach from=$article->getGalleys() item=galley name=galleyList}
								<a href="{url page="article" op="view" path=$articlePath|to_array:$galley->getBestGalleyId($currentJournal)}" {if $galley->getRemoteURL()}target="_blank" {/if}class="file">{$galley->getGalleyLabel()|escape}</a>
								{if $subscriptionRequired && $showGalleyLinks && $restrictOnlyPdf}
									{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || !$galley->isPdfGalley()}
										<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
									{else}
										<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
									{/if}
								{/if}
							{/foreach}
							{if $subscriptionRequired && $showGalleyLinks && !$restrictOnlyPdf}
								{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN}
									<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
								{else}
									<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
								{/if}
							{/if}
						{/if}

					{/if}
				</li>
				<li class="text-list-item-indent">
					{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
						{foreach from=$article->getAuthors() item=author name=authorList}
							{$author->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}
						{/foreach}
					{else}
						&nbsp;
					{/if}
				</li>

			{else}
	    {* Sem artigos*}
				{translate key="current.noCurrentIssueDesc"}
			{/if}
		{/foreach}
	</ul>
{/foreach}
</div>

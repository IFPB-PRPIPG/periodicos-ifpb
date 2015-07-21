<div class="text-box">
<h2 class="header-title large-size border-title-light">Editorial</h2>

<!-- Section para ser utilizada como sub section em páginas de texto -->
<div class="text-box-section border-box">

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

<div class="text-box-section">
  <h3 class="text-box-title large-size border-title-light">{translate key="issue.toc"}</h3>
{foreach name=sections from=$publishedArticles item=section key=sectionId}

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
		<ul class="text-list">
      {if $section.title}
      <li class="text-list-item-header">{$section.title|escape}</li>
      {/if}
			<li class="text-list-item">
				{if !$hasAccess || $hasAbstract}
					<a href="{url page="article" op="view" path=$articlePath}">{$article->getLocalizedTitle()|strip_unsafe_html}</a>
				{else}
					{$article->getLocalizedTitle()|strip_unsafe_html}
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
		</ul>
		{else}
    {* Sem artigos*}
			{translate key="current.noCurrentIssueDesc"}
		{/if}
	{/foreach}
{/foreach}
</div>
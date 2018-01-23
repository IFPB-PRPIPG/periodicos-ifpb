{**
 * plugins/generic/webFeed/templates/atom.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Atom feed template
 *
 *}
<?xml version="1.0" encoding="{$defaultCharset|escape}"?>
<feed xmlns="http://www.w3.org/2005/Atom">
	{* required elements *}
	<id>{url page="issue" op="feed"}</id>
	<title>{$journal->getLocalizedTitle()|strip|escape:"html"}</title>

	{* Figure out feed updated date *}
	{assign var=latestDate value=$issue->getDatePublished()}
	{foreach name=sections from=$publishedArticles item=section}
		{foreach from=$section.articles item=article}
			{if $article->getLastModified() > $latestDate}
				{assign var=latestDate value=$article->getLastModified()}
			{/if}
		{/foreach}
	{/foreach}
	<updated>{$latestDate|date_format:"%Y-%m-%dT%T%z"|regex_replace:"/00$/":":00"}</updated>

	{* recommended elements *}
	{if $journal->getSetting('contactName')}
		<author>
			<name>{$journal->getSetting('contactName')|strip|escape:"html"}</name>
			{if $journal->getSetting('contactEmail')}
			<email>{$journal->getSetting('contactEmail')|strip|escape:"html"}</email>
			{/if}
		</author>
	{/if}

	<link rel="alternate" href="{$journal->getUrl()|escape}" />
	<link rel="self" type="application/atom+xml" href="{url page="feed" op="atom"}" />

	{* optional elements *}

	{* <category/> *}
	{* <contributor/> *}

	<generator uri="http://pkp.sfu.ca/ojs/" version="{$ojsVersion|escape}">Open Journal Systems</generator>
	{if $journal->getLocalizedDescription()}
		{assign var="description" value=$journal->getLocalizedDescription()}
	{elseif $journal->getLocalizedSetting('searchDescription')}
		{assign var="description" value=$journal->getLocalizedSetting('searchDescription')}
	{/if}

	<subtitle type="html">{$description|strip|escape:"html"}</subtitle>

	{foreach name=sections from=$publishedArticles item=section key=sectionId}
		{foreach from=$section.articles item=article}
			<entry>
				{* required elements *}
				<id>{url page="article" op="view" path=$article->getBestArticleId($currentJournal)}</id>
				<title>{$article->getLocalizedTitle()|strip|escape:"html"}</title>
				<updated>{$article->getLastModified()|date_format:"%Y-%m-%dT%T%z"|regex_replace:"/00$/":":00"}</updated>

				{* recommended elements *}

				{foreach from=$article->getAuthors() item=author name=authorList}
					<author>
						<name>{$author->getFullName()|strip|escape:"html"}</name>
						{if $author->getEmail()}
							<email>{$author->getEmail()|strip|escape:"html"}</email>
						{/if}
					</author>
				{/foreach}{* authors *}

				<link rel="alternate" href="{url page="article" op="view" path=$article->getBestArticleId($currentJournal)}" />

				{if $article->getLocalizedAbstract()}
					<summary type="html" xml:base="{url page="article" op="view" path=$article->getBestArticleId($currentJournal)}">{$article->getLocalizedAbstract()|strip|escape:"html"}</summary>
				{/if}

				{* optional elements *}
				{* <category/> *}
				{* <contributor/> *}

				{if $article->getDatePublished()}
					<published>{$article->getDatePublished()|date_format:"%Y-%m-%dT%T%z"|regex_replace:"/00$/":":00"}</published>
				{/if}

				{* <source/> *}
				<rights>{translate|escape key="submission.copyrightStatement" copyrightYear=$article->getCopyrightYear() copyrightHolder=$article->getLocalizedCopyrightHolder()}</rights>
			</entry>
		{/foreach}{* articles *}
	{/foreach}{* sections *}
</feed>

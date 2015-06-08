<h1>Vizualizando a notícia</h1>

{strip}
{assign var="pageTitleTranslated" value=$announcementTitle}
{assign var="pageId" value="announcement.view"}
{/strip}

<table id="announcementDescription" width="100%">
	<tr>
		<td>{$announcement->getLocalizedDescription()|nl2br}</td>
	</tr>
</table>
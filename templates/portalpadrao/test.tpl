{iterate from=announcements item=announcement}
		<tr class="title">
		{if $announcement->getTypeId()}
			<td class="title"><h4>{$announcement->getAnnouncementTypeName()|escape}: {$announcement->getLocalizedTitle()|escape}</h4></td>
		{else}
			<td class="title"><h4>{$announcement->getLocalizedTitle()|escape}</h4></td>
		{/if}
			<td class="more">&nbsp;</td>
		</tr>
		<tr class="description">
			<td class="description">{$announcement->getLocalizedDescriptionShort()|nl2br}</td>
			<td class="more">&nbsp;</td>
		</tr>
		<tr class="details">
			<td class="posted">{translate key="announcement.posted"}: {$announcement->getDatePosted()}</td>
			{if $announcement->getLocalizedDescription() != null}
				<td class="more"><a href="{url page="announcement" op="show" path=$announcement->getId()}">{translate key="announcement.viewLink"}</a></td>
			{/if}
		</tr>
{/iterate}

{if $announcements->wasEmpty()}
	<tr>
		<td colspan="2" class="nodata">{translate key="announcement.noneExist"}</td>
	</tr>
	<tr>
		<td colspan="2" class="endseparator">&nbsp;</td>
	</tr>
{/if}
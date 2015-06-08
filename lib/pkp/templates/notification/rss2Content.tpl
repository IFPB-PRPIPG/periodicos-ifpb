{**
 * templates/notification/rss2Content.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Template for a notification to be displayed in the RSS2 feed
 *}

<item>
	<title>{translate key="notification.notification"} : {$notificationDateCreated|date_format:"%a, %d %b %Y %T %z"}</title>
	<link>
		{if $notificationUrl != null}
			{$notificationUrl|escape}
		{else}
			{url page="notification"}
		{/if}
	</link>
	<description>
		{$notificationContent|escape:"html"}
	</description>
	<pubDate>{$notificationDateCreated|date_format:"%a, %d %b %Y %T %z"}</pubDate>
</item>


<!DOCTYPE html>
<html>
<head>
	{if $siteTitle}
		{assign var="pageTitleTranslated" value=$siteTitle}
	{/if}
	<title>{$pageTitleTranslated}</title>
	<link rel="stylesheet" href="https://necolas.github.io/normalize.css/3.0.2/normalize.css">
	<link rel="stylesheet" href="{$baseUrl}/templates/portalpadrao/assets/stylesheet/style.css">
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/pkp.css">
  	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css">
  	<link rel="stylesheet" href="{$baseUrl}/styles/common.css">
  	<link rel="stylesheet" href="{$baseUrl}/styles/compiled.css">
	<link rel="icon" href="{$baseUrl}/templates/portalpadrao/assets/images/icon-portal.png" type="image/png" sizes="16x16">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

{include file="portalpadrao/revista/base/header.tpl"}
	{include file="portalpadrao/revista/body.tpl"}
{include file="portalpadrao/base/footer.tpl"}
</body>
</html>

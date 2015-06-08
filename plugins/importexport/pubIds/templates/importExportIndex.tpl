{**
 * plugins/importexport/pubIds/templates/importExportIndex.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List of operations this plugin can perform
 *
 *}
{strip}
{assign var="pageTitle" value="plugins.importexport.pubIds.displayName"}
{include file="common/header.tpl"}
{/strip}

<br/>

<h3>{translate key="plugins.importexport.pubIds.export"}</h3>
<ul>
	<li><a href="{plugin_url path="selectIssue"}">{translate key="plugins.importexport.pubIds.export.forIssues"}</a></li>
</ul>

<h3>{translate key="plugins.importexport.pubIds.import"}</h3>
<p>{translate key="plugins.importexport.pubIds.import.description"}</p>
<form action="{plugin_url path="import"}" method="post" enctype="multipart/form-data">
<input type="file" class="uploadField" name="importFile" id="import" /> <input name="import" type="submit" class="button" value="{translate key="common.import"}" />
</form>

{include file="common/footer.tpl"}

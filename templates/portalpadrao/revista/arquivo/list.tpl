<div class="text-box">

	<a href="{url journal="index" page="index"}">
    	<img src="{$baseUrl}/templates/portalpadrao/assets/images/banner_periodicos_site.png" alt="" class="image-responsible banner-content">
	</a>

	<h2 class="header-title large-size border-title-light">{translate key="issue.issues"}</h2>

	{iterate from=issues item=issue}
		{if $issue->getYear() != $lastYear}
			{if !$notFirstYear}
				{assign var=notFirstYear value=1}
			{else}
				</div>
				<br />
				<div class="separator" style="clear:left;"></div>
			{/if}
			<div style="float: left; width: 100%;">
			<h3>{$issue->getYear()|escape}</h3>
			{assign var=lastYear value=$issue->getYear()}
		{/if}

    <ul class="date-list mid-12">
      <!-- Entrada dos itens -->
      <li class="date-list-item" id="issue-{$issue->getId()}">
        <!--<div class="date mid-3">
          <span class="year">{$issue->getDatePublished()|date_format:"%d/%m/%Y"}</span>  date_format incluido para resolver problema da hora errada
        </div>--> <!-- Remoção da data das publicações -->
        <div class="image mid-4">
		{if $issue->getLocalizedFileName() && $issue->getShowCoverPage($locale) && !$issue->getHideCoverPageArchives($locale)}
          <img src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $issue->getCoverPageAltText($locale) != ''} alt="{$issue->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/>
        {/if}
        </div>
        <div class="text mid-8" style="text-align:justify;">
          <h4 class="title">
          	<a class="title" href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">{$issue->getIssueIdentification()|escape}</a>
          </h4>
          <p>{$issue->getLocalizedDescription()|strip_unsafe_html}</p>
        </div>
      </li>
      </ul>
	{/iterate}

	<div class="mid-8">
	{if $notFirstYear}<br/>{/if}
	{if !$issues->wasEmpty()}
		{page_info iterator=$issues}&nbsp;&nbsp;&nbsp;&nbsp;
		{page_links anchor="issues" name="issues" iterator=$issues}
	{else}
		{translate key="current.noCurrentIssueDesc"}
	{/if}
	<br/><br/><br/><br/><br/><br/>
	</div>
</div> <!-- /text box -->


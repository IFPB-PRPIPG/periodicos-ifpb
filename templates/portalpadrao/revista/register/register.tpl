 {strip}
{assign var="helpTopicId" value="user.registerAndProfile"}
{assign var="registerOp" value="register"}
{assign var="registerLocaleKey" value="user.login.registerNewAccount"}
{/strip}
<div class="text-box">
{if $isUserLoggedIn}
<div class="text-box-section">
  <div class="content-box mid-12">
    <div class="header-box default">Submissão Online</div>
  </div>
  <a class="btn-submit" href="{url page="author" op="submit"}">Clique aqui para submeter</a>
</div>
{else}
    <!-- Section Utilizada para descrição -->

    <a href="{url journal="index" page="index"}">
      <img src="{$baseUrl}/templates/portalpadrao/assets/images/banner_periodicos_site.png" alt="" class="image-responsible banner-content">
    </a>

    <div class="text-box-section">

      <p>O cadastro no sistema e posterior acesso são obrigatórios para a publicação de trabalhos, bem como para acompanhar o processo editorial em curso. Caso não tenha cadastrado, preencha o formulário para se cadastrar no sistema e submeter trabalhos.</p>
    </div>
	<div class="content-box mid-4" style="float:right;">
	  <div class="header-box default">Tenho cadastro</div>
	  <form action="{$userBlockLoginUrl}" method="post" class="form-control-default">
	    <input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />
	    <fieldset>
	      <legend>Acesso do usuário</legend>
	      <label for="login-sub" class="label-control">{translate key="user.username"}</label>
	      <input type="text" id="login-sub" class="input-control" name="username">
	      <label for="password-sub" class="label-control">{translate key="user.password"}</label>
	      <input type="password" id="password-sub" class="input-control" name="password" value="{$password|escape}">
	    </fieldset>
	    <button class="btn-submit">Acessar</button>
	  </form>
	</div>

	<div class="content-box mid-8">
		<div class="header-box default">Não tenho cadastro</div>
			<form class="form-control" id="registerForm" method="post" action="{url page="user" op="registerUser"}">
			{if !$implicitAuth}
				{if !$existingUser}
					{url|assign:"url" page="user" op="register" existingUser=1}
					<!-- clique aqui se ja possuir o cadastro -->
					<!--p>{translate key="user.register.alreadyRegisteredOtherJournal" registerUrl=$url}</p-->
				{else}
					{url|assign:"url" page="user" op="register"}
					<p>{translate key="user.register.notAlreadyRegisteredOtherJournal" registerUrl=$url}</p>
					<input type="hidden" name="existingUser" value="1"/>
				{/if}

        {include file="common/formErrors.tpl"}


				{if $existingUser}
					<p>{translate key="user.register.loginToRegister"}</p>
				{/if}
			{/if}{* !$implicitAuth *}
			{if $source}
				<input type="hidden" name="source" value="{$source|escape}" />
			{/if}

			<table class="data">
			{if count($formLocales) > 1 && !$existingUser}
				<tr valign="top">
					<td width="20%" class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{url|assign:"userRegisterUrl" page="user" op="register" escape=false}
						{form_language_chooser form="register" url=$userRegisterUrl}
						<span class="instruct">{translate key="form.formLanguage.description"}</span>
					</td>
				</tr>
			{/if}

			{if !$implicitAuth}
        <fieldset>
          <legend>{translate key="user.profile"}</legend>
            <!-- login -->
            {fieldLabel class="label-control-right mid-6" name="username" required="true" key="user.username"}
            <input type="text" name="username" value="{$username|escape}" id="username" size="20" maxlength="32" class="input-control mid-6" required />

            <!-- senha -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="password" required="true" key="user.password"}
              <input type="password" name="password" value="{$password|escape}" id="password" size="20" class="input-control mid-6" />
              <small style="text-align: right;display: block">{translate key="user.register.passwordLengthRestriction" length=$minPasswordLength}</small>
            </div>

            <!-- repetir senha -->
            {fieldLabel class="label-control-right mid-6" name="password2" required="true" key="user.repeatPassword"}
            <input type="password" name="password2" id="password2" value="{$password2|escape}" size="20" class="input-control mid-6" />
        </fieldset>

        <fieldset>
          <legend>Dados Pessoais</legend>
            <!-- Pronome de tratamento -->
            <div class="input-container">
            {fieldLabel class="label-control-right mid-6" name="salutation" key="user.salutation"}
            <input type="text" name="salutation" id="salutation" value="{$salutation|escape}" size="20" maxlength="40" class="input-control mid-6"/>
            </div>
            <!-- Nome -->
            <div class="input-container">
            {fieldLabel class="label-control-right mid-6" name="firstName" required="true" key="user.firstName"}
            <input type="text" id="firstName" name="firstName" value="{$firstName|escape}" size="20" maxlength="40" class="input-control mid-6"/>
            </div>
            <!-- Nome do meio -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="middleName" key="user.middleName"}
              <input type="text" id="middleName" name="middleName" value="{$middleName|escape}" size="20" maxlength="40" class="input-control mid-6"/>
            </div>
            <!-- Ultimo nome -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="lastName" required="true" key="user.lastName"}
              <input type="text" id="lastName" name="lastName" value="{$lastName|escape}" size="20" maxlength="90" class="input-control mid-6" />
            </div>

            <!-- Iniciais -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="initials" key="user.initials"}
              <input type="text" id="initials" name="initials" value="{$initials|escape}" size="5" maxlength="5" class="input-control mid-6" />
              <small style="text-align: right;display: block">{translate key="user.initialsExample"}</small>
            </div>
            
            <!-- sexo -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="gender-m" key="user.gender"}
              <select name="gender" id="gender" size="1" class="input-control mid-6">
                {html_options_translate options=$genderOptions selected=$gender}
              </select>
            </div>

            <!-- Instituição/afiliação -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="affiliation" key="user.affiliation"}
              <textarea id="affiliation" name="affiliation[{$formLocale|escape}]" rows="5" cols="40" class="input-control mid-6">{$affiliation[$formLocale]|escape}</textarea>
              <small style="display: block; text-align: right;">{translate key="user.affiliation.description"}</small>
            </div>

            <!-- Assinatura -->
            <div class="input-container">
            {fieldLabel class="label-control-right mid-6" name="signature" key="user.signature"}
            <textarea name="signature[{$formLocale|escape}]" id="signature" rows="5" cols="40" class="input-control mid-6">{$signature[$formLocale]|escape}</textarea>
            </div>
            
            <!-- Email -->
            <div class="input-container">
            {fieldLabel class="label-control-right mid-6" name="email" required="true" key="user.email"}
            <input type="text" id="email" name="email" value="{$email|escape}" size="30" maxlength="90" class="input-control mid-6" /> {if $privacyStatement}<a class="action" href="#privacyStatement">{translate key="user.register.privacyStatement"}</a>{/if}
            </div>

            <!-- Confirmar email -->
            <div class="input-container">
            {fieldLabel class="label-control-right mid-6" name="confirmEmail" required="true" key="user.confirmEmail"}
            <input type="text" id="confirmEmail" name="confirmEmail" value="{$confirmEmail|escape}" size="30" maxlength="90" class="input-control mid-6" />
            </div>

            <!-- ORCID -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="orcid" key="user.orcid"}
              <input type="text" id="orcid" name="orcid" value="{$orcid|escape}" size="40" maxlength="255" class="input-control mid-6" />
              <small>{translate key="user.orcid.description"}</small>
            </div>

            <!-- URL -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="userUrl" key="user.url"}
              <input type="text" id="userUrl" name="userUrl" value="{$userUrl|escape}" size="30" maxlength="255" class="input-control mid-6" />
            </div>

            <!-- Telefone -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="phone" key="user.phone"}
              <input type="text" name="phone" id="phone" value="{$phone|escape}" size="15" maxlength="24" class="input-control mid-6" />
            </div>

            <!-- FAX -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="fax" key="user.fax"}
              <input type="text" name="fax" id="fax" value="{$fax|escape}" size="15" maxlength="24" class="input-control mid-6" />
            </div>
            
            <!-- Endereço Postal -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="mailingAddress" key="common.mailingAddress"}
              <textarea name="mailingAddress" id="mailingAddress" rows="3" cols="40" class="input-control mid-6">{$mailingAddress|escape}</textarea>
            </div>
            
            <!-- Biografia -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="biography" key="user.biography"}
              {translate key="" user.biography.description"}
              <textarea name="biography[{$formLocale|escape}]" id="biography" rows="5" cols="40" class="input-control mid-6">{$biography[$formLocale]|escape}</textarea>
            </div>
            
            <!-- País -->
            <div class="input-container">
              {fieldLabel class="label-control-right mid-6" name="country" key="common.country"}
              
                <select name="country" id="country" class="input-control mid-6">
                  <option value="">Selecione</option>
                  {html_options options=$countries selected=$country}
                </select>
            </div>
        </fieldset>

				{if !$existingUser}
				{/if}{* !$existingUser *}
				{if !$existingUser}

					{if $captchaEnabled}
						<tr>
							{if $reCaptchaEnabled}
							<td class="label" valign="top">{fieldLabel name="recaptcha_challenge_field" required="true" key="common.captchaField"}</td>
							<td class="value">
								{$reCaptchaHtml}
							</td>
							{else}
							<td class="label" valign="top">{fieldLabel name="captcha" required="true" key="common.captchaField"}</td>
							<td class="value">
								<img src="{url page="user" op="viewCaptcha" path=$captchaId}" alt="{translate key="common.captchaField.altText"}" /><br />
								<span class="instruct">{translate key="common.captchaField.description"}</span><br />
								<input name="captcha" id="captcha" value="" size="20" maxlength="32" class="input-control mid-6" />
								<input type="hidden" name="captchaId" value="{$captchaId|escape:"quoted"}" />
							</td>
							{/if}
						</tr>
					{/if}{* $captchaEnabled *}



					<tr valign="top">
						<td class="label">{fieldLabel name="sendPassword" key="user.sendPassword"}</td>
						<td class="value">
							<input type="checkbox" name="sendPassword" id="sendPassword" value="1"{if $sendPassword} checked="checked"{/if} /> <label for="sendPassword">{translate key="user.sendPassword.description"}</label>
						</td>
					</tr>

					{if count($availableLocales) > 1}
						<tr valign="top">
							<td class="label">{translate key="user.workingLanguages"}</td>
							<td class="value">{foreach from=$availableLocales key=localeKey item=localeName}
							<input type="checkbox" name="userLocales[]" id="userLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if in_array($localeKey, $userLocales)} checked="checked"{/if} /> <label for="userLocales-{$localeKey|escape}">{$localeName|escape}</label><br />
							{/foreach}</td>
						</tr>
					{/if}{* count($availableLocales) > 1 *}
				{/if}{* !$existingUser *}
			{/if}{* !$implicitAuth *}

			{if $allowRegReader || $allowRegReader === null || $allowRegAuthor || $allowRegAuthor === null || $allowRegReviewer || $allowRegReviewer === null || ($currentJournal && $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION && $enableOpenAccessNotification)}
				<tr valign="top">
					<td class="label">{fieldLabel suppressId="true" name="registerAs" key="user.register.registerAs"}</td>
					<td class="value">{if $allowRegReader || $allowRegReader === null}<input type="checkbox" name="registerAsReader" id="registerAsReader" value="1"{if $registerAsReader} checked="checked"{/if} /> <label for="registerAsReader">{translate key="user.role.reader"}</label>: {translate key="user.register.readerDescription"}<br />{/if}
					{if $currentJournal && $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION && $enableOpenAccessNotification}<input type="checkbox" name="openAccessNotification" id="openAccessNotification" value="1"{if $openAccessNotification} checked="checked"{/if} /> <label for="openAccessNotification">{translate key="user.role.reader"}</label>: {translate key="user.register.openAccessNotificationDescription"}<br />{/if}
					{if $allowRegAuthor || $allowRegAuthor === null}
            <input type="checkbox" name="registerAsAuthor" id="registerAsAuthor" value="1"checked="checked" />
            <label for="registerAsAuthor">{translate key="user.role.author"}</label>: {translate key="user.register.authorDescription"}<br />
          {/if}
					{if $allowRegReviewer || $allowRegReviewer === null}<input type="checkbox" name="registerAsReviewer" id="registerAsReviewer" value="1"{if $registerAsReviewer} checked="checked"{/if} /> <label for="registerAsReviewer">{translate key="user.role.reviewer"}</label>: {if $existingUser}{translate key="user.register.reviewerDescriptionNoInterests"}{else}{translate key="user.register.reviewerDescription"}{/if}
					<br /><div id="reviewerInterestsContainer" style="margin-left:25px;">
						<label class="desc">{translate key="user.register.reviewerInterests"}</label>
						{include file="form/interestsInput.tpl" FBV_interestsKeywords=$interestsKeywords FBV_interestsTextOnly=$interestsTextOnly}
					</div>
					</td>
					{/if}
				</tr>
			{/if}

			</table>

			<br />
			<p style="text-align: right;">
        <input type="submit" value="{translate key="user.register"}" class="btn-submit" style="display: inline-block;"/>
        <input type="button" value="{translate key="common.cancel"}" class="btn-default btn-large" onclick="document.location.href='{url page="index" escape=false}'" /></p>

			{if ! $implicitAuth}
				<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
			{/if}{* !$implicitAuth *}

			<div id="privacyStatement">
			{if $privacyStatement}
				<h3>{translate key="user.register.privacyStatement"}</h3>
				<p>{$privacyStatement|nl2br}</p>
			{/if}
			</div>

			</form>
</div> <!-- fecha a div do form -->

{/if}

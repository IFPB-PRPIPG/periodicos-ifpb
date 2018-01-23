<!DOCTYPE html>
<html>
<head>
	<title>Portal de Revistas Eletrônicas do IFPB</title>
	<link rel="stylesheet" href="{$baseUrl}/templates/portalpadrao/assets/stylesheet/main.css">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

{include file="portalpadrao/base/header.tpl"}
  <main class="page-container">
    <!-- Grid -->
    <div class="page-grid">
      <!-- incluindo barra lateral -->
      {include file="portalpadrao/base/aside.tpl"}

		{$content}
		
      </section> <!-- fim do page content -->
    </div> <!-- fim do page-grid -->
  </main> <!-- fim do page-grid geral -->
{include file="portalpadrao/base/footer.tpl"}

</body>
</html>



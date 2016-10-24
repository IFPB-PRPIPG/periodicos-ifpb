<?php
switch ($op) {
	case 'validacao':
		define('HANDLER_CLASS', 'ValidacaoHandler');
		import('pages.validacao.ValidacaoHandler');
		break;
}
?>

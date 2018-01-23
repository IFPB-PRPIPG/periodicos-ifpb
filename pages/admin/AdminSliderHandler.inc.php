<?php

/**
 * @file pages/admin/AdminSettingsHandler.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class AdminSettingsHandler
 * @ingroup pages_admin
 *
 * @brief Handle requests for changing site admin settings.
 *
 */

import('pages.admin.AdminHandler');

class AdminSliderHandler extends AdminHandler {
  /**
   * Constructor
   **/
  function AdminSliderHandler() {
    parent::AdminHandler();
  }

  function slider() {
    $templateMgr =& TemplateManager::getManager();

    $data = Array();
    /*
    * Lendo o XML e salvando as tags na array;
    */
    $xml = new DOMDocument();
    $xml->load('slideconfig.xml');
    $items = $xml->getElementsByTagName('item') ;
    $container = $xml->getElementsByTagName('container');

    if ($items->length > 0) {
      foreach($items as $key => $item) {
        $data[$key] = Array(
          'imagem' => $item->getAttribute('img'),
          'link' => $item->getAttribute('link')
          );
      }
    }

    foreach ($container as $key => $c) {
      $showSlideValue = $c->getAttribute('showslide');
    }

    $templateMgr->assign('showSlide', $showSlideValue);
    $templateMgr->assign('adminSlider', true);
    $templateMgr->assign('slideItems', $data);
    $templateMgr->display('portalpadrao/layout.tpl');
  }

  function saveSlider($args, &$request) {
    $this->validate();

    $xml = new DOMDocument("1.0", "ISO-8859-15");
    $xml->load('slideconfig.xml');

    $images = $_POST['slide-imagem'];
    $links = $_POST['slide-link'];
    $showSlidePost = $_POST['showslide'];

    
    //Salvando os links no XML 
    if (isset($images) && count($images) > 0) {
      $items = $xml->getElementsByTagName('item');
      foreach ($items as $key => $item) {
        $item->setAttribute("img", $images[$key]);
        $item->setAttribute("link", $links[$key]);
      }
    }

    if (isset($showSlidePost)) {
      $containers = $xml->getElementsByTagName('container');
      foreach ($containers as $key => $container) {
        $container->setAttribute('showslide', $showSlidePost);
      }
    } else {
      $containers = $xml->getElementsByTagName('container');
      foreach ($containers as $key => $container) {
        $container->setAttribute('showslide', "false");
      }
    }
    
    $xml->save("slideconfig.xml");

    //Exibindo a página de administração
    AdminSliderHandler::slider();
  }
}


// $xml = new DOMDocument("1.0", "ISO-8859-15");

// $container = $xml->createElement("container");

// for ($i = 0; $i < 5; $i++) {
//   $item = $xml->createElement("item");
//   $img = $xml->createAttribute('img');
//   $link = $xml->createAttribute('link');
//   $img->value = 'link-da-imagem';
//   $link->value = 'link-do-link';
//   $item->appendChild($img);
//   $item->appendChild($link);

//   $container->appendChild( $item );      
// }

// $xml->appendChild( $container );
// $xml->save("slideconfig.xml");

?>

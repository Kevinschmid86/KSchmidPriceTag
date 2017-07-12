<?php
/**
 * Created by PhpStorm.
 * User: kevin.schmid
 * Date: 02.01.2017
 * Time: 20:35
 */

namespace KSchmidPriceTag;

use Shopware\Components\Plugin;

class KSchmidPriceTag extends Plugin
{

    public static function getSubscribedEvents()
    {
        return [
            'Enlight_Controller_Action_PostDispatchSecure_Backend_Article' => 'onPostDispatchArticle'
        ];
    }

    public function onPostDispatchArticle(\Enlight_Event_EventArgs $args)
    {
        /** @var \Enlight_Controller_Action $controller */
        $controller = $args->get('subject');
        $request    = $controller->Request();
        $view       = $controller->View();

        $view->addTemplateDir(__DIR__ . '/Resources/Views/');

        if ($request->getActionName() == 'load') {
            //Erweiterung der Standard View ganz unten
            //$view->extendsTemplate('backend/price_tag/article/view/window.js');
            //Erweiterung der Toolbar oben vom Produkt beim Bereich duplizieren
            $view->extendsTemplate('backend/price_tag/article/view/toolbar.js');
        }

    }
}
<?php
/**
 * Created by PhpStorm.
 * User: kevin.schmid
 * Date: 02.01.2017
 * Time: 21:21
 */

use Shopware\Components\CSRFWhitelistAware;

include_once(Shopware()->DocPath() . "engine/Library/Mpdf/mpdf.php");
require (__DIR__ .'/../../vendor/autoload.php');

class Shopware_Controllers_Backend_KSchmidPriceTagPdfPrint extends Shopware_Controllers_Backend_ExtJs implements CSRFWhitelistAware{

    /**
     * @return array
     */
    public function getWhitelistedCSRFActions()
    {
        return [
            'print'
        ];
    }

    public function printAction()
    {
        $articleid = $this->Request()->getParam('articleid');
        $shopId = $this->Request()->getParam('shopId');

        //Hole aktuellen Shopware Shop Context

        $repository = Shopware()->Container()->get('models')->getRepository('Shopware\Models\Shop\Shop');
        $shop = $repository->getActiveById($shopId);
        $shop->registerResources();

        $templateEngine = clone Shopware()->Template();
        $template = $templateEngine->createTemplate(__DIR__ . '/../../Resources/Views/documents/price_tag.tpl','price_tag');

        //Hole Artikel Infos
        //Versuche Artikel zu laden;
        try
        {
            $article = Shopware()->Modules()->Articles()->sGetArticleById($articleid);
        }
        catch(Exception $ex)
        {
            echo $ex->getMessage();
        }

        if($article !== null && count($article) > 0)
        {
            //Assign Article to template
            //print_r($article);
            $template->assign('sArticle', $article);

            //Erstelle EAN HTML Code sofern vorhanden
            if($article['ean'] != '')
            {
                $generator = new \Picqer\Barcode\BarcodeGeneratorPNG();
                $htmlBarcode = '<img src="data:image/png;base64,' . base64_encode($generator->getBarcode($article['ean'], $generator::TYPE_CODE_128)) . '">';
            }
            else
            {
                $htmlBarcode = '';
            }

            $template->assign('sArticleBarcode',$htmlBarcode);

            //Aus den Einstellungen holen, die Breite und Höhe
            $mpdf = new mPDF('utf-8', array(98.5,297), 0, '', 2, 2, 2, 2, 9, 9, 'P');
            $mpdf->WriteHTML($template->fetch());
            $mpdf->Output('Preisschild.pdf','D');
        }
        else
        {
            echo "\r\nArtikel nicht aktiviert oder keine Kategorie zugeordnet";
        }



    }
}

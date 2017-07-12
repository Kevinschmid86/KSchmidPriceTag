<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; utf-8">
    <title></title>
    <style type="text/css">
        @page {
            margin: 7cm 2mm 0 2mm;
        }

        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            font-size: 10pt;
            line-height: 1.5;
        }

        h1 {
            font-size: 13pt;
            font-weight: bold;
            margin:0;
        }

        #artikelname {
            text-align: left;
        }

        #geschmacksrichtung {
            border-bottom:0.5pt solid blue;
            padding-bottom:2mm;
        }

        #geschmacksrichtung table tr td {
             font-size:8pt;
             font-style: italic;
         }

        #priceinfo {
            margin:2mm 0;
        }

         #price {
            text-align: center;
            color:blue;
            font-size:8pt;
        }

        #beschreibung {
            border:0.5pt solid #000000;
            padding: 2mm 1mm;
        }

        #htmlbarcode {
            margin-top:2mm;
            text-align: center;
            width:25%;
        }

    </style>
<body>
    {foreach $sArticle.sProperties as $sProperty}
        {if $sProperty.name == "Land"}
            {assign var="land" value=$sProperty.value|escape}
        {/if}

        {if $sProperty.name == "Gebiet"}
            {assign var="gebiet" value=$sProperty.value|escape}
        {/if}

        {if $sProperty.name == "Geschmack"}
            {assign var="geschmack" value=$sProperty.value|escape}
        {/if}
    {/foreach}

    {if $land || $gebiet}
        <div id="herkunft">
            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                <tbody>
                    <tr>
                        {if $land}
                            <td width="50%">
                                {$land}
                            </td>
                        {/if}
                        {if $gebiet}
                            <td width="50%">
                                {$gebiet}
                            </td>
                        {/if}
                    </tr>
                </tbody>
            </table>
        </div>
    {/if}
    <div id="artikelname">
        <h1>
            {if $sArticle.attr6}
                {$sArticle.attr6}
            {/if}
            {$sArticle.articleName}
        </h1>
    </div>
    <div id="artikelZusatz">
        {$sArticle.attr4}
    </div>
    <div id="erzeuger">
        {$sArticle.supplierName}
    </div>
    <div id="geschmacksrichtung">
        <table cellpadding="0" cellspacing="0" width="100%" border="0">
            <tbody>
                <tr>
                    <td width="85%">
                        {$geschmack}
                    </td>
                    <td width="15%" style="text-align: right;">
                        {$sArticle.purchaseunit} {$sArticle.sUnit.description}
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div id="priceinfo">
        <table cellpadding="0" cellspacing="0" width="100%" border="0">
            <tbody>
                <tr>
                    <td width="25%">
                        <h1>{$sArticle.ordernumber}</h1>
                    </td>
                    <td width="50%" id="price">
                        ({$sArticle.referenceprice|currency} / {$sArticle.referenceunit} {$sArticle.sUnit.description})
                    </td>
                    <td width="25%" style="text-align: right;">
                        <h1>{$sArticle.price_numeric|currency}</h1>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    {if $sArticle.description_long}
        <div id="beschreibung">
            {$sArticle.description_long|strip_tags}
        </div>
    {/if}
    {if $sArticleBarcode}
        <div id="htmlbarcode">
            {$sArticleBarcode}
        </div>
    {/if}
</body>
</html>
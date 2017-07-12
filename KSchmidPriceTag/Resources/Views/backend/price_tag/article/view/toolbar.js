//{block name="backend/article/view/detail/toolbar" append}
Ext.override(Shopware.apps.Article.view.detail.Toolbar, {

    /**
     * Creates all elements for the toolbar
     * @returns Array
     */
    createToolbarElements: function() {
        var me = this,
        /*
            items = [];

        items.push(me.createShopComboBox());
        items.push(me.createPreviewButton());
        items.push({ xtype: 'tbspacer', width: 10 });
        items.push(me.createDuplicateButton());
        items.push(me.createDeleteButton());

        items = me.callParent(arguments);

        */

        items = me.callParent(arguments);
        items.push(me.createPriceTagButton());
 
        return items;
    },


    /**
     * Creates the article preview button
     * @returns Ext.button.Button
     */
    createPriceTagButton: function() {
        var me = this;

        me.createPriceTagButton = Ext.create('Ext.button.Button', {
            text: 'Preisschild drucken',
            name: 'pdf-print-button',
            iconCls: 'sprite-blueprint',
            handler: function() {
                //console.log(me.article.getCategory().data.items);
                //console.log(me.article.get('id'));
                var shopId = 1;
                var catItems = me.article.getCategory().data.items;
                if(catItems.length > 0)
                {
                    //console.log(catItems[0].data.name.indexOf('Ladenartikel'));
                    if(catItems[0].data.name.indexOf('Ladenartikel') != -1)
                    {
                        //console.log('Ladenartikel gefunden');
                        shopId = 3;
                    }
                }
                var url = "{url controller=KSchmidPriceTagPdfPrint action=print}" + '?articleid=' + me.article.get('id') + '&shopId=' + shopId;
                var win = window.open(url, '_blank');
                win.focus();
            }
        });

        return me.createPriceTagButton;
    }
});
//{/block}
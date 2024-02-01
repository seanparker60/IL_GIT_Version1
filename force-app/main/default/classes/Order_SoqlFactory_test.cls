@Istest
public with sharing class Order_SoqlFactory_test {
    

    Public static testmethod void SoqlFactory1(){
        
        Test.startTest();

        List<Account> lstAccount = TestDataFactory.insertAccountsSubsidiary(1, 'Noordhoff',true,true);

        Set<String> Set_AccId = new Set<String>();
        for(Account acc:lstAccount){
            Set_AccId.add(acc.id);
        }
    
        AccountSubsidiary__c[] lstAccountSubsidiary = [Select id,Account__c from AccountSubsidiary__c where Account__c in:Set_AccId ];
    
        Map<String,String> Map_AccSub = new Map<String,String>();
        Integer i=0;
        for(AccountSubsidiary__c  sub:lstAccountSubsidiary){
            sub.NetsuiteInternalId__c = '88776'+i;
            Map_AccSub.put(sub.Account__c,sub.id);
            i++;
        }
    
        update lstAccountSubsidiary;
    
        List<Product2> lstProduct = TestDataFactory.insertProducts(1,true);
        Pricebook2 standardPricebook = TestDataFactory.insertPricebook();
        List<PricebookEntry> lstPricebookEntry = TestDataFactory.insertPricebookEntry(standardPricebook.id ,lstProduct,true);
        List<Contract> lstContract = TestDataFactory.insertContract(1,lstAccount,standardPricebook.id,true);
        List<Order> lstOrder = TestDataFactory.insertOrderHeader(1,lstAccount,lstContract,standardPricebook.id,true);
        List<ListPriceDiscount__c> ListPriceDiscount = Order_TestDataFactory.insertListPriceDiscount(5,'Regular','Workbooks',true);
        List<OrderItem> lstOrderItems = TestDataFactory.insertOrderItems(1,lstAccount,Map_AccSub,lstOrder,lstPricebookEntry,true); 
    
        Set<String> Set_CusDiscountGroup = new Set<String>();
        Set<String> Set_OperatingCo = new Set<String>();
        Set<String> Set_ProdDiscountGroup = new Set<String>();
        Set<String> Set_OrderLineItemType = new Set<String>();
        Set<String> Set_MarketSegment = new Set<String>();


        

        Set<String> Set_ItemId = new Set<String>();
        List<Id> OrderId = new List<Id>();
        Set<String> Set_ItemGroupBlock = new Set<String>();  
        List<Id> MaxOrderLineId = new List<Id>();
        Set<String> ShiptoId = new Set<String>();
        String LPDType;
        String Type;
        String PricingMethod;


        for(OrderItem item:lstOrderItems){ 
            ShiptoId.add(item.ShipToAccount__c);
            Set_ItemId.add(item.id);
            OrderId.add(item.OrderId);
        }




        //SOQLS
        Type = 'AssetsCreateOnOrderActivation';
        OrderItem[] lstOrderItem = order_soqlfactory.returnQueryOrderItems(Set_ItemId,OrderId,Set_ItemGroupBlock,Type);        
        Type = 'ProductSelectController';
        lstOrderItem = order_soqlfactory.returnQueryOrderItems(Set_ItemId,OrderId,Set_ItemGroupBlock,Type);

        Type = 'OrderActivateQueueHandler';
        lstOrder = order_soqlfactory.returnQueryOrder(OrderId,MaxOrderLineId,Type);
        Type = 'OrderInsertQueuable';
        order_soqlfactory.returnQueryOrder(OrderId,MaxOrderLineId,Type);

        List<Map<String,String>> Map_AccSubList = order_soqlfactory.returnAccountSubsidiary(ShiptoId);
        

        for(OrderItem item:lstOrderItem){ 
            Set_CusDiscountGroup.add(item.Order.Billto__r.CustomerDiscountGroup__c); 
            Set_OperatingCo.add(item.Order.Billto__r.OperatingCompany__c);
            Set_ProdDiscountGroup.add(item.Product2.ProductDiscountGroup__c);
            Set_OrderLineItemType.add(item.OrderLineType__c);
        }
        ListPriceDiscount__c[] lstListPrice = order_soqlfactory.returnListPriceDiscount(LPDType,PricingMethod,lstOrder ,Set_CusDiscountGroup,Set_OperatingCo,Set_ProdDiscountGroup,Set_OrderLineItemType,Set_MarketSegment);

        Test.stopTest();
        
    }
    
    Public static testmethod void SoqlFactory2(){
        
        Test.startTest();


        List<Product2> lstProductItemGroup = TestDataFactory.insertProducts(3,true);
        List<Product2> lstProductItem = TestDataFactory.insertProducts(1,true);
        
        List<Product2> lstProduct = TestDataFactory.insertProducts(1,true);
        List<Product2> lstProductSuccessor = TestDataFactory.insertProducts(1,true);

        Order_TestDataFactory.UpdateSuccessorItem(lstProduct, lstProductSuccessor, true);

        Pricebook2 standardPricebook = TestDataFactory.insertPricebook();
        List<PricebookEntry> lstPricebookEntry = TestDataFactory.insertPricebookEntry(standardPricebook.id ,lstProductItem,true);

        Pricebook2 PricebookCustom = TestDataFactory.insertPricebookCustom('Plantyn - All Products 2021');
        lstPricebookEntry = TestDataFactory.insertPricebookEntry(PricebookCustom.id ,lstProductItem,true);

        List<ProductComponent__c> lstProductComponent = Order_TestDataFactory.InsertGroupComponent(lstProductItem,lstProductItemGroup,true);
        Pricing__c[] lstPricing = Order_TestDataFactory.InsertPricing(lstProductItem,lstProductComponent,true);

        Pricing__c[] lstPricingComponent = Order_TestDataFactory.InsertPricingProductComponent(lstProductComponent,true);

        lstPricing.addall(lstPricingComponent);

        //Products not added to the Price book with Pricing
        lstProductItemGroup = TestDataFactory.insertProducts(3,true);
        lstProductItem = TestDataFactory.insertProducts(1,true);
        lstProductComponent = Order_TestDataFactory.InsertGroupComponent(lstProductItem,lstProductItemGroup,true);
        Pricing__c[] lstPricing2 = Order_TestDataFactory.InsertPricing(lstProductItem,lstProductComponent,true);
        Pricing__c[] lstPricingComponent2 = Order_TestDataFactory.InsertPricingProductComponent(lstProductComponent,true);


        //SOQLS
        String Type;
        String Pricebook2Id;
        String SearchString;

        List<Id> lst_ProdPriceId = new List<Id>();

        Set<String> Set_PriceBook = new Set<String>(); 
        Set<String> Set_Subsid = new Set<String>();
        Set<String> Set_ProdId = new Set<String>();
        

        Set<String> Set_SuccProductId= new Set<String>();
        Set<String> Set_ProdItemGroup= new Set<String>();
        Map<String,String> Map_ItemGroup = new Map<String,String>();

            for(PricebookEntry pbe:lstPricebookEntry ){
                    Set_ProdId.add(pbe.Product2Id);
                    Set_PriceBook.add(pbe.Pricebook2Id);                     
            }
            
            for(Product2 prod:lstProduct){
                Set_SuccProductId.add(prod.SuccessorItem__c);
            }
            for(ProductComponent__c comp: lstProductComponent){
                Set_ProdItemGroup.add(comp.MainProduct__c);
                lst_ProdPriceId.add(comp.Product__c);
            }

        Set_Subsid.add(PricebookCustom.Subsidiary__c);
        Pricebook2Id = PricebookCustom.id;

        lstProduct = order_soqlfactory.returnProduct(Set_ProdId);

        Pricebook2[] lstPricebook = order_soqlfactory.returnPricebook(Set_PriceBook, Set_Subsid);   
        

        Type = 'AssetRenewalProductsbyPriceBook';
        SearchString = 'Prod';
        PricebookEntry[] lstPBEntry = order_soqlfactory.returnPricebookEntry(Type,SearchString, Set_ProdId,Set_Pricebook,Pricebook2Id,Map_ItemGroup,Set_SuccProductId);


        Type ='AssetRenewalProductsbyPriceBookSuccessor';
        lstPBEntry = order_soqlfactory.returnPricebookEntry(Type,SearchString, Set_ProdId,Set_Pricebook,Pricebook2Id,Map_ItemGroup,Set_SuccProductId);

        Type = 'ProductSelectorSearch';
        lstPBEntry = order_soqlfactory.returnPricebookEntry(Type,SearchString, Set_ProdId,Set_Pricebook,Pricebook2Id,Map_ItemGroup,Set_SuccProductId);

        Type = 'ProductSelector1';
        lstPricing =order_soqlfactory.returnPricing(Type,Set_ProdItemGroup,lst_ProdPriceId);

        Test.stopTest();
        
    }    


  
    Public static testmethod void SoqlFactory3(){
        
        Test.startTest();
        List<Account> lstAccount = TestDataFactory.insertAccountsSubsidiary(1, 'Noordhoff',true,true); 
        
        
        List<Product2> lstProduct = TestDataFactory.insertProducts(1,true);
        Pricebook2 standardPricebook = TestDataFactory.insertPricebook();
        List<PricebookEntry> lstPricebookEntry = TestDataFactory.insertPricebookEntry(standardPricebook.id ,lstProduct,true);
        List<Asset>lst_Asset = TestDataFactory.insertAsset(standardPricebook.id ,lstProduct,lstAccount, lstAccount,true);
       
        Set<String> Set_BillTo = new Set<String>();

        for(Account acc:lstAccount){
                Set_BillTo.add(acc.id);
        }          

        //SOQLS
        String Type = 'renewal';

        String strAsset = order_soqlfactory.returnasset(Type,Set_BillTo);
        Test.stopTest();
        
    }


    
/*
    Public static testmethod void SoqlFactory4(){
        
        Test.startTest();
        List<Account> lstAccount = TestDataFactory.insertAccountsSubsidiary(1, 'Plantyn',true,true);
        
        List<Product2> lstProductItemGroup = TestDataFactory.insertProducts(3,true);
        List<Product2> lstProductItem = TestDataFactory.insertProducts(1,false);

        Integer x=0;
        for(Product2 prod:lstProductItem){
            if(x==0){
                prod.Renewal__c = 'Manual';
            }
            else{
                prod.Renewal__c = null;
            }
            x++;
        }
        insert lstProductItem;

        Pricebook2 standardPricebook = TestDataFactory.insertPricebook();


        List<ProductComponent__c> lstProductComponent = Order_TestDataFactory.InsertGroupComponent(lstProductItem,lstProductItemGroup,true);
        
        
        List<PricebookEntry> lstPricebookEntryItemGroup = TestDataFactory.insertPricebookEntry(standardPricebook.id ,lstProductItemGroup,true);
        List<PricebookEntry> lstPricebookEntryItem = TestDataFactory.insertPricebookEntry(standardPricebook.id ,lstProductItem,true);
        lstPricebookEntryItemGroup.AddAll(lstPricebookEntryItem);
        
        //Fires Process Builder (Invocable method)
        Order_TestDataFactory.InsertPricing(lstProductItem,lstProductComponent,true);
        Order_TestDataFactory.InsertPricingProductComponent(lstProductComponent,true);
     
        
        List<Contract> lstContract = TestDataFactory.insertContract(1,lstAccount,standardPricebook.id,true);
        List<Order> lstOrder = TestDataFactory.insertOrderHeader(1,lstAccount,lstContract,standardPricebook.id,true);


        Set<String> Set_AccId = new Set<String>();
        for(Account acc:lstAccount){
            Set_AccId.add(acc.id);
        }

        AccountSubsidiary__c[] lstAccountSubsidiary = [Select id,Account__c from AccountSubsidiary__c where Account__c in:Set_AccId ];

        Map<String,String> Map_AccSub = new Map<String,String>();
        Integer i=0;
        for(AccountSubsidiary__c  sub:lstAccountSubsidiary){
            sub.NetsuiteInternalId__c = '88776'+i;
            Map_AccSub.put(sub.Account__c,sub.id);
            i++;
        }

        List<OrderItem> lstOrderItems = TestDataFactory.insertOrderItems(1,lstAccount,Map_AccSub,lstOrder,lstPricebookEntryItemGroup,true);
        
        List<Opportunity> lstOpportunity =  TestDataFactory.insertOpportunityHeader(1,lstAccount,standardPricebook.id,false);
        
        for(Opportunity opp:lstOpportunity){
            opp.PricingMethod__c = 'OrderTotalAmount';
        }

        insert lstOpportunity;


        List<OpportunityLineItem> lstOpportunityItems = TestDataFactory.insertOpportunityItems(2,lstAccount,lstOpportunity, lstPricebookEntryItemGroup,true);
        



        //SOQLS
        OpportunityLineItem[] lstOpportunity = order_soqlfactory.returnOpportunityLine(String curOrderId);
        Test.stopTest();
        
    }

            
    
    Public static testmethod void SoqlFactory5(){
        
        Test.startTest();
        List<Account> lstAccount = TestDataFactory.insertAccountsSubsidiary(1, 'Noordhoff',true,true);

        Set<String> Set_AccId = new Set<String>();
        for(Account acc:lstAccount){
            Set_AccId.add(acc.id);
        }

        AccountSubsidiary__c[] lstAccountSubsidiary = [Select id,Account__c from AccountSubsidiary__c where Account__c in:Set_AccId ];

        Map<String,String> Map_AccSub = new Map<String,String>();
        Integer i=0;
        for(AccountSubsidiary__c  sub:lstAccountSubsidiary){
            sub.NetsuiteInternalId__c = '12345'+i;
            Map_AccSub.put(sub.Account__c,sub.id);
            i++;
        }

        update lstAccountSubsidiary;


        lstAccount = [Select NetsuiteInternalId__c from Account];
        List<ImportOrder__c> lstinsertImportOrder = Order_TestDataFactory.insertImportOrderOrder(lstAccount,false,OrderExternalId,'eCommerce B2B');
        lstinsertImportOrder[0].Status__c = 'Completed';
        insert lstinsertImportOrder;
 
        List<ImportOrder__c> lstinsertImportOrderItem = Order_TestDataFactory.insertImportOrderItem(lstProductItem,false,OrderExternalId,null,'eCommerce B2B');
        List<ImportOrder__c> lstinsertImportOrderItemGroup = Order_TestDataFactory.insertImportOrderItem(lstProductItemGroup,false,OrderExternalId,lstProductItem[0].EAN__c,'eCommerce B2B');
        lstinsertImportOrderItem.addAll(lstinsertImportOrderItemGroup);
       
       for(ImportOrder__c io : lstinsertImportOrderItem){
            io.Status__c = 'Completed';   
       }
       insert lstinsertImportOrderItem;




        //SOQLS
        ImportOrder__c[] lstImportOrder = order_soqlfactory.returnImportOrders(String Type,List<Id> OrderId,Set<String> Set_ExternalOrderId,Set<String> Set_ImportOrderId);

        Test.stopTest();
        
    }
*/
   

}
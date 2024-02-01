public with sharing class Order_SoqlFactory {

//Comment

    
    Public static List<OrderItem> returnQueryOrderItems(Set<String> Set_ItemId,List<Id> OrderId, Set<String> Set_ItemGroupBlock,  String Type){

        String Querystr;
        
            Querystr= 'Select id,'
            +' AccountSubsidiary__c,'
            +' CustomerReference__c,'
         +' ComponentListPrice__c,'
         +'  DeliveryType__c,'
         +' discount__c,'
         +' DigitalActivationEMail__c,'
         +' DiscountedPrice__c,' 
         +' DiscountedPriceItemGroup__c,'
         +' EndDate,'
         +'  ItemGroup__c,'     
         +' IsInspectionCopyOrderPossible__c,'
         +' IsRegularOrderPossible__c,'
         +' IsUseCopyOrderPossible__c,'
         +' ImportItemGroupEAN__c,' 		    
         +' ListPriceDiscountRate__c,'        
         +' LineItemTotal__c,'
         +' ListPriceItemGroup__c,'
         +' ListPriceDiscount__c,'
         +'  ListPrice,'
         +'  List_Price_Rate__c,' 
         +' MultiShiptoInventoryRollingCount__c,'
         +' MultiShipAddressRollingCount__c,'       
         +' ManualDiscountValue__c,'
         +' ManualDiscount__c,'
         +' ManualDiscountPercent__c,'
         +' NetSuiteIdShiptoAccount__c,'
         +' NetSuiteIdBilltoAccount__c,'
         +' NetsuiteInternalId__c,'          
         +' NetSalesPriceItemGroup__c,'
         +' NetsuiteListPrice__c,'
         +'  NetsuiteQuantity__c,'
         +' OrderMultipleShippingLocations__c,'
         +' orderImportNumber__c,'
         +' OrderId,'
         +' OrderLineType__c,'
         +' ProductType__c,'
         +'  Product2Id,'
         +'  ProductLicenseDuration__c, '
         +' PricebookEntryId,'
         +' ProductEAN__c,'
         +' ProductComponent__c,'
         +'  Quantity,'
         +' Renewable__c,'
         +' StartDate__c,'
         +' ServiceDate,'
         +' ShipToAccount__c,'
         +' ShippingCity__c,'
         +' ShippingCountry__c,'
         +' ShippingPostalCode__c,'
         +' ShippingState__c,'
         +' ShippingStreet__c,'
         +' ShippingIndicationRule__c,' 
         +' TrialStartDate__c,'
         +' TrialEndDate__c,'  
         +' TotalDiscountAmount__c,'
         +' UnitPrice,'
         +' VATCalculated__c,' 
         +' ItemGroup__r.ProductEAN__c,'
         +' Order.ShippingCostExempt__c,'
         +' Order.Billto__r.CustomerDiscountGroup__c,'
         +' Order.Billto__r.OperatingCompany__c,'
         +' Order.ShippingIndicationRule__c,'
         +' Order.ShippingCostMethodNS__c,'        
         +' Order.MultipleShippingLocations__c,' 
         +' Order.DigitalActivationEMail__c,'
         +' Order.PricingMethod__c,'
         +' Order.Pricebook2.Name,'
         +' Order.CurrencyIsoCode,'
         +' Order.Source__c,'
         +' Order.ShipbyDate__c,'
         +' Product2.ProductRateGroup__c,'  
         +' Product2.FixedStartDate__c,'
         +' Product2.FreeFromDate__c,'         
         +' Product2.MarketSegment__c,'
         +' Product2.LicenseDuration__c,'
         +' Product2.Name,'
         +' Product2.IsSuccessorItemActive__c,'
         +' Product2.SuccessorItem__c,'
         +' Product2.Stocknumber__c,'
         +' Product2.StockLevel__c,' 
         +' Product2.PlannedPrintDate__c,'
         +' Product2.OrderLineType__c,'
         +' Product2.ProductDiscountGroup__c,'
         +' ProductComponent__r.Quantity__c,'
         +' ShipToAccount__r.NumberOfStudents__c,'
         +' VATRule__c,'		
         +' VATRule__r.Rate__c'
         +'  from OrderItem where ';
         
         if(OrderId != null){
             querystr += 'OrderId in: OrderId';
         }
         else if(Set_ItemGroupBlock != null){
            querystr += 'id in: Set_ItemId AND Product2Id not in: Set_ItemGroupBlock';
         }
         else{
            querystr += 'Id in: Set_ItemId';
         }

         if(Type == 'AssetsCreateOnOrderActivation'){
            querystr += ' limit 200 ';
         }

         else if(Type == 'ProductSelectController'){
            querystr += ' Order By createddate ASC';
         }
         

         OrderItem[] lst_OrdItem =  Database.query(querystr);

         


         
        
        //    Order_OrdeItemFromOrderFlow (DONE)
                //from OrderItem where OrderId in:req[0].OrderId (DONE)
         //Order_OrderandOrdeItemHandler (NB) (DONE)
                //From OrderItem where OrderId in:recordIdStrings (DONE)
         //Order_UpdateOrderListPriceDiscountAll (DONE)
                //From OrderItem where OrderId in:lstOrderId (DONE)
        //Order_UpdateShippingCostsFromItems (DONE)
                //OrderItem where id in:Set_ItemId (DONE)
        //Order_UpdateVatOnItems (DONE)
                //where id in:Set_ItemId (DONE)

        //Order_AssetsCreateOnOrderActivation (DONE)
            //From OrderItem where Id in:ItemId limit 200 (DONE)
        // Order_ProductSelectController  (DONE)
            //From OrderItem where OrderId =:curOrderId Order By createddate ASC (DONE)
    //Order_ImportOrderItemGroupUpdate (DONE)
            //from OrderItem where OrderId in: Set_OrderId (DONE)
            //from OrderItem where id in: Set_ItemId AND Product2Id not in: Set_ItemGroupBlock (DONE)
         return lst_OrdItem;
   }    

   Public static List<Order> returnQueryOrder(List<Id> OrderId, List<Id> MaxOrderLineId){

    String Querystr;
   

    Querystr= 'Select id,'

     + 'ActivateforBatchProcessing__c, '
     +' AccountSubsidiary__c, ' 
     +' BillingCity, ' 
     +' BillingStreet, ' 
     +' BillingPOstalcode, ' 
     +' BillingCountry, ' 
     +' BillingAddressNote__c, ' 
     +' BillingReminderEmail__c,  '
     +' BillingReminderEmail2__c,  '      
     +' Billto__c, '   
     +' ContractId,'  
     + 'CurrencyIsoCode,'
     +' CustomerReference__c, '
     +' DigitalActivationEmail__c,  ' 
     +' DeliveryEmail__c, '
     +' DeliveryPhone__c, ' 
     +' DateUpdateBlock__c,' 
     +' EffectiveDate, ' 
     +' ExternalOrderId__c,'
     +' ForTheAttentionOf__c,'
     +' ItemGroupCount__c, '
     +' InvoiceEmail__c,  ' 
     +' InvoiceEmail2__c,  ' 
     +' LineCount__c, '
     +' MultipleShippingLocations__c,'
     +' MasterOrder__c, ' 
     +' NetSuiteIdAccountSubsidiary__c, '
     +' NetSuiteIdShiptoAccount__c, ' 
     + 'OrderNumber, '
     +' OrderImportLineCount__c, ' 
     +' OrderReferenceNumber, '
     +' OrderNotificationEmail__c, '
     +' OrderNotificationEmail2__c, ' 
     +' OperatingCompany__c, ' 
     +' PaymentMethod__c , '      
     +' PricingMethod__c, ' 
     +' Pricebook2Id, '       
     +' ShipByDate__c, '
     +' Shipto__c,  ' 
     +' ShippingCity, ' 
     +' ShippingStreet, ' 
     +' ShippingPOstalcode, ' 
     +' ShippingCountry, ' 
     +' Source__c, ' 
     +' ShippingCost__c, ' 
     +' ShippingCostDomestic__c, ' 
     +' ShippingCostNonDomestic__c, '
     +' ShippingCostMethod__c, '
     +' ShippingCostMethodNS__c, '
     +' ShippingCostMethodNsId__c, ' 
     +' ShippingIndicationRule__c,'
     +' ShippingCostExempt__c, '
     +' shipToAttentionOf__c,'
     +' ShippingAddressNote__c, ' 
     +' Status, ' 
     +' TotalAmount , ' 
     +' Type, ' 
     + ' ValidateB2BLineCountError__c, '
     +' ValidationErrorsOrder__c, '
     +' ValidationErrorsOrderProducts__c '
     +' WarehouseReference__c, '
     +' Shipto__r.NetsuiteInternalId__c, ' 
     +' Account.BillingReminderEmail__c,  ' 
     +' Account.DigitalActivationEmail__c,  ' 
     +' Account.InvoicingEmail__c,  ' 
     +' Account.OrderNotificationEmail__c, ' 
     +' Account.BillingReminderEmail2__c,  ' 
     +' Account.InvoiceEmail2__c,  ' 
     +' Account.OrderNotificationEmail2__c, ' 
     +' Account.NetsuiteInternalId__c,'    
     +' Account.BillingAddressNotes__c, ' 
     +' Account.ShippingAddressNotes__c, ' 
     +' Billto__r.PaymentMethod__c, '
     +' Billto__r.CustomerDiscountGroup__c, '
     +' Billto__r.OperatingCompany__c, '
     +' Billto__r.BillingReminderEmail__c, '
     +' Billto__r.BillingReminderEmail2__c, '
     +' Billto__r.InvoicingEmail__c,  ' 
     +' Shipto__r.OrderNotificationEmail__c,  ' 
     +' Shipto__r.OrderNotificationEmail2__c, '
     +'  from Order where ';
     
     if(Type == 'OrderActivateQueueHandler'){
        querystr += 'Id not in: OrderId AND id !=:checked AND  ActivateforBatchProcessing__c =:true AND ValidateB2BLineCountError__c=:0 AND  ActivateforBatchProcessing__c =:true  and Status !=: 'Activated' and ValidationErrorsOrder__c =:0 and ValidationErrorsOrderProducts__c =:0 and LineCount__c >:0 Order by LineCount__c ASC limit 1';
     }
     else if(MaxOrderLineId == null || Type == 'OrderInsertQueuable'){
         querystr += 'Id in: OrderId';
     }
     else{
        querystr += 'MaxOrderLine__c in:MaxOrderLineId';
     }



     Order[] lst_Ord =  Database.query(querystr);

     //--(DONE)- Order_ProductSelectController  from Order where id=: NewOrderId 
    // --(DONE)- - Order_OrdeItemFromOrderTypeChange Order where id =: req[0].OrderId 
    //-(DONE)- Order_OrderActivateQueueHandler (?) FROM Order where id not in: Set_Checked AND id !=:checked AND  ActivateforBatchProcessing__c =:true AND ValidateB2BLineCountError__c=:0 AND  ActivateforBatchProcessing__c =:true  and Status !=: 'Activated' and ValidationErrorsOrder__c =:0 and ValidationErrorsOrderProducts__c =:0 and LineCount__c >:0 Order by LineCount__c ASC limit 1
   // -(DONE) Order_OrderActivateRESTAPI from Order where Id =: OrdId
   // -(DONE)- Order_OrderandOrdeItemHandler (NB) Order where id in: recordIdStrings
     return lst_Ord;
}

Public static List<ListPriceDiscount__c> returnListPriceDiscount(Order[] lst_Order ,Set<String> Set_CusDiscountGroup, Set<String> Set_OperatingCo, Set<String> Set_ProdDiscountGroup, Set<String> Set_OrderLineItemType, Set<String> Set_MarketSegment){

    String Querystr;
    Date CurDate = system.today();
    
    
Querystr =  'Select id,'
+' DiscountType__c, '
+' ProductDiscountGroup__c, '
+' Subsidiary__c, '
+' ValueType__c, '
+' StartAmount__c, '
+' CustomerDiscountGroup__c, '
+' OrderLineType__c, ' 
+' MarketSegment__c, '
+' Rate__c, '
+' StartQuantity__c ' 
+' from ListPriceDiscount__c where '
+' EndDate__c >=:CurDate  AND StartDate__c  <=:CurDate';

if(Type =='AllDiscount' || Type == 'OrderTypeChange'){
    Querystr += ' AND CustomerDiscountGroup__c in: Set_CusDiscountGroup AND Subsidiary__c in: Set_OperatingCo  AND ProductDiscountGroup__c in: Set_ProdDiscountGroup  AND OrderLineType__c in: Set_OrderLineItemType '; // AND MarketSegment__c in: Set_MarketSegment
}
else if(Type =='ProductSelector'){
    Querystr += ' AND CustomerDiscountGroup__c =: Set_CusDiscountGroup AND Subsidiary__c =: Set_OperatingCo  '; 
}
if(Type =='AllDiscountv2' ){
    //Do nothing for now: remove later when call to method is done.
}

if(lst_Order[0].PricingMethod__c=='OrderTotalAmount'){
    Querystr += ' AND ValueType__c = \'Amount\' ';                
    Querystr += ' ORDER BY StartAmount__c DESC';
}
else{
    if(Type =='ProductSelectorv2'){
        +' AND StartQuantity__c <=: NoStudents   '; 
    }
   
    Querystr += ' AND ValueType__c = \'Quantity\' '; 
    Querystr += ' ORDER BY StartQuantity__c DESC'; 
}

ListPriceDiscount__c[] lst_ListPriceDiscountRegular =  Database.query(querystr);

return lst_ListPriceDiscountRegular;


//--(DONE)--Product selector v2
 
//--(DONE)--where  StartQuantity__c <=: NoStudents   
//--(DONE)--AND  EndDate__c >=:CurDate 
//--(DONE)--AND StartDate__c  <=:CurDate ORDER BY StartQuantity__c DESC];

        //OrdeItemFromOrderTypeChange
     
     //   where  EndDate__c >=:CurDate 
     //   AND StartDate__c  <=:CurDate
     //--(DONE)   AND CustomerDiscountGroup__c in: Set_CusDiscountGroup
     //--(DONE)   AND Subsidiary__c in: Set_OperatingCo 
      //--(DONE)  AND ProductDiscountGroup__c in: Set_ProdDiscountGroup 
      //--(DONE)  AND OrderLineType__c in: Set_OrderLineItemType  
      //--(DONE)  AND MarketSegment__c in: Set_MarketSegment    
      //--(DONE)  ORDER BY StartQuantity__c DESC];


 //List Price discount All       
  //--(DONE)      if(lst_ListPriceDiscountRegular == null){
      //--(DONE)                                                                                        where  EndDate__c >=:CurDate 
    //--(DONE)                                                                                        AND StartDate__c  <=:CurDate  
     //--(DONE)                                                                                       ORDER BY StartQuantity__c DESC];



}

Public static List<PricebookEntry> returnPricebook(Set<String> Set_Subsid,String Type){

    //Pricebook entry create
    String Querystr;
    Date CurDate = system.today();
   
Querystr =  'Select id,'
+' Subsidiary__c,'
+' isStandard,'
+' PricebookType__c,'
+' SoldInSubSegment__c,'
+' EndDate__c,'
+' StartDate__c '
+' from Pricebook2 where '

if(Set_Subsid != null){
    Querystr += ' Subsidiary__c in:Set_Subsid AND IsActive =: true';
}
else{
    Querystr += ' isStandard=true';   
}
 


 //   Pricebook2[] lstPricebook = [Select Subsidiary__c,isStandard,PricebookType__c,SoldInSubSegment__c,EndDate__c,StartDate__c From Pricebook2 where Subsidiary__c in:Set_Subsid AND IsActive =: true ];
 //   Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];

}


Public static List<PricebookEntry> returnPricebookEntry(String Type, String Search){
    String Querystr;
    
    Product2.Renewable__c,Product2.OrderLineType__c,Product2.ISBNArticleNumber__c,Product2.MarketSegment__c,Product2.name,Product2.SoldInSegment__c, Product2.QuantitySelectionType__c,Product2.ProductDiscountGroup__c,Product2.ProductRateGroup__c,Product2.Type__c,productcode,unitprice,Product2Id

    Querystr =  'Select id,'
    +' Pricebook2Id, '
    +' Price__r.ListRate__c,'
    +' Price__c,'	
    +' Product2.name,'
    +' Product2.SoldInSegment__c,' 
    +' Product2.IsSuccessorItemActive__c,'
    +' Product2.SuccessorItem__c,'
    +' Product2.SuccessorItem__r.IsActive,' 
    +' Product2.QuantitySelectionType__c,'
    +' Product2.ProductRateGroup__c,'
    +' Product2.Stocknumber__c,'
    +' Product2.maxQuantity__c,'
    +' Product2.DeliveryStatus__c,' 
    +' Product2.Renewable__c,'
    +' Product2.OrderLineType__c,'
    +' Product2.ISBNArticleNumber__c,'
    +' Product2.MarketSegment__c,'
    +' Product2.ProductDiscountGroup__c,'
    +' Product2.Type__c,'
    +' productcode,'
    +' Product2Id,'
    +' unitprice' 
    +' from PricebookEntry '
    +' where IsActive =:true';
    if(Type ='ProductsbyPriceBook'){
        Querystr += '     AND Pricebook2Id in:Set_Pricebook' 
                 +'     AND (Product2Id in: Set_ProductId OR Product2Id in: Set_SuccProductId)'; 
    }
    else if(Type ='ProductsbyPriceBookSuccessor'){       
        Querystr += '     AND Pricebook2Id in:Set_Pricebook'
        +'     AND Product2Id in: Set_SuccProductId';
    }
    else if(Type == 'ProductSelectorSearch'){
        Search = '%'+SearchString+'%';
      
        Querystr += '      AND Pricebook2Id =:Pricebook2Id'  
      +'      AND Product2Id not in: Set_OrdProd'
      +'       AND Product2.HasBlock__c=: false'
      +'      AND Product2.itemGroupManualBlock__c =: false'
      +'      AND (Product2.Name  like:Search '
      +'          OR Product2.ISBNArticleNumber__c like:Search'
      +'          OR Product2.EAN__c like:Search'
      +'          OR Product2.ISBN__c like:Search'
      +'          OR Product2.Type__c like: Search'
      +'     ) Order by Product2.Name ASC limit 70])';
    }    
    else if(Type == 'ProductSelectorLoad'){
        Querystr += '        where Pricebook2Id =:Pricebook2Id' 
        +'  AND IsActive =: true '
        +' AND Product2.itemGroupManualBlock__c =: false'
        +' AND Product2Id not in: Set_OrdProd'
        +'AND Product2.HasBlock__c=: false Order by Product2.Name ASC limit 70 ])';
    } 
    else if(Type == 'Itemgroupcreate' ){
        Querystr += 'Product2Id in:Set_ProdId'
            +'AND Pricebook2Id !=:standardPB.id';
        if(Set_PB.size()>0){           
            Querystr += 'AND Pricebook2Id in: Set_PB';
        } 
    }
    else if( Type='Successorupdate'){
        Querystr += 'Product2Id in:Set_ProdId'
            +'AND Pricebook2Id !=:standardPB.id';
            +'Product2Id in:Set_Successor AND Pricebook2Id =:lstPricebookEntryExist[0].Pricebook2Id';
    }
    else if( Type='Successorupdate'){
        Querystr += 'Product2Id in:Set_ProdId'
            +'AND Pricebook2Id !=:standardPB.id';
            +'Product2Id in:Set_Successor AND Pricebook2Id =:lstPricebookEntryExist[0].Pricebook2Id';
    }
    
    else if(Type='Pricebookentrycreate_1'){
            Querystr += 'Product2Id in:Set_priceProduct';
    }   
    else if(Type='Pricebookentrycreate_2'){
        Querystr += 'Pricebook2Id=:standardPB.id AND Product2Id in:Set_priceProduct';
    }
    else if(Type='AssetRenewal_1'){
            Querystr += 'Product2Id in:Set_ProdId'
            +'AND Pricebook2Id !=:standardPB.id';
            +'Product2Id in:Set_Successor AND Pricebook2Id =:lstPricebookEntryExist[0].Pricebook2Id';
    }
    else if( Type='Successorupdate_2'){
        Querystr += 'Product2Id in:Set_ProdId'
        +'AND Pricebook2Id !=:standardPB.id';
        +'Product2Id in:Set_Successor AND Pricebook2Id =:lstPricebookEntryExist[0].Pricebook2Id';
    } 
    
  
      //Product selector
      ProductsbyItemGroup = new List <PricebookEntry>([Select Product2.Renewable__c,Product2.OrderLineType__c,Product2.ISBNArticleNumber__c,Product2.MarketSegment__c,Product2.name,Product2.SoldInSegment__c, Product2.QuantitySelectionType__c,Product2.ProductDiscountGroup__c,Product2.ProductRateGroup__c,Product2.Type__c,productcode,unitprice,Product2Id from PricebookEntry //,
      where Pricebook2Id =:Pricebook2Id AND Product2Id in:Map_ItemGroup.keyset() ]);
  


    //Itemgroup create
    //PricebookEntry[] lstPricebookEntryExist;
   //     if(Set_PB.size()>0){
   //         lstPricebookEntryExist = [Select id,Product2Id,Product2.Name, Pricebook2Id,Product2.IsSuccessorItemActive__c,Product2.SuccessorItem__c,Product2.Stocknumber__c,Product2.StockLevel__c, Product2.PlannedPrintDate__c from PricebookEntry 
    //        where Product2Id in:Set_ProdId AND Pricebook2Id !=:standardPB.id AND Pricebook2Id in: Set_PB]; // 
   //     }
    //   else{
     //       lstPricebookEntryExist = [Select id,Product2Id,Product2.Name, Pricebook2Id,Product2.IsSuccessorItemActive__c,Product2.SuccessorItem__c,Product2.Stocknumber__c,Product2.StockLevel__c, Product2.PlannedPrintDate__c from PricebookEntry 
     //       where Product2Id in:Set_ProdId AND Pricebook2Id !=:standardPB.id ]; // 
     //   }

    //Successor update
    
   // if(Set_PB.size()>0){
   //     lstPricebookEntryExist = [Select id,Product2Id, Pricebook2Id,Product2.IsSuccessorItemActive__c,Product2.SuccessorItem__c,Product2.SuccessorItem__r.IsActive,Product2.Stocknumber__c,Product2.StockLevel__c, Product2.PlannedPrintDate__c from PricebookEntry 
   //     where Product2Id in:Set_ProdId AND Pricebook2Id !=:standardPB.id AND Pricebook2Id in: Set_PB]; // 
   // }
   // else{
   //     lstPricebookEntryExist = [Select id,Product2Id, Pricebook2Id,Product2.IsSuccessorItemActive__c,Product2.SuccessorItem__c,Product2.SuccessorItem__r.IsActive,Product2.Stocknumber__c,Product2.StockLevel__c, Product2.PlannedPrintDate__c from PricebookEntry 
    //    where Product2Id in:Set_ProdId AND Pricebook2Id !=:standardPB.id]; //       
   // }


   // PricebookEntry[] lstPricebookSuccessor = [Select id,Product2Id, Pricebook2Id,Product2.IsSuccessorItemActive__c,Product2.SuccessorItem__c,Product2.Stocknumber__c,Product2.StockLevel__c, Product2.PlannedPrintDate__c from PricebookEntry where 
  //  Product2Id in:Set_Successor AND Pricebook2Id =:lstPricebookEntryExist[0].Pricebook2Id ]; // 
    
    
    //Pricebook entry create
   // PricebookEntry[] lstPricebookEntryStdExist = [Select id,Product2Id, Pricebook2Id from PricebookEntry 
  //  where Pricebook2Id=:standardPB.id AND Product2Id in:Set_priceProduct]; //
  //  PricebookEntry[] lstPricebookEntryExist = [Select id,Product2Id, Pricebook2Id from PricebookEntry 
   // where Product2Id in:Set_priceProduct]; // 
    



}
    
Public static List<Pricing__c> returnPricing(String Type){
   
   //Product selector

   String Querystr;
   
  
  From Pricing__c where id in:PriceId AND ProductComponent__c =:null];  
    
   Querystr =  'Select id,'
   +' Pricebook2Id, '
   +' Price__r.ListRate__c,'
   +' ListRate__c,'
   +' Product__c,'
   +' EndDate__c,'
   +' IsActive__c,'
   +' ExternalId__c,'
   +' StartDate__c,'
   +' Subsidiary__c,'
   +' CurrencyIsoCode,'
   +' Product__r.Type__c,'
   +' Product__r.MarketSegment__c,'
   +' Product__r.Stocknumber__c,'
   +' Product__r.SoldInSegment__c,'
   +' Product__r.SoldInSubSegment__c,'
   +' Product__r.DeliveryStatus__c,'
   +' Product__r.StockLevel__c,'
   +' Product__r.PlannedPrintDate__c,'
   +' Product__r.HasBlock__c,'
   +' Product__r.IsSuccessorItemActive__c,'
   +' Product__r.SuccessorItem__c,'
   +' Product__r.IsActive,'
   +' ProductComponent__c,'
   +' ProductComponent__r.IsActive__c,'
   +' ProductComponent__r.Quantity__c,'
   +' ProductComponent__r.Type__c,'
   +' ProductComponent__r.MainProduct__c,'
   +' ProductComponent__r.Product__c,'
   +' ProductComponent__r.Product__r.MarketSegment__c,'
   +' ProductComponent__r.MainProduct__r.itemGroupManualBlock__c,'  
   +' from Pricing__c Where '
   +' AND StartDate__c <=: system.today()'
   +'  AND EndDate__c >=: system.today()'
   +'  AND IsActive__c =:true';

   if(){
        Querystr += 'AND (ProductComponent__r.MainProduct__c in: Set_ProdItemGroup OR ProductComponent__r.Product__c in: Set_ProdItemGroup OR Product__c in: Set_ProdItemGroup )';
   }
   else if('ProductSelector'){
        Querystr += 'AND (ProductComponent__r.MainProduct__c in: Set_ItemGroup OR id in: Set_ItemPrice)';
   } 
   else if('ItemgroupCreate'){
        Querystr += 'AND (ProductComponent__r.MainProduct__c in: Set_ItemGroup )'; 
   }
   else if('Itemgroupupdate'){
        Querystr += 'AND ((ProductComponent__r.MainProduct__c in: Set_GroupId AND ProductComponent__r.Product__c in: Set_ProductId ))';
   }
   else if('Pricebookentrycreate'){
        Querystr += 'AND id in:PriceId AND ProductComponent__c =:null';   
    }
   else if('UpdatePricingfromProduct'){
        Querystr += 'AND (Product__c in:ProductId OR ProductComponent__r.Product__c in: ProductId)';
   }
    
/*
    Where   (ProductComponent__r.MainProduct__c in: Set_ProdItemGroup OR Product__c in: Set_ProdItemGroup OR ProductComponent__r.Product__c in: Set_ProdItemGroup )
    AND StartDate__c <=: system.today()
    AND EndDate__c >=: system.today()
    AND IsActive__c =:true];
  */
    /*
    //Product selector
      Where (ProductComponent__r.MainProduct__c in: Set_ItemGroup OR id in: Set_ItemPrice)
    //(ProductComponent__r.MainProduct__c in: Set_ItemGroup OR Product__c in: Set_ItemGroup OR ProductComponent__r.Product__c in: Set_ItemGroup )
    //AND id in: Set_ItemPrice
    AND StartDate__c <=: system.today()
    AND EndDate__c >=: system.today()
    AND IsActive__c =: true];
*/
  /*
    //Itemgroup Create
    Pricing__c[] lstPriceActive = [Select ProductComponent__r.MainProduct__r.itemGroupManualBlock__c,ListRate__c,ProductComponent__r.Product__r.Name,Product__c,EndDate__c,IsActive__c,ProductComponent__r.Quantity__c,ProductComponent__r.Type__c,ProductComponent__r.MainProduct__c,ProductComponent__r.Product__c from Pricing__c 
        Where   (ProductComponent__r.MainProduct__c in: Set_ItemGroup )
        AND StartDate__c <=: system.today()
        AND EndDate__c >=: system.today()
        AND IsActive__c =:true];
*/
        
/*
    //    Item group update
        Pricing__c[] lstPrice = [Select ListRate__c,ProductComponent__r.MainProduct__r.itemGroupManualBlock__c,ProductComponent__r.Product__r.Name,Product__c,EndDate__c,IsActive__c,ProductComponent__r.Quantity__c,ProductComponent__r.Type__c,ProductComponent__r.MainProduct__c,ProductComponent__r.Product__c from Pricing__c 
        // Where   ((ProductComponent__r.MainProduct__c in: Set_GroupId) OR (ProductComponent__r.Product__c in: Set_GroupId AND ProductComponent__r.MainProduct__c !=: null))
        Where   ((ProductComponent__r.Product__c in: Set_ProductId AND ProductComponent__r.MainProduct__c in: Set_GroupId))
         
        AND StartDate__c <=: system.today()
         AND EndDate__c >=: system.today()];    
*/

  //Pricebook entry create
  /*
  Pricing__c[] lstPricing = [Select id,EndDate__c,ExternalId__c,ProductComponent__r.Product__r.MarketSegment__c,ProductComponent__c,ProductComponent__r.IsActive__c,
                            ProductComponent__r.Product__c,ListRate__c,Product__c,StartDate__c,Subsidiary__c,Product__r.MarketSegment__c,Product__r.Stocknumber__c,Product__r.SoldInSegment__c,
                            Product__r.SoldInSubSegment__c,IsActive__c,Product__r.DeliveryStatus__c,Product__r.StockLevel__c,Product__r.PlannedPrintDate__c,Product__r.Type__c,
                            Product__r.HasBlock__c,Product__r.IsSuccessorItemActive__c,Product__r.SuccessorItem__c,Product__r.IsActive,CurrencyIsoCode
                            From Pricing__c where id in:PriceId AND ProductComponent__c =:null];  
*/
/*
  //Update Pricing from Product                          
      lstPricing = [Select id,EndDate__c,StartDate__c,IsActive__c From Pricing__c where 
                            (Product__c in:ProductId OR ProductComponent__r.Product__c in: ProductId)
                            AND StartDate__c <=: system.today()
                            AND EndDate__c >=: system.today()
                            AND IsActive__c =: true
                        ];
*/
}   

   
}

Public static List<Asset> returnasset(String Type){

    String Querystr;
    Date CurrrentDay = system.today();
    Date RenewalDay = system.today();
 
    Querystr =  'Select id,'
    +' PriceBook__c, '
    +' Name,'
    +' LastRenewalUpdate__c, '
    +' DiscountedPrice__c, '
    +' ManualDiscountPercent__c, '
    +' ManualDiscountValue__c, '
    +' PriceBook__r.FollowUpPriceBook__c, '
    +' RenewalDate__c, '
    +' Account.DigitalActivationEmail__c , '    
    +' OrderLineType__c,'
    +' RenewalTerm__c,'
    +' IsUpForRenewal__c,'
    +' AccountId,'
    +' PricingMethod__c,'
    +' BillToAccount__r.ShippingCostMethod__c,'
    +' ManualDiscount__c,'
    +' BillToAccount__r.PaymentMethod__c,'
    +' BillToAccount__r.CustomerDiscountGroup__c,'
    +' Account.CustomerDiscountGroup__c,'
    +' Price,'
    +' Quantity, 
    +' BillToAccount__c,'
    +' BillToAccount__r.OperatingCompany__c,'
    +' Account.OperatingCompany__c,'
    +' DigitalActivationEMail__c,'
    +' Product2Id,'
    +' BillToAccount__r.NetsuiteInternalId__c,'
    +' Account.NetsuiteInternalId__c,' 
    +' Account.NumberofStudents__c,'
    +' ShipToAttentionOf__c,'
    +' BillToAccount__r.ShippingStreet,'
    +' BillToAccount__r.ShippingPostalCode,'
    +' BillToAccount__r.ShippingCountry,'
    +' BillToAccount__r.ShippingCity,'
    +' BillToAccount__r.BillingStreet,'
    +' BillToAccount__r.BillingPostalCode,'
    +' BillToAccount__r.BillingCountry,'
    +' BillToAccount__r.BillingCity,'
    +' ,'
    +' Product2.IsSuccessorItemActive__c,'
    +' Product2.SuccessorItem__c,'
    +' Product2.SuccessorItem__r.IsActive,'
    +' Product2.Type__c,'
    +' Product2.LicenseDuration__c, '
    +' Product2.OrderLineType__c, '
    +' Product2.ProductDiscountGroup__c, '
    +' Product2.ProductRateGroup__c,'
    +' Product2.Name'
    +' from asset' 
    +' where 
    if(Type =='renewal'){
        Querystr +=' (Product2Id !=: null AND BillToAccount__c !=: null AND PricingMethod__c !=: null )'
        +' AND(('
        +' (CancellationDate__c >: CurrrentDay OR CancellationDate__c =:null)'
        +' AND RenewalDate__c  =: RenewalDay'
        +' AND LastRenewalUpdate__c !=: CurrrentDay'
        +' AND AutomatedRenewProcess__c =: true' 
        +' AND Contract__c =:null'
        +' AND Product2.Type__c != \'Item Group\''
        +' )'
        +' OR('
        +' AssetRenewalTrigger__c =: true'
        +' AND Product2.Type__c != \'Item Group\''
        +' )'
        +' )'
    }
    else if(Type =='Activation'){
        Querystr += 'Product2Id in:Set_Asset' 
        +'AND BillToAccount__c in:Set_BillTo' 
        +'AND AccountId in:Set_ShipTo '
        +'AND PricingMethod__c in: Set_PricingMethod'; 
    }
    else if(Type == 'AssetsFromOrder'){
        Querystr += 'Product2Id in: Set_ProdId' 
        +'AND AccountId in: Set_Shipto' 
        +'AND (CancellationDate__c >: Startdate OR CancellationDate__c=:null)';
    }
    else if('ProductSelector' || 'ListPriceDiscount'){

        Querystr += '(CancellationDate__c >: CurrrentDay OR CancellationDate__c =:null)'
        += 'AND RenewalDate__c  >=: CurrrentDay'
        += 'AND (ActivationDate__c <=: CurrrentDay OR  ActivationDate__c =: null)'
        += 'AND IsActive__c =: true'
        += 'AND BillToAccount__c in:Set_BillTo'
        += 'AND Contract__c =:null';  
    }
   


    Asset[] lst_Asset =  Database.query(querystr);

    return lst_Asset;


}

Public static ListProductComponent__c> returnProductComponent(String Type){

    ProductComponent__c[] lstProductComponent = [Select Product__c,MainProduct__c from ProductComponent__c where MainProduct__c in: Set_ItemGrpCom];

}

----------------------------------- Order_RemoveAccounts_OrderContract

            OrderShipto__c[] lstOrderShiptoDelete = [Select id,ShiptoAccount__c from OrderShipto__c where ShiptoAccount__c in: req[0].ListOfAccountIds AND Order__c =:req[0].RecordId];
            OrderShipto__c[] lstOrderShipto = [Select id,ShiptoAccount__c from OrderShipto__c where ShiptoAccount__c not in: req[0].ListOfAccountIds AND Order__c =:req[0].RecordId];
           
            OrderItem[] lstOrderItem = [Select id,ShipToAccount__c   From OrderItem where OrderId =:req[0].RecordId AND ShipToAccount__c in:req[0].ListOfAccountIds]; 


------------------------------------ Order_ReturnContractAccounts

            lstShiptoAccounts = [Select id,Name,Type,ShippingStreet,ShippingCity,	ExternalCustomerId__c,PurchasingGroup__c,NumberofStudents__c from Account where ValidateErrors__c = false AND (id=:CurOrder[0].Billto__c OR PurchasingGroup__c =:CurOrder[0].Billto__c OR ParentId=:CurOrder[0].Billto__c OR SalesAccount__c=:CurOrder[0].Billto__c OR DefaultBillto__c=:CurOrder[0].Billto__c) AND id not in: Set_AccountId AND NumberofStudents__c !=: null];
            lstShiptoAccounts = [Select id,Name,Type,ShippingStreet,ShippingCity,	ExternalCustomerId__c,PurchasingGroup__c,NumberofStudents__c from Account where ValidateErrors__c = false AND  (PurchasingGroup__c =:req[0].BilltoAccount.Id OR ParentId=:req[0].BilltoAccount.Id OR SalesAccount__c=:req[0].BilltoAccount.Id OR DefaultBillto__c=:req[0].BilltoAccount.Id) AND NumberofStudents__c !=: null];

            if(lstShiptoAccounts.size()==0 && req[0].MultipleShipto == true && ObjectName[0] !='Contract'){
                lstShiptoAccounts = [Select id,Name,Type,ShippingStreet,ShippingCity,	ExternalCustomerId__c,PurchasingGroup__c,NumberofStudents__c from Account where ValidateErrors__c = false AND (PurchasingGroup__c =:CurOrder[0].Billto__c OR id=:CurOrder[0].Billto__c OR ParentId=:CurOrder[0].Billto__c OR SalesAccount__c=:CurOrder[0].Billto__c OR DefaultBillto__c=:CurOrder[0].Billto__c) AND NumberofStudents__c !=: null];
            }
            else if(lstShiptoAccounts.size()==0 && (req[0].MultipleShipto == null || req[0].MultipleShipto == false) && ObjectName[0] !='Contract' ){
                lstShiptoAccounts = [Select id,Name,Type,ShippingStreet,ShippingCity,	ExternalCustomerId__c,PurchasingGroup__c,NumberofStudents__c from Account where id=:CurOrder[0].Shipto__c  AND ValidateErrors__c = false AND NumberofStudents__c !=: null];
            }
//----------------------------------- Order_ProductSelectController  from Order where id=: NewOrderId

List<Account> AccountbyShipto = new List <Account>([Select Id,name,NumberofStudents__c, OperatingCompany__c,DefaultBillto__r.CustomerDiscountGroup__c, PurchasingGroup__r.CustomerDiscountGroup__c,CustomerDiscountGroup__c from Account where NumberofStudents__c >=: 0 AND id in:ShiptoId  ]); //      ]); //   Use_in_flow__c =:true 
       

Contract[] Contract = [Select AccountId,NumberofUsers__c,SoldUsers__c,StartDate,Pricebook2Id,PaymentMethod__c,ShippingCostMethod__c,PricingMethod__c,defaultBilltoAccount__c from Contract where id =: ContractId];

Product2[] lstProduct = [Select id,Type__c,FreeFromDate__c,IsRegularOrderPossible__c,IsInspectionCopyOrderPossible__c,IsUseCopyOrderPossible__c,FixedStartDate__c,StartDate__c,LicenseDuration__c,Renewable__c from Product2 where id in: Set_Products];

AccountSubsidiary__c[] lstAccountSubsidiary = [Select id,LegalName__c,NetsuiteInternalId__c,Account__c,Account__r.OperatingCompany__c,Account__r.isVocationalEducation__c,Account__r.isHigherEducation__c from AccountSubsidiary__c where Account__c in:Set_Sub AND (Deleted__c =:false AND 	IsInactive__c =:false) ];


----------------------------------- Order_OrderInsertQueueable
    
    Order[] CurOrder = [Select AccountSubsidiary__c,MultipleShippingLocations__c,Shipto__r.NetsuiteInternalId__c ,Account.NetsuiteInternalId__c,OperatingCompany__c,Source__c,InsertProductSelector__c,CustomerReference__c,NumberOfStudents__c,Billto__c,ContractId,EffectiveDate,ShipByDate__c from Order where id=: NewOrderId];
    
----------------------------------- Order_AssetRenewal



----------------------------------- Order_AssetRenewalLineItemQueueable 


-----------------------------------Order_AssetsCreateOnOrderActivation

                                                        

----------------------------------- Order_AssetsFromOrder 


----------------------------------- Order_B2BOrderInvocable (DONE)



----------------------------------- Order_Batch_AssetRenewal



----------------------------------- Order_ImportOrderItemGroupCreate (Pricing)
    


----------------------------------- Order_ImportOrderItemGroupUpdate
  

----------------------------------- Order_ImportOrderSuccessorUpdate (Pricebook entries)

       


----------------------------------- Order_OrdeItemFromOrderFlow
      
----------------------------------- Order_OrdeItemFromOrderTypeChange 





----------------------------------- Order_OrderActivateQueueHandler (?) FROM Order where id not in: Set_Checked AND id !=:checked AND  ActivateforBatchProcessing__c =:true AND ValidateB2BLineCountError__c=:0 AND  ActivateforBatchProcessing__c =:true  and Status !=: 'Activated' and ValidationErrorsOrder__c =:0 and ValidationErrorsOrderProducts__c =:0 and LineCount__c >:0 Order by LineCount__c ASC limit 1


      //  Order[] nextOrder = [SELECT Id,Billto__c,Source__c,ValidateB2BLineCountError__c FROM Order where id not in: Set_Checked AND id !=:checked AND  ActivateforBatchProcessing__c =:true AND ValidateB2BLineCountError__c=:0 AND  ActivateforBatchProcessing__c =:true  and Status !=: 'Activated' and ValidationErrorsOrder__c =:0 and ValidationErrorsOrderProducts__c =:0 and LineCount__c >:0 Order by LineCount__c ASC limit 1];
           

----------------------------------- Order_OrderActivateRESTAPI 
      //  Order[] lstOrder = [Select id,Billto__c,MaxOrderLine__c,MaxOrderLine__r.RelatedOrderActivationready__c,AccountId,status,ActivateforBatchProcessing__c,RelatedOrderActivationBlock__c from Order where Id =: OrdId]; 
        MaxOrderLine__c[] lstMaxOrderLine =[Select id,OrdersActivated__c,ExpectedActivationCount__c,ActivationStart__c,ActivationMessage__c,CheckActivationProcessing__c from MaxOrderLine__c Where id =: lstOrder[0].MaxOrderLine__c]; 
                    
        - Order_OrderActivateRESTAPI from Order where Id =: OrdId
----------------------------------- Order_OrderandOrdeItemHandler (NB) 
      //  Order[] CurOrder = [Select Type, AccountSubsidiary__c,NumberOfStudents__c,Billto__c,ContractId,EffectiveDate,ShipByDate__c from Order where id in: recordIdStrings];

        /*
        lstOrderItem = [Select id,Order.EffectiveDate, Order.ShipByDate__c,LineItemTotal__c,ItemGroup__r.Product2Id,Product2.OrderLineType__c,Product2.MarketSegment__c,Product2.name,Product2.SoldInSegment__c,Product2.QuantitySelectionType__c,OrderId,ItemGroup__c,ShipToAccount__r.Name,ShipToAccount__r.CustomerDiscountGroup__c,ListPrice,UnitPrice,Quantity,Product2.ProductDiscountGroup__c,ListPriceDiscount__c,ListPriceDiscount__r.OrderLineType__c,ListPriceDiscount__r.Rate__c,Product2Id,PricebookEntryId,ShipToAccount__c,ManualDiscount__c,ManualDiscountPercent__c,ManualDiscountValue__c 
                From OrderItem where OrderId in:recordIdStrings];
            */
    



----------------------------------- Order_PricebookEntryCreate
      
                            
--------------------------------- Order_PricebookUpdateFromProduct




----------------------------------- Order_UpdateOrderListPriceDiscountAll 
/*
lstOrderItem = [Select id,Order.Billto__r.OperatingCompany__c,LineItemTotal__c,ListPriceItemGroup__c,ComponentListPrice__c,Product2.MarketSegment__c,ShipToAccount__c,ShipToAccount__r.NumberOfStudents__c, OrderLineType__c,
            ManualDiscountValue__c,ManualDiscountPercent__c,Order.PricingMethod__c,Product2.ProductDiscountGroup__c,Product2.ProductRateGroup__c,Order.Billto__r.NumberOfStudents__c,
                                    Product2.Name,Order.Billto__r.CustomerDiscountGroup__c,Quantity,ListPrice, UnitPrice ,ManualDiscount__c,Product2.OrderLineType__c
                                    From OrderItem where OrderId in:lstOrderId                                                       
                                ]; 
*/
----------------------------------- Order_UpdateShippingCostsFromItems 
/*
            OrderItem[] lst_OrderItemSelected = [Select Product2.VAT__c,DigitalActivationEMail__c,ShipToAccount__r.DigitalActivationEmail__c, OrderLineType__c,
            ShippingCity__c,ShipToAccount__r.ShippingCity,ShippingCountry__c,ShipToAccount__r.ShippingCountry,ShippingPostalCode__c,ShipToAccount__r.ShippingPostalCode,
            ShippingState__c,ShipToAccount__r.ShippingState,ShippingStreet__c,ShipToAccount__r.ShippingStreet,ShippingIndicationRule__c,Weight__c,Quantity, LineItemTotal__c
            from OrderItem where id in:Set_ItemId]; 
*/


----------------------------------- Order_UpdateVatOnItems 
/*
OrderItem[] lst_OrderItemSelected = [Select  Quantity,UnitPrice,OrderId,Product2.VAT__c,DigitalActivationEMail__c,ShipToAccount__r.DigitalActivationEmail__c,ShipToAccount__r.VATNumber__c ,ShipToAccount__r.VATStatus__c,ProductType__c,
            ShippingCity__c,ShipToAccount__r.ShippingCity,ShippingCountry__c,ShipToAccount__r.ShippingCountry,ShippingPostalCode__c,ShipToAccount__r.ShippingPostalCode,ShipToAccount__r.OperatingCompany__c,
            ShippingState__c,ShipToAccount__r.ShippingState,ShippingStreet__c,Order.ShippingIndicationRule__c,ShipToAccount__r.ShippingStreet,ShippingIndicationRule__c,Weight__c,ShipToAccount__r.ShippingCountryCode
            from OrderItem where id in:Set_ItemId];
*/

 


---------------------------------------------------

 
                                                        












}

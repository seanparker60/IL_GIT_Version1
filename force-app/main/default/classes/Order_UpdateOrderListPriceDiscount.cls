global with sharing class Order_UpdateOrderListPriceDiscount implements Database.Batchable<sObject>,Schedulable, Database.AllowsCallouts {
    
    public List<String> lstOrderId;


    Public Order_UpdateOrderListPriceDiscount(Decimal NoStudents, List<String> lstOrdId , String PricebookId){
        system.debug('**Construct 1**'+lstOrdId);
        this.lstOrderId = new List<String>(lstOrdId); 
    }
    Public Order_UpdateOrderListPriceDiscount(){
       
    }

    global Database.QueryLocator start(Database.BatchableContext BC){  
       // system.debug('**lstOrderId 1**'+lstOrderId);

        
        return Database.getQueryLocator([Select Pricebook2Id,Billto__r.CustomerDiscountGroup__c,PricingMethod__c,Billto__c from Order where B2BJobRun__c =: true]);
    }

    global void finish(Database.BatchableContext BC){
    }
    
    global void execute(SchedulableContext sc)
    {
        Order_UpdateOrderListPriceDiscount  UpdateOrder = new Order_UpdateOrderListPriceDiscount();
        database.executebatch(UpdateOrder ,100);
    }

    public void execute (Database.BatchableContext BC,List<Order> curOrder)
    {

        lstOrderId = new List<String> ();
        
        for(Order ord:curOrder){
            lstOrderId.add(ord.id);
        }
 //   Public static void UpdateOrdeItemswithListPriceDiscount(Decimal NoStudents, List<String> lstOrderId , String PricebookId){


        system.debug('**UpdateOrdeItems 1**'+lstOrderId);

      //  Order[] curOrder = [Select Pricebook2Id,Billto__r.CustomerDiscountGroup__c,PricingMethod__c,Billto__c from Order where id in: lstOrderId];
    
        OrderItem[] lstOrderItem = [Select id,ShipToAccount__c,Order.PricingMethod__c,Product2.ProductDiscountGroup__c,Product2.ProductRateGroup__c,Order.Billto__r.NumberOfStudents__c,
                                    Product2.Name,Order.Billto__r.CustomerDiscountGroup__c,Quantity,ListPrice, UnitPrice ,ManualDiscount__c,Product2.OrderLineType__c
                                    From OrderItem where OrderId in:lstOrderId                                                       
                                ]; 
    
                                Date CurDate = system.today();

        ListPriceDiscount__c[] lst_ListPriceDiscountRegular = [Select Id,ProductDiscountGroup__c,CustomerDiscountGroup__c,OrderLineType__c, MarketSegment__c,Rate__c,StartQuantity__c From ListPriceDiscount__c  
                                                                                        where  EndDate__c >=:CurDate 
                                                                                        AND StartDate__c  <=:CurDate  
                                                                                        ORDER BY StartQuantity__c DESC];

        system.debug('**UpdateOrdeItems 1: lstOrderItem**'+lstOrderItem);
        Set<String> Set_BillTo = new Set<String>();

        for(Order ord:curOrder){
            Set_BillTo.add(ord.Billto__c);
        }


    Date CurrrentDay = system.today();
    asset[] loadAssetsListGroupRate  = [Select id,Name,Product2.Name,Product2.OrderLineType__c,PriceBook__c,PriceBook__r.FollowUpPriceBook__c,RenewalDate__c,Account.DigitalActivationEmail__c ,Product2.ProductDiscountGroup__c,Product2.ProductRateGroup__c,RenewalTerm__c,IsUpForRenewal__c,AccountId,PricingMethod__c,BillToAccount__r.ShippingCostMethod__c,BillToAccount__r.PaymentMethod__c,Price,Quantity, BillToAccount__c,Product2Id 
                                                from asset 
                                                where (CancellationDate__c >: CurrrentDay OR CancellationDate__c =:null)
                                                AND RenewalDate__c  >=: CurrrentDay
                                                AND ActivationDate__c <: CurrrentDay
                                                AND IsActive__c =: true
                                                AND BillToAccount__c in:Set_BillTo
                                                AND Contract__c =:null]; 
    
    
    Map<String,Decimal> Map_OrderProdMap = new Map<String,Decimal>(); 

    Map<String,List<String>> Map_PriceProductType = new Map<String,List<String>>();
    String ProdGroup;
     
            
        for(asset ass:loadAssetsListGroupRate){
            //'ProductDiscountGroupUsageBased
            ProdGroup = ass.BillToAccount__c + ass.Product2.ProductRateGroup__c;                 
    
            if(Map_OrderProdMap.get(ProdGroup)== null){
                Map_OrderProdMap.put(ProdGroup,ass.Quantity);               
            }
            else{
                Map_OrderProdMap.put(ProdGroup ,Map_OrderProdMap.get(ProdGroup)+ass.Quantity);         
            }
            
            //'ProductUsageBased
            ProdGroup = ass.BillToAccount__c;
            ProdGroup =+ ass.Product2Id;
            if(Map_OrderProdMap.get(ProdGroup)== null){
                Map_OrderProdMap.put(ProdGroup,ass.Quantity);               
            }
            else{
                Map_OrderProdMap.put(ProdGroup ,Map_OrderProdMap.get(ProdGroup)+ass.Quantity);         
            }

            List<String> PriceProductType = new List<String>();
            PriceProductType.AddAll(ass.Product2.OrderLineType__c.Split(';'));
            Map_PriceProductType.put(ass.Product2Id,PriceProductType);
        }    
        system.debug('**UpdateOrdeItems 2**');
        for(OrderItem Item:lstOrderItem){
    
                if(Item.Order.PricingMethod__c =='OrderProductQuantity'){
                    ProdGroup = Item.OrderId + Item.Product2.Name+ Item.Product2.ProductDiscountGroup__c+ Item.Order.Billto__r.CustomerDiscountGroup__c;
                }
                else if(Item.Order.PricingMethod__c=='AccountStudents'){
                    ProdGroup = Item.OrderId;
                }
    
                
                if(Map_OrderProdMap.get(ProdGroup)== null){
                    Map_OrderProdMap.put(ProdGroup,Item.Quantity);               
                }
                else{
                    Map_OrderProdMap.put(ProdGroup ,Map_OrderProdMap.get(ProdGroup)+Item.Quantity);         
                }
               
    
                List<String> PriceProductType = new List<String>();
                                PriceProductType.AddAll(Item.Product2.OrderLineType__c.Split(';'));
                                
                    Map_PriceProductType.put(Item.Product2Id,PriceProductType);
                
        }

    
    Boolean listPriceSelected;
    
    for(OrderItem Item:lstOrderItem){
        system.debug('**UpdateOrdeItems 3**');
        listPriceSelected=false;
        for(ListPriceDiscount__c lpr:lst_ListPriceDiscountRegular){      
             
            if(Item.Order.PricingMethod__c=='ProductDiscountGroupUsageBased'){
                ProdGroup = Item.Order.Billto__c + Item.Product2.ProductRateGroup__c;        
            }
            else if(Item.Order.PricingMethod__c=='ProductUsageBased'){
                ProdGroup = Item.Order.Billto__c;
                ProdGroup =+ Item.Product2Id;
            }
            else if(Item.Order.PricingMethod__c =='OrderProductQuantity'){
                ProdGroup = Item.OrderId+ Item.Product2.Name+ Item.Product2.ProductDiscountGroup__c+ Item.Order.Billto__r.CustomerDiscountGroup__c;
            }
            else if(Item.Order.PricingMethod__c=='AccountStudents'){
                ProdGroup = Item.OrderId;
            } 
             
             
             system.debug('**ProductDiscountGroup**'+lpr.ProductDiscountGroup__c);
             system.debug('**fullOrderList**'+Item.Product2.ProductDiscountGroup__c);
             system.debug('**OrderProdMap**'+Map_OrderProdMap.get(ProdGroup));
             system.debug('**StartQuantity**'+lpr.StartQuantity__c);
             system.debug('**CustomerDiscountGroup**'+lpr.CustomerDiscountGroup__c);
      
        if((lpr.CustomerDiscountGroup__c == Item.Order.Billto__r.CustomerDiscountGroup__c) 
            && Map_OrderProdMap.get(ProdGroup) >= lpr.StartQuantity__c && listPriceSelected==false){
                system.debug('**IN LPD 1**');
            
                if((lpr.ProductDiscountGroup__c == item.Product2.ProductDiscountGroup__c && Item.Order.PricingMethod__c!='ProductDiscountGroupUsageBased')
                || (lpr.ProductDiscountGroup__c == item.Product2.ProductRateGroup__c && Item.Order.PricingMethod__c =='ProductDiscountGroupUsageBased')){ 
                
                
    
                for(String ProductType:Map_PriceProductType.get(Item.Product2Id)){
                    system.debug('**IN LPD 2**');
                    if(lpr.OrderLineType__c == ProductType && listPriceSelected==false){
                        system.debug('**IN LPD 3**'+(lpr.Rate__c/100));
                        listPriceSelected=true;
                                
                        item.ListPriceDiscount__c =  lpr.Id;
                        item.UnitPrice = item.ListPrice - (item.ListPrice * (lpr.Rate__c/100));
                                       
                        if(item.ManualDiscount__c=='Value'){
                            item.UnitPrice = item.UnitPrice-item.ManualDiscountValue__c;  
                        }
                        else if(item.ManualDiscount__c=='Percent'){
                            item.UnitPrice = item.UnitPrice-(item.UnitPrice*(Item.ManualDiscountPercent__c/100));
                        }
                        
       
                    }
                }
             
        }     
    
    }  
    
     
    }
    
    
    
    /*
       for(){
        CurOrder[0].NumberOfStudents__c = NoStudents;
       }
    */
        
    
       // update CurOrder;
        update lstOrderItem;
    
    
    }    

    }

}
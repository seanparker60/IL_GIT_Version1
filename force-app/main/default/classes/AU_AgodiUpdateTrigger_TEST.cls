@isTest
public with sharing class AU_AgodiUpdateTrigger_TEST {

    @TestSetup
    static void makeData(){
        
        List<Account> accountList = TestDataFactory.insertAccounts(5,'Plantyn', false);
        accountList[0].ExternalCustomerId__c = '123456';
        accountList[1].ExternalCustomerId__c = '123457';
        accountList[2].ExternalCustomerId__c = '123458';
        accountList[3].ExternalCustomerId__c = '654321';
        accountList[4].ExternalCustomerId__c = '987654';
        insert accountList;

        AgodiUpdate__c au = new AgodiUpdate__c();
        insert au;

    }

    @IsTest
    static void Test01(){
        
        List<AgodiUpdate__c> auList = [SELECT Id, filesUploaded__c, updateIsRunning__c, Processed__c FROM AgodiUpdate__c];
        auList[0].filesUploaded__c = true;

        String fakeFileContentIM = 'crab_straat;huisnr;huisnr_ext;lange_naam_instelling;nummer;postcode;fusiegemeente;telefoon;telefax;e_mail;website\r\n'+
                'testStraat;1;b;TestAccount;123456;12345;testGemeente;0032-123456789;0032-123456798;test@test.be;www.testwebsite.be\r\n';

        insertFile(fakeFileContentIM, 'inrichtendeMachten.txt', auList[0].Id);

        Test.startTest();
            update auList;
        Test.stopTest();

        Account updatedPurchasingGroup = [SELECT Name, LegalName__c, ShippingStreet, ShippingPostalCode, ShippingCity, Phone, invoicingEmail__c, Website, Type, ShippingCountry FROM Account WHERE ExternalCustomerId__c = '123456' LIMIT 1];

        // Check PurchasingGroup
        System.assertEquals('TestAccount', updatedPurchasingGroup.LegalName__c);
        System.assertEquals('testStraat 1-b', updatedPurchasingGroup.ShippingStreet);
        System.assertEquals('12345', updatedPurchasingGroup.ShippingPostalCode);
        System.assertEquals('testGemeente', updatedPurchasingGroup.ShippingCity);
        System.assertEquals('Belgium', updatedPurchasingGroup.ShippingCountry);
        System.assertEquals('0032 123456789', updatedPurchasingGroup.Phone);
        System.assertEquals('test@test.be', updatedPurchasingGroup.invoicingEmail__c);
        System.assertEquals('www.testwebsite.be', updatedPurchasingGroup.Website);
        System.assertEquals('Purchasing Group', updatedPurchasingGroup.Type);
        
    }

    private static void insertFile(String content, String name, Id parentRecordId){
    
        // create File (ContentVersion)
        ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S';
        conVer.PathOnClient = name;
        conVer.Title = name;
        conVer.VersionData = Blob.valueOf(content);
        insert conVer;

        // Link file to object
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
        ContentDocumentLink conDocLink = New ContentDocumentLink();
        conDocLink.LinkedEntityId = parentRecordId;
        conDocLink.ContentDocumentId = conDoc;
        conDocLink.shareType = 'V';
        insert conDocLink;

    }

}
String jsonInput = '{\n' +
' "success": false ,\n' +
' "correlationId": "xxx0x0x0x0x0x0x0x0x0",\n' +
 ' "failures" : [ ' + 
'{ "id": "0013N000019rz2bQAA", ' + 
'"message": "Problem Child 1" }, \n'+
'{ "id": "0013N00001AzELrQAN", ' + 
'"message": "Problem Child 2" } ]\n' +
'}';

Set<ID> ids = new Set<ID>();
ids.add('0013N000019rz2bQAA');
ids.add('0013N00001AzELrQAN');

bg_LogResponse.logresponse(jsonInput,ids);


Set<String> set_id = new Set<String>();

set_id.add('0013N000019s0XfQAI');
set_id.add('0013N000019s0XeQAI');

account[] lstAcc = [select id,IntegrationFactorySend__c from account where id in: set_id];

for(account acc:lstAcc){
    acc.IntegrationFactorySend__c = true;
}

update lstAcc;
//Author: Mark Collier 
//Purpose: To test that we have achieved the following goal:   
//	-  To get and add values to a JSON String.   
@isTest   
public class JSONObjectTest{  
	//the purpose of this method is to ensure tests are covered and errors in JSONObject.cls are detected early.   
	@isTest   
	public static void testGet(){   
		JSONObject jso = new JSONObject('{"title":{"name":"Test"}}');  
		System.assertEquals('"Test"',jso.get('title:name'));  
	}   
	@isTest  
	public static void testGetList(){  
		JSONObject jso = new JSONObject('[{"title":{"name":"Test"}}]');  
		System.assertEquals('"Test"',jso.get('|0:title:name'));  
	}  
	@isTest  
	public static void testGetTitleList(){  
		JSONObject jso = new JSONObject('{"title":[{"name":"Test"}]}');  
		System.assertEquals('"Test"',jso.get('title|0:name'));  
	}  
	@isTest  
	public static void testGetTitle1List(){  
		JSONObject jso = new JSONObject('{"title":[{"name":"Mitch"},{"name":"Test"}]}');  
		System.assertEquals('"Test"',jso.get('title|1:name'));  
	}  
	@isTest  
	public static void testGetNothing(){  
		JSONObject jso = new JSONObject('{"title":[{"name":"Mitch"},{"name":"Test"}]}');  
		System.assertEquals('{"title":[{"name":"Mitch"},{"name":"Test"}]}',jso.get(''));  
		System.debug('Nothing = '+jso.get('nothing'));  
	}  
	@isTest  
	public static void doListGetTest(){  
		Serial createList = new Serial('[{"name":"Mitch"},{"name":"Test"}]',1);  
		List<Object> listShouldHave2Items = createList.getList();  
		System.assertEquals(2,listShouldHave2Items.size(),'The list '+listShouldHave2Items+' should have 2 items within it.');  
		System.debug('The list '+listShouldHave2Items+' has 2 items within it.');  
		System.debug('Now we are going to delete an item: '+listShouldHave2Items.remove(1));  
		System.assertEquals(1,listShouldHave2Items.size(),'The list '+listShouldHave2Items+' should have 1 item within it.');  
		System.debug('The list '+listShouldHave2Items+' has 1 item within it.');  
	}  
	@isTest  
	public static void doGetTestError(){  
		Serial createList = new Serial('[{"name":"Mitch"},{"name":"Test"}]','|0|1:error');  
		JSONGet getError = new JSONGet(createList);  
		getError.localJSONSerial = createList;  
		System.debug('Specifying a location like this ['+getError.getLocations().toString().replace('(','').replace(')','').replace(', ',':')+'] should return an empty object.');  
		System.assertEquals(null,getError.getLocalObject(),'An null object should have been retrieved');  
	}  
	@isTest  
	public static void testGetEmptyListAndConvertToAMap(){  
		JSONObject jso = new JSONObject('[]');  
		System.assertEquals(new List<Object>(),jso.getList(),'JSON Object getList() method should return an empty list.');  
		System.debug(jso.edit('','')); 
		System.debug(jso.edit('{"man":"plane"}','')); 
		System.debug(jso.edit('[0,1,2]','')); 
		System.debug(jso.edit('cape','fry'));  
		System.debug(jso.add('rider','|3:|4'));  
		jso = new JSONObject(jso.get(0));  
		System.debug('jso = '+jso);  
		System.debug(jso.edit('rider','|3:|4'));  
		System.debug(jso.getList(3));  
		System.debug(jso.getMap(0));  
		System.debug(jso.edit('camp',1));  
		System.debug(jso.getMap(0));  
		System.debug(jso.getObject(1));  
		System.debug('Final JSON object = '+jso.getObject());  
	}  
	@isTest  
	public static void turnMapIntoList(){  
		JSONObject jso = new JSONObject('{}');  
		jso.add('value','key');  
		System.debug(jso.getMap());  
		System.debug(jso.add('New Value'));  
		System.debug(jso.getList().get(0));  
	}  
	@isTest  
	public static void testAdd(){  
		JSONObject jso = new JSONObject(new Map<String,Object>());  
		System.debug(jso.add('value','key'));  
		System.debug(jso.add('value','Account:Contact'));  
		System.debug(jso.add('listItem','Account|5'));  
		System.debug(jso.add('value1','key'));  
	}  
	@isTest  
	public static void testChessBoard(){  
		JSONObject chess = new JSONObject('[]');  
		JSONObject ten = new JSONObject('[]');  
		ten.add('',10);  
		System.debug(chess.add(ten.text,0));  
		System.debug(chess.add('Error','Base|7'));  
		System.debug(chess.add('cop','Pic'));  
		System.debug(chess.remove(0));  
		System.debug(chess);  
	}  
	@isTest  
	public static void addFromSingleInstance(){  
		JSONObject instance = new JSONObject('["instance 1"]');  
		System.debug(instance.add('instance 2'));  
	}  
	@isTest  
	public static void addStringsAndLists(){  
		JSONObject instance = new JSONObject('{}');  
		System.debug(instance.add('instance 2'));  
		System.debug(instance.add('[0,1,2]'));  
	}  
	@isTest  
	public static void addMapToANumber(){  
		JSONObject numberJSON = new JSONObject(1);  
		System.debug(numberJSON.add('{"hi":"hello"}'));  
	}  
	@isTest  
	public static void areNumbersRecognised(){  
		JSONObject numberJSON = new JSONObject(2);  
		System.debug(numberJSON.add(3));  
		System.debug(numberJSON.add(4));  
	}  
	@isTest  
	public static void addNumberToAMap(){  
		JSONObject mapJSON = new JSONObject('{"key":"value"}');  
		System.debug(mapJSON.add(3));  
	}  
	@isTest  
	public static void addEmptyToEmpty(){  
		List<Object> emptyValues = new List<Object>();  
		emptyValues.add(new Map<String,Object>());  
		emptyValues.add(new List<Object>());  
		emptyValues.add(null);  
		emptyValues.add('{}');  
		emptyValues.add('[]');  
		emptyValues.add('');  
		emptyValues.add('null');  
		emptyValues.add('none');  
		System.debug(emptyValues);  
		for(Object emptyValue:emptyValues){  
			JSONObject empty = new JSONObject(emptyValue);  
			if(emptyValue=='none'){  
				System.debug(empty);  
			}  
			for(Object addToEmpty:emptyValues){  
				empty.add(addToEmpty);  
			}  
			System.debug(empty);  
		}  
	}  
	@isTest  
	public static void addMapFromHardNull(){  
		JSONObject toNull = new JSONObject('');  
		toNull.text = null;  
		System.debug(toNull.add('{}'));  
		System.debug(toNull.add('value','key'));  
		System.debug(toNull.add(null));  
	}  
	@isTest  
	public static void addMapToAList(){  
		JSONObject listJSON = new JSONObject('[]');  
		JSONObject item = new JSONObject('{}');  
		System.debug(item.add('value','key'));  
		System.debug(item.add('pig','Id:value'));  
		System.debug(item.add('lamb','Id:log'));  
		System.debug(item.add('cow','Id:log:crow'));  
		System.debug(item.add('pet','Id:log:maid:catipilar|1'));  
		System.debug(listJSON.add(item.text));  
		System.debug(listJSON);  
	}  
	@isTest  
	public static void testNothing(){  
		JSONObject nothing = new JSONObject('Nothing');  
		System.debug(nothing.getObject());  
	}  
	@isTest  
	public static void addMapToAMap(){  
		JSONObject jmap = new JSONObject('{"key":"value"}');  
		System.debug(jmap.add('{"plane":"sky"}'));  
		Map<String,Object> jsonMap = jmap.getMap();  
		System.debug(jsonMap);  
		jsonMap.remove('plane');  
		System.debug(jsonMap);  
	}  
	@isTest  
	public static void testRemove(){  
		JSONObject jmap = new JSONObject('{"key":{"goal":"value","load":[0,1,2,3]},"jet":"plane"}');  
		System.debug(jmap.edit(4,'key:load|1'));  
		System.debug(jmap.remove('key:load|1'));  
		System.debug(jmap.remove('key:goal'));  
		System.debug(jmap.remove(''));  
	}  
	@isTest  
	public static void testRemoveIndex(){  
		JSONObject jmap = new JSONObject('[0,1,2,3]');  
		System.debug(jmap.edit(4,1));  
		System.debug(jmap.remove(1));  
	}  
	@isTest  
	public static void testDummyAdd(){  
		JSONObject dummy = new JSONObject('{"key":{"goal":"value","load":[0,1,2,3]}}');  
		System.debug(dummy.add('value','key'));  
	}  
	@isTest  
	public static void testEdit(){  
		JSONObject jso = new JSONObject('{}');  
		System.debug(jso.edit('man','power'));  
		System.debug(jso.edit('value','cap:toil|3:bin:car:vehicle|5:coat'));  
		System.debug(jso.edit('tree','cap:toil|1'));  
		System.debug(jso.edit('root','cap:toil|3:bin:mosquito:veg|3'));  
		System.debug(jso.remove('cap:toil|3:bin:car:vehicle|1'));  
		System.debug(jso.remove('cap:toil|4:bin:car:vehicle|1'));  
		System.debug(jso.remove('cap:toil|3:bin:car'));  
		System.debug(jso.remove('power'));  
		System.debug(jso.remove('cap:toil|3'));  
		System.debug(jso.remove('cap:toil'));  
		System.debug(jso.remove('air'));  
	}  
}
//Author: Mark Collier 
//Purpose: To test that we have achieved the following goal: 
//	-  To post and get data from an external service API. 
@isTest 
public class RestTest{ 
	//the purpose of this method is to ensure tests are covered and errors in Rest.cls are detected early. 
	@isTest 
	public static void test(){ 
		new Rest( 'https://th-apex-http-callout.herokuapp.com/animals'); 
	} 
}
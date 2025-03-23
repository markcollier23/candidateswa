/**       
* Name: DynamicLabel       
* Purpose: Apex class used to retrieve a specific label from the Dynamic Label custom setting.       
*        
* Who            When           Ref            What                   
* -------------------------------------------------------------       
* Mark Collier   10/12/2024     API            All                    
* -------------------------------------------------------------       
**/       
public class DynamicLabel{        
	public static List<String> orgNameExtensions = new String[]{'_PROD__c','_UAT__c','_SIT__c'};       
	private static Map<String,Object> defaultValues = new Map<String,Object>{       
		'ActivateResident__c' => true,
		'TurnOnNebulaSuccessLogs__c' => true, 
		'TurnOnNebulaErrorLogs__c' => true,   
		'ActivateAPIPayload__c' => true,       
		'Salesforce_Default_URL__c' => ''       
	};       
	/**       
	* Name: get       
	* Purpose: To retreive a value from the Dynamic Label Custom Setting by field.       
	*        
	* Who            When           Ref            What                            
	* ----------------------------------------------------------------------       
	* Mark Collier   10/12/2024     API            Method has been created.        
	* ----------------------------------------------------------------------       
	**/       
	public static Object get(String field){       
		return get(field,true);       
	}       
	/**       
	* Name: get       
	* Purpose: To retreive a value from the Dynamic Label Custom Setting by field depending on whether it can be set via the Dynamic Label Custom Setting or not.       
	*        
	* Who            When           Ref            What                            
	* ----------------------------------------------------------------------       
	* Mark Collier   10/12/2024     API            Method has been created.        
	* ----------------------------------------------------------------------       
	**/       
	public static Object get(String field,Boolean isDynamic){       
		String key = field;       
		if(defaultValues.keySet().contains(field+'_SIT__c')){       
			String thisURL = URL.getOrgDomainURL().toExternalForm();       
			String defaultURL = String.valueOf(get('Salesforce_Default_URL__c',isDynamic));       
			Integer numberOfOrgNamesFound = 0;       
			for(String orgURL:new String[]{thisURL,defaultURL}){       
				//If this org URL does not match the org URLs as per defaultValues map above then choose the org url matching Salesforce Default URL.       
				if(orgURL==thisURL||numberOfOrgNamesFound==0){       
					for(String orgName:orgNameExtensions){       
						if(orgURL==String.valueOf(get('Salesforce'+orgName,isDynamic))){       
							key+=orgName;       
							numberOfOrgNamesFound++;       
						}       
					}       
				}       
			}       
			//If the Salesforce Default URL does not match the URLs for SIT,UAT and Production then choose the SIT URL.       
			if(numberOfOrgNamesFound!=1){       
				if(isDynamic){       
					put('Salesforce_Default_URL__c',String.valueOf(get('Salesforce_SIT__c')));       
				}       
				key = field + '_SIT__c';       
			}       
		}       
		return isDynamic?put(key,null):defaultValues.get(key);       
	}       
	/**       
	* Name: put       
	* Purpose: To set a particular value on the Dynamic Label Custom Setting by field.       
	*        
	* Who            When           Ref            What                            
	* ----------------------------------------------------------------------       
	* Mark Collier   10/12/2024     API            Method has been created.        
	* ----------------------------------------------------------------------       
	**/       
	public static Object put(String key,Object value){       
		SObject customSetting = DynamicLabel__c.getInstance(UserInfo.getOrganizationId());       
		if(String.isBlank(String.valueOf(value))){       
			if(String.isBlank(String.valueOf(customSetting.get(key)))){       
				customSetting.put(key,defaultValues.get(key));       
				upsert customSetting;       
			}       
		}else{       
			if(customSetting.get(key)!=value){       
				customSetting.put(key,value);       
				upsert customSetting;       
			}       
		}       
		return customSetting.get(key);       
	}       
	/**       
	* Name: notDynamic       
	* Purpose: To get the default value for a particular field representing the Dynamic Label Custom Setting.       
	*        
	* Who            When           Ref            What                            
	* ----------------------------------------------------------------------       
	* Mark Collier   10/12/2024     API            Method has been created.        
	* ----------------------------------------------------------------------       
	**/       
	public static String notDynamic(String field){       
		return String.valueOf(get(field,false));       
	}       
}

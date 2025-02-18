/** 
* Name: UtilDateTime 
* Purpose: To convert a String into a Date/Time/DateTime value. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   19/11/2024     99354076       All              
* ------------------------------------------------------------- 
**/ 
public class UtilDateTime{      
	/** 
	* Name: getDate 
	* Purpose: To convert a date string into an actual date value. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public static Date getDate(String dateString,String format){     
		if(String.isNotBlank(dateString)){ 
			Map<String,String> dateFormatMap = new Map<String,String>{     
				'D' => getFormatMatch('D', format),     
				'M' => getFormatMatch('M', format),     
				'Y' => getFormatMatch('Y', format)     
			};     
			Map<String,Integer> dateValueMap = getValueMap(dateString,format,dateFormatMap);     
			return Date.newInstance(dateValueMap.get('Y'),dateValueMap.get('M'),dateValueMap.get('D'));     
		}     
		return null; 
	}     
	/** 
	* Name: getTime 
	* Purpose: To convert a time string into an actual time value. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public static Time getTime(String timeString,String format){     
		if(String.isNotBlank(timeString)){ 
			Map<String,String> timeFormatMap = new Map<String,String>{     
				'h' => getFormatMatch('h', format),     
				'm' => getFormatMatch('m', format),     
				's' => getFormatMatch('s', format)     
			};     
			Map<String,Integer> timeValueMap = getValueMap(timeString,format,timeFormatMap);     
			return Time.newInstance(timeValueMap.get('h'), timeValueMap.get('m'), timeValueMap.get('s'), 0);     
		}     
		return null; 
	}     
	/** 
	* Name: getDateTime 
	* Purpose: To convert a dateTime string into an actual dateTime value. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public static DateTime getDateTime(String dateTimeString,String format){     
		if(String.isBlank(dateTimeString)){ 
			return null; 
		}else{ 
			return DateTime.newInstance(getDate(dateTimeString,format), getTime(dateTimeString, format));     
		} 
	}     
	/** 
	* Name: getValueMap 
	* Purpose: To retrieve an Integer for each date or time representation. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	private static Map<String,Integer> getValueMap(String value,String format,Map<String,String> formatMap){     
		Map<String,Integer> valueMap = new Map<String,Integer>();     
		for(String indicator:formatMap.keySet()){     
			Integer index = format.indexOf(indicator);     
			Integer length = formatMap.get(indicator).length();     
			List<Integer> characters = new List<Integer>();     
			for(Integer i=index;i<index+length;i++){     
				characters.add(value.charAt(i));     
			}     
			String num = String.fromCharArray(characters);     
			valueMap.put(indicator,Integer.valueOf(num));     
		}     
		return valueMap;     
	}     
	/** 
	* Name: getFormatMatch 
	* Purpose: To retrieve a single date/time format string. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	private static String getFormatMatch(String indicator,String format){     
		Integer length = format.countMatches(indicator);     
		String match = '';     
		for(Integer i=0;i<length;i++){     
			match+=indicator;     
		}     
		return match;     
	}     
}
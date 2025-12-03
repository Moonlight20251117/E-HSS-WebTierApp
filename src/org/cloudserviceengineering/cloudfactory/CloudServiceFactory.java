package org.cloudserviceengineering.cloudfactory;

public class CloudServiceFactory {
	
	public ICloud produce_domaincloud(String domainType){
		ICloud cloud = null;
		if(domainType != null && domainType.equals("Healthcare")){
			cloud = new HealthCareCloud();
		}
		else if(domainType != null && domainType.equals("Enterprise")){
			cloud = new EnterpriseCloud();
		}
		else if(domainType != null && domainType.equals("Education")){
			cloud = new EducationCloud();
		}
		else if(domainType != null && domainType.equals("Epidemic")){
			cloud = new EpidemicCloud();
		}
		// 如果没有匹配的类型，返回默认的医疗云
		if(cloud == null){
			cloud = new HealthCareCloud();
		}
		return cloud;
	}
}

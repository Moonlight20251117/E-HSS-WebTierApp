package org.cloudserviceengineering.app.login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.cloudserviceengineering.cloudfactory.CloudServiceFactory;
import org.cloudserviceengineering.cloudfactory.ICloud;

@WebServlet("/CloudServiceEngineering")
public class CloudServiceEngineering extends HttpServlet {
	
	private String domain_str = "Healthcare Cloud";
	private ICloud domaincloud;
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String domain_str = request.getParameter("select");
		System.out.println("接收到的云类型参数: " + domain_str);
		CloudServiceFactory factory = new CloudServiceFactory();
		domaincloud = factory.produce_domaincloud(domain_str);
		if(domaincloud == null){
			System.err.println("错误：无法创建云服务实例，domain_str = " + domain_str);
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "无法创建云服务实例");
			return;
		}
		String cloudNameString = domaincloud.getCloudName();
		System.out.println("创建的云服务名称: " + cloudNameString);
		request.getSession().setAttribute("Cloud",domain_str);
		request.getSession().setAttribute("CloudName",cloudNameString);
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}

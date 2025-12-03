package org.cloudserviceengineering.app.business;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 患者远程诊断Servlet
 */
@WebServlet("/servlet/patient/RemoteDiagnosisClientServlet")
public class RemoteDiagnosisClientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RemoteDiagnosisClientServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().append("远程诊断功能");
	}
}


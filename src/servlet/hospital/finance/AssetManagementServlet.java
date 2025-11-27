package servlet.hospital.finance;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 财务端资产与资源管理Servlet
 */
@WebServlet("/servlet/hospital/finance/AssetManagementServlet")
public class AssetManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AssetManagementServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("资产与资源管理");
	}
}


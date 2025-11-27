package servlet.hospital.finance;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 财务统计分析Servlet
 */
@WebServlet("/servlet/hospital/finance/FinancialStatisticsServlet")
public class FinancialStatisticsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FinancialStatisticsServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().append("财务统计分析功能");
	}
}


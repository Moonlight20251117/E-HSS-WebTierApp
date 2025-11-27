package servlet.hospital.nurse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DBUtil;
import dao.TaskDAO;
import entity.Task;
import java.util.List;

/**
 * 护士端医疗服务Servlet
 */
@WebServlet("/servlet/hospital/nurse/MedicalServiceServlet_Nurse")
public class MedicalServiceServlet_Nurse extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private TaskDAO taskDAO = new TaskDAO();
       
    public MedicalServiceServlet_Nurse() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String action = request.getParameter("action");

		if ("list".equals(action)) {
			// 获取任务列表
			List<Task> tasks = taskDAO.getAllTasks();
			StringBuilder json = new StringBuilder("[");
			boolean first = true;
			for (Task task : tasks) {
				if (!first) json.append(",");
				json.append(String.format(
					"{\"id\":%d,\"time\":\"%s\",\"bed\":\"%s\",\"name\":\"%s\",\"content\":\"%s\",\"status\":%d}",
					task.getId(), task.getTime(), task.getBed(), task.getName(), 
					task.getContent(), task.getStatus()
				));
				first = false;
			}
			json.append("]");
			out.write(json.toString());
			
		} else if ("update".equals(action)) {
			// 更新状态
			String idStr = request.getParameter("id");
			String statusStr = request.getParameter("status");
			
			try {
				int id = Integer.parseInt(idStr);
				int status = Integer.parseInt(statusStr);
				boolean success = taskDAO.updateStatus(id, status);
				out.write(success ? "success" : "fail");
			} catch (Exception e) {
				e.printStackTrace();
				out.write("error");
			}
		}
	}
}


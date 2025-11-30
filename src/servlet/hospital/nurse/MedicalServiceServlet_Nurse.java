package servlet.hospital.nurse;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.NursingTaskDAO;
import entity.NursingTask;

/**
 * 护士端医疗服务Servlet - 日常护理工作
 * 使用新的数据库 smart_medical_system 和 nursing_task 表
 */
@WebServlet("/servlet/hospital/nurse/MedicalServiceServlet_Nurse")
public class MedicalServiceServlet_Nurse extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private NursingTaskDAO taskDAO = new NursingTaskDAO();
	private SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
       
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
			try {
				List<NursingTask> tasks = taskDAO.getAllTasks();
				StringBuilder json = new StringBuilder("[");
				boolean first = true;
				
				for (NursingTask task : tasks) {
					if (!first) json.append(",");
					
					// 格式化时间为 HH:mm
					String timeStr = "";
					if (task.getPlanTime() != null) {
						timeStr = timeFormat.format(task.getPlanTime());
					}
					
					// 获取状态文本（待执行/执行中/已完成/已取消）
					String statusText = task.getStatus();
					
					// 确保状态不为null，且处理可能的数字格式
					if (statusText == null || statusText.trim().isEmpty()) {
						statusText = "待执行";
					}
					// 如果状态是数字字符串，转换为文本
					if ("0".equals(statusText)) {
						statusText = "待执行";
					} else if ("1".equals(statusText)) {
						statusText = "已完成";
					}
					
					// 转义JSON特殊字符
					String content = escapeJson(task.getTaskContent() != null ? task.getTaskContent() : "");
					String name = escapeJson(task.getPatientName() != null ? task.getPatientName() : "");
					String bed = task.getBedNumber() != null ? task.getBedNumber() : "0000";
					String statusEscaped = escapeJson(statusText);
					
					json.append(String.format(
						"{\"id\":\"%s\", \"time\":\"%s\", \"bed\":\"%s\", \"name\":\"%s\", \"content\":\"%s\", \"status\":\"%s\"}",
						task.getTaskId(),
						timeStr,
						bed,
						name,
						content,
						statusEscaped
					));
					first = false;
				}
				json.append("]");
				out.write(json.toString());
				
			} catch (Exception e) {
				e.printStackTrace();
				out.write("[]");
			}
			
		} else if ("update".equals(action)) {
			// 更新状态
			String taskId = request.getParameter("id");
			String newStatus = request.getParameter("status");
			
			try {
				// 验证状态值是否有效
				if (newStatus == null || 
				    (!newStatus.equals("待执行") && !newStatus.equals("执行中") && 
				     !newStatus.equals("已完成") && !newStatus.equals("已取消"))) {
					System.err.println("无效的状态值: " + newStatus);
					out.write("invalid_status");
					return;
				}
				
				boolean success = taskDAO.updateStatus(taskId, newStatus);
				out.write(success ? "success" : "fail");
				
			} catch (Exception e) {
				System.err.println("更新任务状态异常 - taskId: " + taskId + ", newStatus: " + newStatus);
				e.printStackTrace();
				out.write("error");
			}
		}
	}
	
	/**
	 * 转义JSON字符串中的特殊字符
	 */
	private String escapeJson(String str) {
		if (str == null) return "";
		return str.replace("\\", "\\\\")
		          .replace("\"", "\\\"")
		          .replace("\n", "\\n")
		          .replace("\r", "\\r")
		          .replace("\t", "\\t");
	}
}


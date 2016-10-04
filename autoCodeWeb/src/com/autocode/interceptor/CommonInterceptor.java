package com.autocode.interceptor;

import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class CommonInterceptor extends HandlerInterceptorAdapter {
	private final Logger LOG = Logger.getLogger(CommonInterceptor.class);

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String url = requestUri.substring(contextPath.length());
		this.LOG.info("requestUri:" + requestUri);
		this.LOG.info("contextPath:" + contextPath);
		this.LOG.info("url:" + url);
		return true;
	}

	private void writeErrorInfo(HttpServletResponse response, String message) {
		try {
			response.setContentType("text/html;charset=GBK");
			response.setCharacterEncoding("GBK");
			OutputStream os = response.getOutputStream();
			JSONObject json = new JSONObject();
			json.put("result", Boolean.valueOf(false));
			json.put("message", message);
			os.write(json.toString().getBytes());
			os.flush();
			os.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}

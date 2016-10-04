package com.autocode.filter;

import com.autocode.util.DateTimeUtil;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class CommonFilter implements Filter {
	private static final Log LOG = LogFactory.getLog(CommonFilter.class);

	public void destroy() {
		LOG.info("CommonFilter:destroy " + DateTimeUtil.FormatCurrentDateTime());
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		Long startTime = Long.valueOf(System.currentTimeMillis());
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		String url = httpRequest.getRequestURL().toString();
		try {
			chain.doFilter(request, response);
		} catch (Exception e) {
			LOG.error("CommonFilter:execute failed", e);

			response.setContentType("text/html;charset=GBK");
			response.setCharacterEncoding("GBK");
			OutputStream os = response.getOutputStream();
			JSONObject json = new JSONObject();
			json.put("result", Boolean.valueOf(false));
			json.put("message", "系统异常");
			json.put("error", exceptionToString(e));
			os.write(json.toString().getBytes());
			os.flush();
			os.close();
		}

		if (url.substring(url.length() - 5, url.length()).equals(".html")) {
			long endTime = System.currentTimeMillis();
			LOG.info("URL=" + url + ",处理时间=" + (endTime - startTime.longValue()) + " ms");
		}
	}

	public String exceptionToString(Throwable e) {
		Writer result = new StringWriter();
		PrintWriter printWriter = new PrintWriter(result);
		e.printStackTrace(printWriter);
		return result.toString();
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		LOG.info("CommonFilter:init " + DateTimeUtil.FormatCurrentDateTime());
	}
}

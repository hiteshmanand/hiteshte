package com.te.purreq.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import com.te.purreq.util.CPRWebProperties;

public class NTLMLocalWrapperFilter implements Filter {
	
//	private static final Logger logger = Logger.getLogger(NTLMLocalWrapperFilter.class);	
	
	private FilterConfig fc;
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//		logger.debug("NTLMLocalWrapperFilter: doFilter called");
		System.out.println("Filtering");
		if (CPRWebProperties.getCentrifyDisabledLocally()) {
			String defaultUser = CPRWebProperties.getCentrifyOverrideUserID();
			System.out.println("defaultUser --> " + defaultUser);
//			logger.debug("NTLMLocalWrapperFilter: Bypassing Centrify Athentication, using user " + defaultUser);
			chain.doFilter(new NtlmOverrideHttpServletRequest((HttpServletRequest)request, defaultUser), response);
		} else{
			chain.doFilter(request,response);
		}
		
		/*if (false){//(CPRWebProperties.getCentrifyDisabledLocally()) {
			String defaultUser = "TE158053"; //CPRWebProperties.getCentrifyOverrideUserID();
//			logger.debug("NTLMLocalWrapperFilter: Bypassing Centrify Athentication, using user " + defaultUser);
			chain.doFilter(new NtlmOverrideHttpServletRequest((HttpServletRequest)request, defaultUser), response);
		} else{
			chain.doFilter(request,response);
		}*/
	}
	
	public void init(FilterConfig filterConfig) throws ServletException {
//		logger.debug("NTLMLocalWrapperFilter: init called");
		this.fc = filterConfig;
	}
	
	public void destroy() {
//		logger.debug("NTLMLocalWrapperFilter: destroy called");
		if (this.fc != null) {
			this.fc = null;
		}
	}
		
	private class NtlmOverrideHttpServletRequest extends HttpServletRequestWrapper {
		private String user;
		public NtlmOverrideHttpServletRequest(HttpServletRequest request, String user) {
	        super(request);
	        this.user = user;
	    }
	    public String getRemoteUser() {
	        return user;
	    }
	}
}

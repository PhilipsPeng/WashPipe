package org.wash.pipes.admin.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionCheckInterceptor extends HandlerInterceptorAdapter {

	 @Override
	    public boolean preHandle(HttpServletRequest request,
	            HttpServletResponse response, Object handler) throws Exception {
//	        long startTime = System.currentTimeMillis();
	        System.out.println("Request URL::" + request.getRequestURL().toString()
	                + ":: Start Time=" + System.currentTimeMillis());
//	        request.setAttribute("startTime", startTime);
//	        //if returned false, we need to make sure 'response' is sent
//	        return true;
		 	if (request.getSession().getAttribute("loginMember") != null) {
		 		return true;
		 	} else {
		 		request.setAttribute("message", "登入逾時，重新回登入頁面");
		 		request.getRequestDispatcher("/jsp/alert.jsp").forward(request,response);
		 		return false;
		 	}
	    }
	 
	    @Override
	    public void postHandle(HttpServletRequest request,
	            HttpServletResponse response, Object handler,
	            ModelAndView modelAndView) throws Exception {
	        System.out.println("Request URL::" + request.getRequestURL().toString()
	                + " Sent to Handler :: Current Time=" + System.currentTimeMillis());
	        //we can add attributes in the modelAndView and use that in the view page
	    }
	 
	    @Override
	    public void afterCompletion(HttpServletRequest request,
	            HttpServletResponse response, Object handler, Exception ex)
	            throws Exception {
	        long startTime = (Long) request.getAttribute("startTime");
	        System.out.println("Request URL::" + request.getRequestURL().toString()
	                + ":: End Time=" + System.currentTimeMillis());
	        System.out.println("Request URL::" + request.getRequestURL().toString()
	                + ":: Time Taken=" + (System.currentTimeMillis() - startTime));
	    }
	
	
}

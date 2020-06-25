package com.pageturner.mh.service;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

@Component
@Aspect
public class MemberAOP {
	
	@Before("execution(* com.pageturner.mh.controller.Member.findID(..))")
	public void memb(JoinPoint join) {
		System.out.println("memb()");
		Object[] obj = join.getArgs();
		HttpServletRequest req = (HttpServletRequest)obj[0];
		
		String view = "member/findID";
		String sid = (String)req.getSession().getAttribute("SID");
		if(sid == null) {
			((ModelAndView)obj[1]).addObject("isLogin", false);
		} else {
			((ModelAndView)obj[1]).addObject("isLogin", true);
		}
	}
}

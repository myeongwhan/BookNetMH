package com.pageturner.mh.controller;

import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.pageturner.mh.dao.MemberDAO;
import com.pageturner.mh.service.MemberService;
import com.pageturner.mh.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class Member {
	@Autowired
	MemberDAO mDAO;
	@Autowired
	MemberService mSrvc;
	@Inject
	JavaMailSender mailSender;
	
	// 정보수정 뷰
	@RequestMapping("/editMemb.cls")
	public ModelAndView editMemb(ModelAndView mv) {
		String view = "member/editMemb";
		mv.setViewName(view);
		return mv;
	}
	
	/*
	@RequestMapping("/editMembProc.cls")
	public ModelAndView editMembProc(HttpSession session, ModelAndView mv, MemberVO mVO) {
		int cnt = mSrvc.editUser(mVO);
		
		mv.setView(new RedirectView("마이페이지"));
		return mv;
	}
	*/
	
	// 아디비번찾기
	@RequestMapping("/findID.cls")
	public ModelAndView findID(ModelAndView mv) {
		String view = "member/findID";
		mv.setViewName(view);
		return mv;
	}
	
	// 메일인증
	@RequestMapping("/mail.cls")
	@ResponseBody
	public String mailProc(HttpServletRequest req, String mail) {
		//인증 번호 생성기
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for(int i=0;i<10;i++){
			int rIndex = rnd.nextInt(3);
	        switch (rIndex) {
	        case 0:
	            // a-z
	            temp.append((char) ((int) (rnd.nextInt(26)) + 97));
	            break;
	        case 1:
	            // A-Z
	            temp.append((char) ((int) (rnd.nextInt(26)) + 65));
	            break;
	        case 2:
	            // 0-9
	            temp.append((rnd.nextInt(10)));
	            break;
	        }
	    }
	    String cout = temp.toString();
//      System.out.println(AuthenticationKey);
		
	    try {
	    	MimeMessage msg = mailSender.createMimeMessage();
	    	MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "UTF-8");
	    	msgHelper.setFrom("myeongwhan@gmail.com");
	    	msgHelper.setTo(req.getParameter("mail"));
//	    	msgHelper.setSubject(subject);
	    	msgHelper.setText(cout);
	    	
	    	mailSender.send(msg);
	    } catch(Exception e) {
	    	e.printStackTrace();
	    }
	    
	    return cout;
	}
}

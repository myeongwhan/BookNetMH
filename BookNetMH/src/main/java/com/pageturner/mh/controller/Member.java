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
import com.pageturner.mh.util.Dice;
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
	public ModelAndView findID(HttpServletRequest req, ModelAndView mv) {
		String view = "member/findID";
		mv.setViewName(view);
		return mv;
	}
	
	// 이명환
	// 메일인증
	@RequestMapping("/mail.cls")
	@ResponseBody
	public String mailProc(HttpServletRequest req) {
		Dice dice = new Dice();
	    String cout = dice.Dice();
		
	    try {
	    	MimeMessage msg = mailSender.createMimeMessage();
	    	MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "UTF-8");
	    	msgHelper.setFrom("myeongwhan@gmail.com");
	    	msgHelper.setTo(req.getParameter("mail"));
	    	msgHelper.setSubject("회원가입 인증메일 발송");
	    	msgHelper.setText("인증번호는 " + cout + " 입니다");
	    	
	    	mailSender.send(msg);
	    } catch(Exception e) {
	    	e.printStackTrace();
	    }
	    
	    String str = "{\"tno\": \"" + cout + "\"}";
	    
	    return str;
	}
}

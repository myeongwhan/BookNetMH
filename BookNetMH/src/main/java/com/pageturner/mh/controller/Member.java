package com.pageturner.mh.controller;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pageturner.mh.dao.MemberDAO;
import com.pageturner.mh.service.MemberService;
import com.pageturner.mh.util.Dice;

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
	
	// 지도 테스트
	@RequestMapping("/mapmap.cls")
	public ModelAndView mapmap(ModelAndView mv) {
		mv.setViewName("member/mapmap");
		return mv;
	}
	
	// 지도 테스트2
	@RequestMapping("/mapmap2.cls")
	public ModelAndView mapmap2(ModelAndView mv) {
		mv.setViewName("member/mapmap2");
		return mv;
	}
	
	// 지도 테스트3
	@RequestMapping("/mapmap3.cls")
	public ModelAndView mapmap3(ModelAndView mv) {
		mv.setViewName("member/mapmap3");
		return mv;
	}
	
	// indexOf, substring 테스트
	@RequestMapping("/mapstring.cls")
	public ModelAndView mapstring(ModelAndView mv) {
		mv.setViewName("member/mapstring");
		return mv;
	}
	
	// 지도 테스트 최종
	@RequestMapping("/mapmap_final.cls")
	public ModelAndView mapmap_final(ModelAndView mv) {
		mv.setViewName("member/mapmap_final");
		return mv;
	}
	
	// 지도 테스트 최종
	@RequestMapping("/mapmap_final2.cls")
	public ModelAndView mapmap_final2(ModelAndView mv) {
		mv.setViewName("member/mapmap_final2");
		return mv;
	}
	
	// callback 테스트
	@RequestMapping("/callbacktest.cls")
	public ModelAndView callbacktest(ModelAndView mv) {
		mv.setViewName("member/callbacktest");
		return mv;
	}
	
	// ajax 테스트
	@RequestMapping("/mapajaxtest.cls")
	public ModelAndView mapajaxtest(ModelAndView mv) {
		mv.setViewName("member/mapajaxtest");
		return mv;
	}
	
	// callback 테스트2
	@RequestMapping("/callbacktest2.cls")
	public ModelAndView callbacktest2(ModelAndView mv) {
		mv.setViewName("member/callbacktest2");
		return mv;
	}
	
	// coord2RegionCode 테스트
	@RequestMapping("/coord2RegionCode.cls")
	public ModelAndView coord2RegionCode(ModelAndView mv) {
		mv.setViewName("member/coord2RegionCode");
		return mv;
	}
}

package com.pageturner.mh.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/member")
public class Member {
	@RequestMapping("/editMemb.cls")
	public ModelAndView editMemb(ModelAndView mv) {
		mv.setView(new RedirectView("/mh/member/editMemb"));
		return mv;
	}
}

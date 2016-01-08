package org.wash.pipes.admin.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.service.EmailNotificationService;
import org.wash.pipes.core.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService; 
	@Autowired
	EmailNotificationService emailNotificationService; 
	
	@RequestMapping(value = "/login")
	public String login(
			@ModelAttribute("member") Member loginMember,
			BindingResult result, HttpServletRequest request) {
		Member member = memberService.getMemberForLogin(loginMember.getLoginId());
		boolean isLoginSuccess = memberService.login(loginMember, member);
		if(isLoginSuccess) {
			request.getSession().setAttribute("loginMember", member);
			
			return "redirect:/main.html";
		}else {
			request.setAttribute("loginError", "登入ID或密碼錯誤");
			return "/login";
		}

	}
	
	@RequestMapping(value = "/memberList") 
	public String memberList(ModelMap modelMap) {
		String memberListJson = memberService.memberList();
		modelMap.addAttribute("localData", memberListJson);
		
		return "/memberList";
	}
	
	@RequestMapping(value = "/register")
	public String register(ModelMap modelMap) {
		modelMap.addAttribute("member", new Member());

		return "/register";
	}
	
	@RequestMapping(value = "/registerSubmit")
	public String registerSubmit(@ModelAttribute("member") Member member, 
			ModelMap modelMap) {
		System.out.println(member.getName());
		System.out.println(member.getId());
		System.out.println(member.getLoginId());
		memberService.register(member);
		System.out.println("---------registerSubmit----------");
		
		return "/registerSuccess";
	}
	
	@RequestMapping(value = "/forgetPwd")
	public String forgetPwd(ModelMap modelMap) {
		modelMap.addAttribute("member", new Member());

		return "/forgetPwd";
	}
	
	@RequestMapping(value = "/forgetPwdSubmit")
	public String forgetPwdSubmit(@ModelAttribute("member") Member member, 
			ModelMap modelMap) {
		System.out.println("@@@@@@@@"+member.getLoginId());
		Member member_ = memberService.getMemberForLogin(member.getLoginId());
//		System.out.println(member_.getName());
		String newPwd = this.genRandomNum(6);
		System.out.println("oldPwd="+member_.getPassword());
		System.out.println("newPwd="+newPwd);
		member_.setPassword(newPwd);
		memberService.update(member_);
		boolean isSendSuccess = 
				emailNotificationService.sendForgetPwdNotification(member_);
		
		return "/forgetPwdSuccess";
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginMember");
		
		return "redirect:/index.html";
	}

	@RequestMapping(value = "/memberQuery") 
	public @ResponseBody String memberQuery(@RequestParam String inputMemberId) {
		return String.valueOf(memberService.queryMemberCount(inputMemberId));
	}
	
	@RequestMapping(value = "/loginIdQuery") 
	public @ResponseBody String loginIdQuery(@RequestParam String inputLoginId) {
		return String.valueOf(memberService.queryLoginIdCount(inputLoginId));
	}
	
	@RequestMapping(value = "/memberDelete") 
	public String memberDelete(@RequestParam String deleteMemberId) {
		memberService.deleteMember(deleteMemberId);
		
		return "forward:/memberList.html";
	}
	
	@RequestMapping(value = "/memberDetail") 
	public String memberDetail(ModelMap modelMap, @RequestParam String memberId) {
		Member member = memberService.getMember(memberId);
		modelMap.addAttribute("member", member);
		
		return "/memberDetail";
	}
	
	private String genRandomNum(int pwd_len) {
		// 35是因為數字是從0開始，26個字母+10個數字
		final int maxNum = 36;
		int i; // 生成的隨機數
		int count = 0; // 產生的密碼的長度
		char[] str = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
				'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
				'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
		StringBuffer pwd = new StringBuffer("");
		Random r = new Random();
		while (count < pwd_len) {
			// 產生隨機數，取絕對值，防止產生負數，
			i = Math.abs(r.nextInt(maxNum)); // 產生的數最大為36-1
			if (i >= 0 && i < str.length) {
				pwd.append(str[i]);
				count++;
			}
		}
		return pwd.toString();
	}
	
}

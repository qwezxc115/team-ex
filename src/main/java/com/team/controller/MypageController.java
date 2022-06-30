package com.team.controller;

import java.security.Principal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.domain.CBoardVO;
import com.team.domain.UserVO;
import com.team.security.domain.CustomUser;
import com.team.service.CBoardService;
import com.team.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mypage")
public class MypageController {

	@Setter(onMethod_ = @Autowired)
	private UserService service;

	@Setter(onMethod_ = @Autowired)
	private CBoardService CBservice;

	//마이페이지  홈 
	@GetMapping("/home")
	@PreAuthorize("isAuthenticated()")
	public void main(Principal principal, Model model, CBoardVO vo) {

	}

	//비밀번호확인 후 정보페이지로 이동 
	@PostMapping("/myinfos")
	@PreAuthorize("isAuthenticated()")
	public String checkpwMethod(Principal principal, Model model, String userpwck, CBoardVO vo) {

		log.info(principal.getName());

		UserVO uservo = service.read(principal.getName());
		model.addAttribute("uservo", uservo);

		String Encoderpw = uservo.getUserpw();

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		String resultshow = "";

		if (encoder.matches(userpwck, Encoderpw)) {

			log.info("입력한 비밀번호 일치 ");
			resultshow = "/mypage/myinfos";

		} else {
			log.info("불 일치 ");
			resultshow = "redirect:/mypage/home?error";

		}

		return resultshow;
	}

	@GetMapping("/myinfos")
	@PreAuthorize("isAuthenticated()")
	public void info(Principal principal, Model model, CBoardVO vo) {
		log.info(principal.getName());

		UserVO uservo = service.read(principal.getName());

		model.addAttribute("uservo", uservo);

	}

	//정보불러서 수정하기 
	@PostMapping("/modify")

	@PreAuthorize("isAuthenticated()")
	public String modify(UserVO vo, RedirectAttributes rttr, Authentication auth) {

		boolean ok = service.modify(vo);

		if (ok) {
			rttr.addAttribute("status", "success");
			// session의 authentication 을 수정
			CustomUser user = (CustomUser) auth.getPrincipal();
			user.setUser(vo);
		} else {
			rttr.addAttribute("status", "error");
		}

		return "redirect:/mypage/myinfos";

	}

	//비밀번호 수정하기 
	@PostMapping("/modifypassword")
	@PreAuthorize("isAuthenticated()")
	public String modifyPassword(UserVO vo, Principal principal, RedirectAttributes rttr, Authentication auth,
			String oldPassword) {

		vo.setUserid(principal.getName());

		boolean ok = service.modifyPassword(vo, oldPassword);
		if (ok) {
			// session의 authentication 을 수정
			CustomUser user = (CustomUser) auth.getPrincipal();
			user.setUser(service.read(principal.getName()));
			rttr.addFlashAttribute("qweasd", "비밀번호을 수정했습니다 :) ");
			log.info("비밀번호 수정성공 ! ");
		} else {
			log.info("비밀번호 수정실패 ! ");
			rttr.addFlashAttribute("qqq", "기존 비밀번호가 일치하지 않습니다.  ");
			return "redirect:/mypage/home";
		}

		return "redirect:/main/home";

	}

	//회원탈퇴 
	@PostMapping("/removeuser")
	@PreAuthorize("isAuthenticated()")
	public String remove(UserVO vo, HttpServletRequest req, String inputPassword, RedirectAttributes rttr,
			Principal principal) throws ServletException {
		vo.setUserid(principal.getName());

		log.info(vo);
		log.info(inputPassword);
		boolean ok = service.remove(vo, inputPassword);

		if (ok) {
			log.info("탈퇴성공  ");
			req.logout();
			return "redirect:/main/home";
		} else {
			log.info("탈퇴실패 ");
			rttr.addFlashAttribute("qqq", "비밀번호가 틀렸습니다.  ");
			return "redirect:/mypage/home";
		}

	}

}

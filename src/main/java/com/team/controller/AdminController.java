package com.team.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.domain.UserVO;
import com.team.service.AdminService;
import com.team.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin")
public class AdminController {

	@Setter(onMethod_ = @Autowired)
	private AdminService service;

	@Setter(onMethod_ = @Autowired)
	private UserService Userservice;

	//관리자페이지 홈

	// 기본회원 조회
	@GetMapping("/home")
	public String home(Model model, UserVO vo, RedirectAttributes rttr) {

		log.info("기본회원 조회");

		List<UserVO> Userlist = service.getUserlist();
		model.addAttribute("Userlist", Userlist);

		return "/admin/home";

	}

	//일반회원 회원가입
	@PostMapping("/home")
	public String signupPost(UserVO vo, RedirectAttributes rttr) {
		log.info("회원가입완료");

		boolean ok = service.getUserinsert(vo);

		if (ok) {
			return "redirect:/admin/home";
		} else {
			return "redirect:/admin/home?error";
		}
	}

	//기본회원 수정하기
	@PostMapping("/update")
	public String update(UserVO vo) {

		service.Userupdate(vo);

		return "redirect:/admin/home";
	}

	//기본회원 회원탈퇴
	@PostMapping("/delete")
	public String delete(UserVO vo) {

		service.Userdelete(vo);

		return "redirect:/admin/home";
	}

	// 여기서부터 관리자 관련

	@GetMapping("/adminlist")
	public String adminlist(Model model, UserVO vo, RedirectAttributes rttr) {

		List<UserVO> Adminlist = service.getAdminlist();
		model.addAttribute("Adminlist", Adminlist);

		return "/admin/adminlist";
	}

	//관리자회원 회원가입
		@PostMapping("/adminlist")
		public String adminlistpost(UserVO vo, RedirectAttributes rttr) {
			log.info("관리자계정 추가");

			boolean ok = service.getAdmininsert(vo);

			if (ok) {
				return "redirect:/admin/adminlist";
			} else {
				return "redirect:/admin/adminlist?error";
			}
		}

	//관리자회원 수정하기
	@PostMapping("/adminupdate")
	public String adminupdate(UserVO vo) {

		service.Adminupdate(vo);

		return "redirect:/admin/adminlist";
	}

	//관리자회원 회원탈퇴
	@PostMapping("/admindelete")
	public String admindelete(UserVO vo) {

		service.Admindelete(vo);

		return "redirect:/admin/adminlist";
	}

}

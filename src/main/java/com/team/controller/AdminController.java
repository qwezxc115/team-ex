package com.team.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.domain.OtoAnswerVO;
import com.team.domain.OtoVO;
import com.team.domain.SProductVO;
import com.team.domain.UserVO;
import com.team.service.AdminService;
import com.team.service.SProductService;
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
	private SProductService SPservice;
	
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
	
	
	// 여기서부터 업체 관련
	
	// 업체회원 조회
	@GetMapping("/complist")
	public String complist(Model model, UserVO vo, RedirectAttributes rttr) {
		
		
		log.info("업체 리스트");
		
		List<UserVO> Complist = service.getComplist();
		model.addAttribute("Complist", Complist);
		
		return "/admin/complist";
		
	}
	
	//업체회원 회원가입
	@PostMapping("/complist")
	public String complistpost(UserVO vo, RedirectAttributes rttr) {
		log.info("회원가입완료");

		boolean ok = service.getCompinsert(vo);

		if (ok) {
			return "redirect:/admin/complist";
		} else {
			return "redirect:/admin/complist?error";
		}
	}
	
	//업체회원 수정하기
	@PostMapping("/compupdate")
	public String compupdate(UserVO vo) {
			
		service.Compupdate(vo);
			
		return "redirect:/admin/complist";
	}
	
	//업체회원 회원탈퇴
	@PostMapping("/compdelete")
	public String compdelete(UserVO vo) {
		
		service.Compdelete(vo);
		
		return "redirect:/admin/complist";
	}
	
	
	// 여기서부터 상품목록 관련
	
		//상품목록 리스트
		@GetMapping("/productlist")
		public String productlist(Model model, SProductVO vo, RedirectAttributes rttr, Principal principal) {
			
			// 상품목록 조회
			log.info("상품목록 리스트");
			vo.setUserid(principal.getName());
			UserVO uservo = Userservice.read(principal.getName());
			model.addAttribute("uservo", uservo);
			
			List<SProductVO> Productlist = service.getProductlist();
			model.addAttribute("Productlist", Productlist);
			
			return "/admin/productlist";
		}
		
		//상품 추가하기
		@PostMapping("/productlist")
		public String productlistpost(SProductVO vo, @RequestParam("store_file") MultipartFile[] store_file, RedirectAttributes rttr) {
			log.info("상품 추가");
			SPservice.register(vo, store_file);
	        rttr.addFlashAttribute("result", vo.getPno());
	        
	        return "redirect:/admin/productlist";
		}
		
		//상품 수정하기
		@PostMapping("/productupdate")
		public String productupdate(SProductVO svo,
		  		@RequestParam("store_file") MultipartFile[] store_file) {
				
			SPservice.modify(svo, store_file);
				
			return "redirect:/admin/productlist";
		}
		
		 
		  
		  
		//상품 삭제
		@PostMapping("/productdelete")
		public String productdelete(SProductVO vo) {
			
			service.Productdelete(vo);
			
			return "redirect:/admin/productlist";
		}
			
	// 여기서부터 문의내역 관련
	
	//문의내역 리스트
	@GetMapping("/otolist")
	public String otolist(Model model, OtoVO vo, RedirectAttributes rttr) {
		
		// 문의내역 조회
		log.info("문의내역 리스트");
		
		List<OtoVO> Otolist = service.getOtolist();
		model.addAttribute("Otolist", Otolist);
		
		return "/admin/otolist";
	}
	//문의내역 답변하기
	@PostMapping("/otosend")
	public String otosend(OtoAnswerVO vo){
		
		service.Otoanswer(vo);
		
		return "redirect:/admin/otolist";
	}
	
	
	// 여기서부터 관리자 관련
	
	@GetMapping("/adminlist")
	public String adminlist(Model model, UserVO vo, RedirectAttributes rttr) {
		
		// 업체회원 조회
		log.info("관리자 리스트");
		
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

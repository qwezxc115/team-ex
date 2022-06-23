package com.team.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.domain.CBCriteria;
import com.team.domain.EBCriteria;
import com.team.domain.EBPageDTO;
import com.team.domain.EBoardVO;
import com.team.domain.EBrezmsgVO;
import com.team.service.EBoardService;
import com.team.service.EBrezmsgService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping("/experts")
@AllArgsConstructor
@Log4j
public class ExpertsController {

	private EBoardService service;

	private EBrezmsgService rezservice;
	
	
	//메인 홈 - 리스트 가져오기 
	@GetMapping("/ehome")
	public void mainlist(@ModelAttribute("cri") EBCriteria cri, Model model) {
		log.info("experts home getlist ");
		
		int ebtotal = service.getebToal(cri);
		
		List<EBoardVO> elist = service.getebList(cri);
		model.addAttribute("elist",elist);
		
		model.addAttribute("pageMaker", new EBPageDTO(cri,ebtotal));
	}
	

	//업체 글 보기 
	@RequestMapping({"/ereading","/emodify"})
	public void geteb(Long eno, Model model,
			@ModelAttribute("cri") EBCriteria cri) {
		
		EBoardVO vo =service.geteb(eno);
		model.addAttribute("eboard",vo);
	}
	
	//업체 글쓰기 
	@GetMapping("/ewriting")
	@PreAuthorize("isAuthenticated()")
	public void ebregister()  {
		log.info("ewriting method");
	}
	
	@PostMapping("/ewriting")
	public String ebregister(EBoardVO eboard, MultipartFile file,
			RedirectAttributes rttr) {
		
		eboard.setFileName(file.getOriginalFilename());
		service.ebfregister(eboard, file);
		rttr.addFlashAttribute("result",eboard.getEno());
		rttr.addFlashAttribute("messageTille","작성성공 ! ");
		rttr.addFlashAttribute("messageBody",eboard.getWriter()+" 님 게시물이 등록 되었습니다! ");
		
		return "redirect:/experts/ehome";
		
	}
	
	//업체 글 수정 
	@PostMapping("/emodify")
	@PreAuthorize("principal.username == #eboard.writer")
	public String ebmodify(EBoardVO eboard,EBCriteria cri, 
			@RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		
		
		log.info(eboard);
		boolean success = service.ebfmodify(eboard, file);
		
		if(success) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "수정 성공");
			rttr.addFlashAttribute("messageBody", "수정 되었습니다.");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		return "redirect:/experts/ehome";
	}
	
	//업체 글 삭제 
	@PostMapping("/eremove")
	@PreAuthorize("principal.username == #writer")
	public String cbremove(Long eno, CBCriteria cri, RedirectAttributes rttr, String writer) {
		
		boolean success = service.ebremove(eno);
		if(success) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "삭제 성공");
			rttr.addFlashAttribute("messageBody", "삭제 되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		
		return "redirect:/experts/ehome";
		
	}
	//업체 상담
	@PostMapping("/rez")
	@PreAuthorize("isAuthenticated()")
	public String rezlist(Principal principal, EBrezmsgVO ebrezvo,RedirectAttributes rttr) {
		log.info("rezlist...");
		log.info(principal.getName());
			
		if(rezservice.rezregister(ebrezvo)) {
			
			rttr.addFlashAttribute("rezmsg", " 예약 되었습니다!  ");           	
			
		}else {
			rttr.addFlashAttribute("rezmsg", " 예약 실패 입니다. ");
			
		}
			
			return "redirect:/experts/ehome";    
	}
	
}

		
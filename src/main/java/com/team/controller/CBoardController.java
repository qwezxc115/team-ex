package com.team.controller;

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
import com.team.domain.CBPageDTO;
import com.team.domain.CBoardVO;
import com.team.service.CBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/community")
@AllArgsConstructor
@Log4j
public class CBoardController {

	private CBoardService service;
	
	
	//자유게시판 홈 -글 리스트 
	@GetMapping("/cbhome")
	public void list(@ModelAttribute("cri")  CBCriteria cri, Model model) {
		log.info("cb list ");
		
		int cbtotal = service.getcbToal(cri);
		
		List<CBoardVO> list = service.getcbList(cri);
		model.addAttribute("list",list);
		
		model.addAttribute("pageMaker",new CBPageDTO(cri,cbtotal));
	}
	
	
	
	//자유게시판  글 보기   
	@RequestMapping({"/cbreading","/cbmodify"})
	public void getcb(Long bno,Model model,
			@ModelAttribute("cri") CBCriteria cri ) {
		log.info("cbreading method");
		
		CBoardVO vo = service.getcb(bno);
		
		model.addAttribute("cboard",vo);
		
		
	}
	
	//자유게시판 글쓰기 
	@GetMapping("/cbwriting")
	@PreAuthorize("isAuthenticated()")
	//@PreAuthorize("isAuthenticated()")
	public void register()  {
		log.info("boardwriting method");
	}
	
	//자유게시판 글쓰기
	@PostMapping("/cbwriting")
	public String register(CBoardVO cboard, 
			 MultipartFile file,RedirectAttributes rttr) {
		
		//파일이름 가져와서 저장 
		cboard.setFileName(file.getOriginalFilename());
		
		
		service.cbfregister(cboard,file);
		
		
		rttr.addFlashAttribute("result", cboard.getBno());
		rttr.addFlashAttribute("messageTitle", "작성성공! ");
		rttr.addFlashAttribute("messageBody", cboard.getWriter() + "님  게시물이 등록 되었습니다! ");
		
		
		return "redirect:/community/cbhome";
		
	}
	
	//자유게시판 글 수정 
	@PostMapping("/cbmodify")
	@PreAuthorize("principal.username == #cboard.writer")
	public String  cbmodify(CBoardVO cboard, CBCriteria cri,
			@RequestParam("file") MultipartFile file,RedirectAttributes rttr) {

		log.info(cboard);
		
		boolean success = service.cbfmodify(cboard, file);
		
		if(success) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "수정 성공");
			rttr.addFlashAttribute("messageBody", "수정 되었습니다.");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		
		return "redirect:/community/cbhome";
	}
	
	
	//자유게시판 글 삭제 
	@PostMapping("/cbremove")
	@PreAuthorize("principal.username == #writer")
	public String cbremove(Long bno, CBCriteria cri,RedirectAttributes rttr, String writer) {
		
		boolean success = service.cbremove(bno);
		if(success) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "삭제 성공");
			rttr.addFlashAttribute("messageBody", "삭제 되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		
		return "redirect:/community/cbhome";
		
	}
	
	
	
	
}

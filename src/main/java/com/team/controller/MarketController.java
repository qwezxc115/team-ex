package com.team.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.team.domain.Criteria;
import com.team.domain.MarketVO;
import com.team.domain.PageDTO;
import com.team.service.MarketService;
import com.team.service.MessageService;
import com.team.service.UserService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/market")
@AllArgsConstructor
public class MarketController {
	
	@Setter (onMethod_ = @Autowired)
	private MarketService service;
	
	@Setter(onMethod_ = @Autowired)
	private MessageService messageservice;	
	
	@Setter(onMethod_ = @Autowired)
	private UserService userservice;	
	
	
        @GetMapping("/home")
        public void market(@ModelAttribute("cri") Criteria cri, Model model) {
            log.info("market method");
       		int total = service.getTotal(cri);    
       		
    		List<MarketVO> list = service.getList(cri);

    		model.addAttribute("list", list);
    		model.addAttribute("pageMaker", new PageDTO(cri, total));
    		
        }     
        
	        
    	@GetMapping("/write")
        @PreAuthorize("isAuthenticated()")
    	public void write(@ModelAttribute("cri") Criteria cri) {
    		
    	}
        
        @PostMapping("/write")
        public String write(MarketVO mvo, 
        		@RequestParam("market_file") MultipartFile[] market_file , RedirectAttributes rttr) {
        	
        	service.write(mvo, market_file);
    		
        	rttr.addFlashAttribute("result", mvo.getMno());


        	return "redirect:/market/home"; 
    		} 		

              
		@GetMapping({"/detail", "/modify"})
		public void get(@RequestParam("mno") int mno, @ModelAttribute("cri") Criteria cri, Model model) {
            log.info("market/detail method");
            
            MarketVO mvo = service.read(mno);
            
            model.addAttribute("market", mvo);
            
        }
		
		
		
		@PostMapping("/modify")
		@PreAuthorize("principal.username == #mvo.mwriter")
		public String modify(MarketVO mvo, Criteria cri, 
				@RequestParam("market_file") MultipartFile[] market_file, RedirectAttributes rttr) {
			boolean success = service.modify(mvo, market_file);
			
			if (success) {
				rttr.addFlashAttribute("result", "success");
				rttr.addFlashAttribute("messageTitle", "수정 성공");
				rttr.addFlashAttribute("messageBody", "수정 되었습니다.");
			}
			
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			
			return "redirect:/market/home";
		}
		
		
		@PostMapping("/remove")
		@PreAuthorize("principal.username == #mwriter")
		public String remove(@RequestParam("mno") int mno,
				Criteria cri, RedirectAttributes rttr, String mwriter) {

			boolean success = service.remove(mno);

			if (success) {
				rttr.addFlashAttribute("result", "success");
				rttr.addFlashAttribute("messageTitle", "삭제 성공");
				rttr.addFlashAttribute("messageBody", "삭제 되었습니다.");
			}
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());

			return "redirect:/market/home";
			
		}
		
        
}

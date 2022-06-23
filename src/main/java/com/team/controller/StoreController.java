package com.team.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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

import com.team.domain.CartVO;
import com.team.domain.Order_detailVO;
import com.team.domain.SPCriteria;
import com.team.domain.SPPageDTO;
import com.team.domain.SProductVO;
import com.team.domain.UserVO;
import com.team.domain.WishVO;
import com.team.service.SProductService;
import com.team.service.StoreService;
import com.team.service.UserService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/store")
@AllArgsConstructor
public class StoreController {
	
	@Setter(onMethod_ = @Autowired)
	private SProductService service;
	
	@Setter(onMethod_ = @Autowired)
	private StoreService stservice;
	
	@Setter(onMethod_ = @Autowired)
	private UserService userservice;
	
		// 메인 홈
        @GetMapping("/home")
        public void store(@ModelAttribute("cri") SPCriteria cri, Model model) {
            log.info("store method");
       		int total = service.getTotal(cri);    
       		
    		List<SProductVO> list = service.getCateList(cri);

    		model.addAttribute("list", list);
    		model.addAttribute("pageMaker", new SPPageDTO(cri, total));
    		
        }     
        
    	//찜 목록
    	@GetMapping("/wish")
    	@PreAuthorize("isAuthenticated()")
    	public void wish(WishVO vo, Principal principal, Model model) {
    		log.info(principal.getName());
    		vo.setUserid(principal.getName());
    		List<WishVO> wishlist = stservice.wishlist(principal.getName());
    		model.addAttribute("wishlist", wishlist);
    		log.info("확인되었습니다.");
    	}
    	//찜 담기
    	@PostMapping("/detail")
    	@PreAuthorize("isAuthenticated()")
    	public String pwish(WishVO vo, Principal principal, Model model, SProductVO svo, RedirectAttributes rttr, String pageNum, String amount){
    		log.info(principal.getName());
    		vo.setUserid(principal.getName());		
    		log.info("추가되었습니다.");
    		long count = stservice.countwish(vo.getPno(), principal.getName());
    		log.info(count);
    		if (count == 0) {
    			stservice.addWish(vo);
    			rttr.addFlashAttribute("result", "success");
    			rttr.addFlashAttribute("messageTitle", "저장");
    			rttr.addFlashAttribute("messageBody", "찜목록에 저장되었습니다.");
    			
    			rttr.addAttribute("pno", vo.getPno());
    			rttr.addAttribute("pageNum", pageNum);
    			rttr.addAttribute("amount", amount);
    			return "redirect:/store/detail";
    		} else {
    			stservice.cwishdelete(vo.getPno(), principal.getName());;
    			rttr.addFlashAttribute("result", "success");
    			rttr.addFlashAttribute("messageTitle", "삭제");
    			rttr.addFlashAttribute("messageBody", "찜목록에서 삭제하였습니다.");
    			
    			rttr.addAttribute("pno", vo.getPno());
    			rttr.addAttribute("pageNum", pageNum);
    			rttr.addAttribute("amount", amount);
    			return "redirect:/store/detail";
    		}
    	}
    	
    	// 찜 관련 삭제
    	@PostMapping("/wishdelete")
    	public String wishdelete(@RequestParam("wno") Long wno) {
    		stservice.wishdelete(wno);
    		return "redirect:/store/wish";
    	}
        
        
        // 장바구니 담기        
        @PostMapping("/cart")
        @PreAuthorize("isAuthenticated()")
        public String cart(CartVO vo, Principal principal, Model model, RedirectAttributes rttr) {         
	        log.info(principal.getName());
	        
	        vo.setUserid(principal.getName());
	        
	        long count = stservice.countCart(vo.getPno(), principal.getName());
	        if(count == 0) {
	        	stservice.addCart(vo);  
	        }else {
	        	stservice.updateCart(vo);

	        }
	          return "redirect:/store/cart";
        }

        // 장바구니 담은 내역
        @GetMapping("/cart")
        @PreAuthorize("isAuthenticated()")
        public void getcart(CartVO vo, Principal principal, Model model) {         
	        log.info(principal.getName());
	        
	        vo.setUserid(principal.getName());  
	        List<CartVO> cartlist = stservice.listCart(principal.getName());
	        model.addAttribute("cart", cartlist);
	        
	        long sumMoney = stservice.sumMoney(principal.getName());
	        log.info(sumMoney);
	        vo.setSumMoney(sumMoney);
	        model.addAttribute("sumMoney", sumMoney);
        }

       // 장바구니 삭제
        @PostMapping("/cartdelete")
        public String cartdelete(CartVO vo) {
        	stservice.cartdelete(vo);
        	return "redirect:/store/cart";
        }   
        
        // 구매하기 (장바구니)
        @GetMapping("/order")
        @PreAuthorize("isAuthenticated()")
        public void getcartorder(UserVO vo, Order_detailVO detail, Principal principal, Model model) {         
	        log.info(principal.getName());
	       
	        vo.setUserid(principal.getName());  
	        UserVO uservo = userservice.read(principal.getName());
	        model.addAttribute("user", uservo);
	        
	        log.info(uservo.getUserpoint());
	        
	        List<CartVO> orderlist = stservice.listCart(principal.getName());
	        model.addAttribute("order", orderlist);
	        
	        long sumMoney = stservice.sumMoney(principal.getName());
	        log.info(sumMoney);
	        detail.setSumMoney(sumMoney);
	        model.addAttribute("sumMoney", sumMoney);
	        
        }

        // 구매하기(장바구니)
        @PostMapping("/order")
        @PreAuthorize("isAuthenticated()")
        public void cartorder(UserVO vo, Order_detailVO detail, Principal principal, Model model) {         
	        log.info(principal.getName());
	        
	        vo.setUserid(principal.getName());
	        UserVO uservo = userservice.read(principal.getName());
	        model.addAttribute("user", uservo);
	        
	        List<CartVO> orderlist = stservice.listCart(principal.getName());
	        model.addAttribute("order", orderlist);
	        
	        long sumMoney = stservice.sumMoney(principal.getName());
	        log.info(sumMoney);
	        detail.setSumMoney(sumMoney);
	        model.addAttribute("sumMoney", sumMoney);	        
	        
        }         
        // 바로구매
        @GetMapping("/directorder")
        @PreAuthorize("isAuthenticated()")
    	public void directorder(CartVO vo, Principal principal, Model model) {

        	vo.setUserid(principal.getName());  

    	}        
                
        
        // 바로구매
        @PostMapping("/directorder")
        @PreAuthorize("isAuthenticated()")
    	public void getdirectorder(@RequestParam("pno") Long pno, HttpServletRequest req, UserVO vo, Principal principal, Model model) {

        	vo.setUserid(principal.getName());  
	        UserVO uservo = userservice.read(principal.getName());
	        model.addAttribute("user", uservo);
        	
	        SProductVO svo = service.read(pno);	
	        model.addAttribute("product", svo);
    		log.info(svo);
    		
    		String cartstock = req.getParameter("cartstock");
    		model.addAttribute("cartstock", cartstock);

    	}        
        
        // 구매완료
        @GetMapping("/orderlist")
        @PreAuthorize("isAuthenticated()")
        public void getorderlist(UserVO vo, Principal principal, Model model) {         
	        log.info(principal.getName());
	       
	        vo.setUserid(principal.getName());  
	        UserVO uservo = userservice.read(principal.getName());
	        model.addAttribute("user", uservo);

        }

        // 구매완료
        @PostMapping("/orderlist")
        @PreAuthorize("isAuthenticated()")
        public String orderlist(UserVO vo, Principal principal, Model model, RedirectAttributes rttr) {         
	        log.info(principal.getName());
	        
	        vo.setUserid(principal.getName());		        
	        UserVO uservo = userservice.read(principal.getName());
	        model.addAttribute("user", uservo);
	        
	        userservice.updateSpendPoint(vo);
	        userservice.updatePoint(vo);

	        stservice.deletecartlist(principal.getName());

	        return "redirect:/store/orderlist"; 

        } 
        
        
        
        
        
        
        
        // 관리자 페이지 참고용 자료 (권한X)
        // 상품 등록 페이지
    	@GetMapping("/register")
    	public void register(@ModelAttribute("cri") SPCriteria cri) {
    		
    	}
    	
    	// 상품 등록
        @PostMapping("/register")
        public String register(SProductVO svo, @RequestParam("store_file") MultipartFile[] store_file , RedirectAttributes rttr) {
        	service.register(svo, store_file);
        	rttr.addFlashAttribute("result", svo.getPno());
        	return "redirect:/store/home"; 
    		} 		
        
        // 상세페이지, 수정
		  @GetMapping({"/detail", "/modify"}) 
		  public void get(@RequestParam("pno") Long pno, @ModelAttribute("cri") SPCriteria cri, Model model) {
		  log.info("store/detail method");		  
		  SProductVO svo = service.read(pno);		  
		  model.addAttribute("store", svo);
		  
		  }
		 
		  // 상세페이지 수정하기
		  @PostMapping("/modify")
		  public String modify(SProductVO svo, SPCriteria cri,
				  		@RequestParam("store_file") MultipartFile[] store_file, RedirectAttributes rttr) {
		  
				boolean success = service.modify(svo, store_file);
				
				if (success) {
					rttr.addFlashAttribute("result", "success");
					rttr.addFlashAttribute("messageTitle", "수정 성공");
					rttr.addFlashAttribute("messageBody", "수정 되었습니다.");
				}
				
				rttr.addAttribute("pageNum", cri.getPageNum());
				rttr.addAttribute("amount", cri.getAmount());

				
				return "redirect:/store/home";
			}
		  
		  // 상세페이지 삭제
		  @PostMapping("/remove")
			public String remove(@RequestParam("pno") Long pno,
					SPCriteria cri, RedirectAttributes rttr, String writer) {

				boolean success = service.remove(pno);

				if (success) {
					rttr.addFlashAttribute("result", "success");
					rttr.addFlashAttribute("messageTitle", "삭제 성공");
					rttr.addFlashAttribute("messageBody", "삭제 되었습니다.");
				}
				rttr.addAttribute("pageNum", cri.getPageNum());
				rttr.addAttribute("amount", cri.getAmount());

				return "redirect:/store/home";
				
			}
			 
	}

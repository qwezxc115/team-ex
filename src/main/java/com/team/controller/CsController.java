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

import com.team.domain.Criteria;
import com.team.domain.NoticeVO;
import com.team.domain.PageDTO;
import com.team.service.CsService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cs")
@AllArgsConstructor
@Log4j
public class CsController {

	private CsService service;

	//공지사항 리스트
	@RequestMapping("/notice")
	public String notice(@ModelAttribute("cri") Criteria cri, Model model, NoticeVO nvo, Principal principal) {
		log.info("notice method");
		int total = service.getTotalN(cri);

		List<NoticeVO> list = service.getNoticeList(cri);
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		return "/cs/notice";
	}

	/* 공지 서식 */
	@GetMapping("/noticeWriting")
	@PreAuthorize("isAuthenticated()")
	public void noticeWriteForm(NoticeVO nvo) {
	}

	/* 공지 작성 */
	@PostMapping("/noticeWriting")
	public String noticeWriting(NoticeVO nvo, @RequestParam("notice_file") MultipartFile[] notice_file,
			RedirectAttributes rttr) {

		service.noticeWriting(nvo, notice_file);

		rttr.addFlashAttribute("result", nvo.getNno());
		rttr.addFlashAttribute("messageTitle", "작성성공! ");
		rttr.addFlashAttribute("messageBody", "공지사항이 등록 되었습니다!");

		return "redirect:/cs/notice";
	}

	@GetMapping({ "/noticeReading", "/noticeModify" })
	public void noticeReading(@RequestParam("nno") int nno, @ModelAttribute("cri") Criteria cri, Model model) {

		NoticeVO nvo = service.noticeReading(nno);
		model.addAttribute("nvo", nvo);

	}

	/* 공지 수정 */
	@PostMapping("/noticeModify")
	public String noticeModify(NoticeVO nvo, Criteria cri, @RequestParam("notice_file") MultipartFile[] notice_file,
			RedirectAttributes rttr) {

		log.info(nvo);

		boolean success = service.noticeModify(nvo, notice_file);

		if (success) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "수정 성공");
			rttr.addFlashAttribute("messageBody", "수정 되었습니다.");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		return "redirect:/cs/notice";
	}

	/* 공지삭제 */
	@PostMapping("/noticeDelete")
	public String noticeDelete(int nno, Criteria cri, RedirectAttributes rttr, String userid) {

		boolean success = service.noticeDelete(nno);
		if (success) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "삭제 성공");
			rttr.addFlashAttribute("messageBody", "삭제 되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		return "redirect:/cs/notice";

	}

	//Q&A
	@RequestMapping("/questionAndAnswer")
	public void cs() {
		log.info("questionAndAnswer method");
	}

}

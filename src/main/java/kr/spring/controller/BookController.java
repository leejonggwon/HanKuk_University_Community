package kr.spring.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.entity.Book;
import kr.spring.entity.Criteria;
import kr.spring.entity.Member;
import kr.spring.entity.PageMaker;
import kr.spring.service.BookService;

@Controller 
@RequestMapping("/book/*") 
public class BookController {
	
	@Autowired
	private BookService service;
	
	//도서검색창
	@RequestMapping("/bookSearch")
	public String bookSearch() {
		System.out.println("도서검색창이동");
		return "book/bookSearch";
	}
	
	
	
	//도서리스트
	@RequestMapping("/bookList")
	public String bookList(Model model, Criteria cri, HttpSession session) {
		//이제는 페이지 정보를 알고 있는 Criteria 객체를 Service에게 전달해준다
		List<Book> list = service.bookList(cri); 
		
		//현재로그인정보 
		Member mvo = (Member)session.getAttribute("mvo");
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		pageMaker.setTotalCount(service.totalCount(cri));
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("mvo", mvo);
		
		return "book/bookList";
	}
	
	
	
	
	

	//도서등록페이지 이동 
	@GetMapping("/bookRegister")
	public String bookRegister() {
		return "book/bookRegister";
	}
	
	
	//도서 등록
	@PostMapping("/bookRegister")
	public String bookInsert(Book book) {
		service.bookInsert(book);
		return "redirect:/book/bookList";
	}
	
	//수정화면
	@GetMapping("/bookContent")
	public String bookContent(@RequestParam("bkNum") int bkNum, Model model, @ModelAttribute("cri") Criteria cri) {
		Book vo = service.bookContent(bkNum);
		model.addAttribute("vo", vo);
		return "book/bookContent";
	}
	
	
	//수정기능
	@PostMapping("/bookUpdate")
	public String bookUpdate(Book book, Criteria cri, RedirectAttributes rttr) {
		service.bookUpdate(book);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:bookList";
	}
	
	//도서삭제
	@RequestMapping("/bookDelete")
	public String bookDelete(@RequestParam("bkNum") int bkNum, Criteria cri, RedirectAttributes rttr) {
		
		service.bookDelete(bkNum);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/book/bookList";
	}

}

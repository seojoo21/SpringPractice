package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.pageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board/*")
//BoardController는 BoardService에 의존적이므로 @AllArgsConstructor를 이용해서 생성자를 만들고 자동으로 주입해준다. 
@AllArgsConstructor 
public class BoardController {
	
	private BoardService service;
	
	//1. 게시물 목록 처리 (게시물 페이징 처리 전) 
//	@GetMapping("/list")
//	//list() 는 나중에 게시물의 목록을 전달해야하므로 Model을 파라미터로 지정한다. 
//	public void list(Model model) {
//		log.info("list");
//		model.addAttribute("list", service.getList());
//	}
	
	//1-1. 게시물 목록 처리 (게시물 페이징 처리)
	//list()에 Criteria 파라미터를 추가해준다. 
	//pageDTO를 사용할 수 있도록 Model에 담아서 화면에 전달해 줄 필요가 있다: "pageMaker"라는 이름으로 pageDTO 객체를 만들어 Model에 담아준다.  
	//전체 데이터 개수를 확인하는 getTotal() 메서드를 호출하여 total이라는 변수에 저장 후 pageDTO 객체 생성 시 전체 데이터 수 파라미터인 total로 넣어준다.  
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: "+ cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		
		log.info("total: "+total);
		
		model.addAttribute("pageMaker", new pageDTO(cri, total));
	}
	
	
	//2. 게시물 등록 처리 
	@PostMapping("/register")
	//RedirectAttributes를 파라미터로 지정한 이유: 등록 작업이 끝난 후 다시 목록 화면으로 이동하기 위함인데,
	//추가적으로 새롭게 등록된 게시물의 번호를 같이 전달하기 위해서 RedirectAttributes를 이용한다. 
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register:"+board);
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	
	
	//3. 게시물 조회 처리 
	//7. 게시물 수정 페이지 처리 추가 (@GetMapping, @PostMappin 등에는 URL을 배열로 처리할 수 있다.) 
	//8. 페이징 처리 중 조회 페이지에서 다시 원래 목록 페이지로의 이동 시 페이지 번호 유지를 위해 Criteria를 파라미터로 추가한다. 
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri")Criteria cri, Model model) {
		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
	}
	
	
	//4. 게시물 수정 처리 
	//9. 페이징 처리 중 수정 페이지에서 다시 원래 목록 페이지로의 이동 시 페이지 번호 유지를 위해 Criteria를 파라미터로 추가한다.
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri")Criteria cri, RedirectAttributes rttr) {
		log.info("/modify" +board);
		
		// 수정에 성공한 경우에만 RedirectAttributes에 추가  
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "sucess");
		}
		
//		// 1. addAttribute를 사용하여 파라미터를 받아 리다이렉트를 처리. 
//		// 다시 원래 목록 페이지로의 이동을 위해 URL 뒤에 pageNum값과 amount값을 입력하여 이동할 수 있도록 수정.
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		// 검색 처리 결과를 유지하기 위해 type과 keyword 조건을 리다이렉트 시에 포함시켜야 한다.
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		
//		return "redirect:/board/list";
		
		// 2. UriComponentsBuilder로 생성된 URL을 이용하여 리다이렉트를 처리. 
		return "redirect:/board/list" + cri.getListLink();
		
	}
	
	//5. 게시물 삭제 처리 
	//10. 페이징 처리 중 삭제 후 다시 원래 목록 페이지로의 이동 시 페이지 번호 유지를 위해 Criteria를 파라미터로 추가한다.
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri")Criteria cri, RedirectAttributes rttr ) {
		log.info("remove...." + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "sucess");
		}
		
//		// 1. addAttribute를 사용하여 파라미터를 받아 리다이렉트를 처리. 
//		// 다시 원래 목록 페이지로의 이동을 위해 URL 뒤에 pageNum값과 amount값을 입력하여 이동할 수 있도록 수정.
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		// 검색 처리 결과를 유지하기 위해 type과 keyword 조건을 리다이렉트 시에 포함시켜야 한다.
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		
//		return "redirect:/board/list";
		
		// 2. UriComponentsBuilder로 생성된 URL을 이용하여 리다이렉트를 처리. 
		return "redirect:/board/list" + cri.getListLink();
	}
	
	//6. 게시물 입력 페이지로 이동 
	//게시물 등록 작업은 POST 방식으로 처리하지만, 화면에서 입력을 받아야 하므로 GET방식으로 입력 페이지를 볼 수 있도록 한다. 
	//GET방식으로 연결한 register()는 입력 페이지를 보여주는 역할만을 하기 때문에 별도의 처리가 필요하지 않다.
	@GetMapping("/register")
	public void register() {
		
	}
	
	
	

	
}

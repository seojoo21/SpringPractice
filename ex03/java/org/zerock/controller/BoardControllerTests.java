package org.zerock.controller;

// Tomcat을 실행하지 않고 스프링와 웹URL을 테스트할 수 있는 코드를 앞으로 "codes for test: "라고 표시하겠음. 
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)

@WebAppConfiguration // codes for test: Servlet의 ServletContext를 이용하기 위함. 스프링에서는 WebApplicationContext라는 존재를 이용하기 위함이다. 
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@Log4j
public class BoardControllerTests {
	
	@Setter(onMethod_ = { @Autowired })
	private WebApplicationContext ctx;
	private MockMvc mockMvc;
	
	@Before //codes for test: @Before가 적용된 메서드는 모든 테스트 전에 매번 실행되는 메서드가 된다.(import 구문: import org.junit.Before;)
	//codes for test: MockMvc=가짜MVC. 가짜로 URL과 파라미터 등을 브라우저에서 사용하는 것처럼 만들어서 Controller를 실행해볼 수 있다. 
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	//1. 게시물 목록에 대한 테스트 
	@Test
	// testList()는 MockMvcRequestBuilders라는 존재를 이용해서 GET 방식의 호출을 한다. 
	// 이후에는 BoardController의 getList()에서 반환된 결과를 이용해서 Model에 어떤 데이터들이 담겨있는지 확인한다. 
	public void testList() throws Exception {
		log.info(
				// codes for test:
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	//2. 게시물 등록에 대한 테스트 
	@Test
	public void testRegister() throws Exception {
//		//codes for Test: POST 방식으로 데이터 전달 가능. param() 을 이용해서 전달해야하는 파라미터들 지정 가능. 
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
							.param("title", "테스트 새글 제목")
							.param("content", "테스트 새글 내용")
							.param("writer", "user00"))
							.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	//3. 게시물 조회에 대한 테스트 
	@Test
	public void testGet() throws Exception {
		// codes for Test: GET 방식으로 데이터 전달 가능. 게시물 조회시 반드시 'bno'라는 파라미터 필요하므로 param()을 통해 추가하고 실행  
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
				.param("bno", "1"))
				.andReturn()
				.getModelAndView()
				.getViewName());
	}
	
	//4. 게시물 수정에 대한 테스트
	public void testModify() throws Exception{
		//codes for Test:
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
				.param("bno", "1")
				.param("title", "수정된 테스트 새글 제목")
				.param("content", "수정된 테스트 새글 내용")
				.param("writer", "user00"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	//5. 게시물 삭제에 대한 테스트
	public void testRemove() throws Exception{
		//삭제 전 데이터베이스에 게시물 번호 확인할 것 
		//codes for Test:
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "18"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	//6. 게시물 페이징 처리에 대한 테스트
	@Test
	public void testListPaging() throws Exception {
		log.info(
				// codes for test:
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list")
						.param("pageNum", "2")
						.param("amount", "50"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
}


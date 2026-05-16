package kr.spring.mapper;

import java.sql.Connection;
import java.util.List;

import javax.sql.DataSource;


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

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.service.BoardServiceImpl;
import lombok.extern.log4j.Log4j;

@Log4j //테스트 실행결과를 콘솔창에 나오는 역할
@RunWith(SpringJUnit4ClassRunner.class) //실행하기위해 스프링컨테이너에 올리는 코드 
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"}) //root-context.xml 경로를 잡아주는 과정 (스프링 컨테이너 만들 때, 이 설정 파일을 참고해라)
@WebAppConfiguration //Servlet 컨테이너를 사용하기 위한 어노테이션, JUnit 테스트에서 웹 관련 객체를 사용할 수 있도록 웹 환경을 구성해준다
public class DataSouceTest {
	// root-context.xml이 이상없는지 test하는 클래스 
	
	//Connection이 잘되는지 테스트
	@Autowired //root-context.xml에 있는 id가 dataSource인 녀석을 사용하겠다 
	private DataSource dataSource; //javax.sql
	
	//mapper 테스트
	@Autowired
	private BoardMapper mapper;
	
	//Service 테스트
	@Autowired
	private BoardServiceImpl service;
	
	
	//**콘트롤러 테스트
	@Autowired
	private WebApplicationContext ctx; 
	//Spring Container 메모리 공간 객체
	//여기에는 Controller, Service, Mapper, DB 연결(HikariCP) 등 모든 웹 관련 객체가 들어있다

	private MockMvc mockMvc; 
	//가상의 MVC 웹 환경 만들어주는 객체(브라우저 없이 코드로 요청을 흉내내는 거야), 뷰, 핸들러, 맵핑 등등 실행해줌 
	
	//Test실행하기 전에 먼저 실행하는 부분 
	//가상의 웹 환경(MockMvc)을 만들면서, 실제 웹 애플리케이션 컨텍스트(ctx) 정보를 넣어주는 코드
	@Before //org.junit
	public void setup() {  
		this.mockMvc = MockMvcBuilders          //MockMvc를 만드는 빌더 클래스
					   .webAppContextSetup(ctx) //실제 웹 컨텍스트(ctx)를 기반으로 테스트 환경을 세팅
					   .build();                //빌더로 설정한 내용을 실제 MockMvc 객체로 만든다
	}
	
	
	//페이징 Service 테스트
	//생성자에서 설정한 페이지1번에 보여줄 게시글10개가 출력이 된다
	@Test
	public void testGetList() {
		Criteria cri = new Criteria();
		cri.setPage(2);
		cri.setPerPageNum(5);
		
		List<Board> list = service.getList(cri);
		
		for(Board vo: list) {
			System.out.println(vo.toString());
		}
	}
	
	
	
	
//	//페이징기능 게시글 목록(list) 컨트롤러 테스트
//	//pageMaker=PageMaker(cri=Criteria(page=1, perPageNum=10), totalCount=13, startPage=1, endPage=2, prev=false, next=false, displayPageNum=10)
//	@Test
//	public void testController() throws Exception {
//	    log.info(
//	        mockMvc.perform(
//	                MockMvcRequestBuilders.get("/board/list")  // list 요청                        
//	        )
//	        .andReturn()
//	        .getModelAndView() // Model과 View 정보 모두 가져옴
//	    );
//	}
//	

	
//	//컨트롤러 테스트(modify)
//	@Test
//	public void testController() throws Exception{
//		log.info( //org.apache.commons.logging //로그를 남기는 표준 API 제공
//				mockMvc.perform(MockMvcRequestBuilders.get("/board/modify?idx=3")) //board에 modify?idx=3를 요청하면 게시글 목록을 볼 수 있다 
//				.andReturn()       //return값을 받아오겠다
//				.getModelAndView() //controller의 model값과 view경로를 다 받아오겠다 
//				); 
//	}
	
	
	
//	//insertSelectKey 테스트
//	//mapper 이미 @Autowired해서 사용하면 된다 
//	@Test
//	public void testInsert() {
//		Board vo = new Board();
//		vo.setMemID("admin");
//		vo.setTitle("insertSelectKey 테스트 글");
//		vo.setContent("insertSelectKey 테스트 입니다");
//		vo.setWriter("관리자");
//		mapper.insertSelectKey(vo);
//	}
	

//	//insert 테스트
//	//mapper 이미 @Autowired해서 사용하면 된다 
//	@Test
//	public void testInsert() {
//		Board vo = new Board();
//		vo.setMemID("admin");
//		vo.setTitle("스프링 게시판 테스트 글");
//		vo.setContent("JUnit을 이용한 게시글 등록 테스트입니다");
//		vo.setWriter("관리자");
//		mapper.insert(vo);
//	}
	
	
//	//컨트롤러 테스트
//	@Test
//	public void testController() throws Exception{
//		log.info( //org.apache.commons.logging //로그를 남기는 표준 API 제공
//				mockMvc.perform(MockMvcRequestBuilders.get("/board/list")) //board에 list를 요청하면 게시글 목록을 볼 수 있다 
//				.andReturn()       //return값을 받아오겠다
//				.getModelAndView() //controller의 model값과 view경로를 다 받아오겠다 
//				); 
//	}
	

	 
//	//Service 테스트
//	@Test
//	public void testGetList() {
//		List<Board> list = service.getList();
//		for(Board vo: list) {
//			System.out.println(vo.toString());
//		}
//	}
	
	
	
//  //2. mapper getList 테스트	
//	@Test
//	public void testGetList() {
//		List<Board> list = mapper.getList();
//		for(Board vo: list) {
//			System.out.println(vo.toString());
//		}
//	}
	
	
	
	//Test는 하나만 해야하므로 주석처리 한다 
	 
//  //1. root-contextConnection 테스트
//	@Test
//	public void testConnection() {
//		try(Connection conn = dataSource.getConnection()){ //Connection를 가져온다 
//			log.info(conn); //이상없이 실행되면 info에 정보를 꺼낸다
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//	}
	

}

# 1. 서비스소개 
### 서비스명
- HanKuk University Community (한국대학교 커뮤니티) <br>

### 서비스설명
- 본 프로젝트는 스프링(Spring) 프레임워크와 MVC 3Tier 아키텍처를 기반으로 한 커뮤니케이션 프로젝트입니다. <br>
- 사용자 간 손쉽게 소통하고, 효율적으로 커뮤니티 기능을 활용할 수 있는 웹 애플리케이션 개발을 목표로 합니다. <br>
- 그룹 채팅, 메시지, 게시글 작성, 좋아요, 댓글·답글, 조회수, 검색, 페이징, 게시글 작성자 프로필, 좌석 발권, 자료 검색, 회원 관리 등의 기능을 제공합니다. <br>
- WebSocket과 비동기 통신(AJAX)을 활용한 실시간 갱신을 구현했습니다. <br>
- Bootstrap 3과 직관적인 JSP 기반 UI를 통해 사용자 친화적인 화면을 구성했습니다. <br>
<br>


# 2. 기술스택
- **Language** - Java 1.8 <br>
- **Framework** - Spring Framework 5.0.7.RELEASE <br>
- **Database:** - MySQL 5.1 + MyBatis 3.4.6 <br>
- **Web Layer** - JSP, JSTL, Servlet 3.1, jQuery, AJAX, HTML/CSS <br>
- **Logging & Utilities** - SLF4J, Log4j, Lombok <br>
- **Database Connectivity** - HikariCP, Spring JDBC <br>
- **Development Tools** - eGovFrame 4.0.0, Eclipse, Apache Tomcat 9 <br>
<br>


# 3. System Architecture 

<p align="center">
  <img src="https://github.com/user-attachments/assets/60435bdd-9784-43a1-a2c1-194e88dab72d" width="70%" />
  <br>
   [3Tier System Architecture]
</p>

### 1) Controller / RestController
-  MainController <br>
-  MemberController / MemeberRestController <br>
-  BoardController / BoardRestController <br>
-  SeatController / SeatRestController <br>
-  ChatController <br>
-  ommentRestController <br>
-  LikeRestController <br>

### 2) Service / ServiceImpl
- MemberService / MemberServiceImpl <br>
- BoardService / BoardServiceImpl <br>
- SeatService / SeatServiceImpl <br>
- CommentService / CommentServiceImpl <br>
- LikeService / LikeServiceImpl <br>

### 3) Mapper / mapper.xml
- MemberMapper / MemberMapper.xml <br>
- BoardMapper / BoardMapper.xml <br>
- SeatMapper / SeatMapper.xml <br>
- CommentMapper /CommentMapper.xml <br>
- LikeMapper /LikeMapper.xml <br>
<br>


# 4. DataBase E-R Diagram
<p align="center">
  <img src="https://github.com/user-attachments/assets/8702110a-16cd-4341-8128-b79fdf0deec5" width=100% />
  <br>
  [E-R Diagram]
</p>
<br>


# 5. 기능구조도
<p align="center">
  <img src="https://github.com/user-attachments/assets/1c202b67-cbd3-48fa-b2ef-01d6492d745a" width=60% />
  <br>
  [기능구조도]
</p>
<br>




# 6. 핵심기능설멸

### 로그인 페이지
▪ 로그인 인증 후 접근 가능<br>
▪ 비회원 접근 제한
<p align="center">
  <img src="https://github.com/user-attachments/assets/0cb0e457-c6f2-47b1-99a3-d4e7997db389" width="700" />
</p>


### 회원가입 
▪ 아이디 중복 확인 <br>
▪ 비밀번호 일치 여부 확인 <br>
▪ 필수 회원정보 미입력 시 메시지 출력 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/c0f902f9-7ea9-4dfc-88ec-9979f3d688ab" width="700" />
</p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/9c085db7-79aa-481f-ab79-535fa2b8303c" width="700" />
</p>


### 게시글 기능
▪ 게시글목록 <br>
▪ 게시글 상세보기 할 때마다 조회수 1씩 증가 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/54364dc7-5833-4be0-9319-b56e0d476664" width="700" />
</p>
<br>


▪ 게시글작성(제목 미입력 시 경고 메세지 츨력) <br>
▪ 파일업로드 <br>
▪ 게시글 목록으로 이동 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/6dab254e-4e28-4e7d-84de-0e5f9ebdfef2" width="700" />
</p>
<br>


▪ 게시글수정 <br>
▪ 게시글 삭제 <br>
▪ 답글 삭제시 "작성자에 의해 삭제된 게시글입니다" 표시 <br>
▪ 게시글 목록으로 이동 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/1ae3b894-7c6b-4402-a9fa-a8c1ece173cd" width="700" />
</p>
<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/e1d038f5-3e02-4269-bfe7-0b81b277fa94" width="700" />
</p>
<br>


### 작성자 프로필 및 메시지 기능
▪ 게시글 작성자를 클릭하면 작성자의 프로필 확인 및 메시지 전송 기능 제공 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/ccba83d8-173d-44aa-9954-7c8537b8cc1e" width="700" />
</p>

### 페이징 기능
▪ 페이지별 페이징  <br>
▪ 그룹별 페이징  <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/bb231d25-db8c-439d-8af2-f34a89f68dfe" width="700" />
</p>

### 검색 기능
▪ 옵션 별 검색  <br>
▪ 검색 후 게시글 열람 뒤 목록으로 돌아갈 때 기존 검색 조건 유지 기능<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/41971616-f6ba-47bf-9eb0-5835d089d960" width="700" />
</p>


### 좋아요 기능
▪ 좋아요 버튼 누르면 실시간 반영 <br>
▪ 한 게시물당 좋아요 1회 제한 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/ebba14ae-58e9-4bea-a988-c3109df47188" width="700" />
</p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/4420947a-da8f-4e03-9e4f-04458301ef3c" width="700" />
</p>


### 답글 기능
▪ 답글 입력 <br>
▪ 게시물의 그룹, 순서, 원본글 여부(원본글 0, 댓글 1, 대댓글 2)를 설정하여 답글 작성 가능 <br>
▪ 답글 수정 <br>
▪ 답글 삭제 <br>

 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/97b68cf2-e1f4-4ed2-a10c-67fb460c6965" width="700" />
</p>

<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/79eafdd7-1ce4-470a-a248-06b9636d3775" width="700" />
</p>


### 댓글 기능
▪ 댓글 등록 <br>
▪ 댓글 등록 <br>
▪ 댓글 삭제 시 “ 작성자에 의해 삭제된 댓글입니다” 표시<br>
 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/20f0a64f-0f82-480e-a688-ba863262144a" width="700" />
</p>

### 단체 오픈 채팅 기능 구현

▪ WebSocket 기반 실시간 그룹 채팅 구현<br>
<br>

<p align="center">
  <img  src="https://github.com/user-attachments/assets/429a3055-e868-43fb-b5bd-0a7b66014f67" width="700" />
</p>
<br>

<p align="center">
  <img  src="https://github.com/user-attachments/assets/5bf366e1-73bf-4027-89b2-d02cc0ab99af" width="400" />
</p>
<br>

### 프로필 이미지 업데이트
▪ 회원가입을 완료한 후 최초 로그인 시 기본 프로필 이미지가 설정된다
<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/c7c54ed3-08dd-4ed3-a805-b06f82812da7" width="700" />
</p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/d994a449-f3d5-4f61-a0f8-39be32f324a2" width="700" />
</p>

<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/f86a1d4f-feba-447b-86f6-a7c0d21e0ed2" width="700" />
</p>

### 프로필 수정
▪ 비밀번호, 사용자이름, 닉네임, 나이, 성별, 이름, 이메일 등 프로필수정이 가능하다  <br>
▪ 비밀번호, 비밀번호확인이 일치해야 한 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/c8c6697b-57a7-450e-b4b8-e8c4ecd21e0f" width="700" />
</p>


### 좌석 발권 기능

▪ 지정 좌석 발권 <br>
▪ 발권 후 다른 좌석을 다시 발권하려 할 경우 “현재 사용 중인 좌석이 있습니다”라는 경고창을 출력 <br>
▪ 다른 이용자가 사용 중인 좌석은 발권할 수 없도록 제한 <br>
▪ 발권 좌석 반납기능 <br>
▪ 현재 발권 정보 및 과거 발권 기록 조회 기능 <br>
<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/05b76200-6e0f-4553-89fb-e16504148c41" width="700" />
</p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/9a50c0ab-a66b-4ddb-8ca0-158dfdd61d9d" width="700" />
</p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/83254f2b-d029-48cf-a4ce-7093f79522d9" width="700" />
</p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/37b3cb91-c0a2-4400-830d-0016383d9b0a" width="700" />
</p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/60a2f07b-2bfd-4bc1-8954-6df629376e67" width="700" />
</p>
<br>



### 자료검색(사용자)

▪ 도서명, 작가, 출판사 등 다양한 검색 옵션을 활용하여 등록된 자료를 조회<br>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/5a5b764d-fc82-4490-915c-72d29f69534c" width="700" />
</p>
<br>

<p align="center">
  <img  src="https://github.com/user-attachments/assets/ad324b36-4cd6-4109-8d84-fa431c852146" width="700" />
</p>
<br>

### 자료검색(관리자)
▪ 관리자는 자료 등록 및 수정, 삭제 등 접근 가능 <br>
<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/03623187-51d5-4c00-b725-9ccdf03c1367" width="700" />
</p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/317fa267-d8a9-4dcb-b521-4559d615c0cf" width="700" />
</p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/7e822ba1-a090-4d6d-8fb7-80e7bc8500c7" width="700" />
</p>
<br>

### 메세지

▪ 새 메시지 도착 시 알림 기능 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/f09037d0-d068-4d28-99bf-26f92542736e" width="700" />
</p>
<br>


▪ 수신한 메시지 내역을 확인 <br>
▪ 받은 메세지 수 및 미열람 메세지 수 표시<br>
▪ 메시지 열람 여부(열람/미열람) 상태 표시 <br>
▪ 체크박스로 선택한 메시지를 삭제 <br>
▪ 발신자 아이디 및 제목 등 조건별로 메시지를 검색 <br>
▪ 보낸 메세지 페이지로 이동 <br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/bd529d7f-ea2e-4bfb-bdcc-74b692fda268" width="700" />
</p>
<br>


▪ 사용자가 메시지를 작성할 수 있는 기능 <br>
▪ 중복 확인 버튼을 이용해 수신자 아이디를 확인하는 기능<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/5682c9bc-c9b4-4d8c-815b-476be5499f09" width="700" />
</p>
<br>

<p align="center">
  <img  src="https://github.com/user-attachments/assets/07f807f9-12a0-4d14-bb78-5b49cd6811e4" width="700" />
</p>
<br>

▪ 발신자 아이디 클릭 시 작성자 프로필 확인 및 메시지 전송 버튼 제공 <br>
▪ 보내기 버튼 클릭 시 해당 발신자 어아다 기준으로 메시지 작성 화면으로 이동 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/b56f2461-9a6d-44df-9781-0dc4c73a67d2" width="700" />
</p>
<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/f5408e1c-d19c-4d66-ab25-1b5e2cbb21d5" width="700" />
</p>
<br>

▪ 보낸 메세지 내역을 확인  <br>
▪ 보낸 메세지 수 표시<br>
▪ 메시지 열람 여부(열람/미열람) 상태 표시 <br>
▪ 체크박스로 선택한 메시지를 삭제 <br>
▪ 발신자 아이디 및 제목 등 조건별로 메시지를 검색 <br>
▪ 받은 메세지 페이지로 이동 <br>
<p align="center">
  <img  src="https://github.com/user-attachments/assets/aaf0da10-fa40-4e9e-8167-14a839513467" width="700" />
</p>
<br>

<p align="center">
  <img  src="https://github.com/user-attachments/assets/a94072cb-1be9-4a9c-b0b4-517c7a762477" width="700" />
</p>
<br>




# 1. 서비스소개 
<p align="center">
  <img src="https://github.com/user-attachments/assets/53dc26f0-91cd-4fdf-9a57-ed103ecc2ed8" width="100%" />
</p>

### 서비스명
- HanKuk University Community (한국대학교 커뮤니티) <br>
- Spring MVC와 WebSocket을 활용한 3-Tier Architecture 기반 대학생 중심 커뮤니티 플랫폼

### 서비스설명
- 본 프로젝트는 스프링(Spring) 프레임워크와 MVC 3Tier 아키텍처를 기반으로 한 커뮤니케이션 프로젝트입니다. <br>
- 사용자 간 손쉽게 소통하고 효율적으로 커뮤니티 기능을 활용할 수 있는 웹 애플리케이션 개발을 목표로 합니다. <br>
- 실시간 그룹 채팅, 메시지(메일), 좌석 발권, 게시판 CRUD, 댓글·답글, 검색, 페이징, 게시글 작성자 프로필, 좋아요, 조회수, 자료 검색, 회원 관리 등의 기능을 제공합니다. <br>
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


# 3. Spring MVC
<p align="center">
  <img src="https://github.com/user-attachments/assets/b1b16204-b73e-494a-8991-bd9eb5dfc7be" width="50%" />
  <br>
   [Spring MVC]
</p>


# 3. System Architecture 

<p align="center">
  <img src="https://github.com/user-attachments/assets/60435bdd-9784-43a1-a2c1-194e88dab72d" width="50%" />
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
  <img src="https://github.com/user-attachments/assets/13926689-cb28-4cf4-bef1-a0589860bb74" width=55% />
  <br>
  [기능구조도]
</p>
<br>



# 6. 핵심기능설명

## 1.메시지(메일) 시스템(Message System)
사용자 간 원활한 소통과 실시간 알림을 제공하기 위한 통합 메시징 서비스입니다 <br>

### 실시간 메시지 알림
- JAX를 활용하여 페이지 새로고침 없이 상단 헤더의 배지(Badge)를 통해 신규 메시지 수신 여부를 실시간으로 시각화했습니다 <br>
<br>

### 메시지함 관리
- **받은 메세지함** -  페이징 처리 및 발신자/제목 기반의 동적 검색 기능을 제공하여 편의성을 높였습니다 <br>
- **보낸 메시지함** -  내가 보낸 메시지의 이력을 관리하며, 상대방의 수신 여부(`ReadStatus`)를 실시간으로 확인할 수 있습니다 <br>
<br>

### 비동기 프로필 및 유효성 체크
- **작성자 정보 조회** -  메시지 목록에서 작성자 클릭 시 AJAX 통신으로 회원의 상세 정보(이름, 전공, 사진 등)를 모달 창으로 즉시 호출합니다 <br>
- **오발송 방지** -  메시지 작성 시 수신자 아이디 존재 여부를 비동기로 체크하여 잘못된 전송을 사전에 차단합니다 <br>
<br>

### 기술적특징
- **상태 세분화 설계를 통한 UX 최적화** <br>
  - `readStatus` - 개별 메시지의 읽음/미열람 상태를 관리하여 사용자가 읽은 메시지를 구분할 수 있게 합니다 <br>
  - `arriveStatus` - 시지 목록 진입 시 알림 배지를 초기화하는 상태 값으로, '알림 확인'과 '내용 읽기'를 분리하여 정교한 UX를 구현했습니다 <br>
<br>

- **논리적 삭제 (Soft Delete) 적용** <br>
  - `delToID`, `delFromID` 컬럼을 개별적으로 활용하여, 데이터베이스에서 레코드를 물리적으로 지우지 않고 상태값만 변경합니다 <br>
  - 이를 통해 발신자와 수신자 중 한쪽이 메시지를 삭제하더라도 상대방의 메시지함 데이터는 보존되는 실무적인 삭제 방식을 채택했습니다 <br>
<br>

- **안전한 파일 업로드 및 스트리밍 다운로드** <br>
  - **파일명 보안** - `UUID`를 적용하여 파일명 중복을 방지하고 보안성을 강화했습니다 <br>
  - **서버측 처리** - `MultipartRequest`를 통해 파일을 서버에 저장하고, 다운로드 시 `ResponseEntity<Resource>`와 `StandardCharsets` 인코딩을 사용하여 한글 깨짐 없는 안정적인 파일 스트리밍을 구현했습니다 <br>
<br>

- **사용자 중심의 일괄 처리 및 데이터 처리** <br>
  - **체크박스 기반 다중 선택** - 각 행의 메시지 고유 번호(`msgIdx`)를 체크박스에 매핑하여 사용자가 여러 항목을 직관적으로 선택할 수 있도록 구현했습니다 <br>
  - **동적 폼 데이터 바인딩** - JavaScript(jQuery)를 활용해 선택된 값을 배열로 수집하고, 기존 전송 폼(`pageFrm`)에 `hidden` 태그로 동적 삽입하여 단 한 번의 요청으로 일괄 처리가 가능하도록 설계했습니다 <br>
<br>







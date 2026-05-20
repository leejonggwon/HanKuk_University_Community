# 1. 서비스소개 
<p align="center">
  <img src="https://github.com/user-attachments/assets/a102e35c-af0e-4c29-bc66-27cf606e0178" width="100%" />
</p>


### 1-1. 서비스명
- HanKuk University Community (한국대학교 커뮤니티) <br>
- Spring MVC와 WebSocket을 활용한 3-Tier Architecture 기반 대학생 중심 커뮤니티 플랫폼<br>

<br>

### 1-2. 서비스설명
- 본 프로젝트는 스프링(Spring) 프레임워크와 MVC 3Tier 아키텍처를 기반으로 한 커뮤니케이션 프로젝트입니다. <br>
- 사용자 간 손쉽게 소통하고 효율적으로 커뮤니티 기능을 활용할 수 있는 웹 애플리케이션 개발을 목표로 합니다. <br>
- 실시간 그룹 채팅, 메시지(메일), 좌석 발권, 게시판 CRUD, 댓글·답글, 검색, 페이징, 게시글 작성자 프로필, 좋아요, 조회수, 자료 검색, 회원 관리 등의 기능을 제공합니다. <br>
- WebSocket과 비동기 통신(AJAX)을 활용한 실시간 갱신을 구현했습니다. <br>
- Bootstrap 3과 직관적인 JSP 기반 UI를 통해 사용자 친화적인 화면을 구성했습니다. <br>
<br>

### 1-3. 프로젝트기간
- 2025.10 ~ 2025.12 <br>
- renewal - 2026.5 <br>
<br>

### 1-4. 시연영상
https://www.youtube.com/watch?v=HDL472NQWXA

<br>

# 2. 기술스택
- **Language** - Java 1.8 <br>
- **Framework** - Spring Framework 5.0.7.RELEASE <br>
- **Database** - MySQL 5.1 + MyBatis 3.4.6 <br>
- **Web Layer** - JSP, JSTL, Servlet 3.1, jQuery, AJAX, HTML/CSS <br>
- **Logging & Utilities** - SLF4J, Log4j, Lombok <br>
- **Database Connectivity** - HikariCP, Spring JDBC <br>
- **Development Tools** - eGovFrame 4.0.0, Eclipse, Apache Tomcat 9 <br>
<br>


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

<br>

## 1. 메시지 시스템(Message System)
사용자 간 원활한 소통과 실시간 알림을 제공하기 위한 통합 메시징 서비스입니다 <br>

<br>

### 1-1. 실시간 메시지 알림
- JAX를 활용하여 페이지 새로고침 없이 상단 헤더의 배지(Badge)를 통해 신규 메시지 수신 여부를 실시간으로 시각화했습니다 <br>

<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/80a1e767-df31-4f85-a11d-06027831df2e" width="90%" />
  <br>
   [실시간 메시지 알림]
</p>
<br>

### 1-2. 메시지함 관리
- **받은 메세지함** -  페이징 처리 및 발신자/제목 기반의 동적 검색 기능을 제공하여 편의성을 높였습니다 <br>
- **보낸 메시지함** -  내가 보낸 메시지의 이력을 관리하며, 상대방의 수신 여부(`ReadStatus`)를 실시간으로 확인할 수 있습니다 <br>
<br>  

### 1-3. 비동기 프로필 및 유효성 체크
- **작성자 정보 조회** -  메시지 목록에서 작성자 클릭 시 AJAX 통신으로 회원의 상세 정보(이름, 전공, 사진 등)를 모달 창으로 즉시 호출합니다 <br>
- **오발송 방지** -  메시지 작성 시 수신자 아이디 존재 여부를 비동기로 체크하여 잘못된 전송을 사전에 차단합니다 <br>

<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/0cfbce8e-74ee-4bca-867c-8b50c0fb3ac2" width="90%" />
  <br>
   [작성자 정보 조회]
</p>
<br>

### 1-4. 기술적특징
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

<p align="center">
  <img src="https://github.com/user-attachments/assets/5a8e1d7e-54df-40c1-8e0d-08d821b4bafa" width="90%" />
  <br>
   [받은 메세지함]
</p>
<br>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/5215b375-f466-46f1-956f-1e71bd347c6f" width="90%" />
  <br>
   [보낸 메세지함]
</p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/359754eb-e094-4462-b616-7b6a97ff22a9" width="90%" />
  <br>
   [메세지 작성]
</p>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/c242ed0f-06ea-46bc-9b98-b1fd74183e0d" width="90%" />
  <br>
   [메시지 상세 보기]
</p>
<br>


## 2. 좌석 발권 및 관리 시스템 (Seat Reservation System)
사용자가 실시간으로 열람실 좌석 현황을 확인하고, 발권 및 반납을 자기주도적으로 수행할 수 있는 통합 관리 시스템입니다 <br>
<br>

### 2-1. 실시간 좌석 배치 시각화
 -  `c:forEach`와 `c:choose`를 활용하여 DataBase의 좌석상태값(`seatAvailable`)에 따라 버튼의 활성화 상태를 실시간으로 렌더링합니다 <br>
<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/2172384f-3189-44fd-9085-8cb8374abc44" width="90%" />
  <br>
   [좌석발권페이지]
</p>
<br>

### 2-2. 중복 발권 방지
 - 사용자의 현재 발권상태(`memStatus`)를 실시간으로 체크하여, 이미 좌석을 이용 중인 경우 추가 발권을 원천 차단하는 정교한 예외 처리를 구현했습니다 <br>
 - 이미 이용 중인 좌석이 있는 경우, 추가 발권 시도를 감지하여 "사용 중인 좌석이 있습니다" 라는 안내와 함께 프로세스를 안전하게 차단함으로써 데이터 중복 생성을 방지했습니다 <br>
<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/8a443e61-535f-48f2-b170-5590ec50c0cd" width="90%" />
  <br>
   [중복 발권 방지]
</p>
<br>

### 2-3. 비동기 발권 프로세스
 - 좌석 발권으로 [좌석 점유 상태 변경 → 회원 상태 업데이트 → 발권 데이터 생성]으로 이어지는 연쇄적인 비동기 로직을 구현하여 사용자 편의성을 극대화했습니다 <br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/72cab087-9903-4817-84b1-a31403d08002" width="50%" />
  <br>
   [Ajax 비동기 발권 프로세스]
</p>


### 2-4. 비통합 이용 정보 관리
 - 현재 이용 중인 좌석 정보(n`owRInfo`)와 과거 이용 기록(`rRecord`)을 한 화면에서 비동기로 조회할 수 있으며, JavaScript `Date` 객체 가공을 통해 기록 데이터 가독성을 높였습니다. <br>
<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/c320ceec-626a-4e67-a355-f8f7646bd8c0" width="90%" />
  <br>
   [발권정보페이지]
</p>

### 2-5. 기술적특징
- **데이터 정합성 유지** <br>
  - **발권 시** - `CM_SEAT`의 가용 상태와 회원데이터의 이용 상태(`memStatus`)를 동시 업데이트하여 데이터 간의 모순이 없도록 설계했습니다 <br>
  - **반납 시** - `NOW()` 함수로 정확한 반납 시간을 기록하고, ENDTIMESTATUS 값을 통해 정상 반납 데이터를 관리합니다 <br>
<br>

- **AJAX 기반의 효율적인 UI 업데이트** <br>
  - 발권/반납 성공 시 전체 페이지 새로고침 대신 특정 UI 섹션인 현재발권정보(`nowRview`), 발권기록 출력(`recordView`)만 선택적으로 업데이트하여 서버 자원을 절약하고 부드러운 화면 전환을 구현했습니다<br>
<br>


## 3. 파일 업로드 및 관리 기능 (File Upload System)
사용자가 게시글을 등록할 때 이미지 및 첨부파일을 안전하게 서버에 저장하고 관리하기 위해 다음과 같은 로직을 구현했습니다 <br>
<br>

### 3-1. 주요 기술 스택 및 라이브러리
- **Library** - `cos.jar` (MultipartRequest) <br>
- **Storage** - 로컬 파일 시스템 서버 저장 방식 <br>
  <br>
  
### 3-2. two-way 유효성 검증
- **Client-side** - `accept="image/*"` 속성과 `startsWith("image/")`를 통해 업로드 전 1차 필터링을 수행하여 불필요한 서버 요청을 방지했습니다 <br>
- **Server-side** - 파일 확장자(PNG, JPG, GIF)를 대문자로 변환 후 재검증하여 비정상적인 파일 업로드를 차단했습니다 <br>

   <br>
    <p align="center">
      <img src="https://github.com/user-attachments/assets/6765a10d-2ab5-42b6-bc68-ec150872552c" width="80%" />
      <br>
       [Client-side - accept="image/*"]
    </p>

  <br>
  <p align="center">
    <img src="https://github.com/user-attachments/assets/1ad92840-7399-4ab0-b7c3-d0c7a9022e8f" width="40%" />
    <br>
     [Client-side - startsWith("image/")]
  </p>
  
  <br>
  <p align="center">
    <img src="https://github.com/user-attachments/assets/fe7ca022-9155-4128-b31d-ea114669a5f6" width="60%" />
    <br>
     [Server-side]
  </p>
  <br>

### 3-3. UUID 기반 파일 고유성 확보
- 동일한 파일명을 가진 데이터를 여러 사용자가 업로드할 경우 발생하는 데이터 덮어쓰기(Conflict) 문제를 해결하기 위해 `UUID.randomUUID()`를 적용했습니다 <br>
- **저장 구조** - UUID_원본파일명 형태로 저장하여 DB와 물리적 파일 간의 매핑을 안전하게 관리합니다 <br>
  <br>

### 3-4. 데이터 정합성 유지 및 효율적 수정 로직
- 파일이 새로 첨부되지 않으면` hidden`으로 넘겨받은 `originImgpath`를 유지하여 데이터 소실을 방지합니다. <br>
- 프로필 이미지 변경 시 File.delete()를 호출하여 서버 내 불필요한 구버전 파일을 물리적으로 삭제, 스토리지 용량을 효율적으로 관리합니다 <br>
  <br>    
  
### 3-5. 동적 디렉토리 생성
- 파일 저장 경로가 존재하지 않을 경우 `targetDir.exists()` 체크 후 `mkdirs()`를 통해 실행 시점에 디렉토리를 자동 생성하여 런타임 에러를 예방했습니다 <br>
<br>
 <p align="center">
    <img src="https://github.com/user-attachments/assets/1144f5a9-02e5-4b5a-8aad-8024d60540de" width="90%" />
    <br>
     [커뮤니티 - 첨부파일 업로드]
  </p>

<br>
 <p align="center">
    <img src="https://github.com/user-attachments/assets/6006a158-bdcd-4f9b-b7fb-2635a1a65ece" width="90%" />
    <br>
     [회원정보수정 - 프로필이미지 업로드]
  </p>

<br>


## 4. 파일 다운로드 시스템 (File Download)
파일 업로드 시 보안을 위해 적용한 UUID를 다운로드 시점에 동적으로 제거하고, UTF-8 인코딩을 통해 다양한 브라우저 환경에서 한글 파일명이 안전하게 다운로드되도록 구현했습니다 <br>

### 4-1. UUID 제거 및 원본명 복구
 -  서버 저장 시 중복 방지를 위해 붙였던 UUID를 제거하고, 사용자에게는 원래의 파일명으로 다운로드되도록 처리하여 가독성을 높였습니다 <br>

 
### 4-2. ResponseEntity
 -  스프링의 `ResponseEntity`를 사용하여 단순한 파일 전송을 넘어 HTTP 상태 코드와 헤더 정보를 정밀하게 제어했습니다 <br>


### 4-3. 한글 파일명 인코딩
 -  `UriUtils.encode`를 적용하여 브라우저 환경에 관계없이 한글 파일명이 깨지지 않도록 처리했습니다 <br>


### 4-4. 보안 전송
 -  `APPLICATION_OCTET_STREAM` 타입을 지정하여 파일의 종류와 상관없이 브라우저가 즉시 다운로드 창을 띄우도록 설정했습니다 <br>


### 4-5. 로직 흐름 (Technical Workflow)
   **1. 경로식별** - `@PathVariable`과 정규표현식(`:.+`)을 조합해 확장자가 포함된 전체 파일명을 안전하게 파라미터로 받습니다 <br>
   **2. 리소스 객체화** - 로컬 경로의 파일을 `UrlResource` 객체로 변환하여 메모리 효율적인 스트리밍 준비를 마칩니다 <br>
   **3. 예외 처리** - 파일이 존재하지 않을 경우 404 Not Found를 반환하여 시스템 안정성을 확보했습니다 <br>
   **4. 파일명 파싱** - `indexOf("_")`를 활용해 저장용 이름(UUID_파일명)에서 실제 파일명만 추출합니다 <br>
   **5. 헤더 설정 (Content-Disposition)** - `attachment` 설정을 통해 브라우저 내부 실행이 아닌 '첨부 파일 다운로드' 방식을 강제합니다 <br>
<br>

 <p align="center">
    <img src="https://github.com/user-attachments/assets/59ecc2c5-fea5-4a63-931a-e44f1891fe77" width="90%" />
    <br>
     [파일다운로드기능]
  </p>
  <br>


## 5. 페이징 및 동적 검색 시스 (Paging & Dynamic Search)
대량의 데이터를 효율적으로 조회하고, 사용자가 원하는 정보를 빠르게 찾을 수 있도록 객체 지향적 페이징 처리와 MyBatis 동적 SQL 기반의 검색 기능을 구현했습니다 <br>

### 5-1. 주요 설계
 **Criteria** - 페이지 번호(`page`), 페이지당 게시글 수(`perPageNum`), 검색 키워드 및 타입 데이터를 하나의 객체로 캡슐화하여 계층 간 데이터 전달을 단순화했습니다 <br>
 **PageMaker** - 복잡한 페이징 연산(시작/끝 페이지 계산, 이전/다음 버튼 활성화 여부 등)을 전담하는 클래스를 설계하여 View의 로직 부담을 줄였습니다 <br>
 **Dynamic SQL** - MyBatis의 `<sql>`과 `<include>` 태그를 사용하여 검색 조건에 따라 SQL이 동적으로 생성되도록 구현, 유지보수성을 높였습니다 <br>
 <br>


### 5-2. MyBatis 동적 SQL과  태그 활용
 검색 조건에 따라 SQL이 유연하게 변하도록 <sql>과 <include> 태그를 사용했습니다. 이는 코드의 재사용성을 높이고 유지보수를 용이하게 합니다. <br>
 <br>
 <p align="center">
    <img src="https://github.com/user-attachments/assets/58a937b6-7edf-4dfa-8d5d-3f907d35148f" width="70%" />
    <br>
     [BoardMapper.xml]
  </p>
  <br>
  
### 5-3. JavaScript를 이용한 폼 컨트롤
 페이징 번호를 클릭했을 때 단순히 링크로 이동하는 것이 아니라, 숨겨진 폼(pageFrm)의 값을 JavaScript로 조작하여 전송합니다 <br>

 - **상태 유지** - 페이지 번호를 클릭해도 현재의 검색 조건(type, keyword)이 파라미터로 함께 전송되어 검색 결과 내에서 페이지 이동이 가능합니다 <br>
 - **상세보기 연동** - 게시글 제목 클릭 시에도 기존 페이징 정보를 파라미터로 들고 감으로써, '목록으로 돌아가기' 시 이전 상태를 복원합니다 <br>
 <p align="center">
    <img src="https://github.com/user-attachments/assets/d961aa71-5742-4140-accd-99cb74f03b9b" width="40%" />
    <br>
     [페이지 번호 클릭시 이동하기]
  </p>
 <br>

### 5-4. RedirectAttributes
수정/삭제 후 리다이렉트 시 `addAttribute`로 페이징 정보를 유지하고, `addFlashAttribute`로 결과 메시지를 일회성 모달로 띄워 사용자에게 명확한 피드백을 제공합니다 <br>
 <br>

 <p align="center">
    <img  src="https://github.com/user-attachments/assets/3e0cb289-b988-440b-8905-3c6c98cafb0c" width="90%" />
    <br>
     [페이징기능]
  </p>
 <br>


<p align="center">
    <img  src="https://github.com/user-attachments/assets/504760b9-e8f6-43af-853b-eaf419d77d6f" width="90%" />
    <br>
     [검색기능]
  </p>
 <br>



 ## 6. 계층형 답글 시스템
부모 게시글에 대한 답글을 계층적으로 시각화하고, 복잡한 정렬 순서를 유지하면서 파일 업로드와 페이징 상태까지 보존하는 고급 게시판 기능을 구현했습니다 <br>

### 6-1. 계층구조설계
  - **BoardGroup (그룹 번호)** - 원본 글(부모)과 그에 달린 모든 답글을 하나의 그룹으로 묶습니다. 부모글의 그룹 번호를 그대로 상속받습니다 <br>
  - **BoardSequence (순서)** -같은 그룹 내에서 위아래 출력 순서를 결정합니다. 부모글의 순서보다 1 큰 값을 가지며, 기존 답글들의 순서를 뒤로 밀어내는(Update) 로직을 포함합니다 <br>
  - **BoardLevel (들여쓰기)** - 답글의 깊이를 나타냅니다. 부모글의 레벨보다 1 큰 값을 가지며, UI에서 왼쪽 여백(Padding)을 결정하는 기준이 됩니다 <br>
<p align="center">
    <img  src="https://github.com/user-attachments/assets/3a770f2f-3b21-4350-9c48-c0124039bd66" width="50%" />
    <br>
     [계층구조]
  </p>
 <br>

### 6-2. 핵심 로직: 답글 저장 프로세스
  - **1. 부모 정보 조회** - 답글을 달 대상(부모)의 `idx`를 통해 부모의 `Group`, `Sequence`, `Level` 정보를 가져옵니다 <br>
  - **2. 시퀀스 재배열 (Update):** -같은 그룹 내에서 부모보다 아래에 있던 기존 답글들의 `Sequence`를 모두 1씩 증가시켜 새로운 답글이 들어갈 자리를 만듭니다 <br>
  - **데이터 삽입 (Insert)** - 모의 정보를 바탕으로 계산된 신규 `Sequence`, `Level` 값을 적용하여 저장합니다 <br>
 <br>
 

<p align="center">
    <img  src="https://github.com/user-attachments/assets/a0a41807-9ae5-439e-9e1d-dc4cdec1bd8f" width="90%" />
    <br>
     [답글기능]
  </p>
 <br>



## 6. 비동기 댓글 기능 
페이지 새로고침 없이 실시간으로 댓글 데이터를 처리하는 비동기 통신 시스템을 구현했습니다 <br>

### 6-1. RESTful 기반 비동기 로드 (AJAX)
 - 게시글 고유 번호(idx)를 파라미터로 전달하여 해당 게시글에 속한 댓글 리스트를 JSON 형태로 수신합니다 <br>
 - 전체 페이지를 다시 읽어오지 않고 댓글 영역만 동적으로 렌더링하여 서버 부하를 줄이고 사용자 체감 속도를 개선했습니다 <br>
 
### 6-2. 효율적인 데이터 직렬화 및 실시간 갱신
 - jQuery의 serialize() 메서드를 사용하여 폼 내의 다수 입력 필드를 쿼리 스트링으로 자동 변환, 데이터 전송 로직을 간결화했습니다 <br>
 - 댓글 등록 성공 시 콜백 함수를 통해 목록 로드 함수(loadCmt)를 재실행함으로써 별도의 액션 없이도 최신 데이터가 반영되도록 설계했습니다 <br>

### 6-3. 데이터 무결성을 위한 논리적 삭제(Soft Delete)
 - DB에서 데이터를 물리적으로 즉시 삭제하는 대신, cmtAvailable 플래그(0: 삭제, 1: 활성)를 업데이트하는 방식을 채택했습니다 <br>
 - 삭제된 데이터도 "작성자에 의해 삭제된 댓글입니다"라는 메시지를 남겨 게시글의 전체적인 맥락과 대화 흐름이 깨지지 않도록 처리했습니다 <br>

### 6-4. 세션 기반 사용자 권한 검증
 - 세션에 저장된 사용자 정보(`memID`)와 댓글 작성자 정보를 대조하여, 본인의 댓글에만 삭제 버튼이 활성화되도록 프론트엔드와 백엔드에서 이중으로 검증합니다 <br>

   
 <p align="center">
    <img  src="https://github.com/user-attachments/assets/680c6016-3d93-435a-aed0-336b77dd7be6" width="70%" />
    <br>
     [댓글기능]
  </p>
 <br>

<p align="center">
    <img  src="https://github.com/user-attachments/assets/629cfe92-52ff-4ce0-9c6b-64c86cd5b0e5" width="70%" />
    <br>
     [댓글기능 - 논리적 삭제]
  </p>
 <br>


## 7. 비동기 좋아요 기능 
- 사용자가 게시물에 대해 '좋아요'를 누르거나 취소할 수 있는 비동기 시스템입니다 <br>
- 페이지 새로고침 없이 실시간으로 상태가 반영되도록 구현했습니다 <br>

### 7-1. 주요 기능
 - **비동기 처리** - `AJAX`를 사용하여 화면 전환 없이 좋아요 수와 버튼 상태를 업데이트합니다 <br>
 - **상태 유지** - `CM_LIKE` 테이블에사용자별 좋아요 기록을 저장하여 재방문 시에도 상태를 유지합니다 <br>
 - **토글 방식** - 하나의 버튼으로 '좋아요'와 '좋아요 취소' 기능을 번갈아 수행합니다

### 7-2. 프로세스 흐름 <br>

#### 1) 좋아요 클릭시 (likePlus) <br>
 - `CM_BOARD`의 `LIKECOUNT`를 +1 합니다 <br>
 - `CM_LIKE` 테이블에 사용자 ID와 게시물 번호를 `INSERT` 합니다 <br>
 - 성공 시 버튼의 색상을 `btn-danger`로 변경을 합니다 <br>
 
#### 2) 좋아요 취소 시 (unLike) <br>
 - `CM_BOARD`의 `LIKECOUNT`를 -1 합니다 <br>
 - `CM_LIKE` 테이블에 사용자 ID와 게시물 번호를 `DELETE` 합니다 <br>
 - 성공 시 버튼의 색상을 `btn-default`로 초기화 합니다 <br>

 <p align="center">
    <img src="https://github.com/user-attachments/assets/c9bcb55e-f0b1-4748-857c-712a0af70f3e"" width="90%" />
    <br>
     [좋아요 기능]
  </p>
 <br>


## 8. 공통 프로필 상세 정보 시스템
- 게시글 리스트나 댓글 창에서 작성자의 이름을 클릭하면, 비동기 통신을 통해 해당 사용자의 상세 정보를 모달 형태로 제공하는 기능입니다 <br>
- 페이지 새로고침 없이 실시간으로 상태가 반영되도록 구현했습니다 <br>
  <br>
  
 ### 주요 특징
 - **컴포넌트 재사용성** - 게시글, 댓글, 쪽지함 등 사용자 ID가 노출되는 모든 곳에 동일한 로직을 적용하여 코드 중복을 최소화했습니다 <br>
 - **이벤트 위임** - `$(document).on("click", ...)` 방식을 사용하여, 페이지 로드 후 AJAX로 동적으로 생성된 댓글 작성자 클릭 시에도 이벤트가 안정적으로 작동합니다 <br>
 - **비동기 데이터 바인딩** - AJAX를 통해 서버로부터 회원 정보를 JSON 형태로 받아와 모달에 실시간으로 반영합니다 <br>
 <br>
 
 ### 기술적 포인트
 - **Data Attribute 활용** - HTML data-* 속성에 작성자 ID를 숨겨 저장하고, 이를 서버 통신용 키(Key)값으로 활용합니다. <br>
 - 모달 내부 데이터 저장소(`data("writer_ID")`)에 실제 ID를 보관하여, 화면 표시 내용과 별개로 '메시지 보내기' 등 내부 로직에서 정확한 참조가 가능하도록 설계했습니다 <br>

<p align="center">
    <img src="https://github.com/user-attachments/assets/5bd63012-cbe3-4a24-a07f-59fc6c1e1681" width="40%" />
    <br>
     [프로필 상세정보 시스템 - Data Attribute 활용]
  </p>
 <br>
 <p align="center">
    <img src="https://github.com/user-attachments/assets/5da944e2-9f4e-4209-8e91-c1af35b3f9ae" width="90%" />
    <br>
     [프로필 상세정보 시스템]
  </p>
 <br>


## 9. 실시간 그룹 오픈채팅 시스템 (WebSocket) <br>
### 9-1. 주요 특징 (Key Features) <br>
- **전이중 통신(Full-Duplex)** - 표준 `Native WebSocket API` 활용하여 서버와 클라이언트 간의 실시간 양방향 메시지 전송을 구현 <br>
- **그룹별 세션 관리** - 같은 그룹에 속한 사용자들끼리만 메시지를 주고받을 수 있도록 세션 필터링 로직을 설계 <br>
- **실시간 접속자 리스트** - `ServletContext`를 활용해 서버 전체의 접속자 현황을 관리하고, 사용자의 입장/퇴장 시 실시간으로 접속자 목록이 갱신되도록 구현<br>
- **Handshake 인터셉터** - `HttpSessionHandshakeInterceptor`를 통해 HTTP 세션 정보(로그인 아이디, 그룹명 등)를 웹소켓 세션으로 안전하게 전이시켜 활용<br>
<br>

### 9-2. [Server] 세션 핸들링 및 메시지 브로드캐스팅 <br>
- **접속 관리** - 사용자가 연결되면 `ArrayList<WebSocketSession>`에 저장하고, 입장 메시지를 동일 그룹 사용자들에게 전달한다 <br>
- **메시지 분기 처리** - 메시지 페이로드의 특정 접두사(`#$nickName_`)를 분석하여 입장 알림인지, 일반 채팅 메시지인지 판별하여 처리한다 <br>
- **비정상 종료 대응** - 브라우저 닫기나 네트워크 단절 시 `afterConnectionClosed`를 통해 세션을 즉시 제거하고 퇴장 알림을 보냄으로써 세션 누수를 방지한다 <br>
<br>

### 9-3. [Client] 동적 UI 및 웹소켓 이벤트 처리 <br>
- **이벤트 리스너** - onopen, onmessage, onclose 이벤트를 각각 정의하여 서버와의 연결 상태에 따른 UI 변화를 구현 <br>
- **조건부 렌더링** -서버로부터 받은 메시지가 '나'인 경우와 '타인'인 경우를 구분하여 말풍선 위치와 스타일을 다르게 렌더링 <br>


<p align="center">
  <img src="https://github.com/user-attachments/assets/ea39aba7-77a1-4641-9e74-d64c6aaad9ae" width=90% />
  <br>
  [실시간 그룹 오픈채팅 기능]
</p>

<br>




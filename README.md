# W.B.Shoppin 애니메이션 굿즈 쇼핑몰
# :computer: 개요
- 2024-04-01 ~ 2024-04-26
- Model1 구조의 쇼핑몰 사이트 구현
<br>

# 🛠️ 개발 환경
- Language : HTML5, CSS3, Java, SQL
- Library : BootStrap
- Open API : FullCalendar, jsTree, TOSS API, Naver News API, DAUM Postcode API
- Database : MariaDB
- WAS Apache : Tomcat10
- OS : Windows10
- TOOL : Eclipse, HeidiSQL
<br>

# :camera: 화면구성
<p align="center">
  <img src="https://github.com/user-attachments/assets/5cdb81cb-701f-4654-8fd0-b09f85222402" width="800" height="400">
  <img src="https://github.com/user-attachments/assets/df24b3e1-25fe-498f-98ec-a1b705dfc64e" width="800" height="400">
  <img src="https://github.com/user-attachments/assets/3396ad04-17b6-48a7-8c7b-56848856e4b7" width="800" height="400">
  <img src="https://github.com/user-attachments/assets/accc7915-66d5-43d7-b865-f725a8b03f40" width="800" height="400">
  <img src="https://github.com/user-attachments/assets/ed29dc30-330b-49c4-bc54-ff87ef78bfcf" width="800" height="400">
  <img src="https://github.com/user-attachments/assets/748876f3-b0c5-420b-916f-34ce215d3b60" width="800" height="400">
  <img src="https://github.com/user-attachments/assets/07e245dc-bb32-4f19-9d3f-04865fa221df" width="800" height="400">
  <img src="https://github.com/user-attachments/assets/134d0a1d-a8e6-4a17-8af2-fa2dd2f39023" width="800" height="400">
</p>
<br>

# :pushpin: 주요 기능
- 회원가입, 로그인
  - 회원가입 시 이메일 중복검사 진행
  - 로그인 정보 불일치 시 정보 확인 메시지 출력
- 권한 부여
  - Session에 저장된 grade에 따라 차등권한 부여
- 소통공간(게시판)
  - 모달을 통해 게시글 작성 기능 구현
  - 직급에 따라 공지사항, 자유게시판 카테고리 선택할 수 있는 select box 분기 처리 기능 구현
  - 공지사항, 자유게시판 글 수정 및 삭제 기능 구현
- 쇼핑몰 페이지
  - 상품 상세보기, 구매, 찜하기, 리뷰 작성 기능 구현
  - 상품 정보 수정, 삭제 기능 구현
  - 키워드 검색 기능 구현
- 마이페이지
  - 개인정보 수정, 회원탈퇴 기능 구현
  - 비밀번호 변경 기능 구현
  - 주문조회 기능 구현
- 관리자 페이지
  - 직원 리스트, 직원 활동 상태 관리 기능 구현
  - 상품 구매 요청 현황 조회 및 배송 상태 관리 기능 구현

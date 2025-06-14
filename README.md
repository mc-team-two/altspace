# 🕹 Alt Space | AI 기반 공간 예약 플랫폼

<p align="center">
  <img src="https://github.com/user-attachments/assets/c8a69501-7861-4aa0-9c67-9ad75c8a6f4a" width="80%">
</p>

## 🎞 시연 영상
[🎥 알트스페이스 사용하기](https://www.youtube.com/watch?v=ppMT82kZGns)

---

### ❤ 알트 스페이스 팀
|<a href="https://github.com/kungfugay">이예진(PM)|<a href="https://github.com/linea89kr">이황수(PL)|<a href="https://github.com/kimbugeon">김부건|<a href="https://github.com/imyukyung">임유경|<a href="https://github.com/jwpark-99">박정우|
|:---:|:---:|:---:|:---:|:---:|
|<img src="https://avatars.githubusercontent.com/u/121864128?v=4" width="100">|<img src="https://avatars.githubusercontent.com/u/34230941?v=4" width="100">|<img src="https://avatars.githubusercontent.com/u/55525567?v=4" width="100">|<img src="https://avatars.githubusercontent.com/u/202033529?s=130&v=4" width="100">|<img src="https://avatars.githubusercontent.com/u/192863504?v=4" width="100">|

<br>

---

### 🛠 기술 스택

| 분류                | 기술 스택                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **개발 언어**         | ![Java](https://img.shields.io/badge/Java-007396?style=flat&logo=oracle&logoColor=white) ![HTML](https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=html5&logoColor=white) ![CSS](https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=css3&logoColor=white) ![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=javascript&logoColor=black)                                                                                                        |
| **프레임워크 & 라이브러리** | ![Spring Boot](https://img.shields.io/badge/Spring%20Boot-6DB33F?style=flat&logo=springboot&logoColor=white) ![MyBatis](https://img.shields.io/badge/MyBatis-BB1A1A?style=flat&logo=MyBatis&logoColor=white) ![JSP](https://img.shields.io/badge/JSP-007396?style=flat&logo=java&logoColor=white) ![Bootstrap](https://img.shields.io/badge/Bootstrap-7952B3?style=flat&logo=bootstrap&logoColor=white)                                                                                 |
| **IDE**           | ![IntelliJ IDEA](https://img.shields.io/badge/IntelliJ-000000?style=flat&logo=intellijidea&logoColor=white)                                                                                                                                                                                                                                                                                                                                                                             |
| **협업 도구**         | ![Discord](https://img.shields.io/badge/Discord-5865F2?style=flat&logo=discord&logoColor=white) ![Zoom](https://img.shields.io/badge/Zoom-2D8CFF?style=flat&logo=zoom&logoColor=white) ![Google Drive](https://img.shields.io/badge/Google%20Drive-4285F4?style=flat&logo=googledrive&logoColor=white) ![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=Git&logoColor=white) ![Github](https://img.shields.io/badge/Github-181717?style=flat&logo=Github&logoColor=white) |
| **DB**            | ![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)                                                                                                                                                                                                                                                                                                                                                                                               |
| **API**           | ![Gemini AI](https://img.shields.io/badge/Gemini%20AI-FF6F61?style=flat)                                                                                                                                                                                                                                                                                                                                                                                                                |
| **서버 배포**         | ![NCP](https://img.shields.io/badge/Naver%20Cloud-03C75A?style=flat&logo=naver&logoColor=white)                                                                                                                                                                                                                                                                                                                                                                                         |

</div>

---

## 📌 프로젝트 개요

- **기간**: 2025.03.26. ~ 2025.05.26.
- **주제**: AI를 활용한 편리한 숙박 공간 예약 플랫폼

### 🎯 기획 의도
- 호스트/클라이언트 분리된 시스템으로 사용성과 데이터 기반 경험 극대화
- AI 기반 개인 맞춤 추천을 통한 반복 방문 유도

### 🧩 차별점
- **호스트 전용 페이지**: 예약/통계/마케팅 전략 지원
- **개인 맞춤 마이페이지**: AI 여행 취향 분석 및 추천
- **UX 중심 설계**: 사용자/호스트 양방향 데이터 활용 구조

---
## TimeLine
![451777725-51fd894a-4e06-40d1-9c61-d2cff3dfae58](https://github.com/user-attachments/assets/4bd19f9a-138c-4d95-bae1-b469a7afe322)


---

## 👨‍💻 업무 분장

## 1.4 프로젝트 업무 분장

|                    담당자                     | 업무                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|:------------------------------------------:|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://github.com/kungfugay">이예진 | [**게스트 & 호스트**] <br>- 회원가입/로그인/비밀번호 재설정 <br>- 웹소켓 1:1 채팅 기능 <br> [**호스트**] <br> - 공간 CRUD 페이지 구현 <br> - 리뷰 CRUD 페이지 구현 <br> - 결제 내역 조회 페이지 구현 <br> - 예약 캘린더 (고도화) 구현 <br>- 호스트 비즈니스 로직에 필요한 모든 Rest API                                                                                                                                                                                                                                                                     |
| <a href="https://github.com/kimbugeon">김부건 | [**공용**] <br> - NCP 서버 전개 및 배포 <br> - DB 구축 및 ERD 설계 <br> [**게스트**] <br> - 아임포트(iamport) API 활용 결제 · 취소 · 환불 기능 구현 & CRUD 설계 <br> - 카카오 맵 API 활용 숙박시설 위치 기능 구현 <br> - Gemini API 활용 사용자 리뷰 요약 기능 구현 <br> - NCP Papago API 활용 사용자 리뷰 다국어 번역 기능 구현 <br> - Client 페이지 Img Util 활용 이미지 업로드, 수정, 삭제 구현 & CRUD 설계 <br> - 서버 및 스트립트 유효성 검사 <br> - 찜 목록(위시리스트) 기능 구현 & CRUD 설계 <br> - 사용자 리뷰 기능 구현 & CRUD 설계 <br> - 숙박시설 상세보기 페이지 / 마이페이지(나의 예약 / 나의 리뷰 / 찜 목록) 페이지 / 리뷰 업로드 페이지 구현 |
| <a href="https://github.com/jwpark-99">박정우 | [**게스트**] <br> - 부트스트랩 기반 템플릿 커스터마이징 및 레이아웃 구조 재정비 <br> - 사용자 화면(UI) 구성: 헤더, 푸터, 사이드바, 메인 콘텐츠 영역 제작 <br> - 모바일 및 태블릿 환경 대응을 위한 반응형 UI 구현 (clamp, flex 등 활용) <br> - 사이트 내 필요한 이미지 및 콘텐츠 연결, 경로 설정 <br> - 전체 페이지 내 공통 디자인 규칙 및 시각 요소 정렬 <br> - 고객센터 및 FAQ 페이지 디자인 및 레이아웃 구성 (FAQ 스타일링, 상담 요청 영역 UI 정리) <br> - 숙소 목록(홈) 페이지 디자인 (숙소 리스트, 가격·위치·후기 요약 정보 표시) <br> - 사이트 정보 페이지 구성 (서비스 소개, 운영 방식, 연락처 등 콘텐츠 시각화)                                                                |
| <a href="https://github.com/linea89kr">이황수 | [**게스트**] <br> - 메인 페이지, 팀 소개 및 마이페이지 구현 <br> - 검색 기능 <br> - 키워드 검색 <br> - 지역 기반 검색 <br> - 다국어 지원 구현 <br> - 클로바 챗봇 <br> - Gemini 챗봇 <br> - 다크모드 <br> - 페이지네이션 <br> - OpenWeatherMap API 연동 <br> - 프론트, 백엔드 유효성 검사 구현 <br> - Google Geochart를 활용한 히트맵 구현 <br> - GeminI가 분석한 랭킹 top5 구현 <br> - 검색시 팝업되는 AI 여행 팁 구현 <br> - Gemini 유저 성향 분석 <br> - 로컬스토리지를 활용한 브라우저 캐싱 <br> - Mybatis Resultmap 을 활용한 쿼리 최적화 <br> - AI 추천 숙소 기능 구현 <br> - 웹소켓을 이용한 페이지 내 실시간 접속자 카운트 및 표시 기능      


---

## 🔎 주요 기능

### 🧳 게스트
- 숙소 검색 (키워드/위치)
- 예약 및 결제
- Gemini 리뷰 요약 및 챗봇
- 찜/마이페이지/다국어 번역
- 웹소켓 기반 1:1 채팅 & 실시간 접속자 표시

### 🏠 호스트
- 스페이스 등록/수정/삭제
- 리뷰/결제/예약 관리
- 통계 기반 대시보드 제공

### 🤖 AI 기능
- Gemini 챗봇 + 여행 팁/성향 분석/추천
- Papago 다국어 리뷰 번역
- Google Geochart 기반 시각화
---



## 🧩 시스템 설계

### 📊 흐름도 및 아키텍처

- 서비스 흐름도
<div align="center">
  <img width="60%" src="https://github.com/user-attachments/assets/9c2b7f28-db66-49d5-9fb0-e1dd4e6ed7b2"/>
</div>
<br><br>

- 화면 흐름도
  <div align="center">
  <img width="60%" src="https://github.com/user-attachments/assets/a40bf190-1302-4796-988d-642b1e3c59dd"/>
  <img width="90%" src="https://github.com/user-attachments/assets/ac02cc95-2208-4af3-9329-1ba09bcb4e8e"/>
</div>
<br><br>

- 시스템 아키텍처
![diagram](https://github.com/user-attachments/assets/bae440a7-839a-41a1-bc1e-6e1f01caa394)


- 구성도
![451958521-b05a4b2e-ea61-4802-a3f2-a09bf9b17581](https://github.com/user-attachments/assets/17809087-f6b6-4440-9e6a-5b6b5ac794b2)


- ERD (10개 테이블, User 중심 구조)

<p align="center">
  <img src="https://github.com/user-attachments/assets/22f70e1f-817f-4bdc-a3ff-9cff406ebe9e" width="80%">
</p>

```
총 10개의 테이블을 기반으로 하는 ERD를 작성하였다.
사용자 활동을 중심으로 한 데이터 추적 및 연관성 확보의 용이를 위해 사용자 중심(User-centric) 구조로 설계되었으며,
핵심 엔티티로 기능하는 테이블은 사용자(Users)와 공간(Accommodations) 테이블이다.
```
---

# 🛠 사용 기술


## AI
![451930885-9bbf9ad0-347a-4ba6-92f3-66f62ac15b6e](https://github.com/user-attachments/assets/29061b71-f997-4975-accc-b6fad02212b6)

![451776952-781ec60c-63a8-411c-956b-f4ba6dc9d4ef](https://github.com/user-attachments/assets/76f59fa7-80b3-462c-8583-bdcc7a14d946)

![451930953-a82c6445-0552-4c98-ab0e-30cb00f449dc](https://github.com/user-attachments/assets/ff42b1f5-2c43-4411-ad30-15b9a8560f66)


![451931229-7c6b10da-48d3-404d-a21c-843c20e8b5cd](https://github.com/user-attachments/assets/717e93d8-e5a6-4fdf-82c8-a6bdbce6de6c)
![451931298-cdff6198-7691-457a-880d-d85b88885845](https://github.com/user-attachments/assets/b1d5f0cd-2e66-46b6-86db-0cde9a4bb9b8)

![451931045-2f625959-d1eb-4d4b-923f-140c2a4b6d42](https://github.com/user-attachments/assets/67da67fc-d8d1-4164-bb01-84f25c4492dd)
![451931133-eea46858-0e01-4020-a800-84f763c5546d](https://github.com/user-attachments/assets/0794f74a-5190-4a8e-ac40-33f7b1e56474)


![451931369-16f1f3cf-bbea-478c-9341-d90a26e2f741](https://github.com/user-attachments/assets/71b47f98-99a1-4b2d-8d4f-a80333b3a176)
![451931437-e74d84c5-59bf-48b0-9483-f1f93ea0edbc](https://github.com/user-attachments/assets/a4315084-551f-4ef6-899b-2ef23d88207c)


## Security

# DB 암호화
![451777187-6ec202a9-017c-4f8d-862a-c944f06545d8](https://github.com/user-attachments/assets/cb62f72e-c2ad-47bb-bb8f-995ccc54110a)


# Config 파일 암호화
![451777102-453ae940-024e-4839-a2e0-69760e2256ce](https://github.com/user-attachments/assets/387ba95e-5f7e-4fce-80ec-dcd91e273dfe)


# interceptor를 이용한 전역적 인증
![interceptor](https://github.com/user-attachments/assets/fb517982-f860-4b81-b2f3-14b74e40aa18)


# 유효성 검사

![유효성검사1](https://github.com/user-attachments/assets/65dd452b-9b4e-4b79-bf3a-014499451738)
![유효성검사2](https://github.com/user-attachments/assets/cab06cc5-efa4-46b8-9c84-49a6ddd8cc20)


## Optimization

# local storage

![451777375-eba0cfc8-159c-4ee5-9c65-649b064b0da2](https://github.com/user-attachments/assets/d3d43336-59b7-479b-83f0-b3bbaf687e47)


# query

![451777488-c365c213-a723-45aa-9a7a-249e159488bb](https://github.com/user-attachments/assets/c8c4aaae-1d1f-4489-903f-2d0e664a019f)


## Websocket
![websocket](https://github.com/user-attachments/assets/c68f0e85-0ae7-4d84-becc-85e466216ad9)


## 번역
![451956300-384dbea5-5b65-4615-a99f-561a23c645a1](https://github.com/user-attachments/assets/e659e4bb-2f50-4c9e-afa4-4f9bb0bac4c1)
![451956370-1262680c-6d0b-45e2-9335-72a950674396](https://github.com/user-attachments/assets/5edf0ffa-4795-4436-a5c8-66c92a29e005)
![451940652-18357021-706b-442d-a19a-bd93929e9d8b](https://github.com/user-attachments/assets/434ad3d6-d5f9-4da5-987a-4b6dc981b79f)
![451940741-45d3d47f-f8fb-4411-acc2-1f3fda35a3cb](https://github.com/user-attachments/assets/aaeecbb0-ee5a-4036-89d0-586b55bc4345)



## 배포
![451931569-75c87b44-206b-4c17-a190-badc15e710ec](https://github.com/user-attachments/assets/ea84c6c0-e8bb-4804-9262-e1c14e7ce2dd)





---

## 📸 데모/스크린샷

### 🔎 공통 페이지

<p align="center">
  ▶ 로그인 
</p>


![로그인](https://github.com/user-attachments/assets/6c9f52ae-3d2f-4a13-bc0e-199b0bb39804)


<p align="center">
  ▶ 반응형
</p>

![반응형](https://github.com/user-attachments/assets/f385e68e-96ef-412e-97dd-79604530d758)



### 🧳 게스트 페이지
<br>

<p align="center">
  ▶ 실시간 채팅
</p>>

![실시간 챗](https://github.com/user-attachments/assets/cd79efaf-083f-4b85-9769-6669f4933a0b)


<p align="center">
  ▶ 결제
</p>

  ![아임포트](https://github.com/user-attachments/assets/f5ec976c-6660-41d7-bb1f-efe1f313a534)
    <img src="https://github.com/user-attachments/assets/8e5bca7f-ef73-4b7b-8c8e-36046e79ba7e"/>
    <img src="https://github.com/user-attachments/assets/19e7dfcd-6e6d-48bc-bb92-7df8466b2bf7"/>


<p align="center">
  ▶ 검색
</p>

![검색](https://github.com/user-attachments/assets/eb7e1650-1e33-4b8a-9801-cb32ca0df57f)
![위치기반검색](https://github.com/user-attachments/assets/74646dd9-2a0a-480c-a4cd-59158ca97ac8)


<p align="center">
▶ 검색 결과 Gemini 분석
</p>

![AI 정보](https://github.com/user-attachments/assets/b175202c-47a3-4dc0-afeb-9f9a3025c940)


<p align="center">
  ▶ AI 추천
</p>

![AI추천](https://github.com/user-attachments/assets/9a0248e6-941b-4821-a96b-446e5a7ea443)

<p align="center">
  ▶ 리뷰 번역
</p>

![파파고 번역](https://github.com/user-attachments/assets/0b8a12f2-2e5e-4f84-a2e1-4368e3be4112)



<p align="center">
  ▶ 메일 문의
</p>

![메일 문의](https://github.com/user-attachments/assets/c4c7b7bc-8c65-437b-8e19-c863a4cc1624)



### 🏠 호스트 페이지

---

## 🧹 트러블슈팅 사례

| 👤 name |                         🐞 Issues                         |                                                                                                                                                                                                                           🧠 Problem Solving                                                                                                                                                                                                                           |                     🔗 Linked Issue                      |
|:-------:|:---------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------:|
|   이예진   |               WebSocket 실시간 메시지에서 시간 처리 문제                |                                                                                                                                                  클라이언트와 서버의 타입 불일치로 인해 시간이 표시되지 않았고, Jackson 역직렬화 에러가 발생하여 ISO 8601로 바꾸어 해결했지만, 후속 이슈인 KST-UTC 시간대 불일치 문제는 DTO에서 시간 타입을 String으로 변경하고 formatTime()으로 변환하는 것으로 해결하였다.                                                                                                                                                   | [💬](https://github.com/mc-team-two/altspace/issues/148) |
|    〃    |                       유저 탈퇴가 안되는 문제                       |                                                                                                                                                                  유저의 PK를 FK로 사용하는 테이블의 제약 조건으로 인해서 참조하는 원본 데이터의 삭제를 거부하는 문제였다. DELETE문을 사용하는 대신 유저 테이블의 칼럼에 deleted_at을 추가하여 탈퇴한 회원을 구분할 수 있도록 구현하였다.                                                                                                                                                                  | [💬](https://github.com/mc-team-two/altspace/issues/255) |
|   이황수   |                        히트맵 시각화 구현                         |                                                                                                                               백엔드에서 전달받은 한글 주소 데이터를 자바스크립트 코드 내에서 파싱하고, Google Geochart가 인식할 수 있도록 해당 지역의 영문 이름으로 변환하는 매핑 로직을 추가했습니다. 특히, 한국 지역의 표준 영문 표기를 확인하기 위해 ISO 3166-2:KR 표준의 'local variant' 값을 직접 참고하여 정확한 매핑 데이터를 구축하고 적용했습니다.                                                                                                                               |  [💬](https://github.com/mc-team-two/altspace/pull/250)  |
|    〃    |                     캐러셀 구현중 EL 태그 충돌                      |                                                                                                                                           자바스크립트 코드를 별도의 `.js` 파일로 분리하여 역할 분담을 명확히 했습니다.<br/>캐러셀의 기본 뼈대(컨테이너, `carousel-inner`, 버튼 등)는 HTML 마크업으로 미리 정의해두고, 자바스크립트로는 API 호출을 통해 받아온 데이터만을 해당 HTML 요소에 채워 넣는 방식으로 로직을 변경했습니다.                                                                                                                                           |  [💬](https://github.com/mc-team-two/altspace/pull/250)  |
|    〃    |                  Gemini 분석을 이용한 고객 유형 분석                  |                                                                                                                                                                                              없는 유형을 자꾸 넣는 문제가 있어, 프롬프트를 강화하고, 유형들을 열거한 뒤, 꼭 이 유형 안에서만 설명하도록 프롬프트를 추가했습니다.                                                                                                                                                                                              |  [💬](https://github.com/mc-team-two/altspace/pull/253)  |
|   임유경   |                 JSP에서 사진 파일이 업로드되지 않는 문제                  |                                                                                                                              DTO 클래스의 필드가 String 타입으로 되어 있는데, JSP 폼에서는 <input type="file">을 통해 MultipartFile로 파일이 전달되어 매핑이 안 되어 생긴 오류로 DTO 클래스의 이미지 관련 필드를 MultipartFile로 바꾼 뒤 컨트롤러에서 MultipartFile을 받아 서버에 저장하고 해당 경로를 DB에 저장하는 형태로 해결함.                                                                                                                              | [💬](https://github.com/mc-team-two/altspace/issues/86)  |
|    〃    |        스페이스 수정 페이지에서 Kakao 지도 마커가 초기 위치로만 설정되는 문제         |                                                                                                                     수정 페이지에서 기존에 저장된 위도/경도 값을 마커 위치로 설정하려 했지만, JavaScript 내에서 JSP 변수 (${space.latitude} 등)가 올바르게 바인딩되지 않아 지도가 기본 중심 좌표만 표시되고 마커가 설정되지 않음. parseFloat(${space.latitude}) 등으로 정확히 숫자 변환하고, JavaScript에서 해당 값을 받아 마커 위치와 중심 좌표에 적용함.                                                                                                                      | [💬](https://github.com/mc-team-two/altspace/issues/51)  |
|    〃    |        예약 달력(FullCalendar)에 모든 스페이스 예약이 표시되지 않는 문제        |                                                                                                                                               기존에는 특정 스페이스 ID만 기준으로 예약 정보를 조회했기 때문에 전체 예약이 달력에 표시되지 않았었으나, 컨트롤러를 수정하여 모든 스페이스의 예약을 조회한 뒤 JSON으로 전달하고, FullCalendar의 이벤트 소스를 해당 데이터로 통합함으로써 모든 예약 정보가 하나의 달력에 표시되도록 개선함.                                                                                                                                                | [💬](https://github.com/mc-team-two/altspace/issues/108) |
|    〃    |        기간 필터(1개월/3개월 등) 버튼 클릭 시 결제 내역이 필터링되지 않는 문제        |                                                                                                         DataTables에서 사용자 정의 필터를 사용하기 위해 버튼 클릭 시 시작일/종료일을 hidden input에 설정하고, DataTables의 draw()를 호출해야 했는데, 초기 구현에서는 hidden input이 없거나 DataTables의 custom filtering 콜백이 누락되어 작동하지 않았었음. 버튼 클릭 시 날짜를 설정하고, DataTables의 $.fn.dataTable.ext.search.push를 사용하여 해결함.                                                                                                         | [💬](https://github.com/mc-team-two/altspace/issues/191) |
|   김부건   | 아임포트 결제 안정성 확보를 위한 imp_uid 누락, 금액 불일치, 취소 제한, 예외 처리 이슈 대응 |                                                                                                                                imp_uid 누락으로 결제 취소 실패가 반복되던 문제 해결을 위해 imp_uid를 DB에 저장하도록 쿼리 및 테이블 구조를 수정. 또한, 금액 불일치 시 자동 취소 로직을 추가하여 보안성 강화.  체크인 2일 전까지만 취소 가능하도록 날짜 조건을 추가하고, 각 처리 단계마다 예외 상황에 대한 응답 메시지를 명확히 정의하여 사용자 피드백 및 안정성 개선.                                                                                                                                 |  [💬](https://github.com/mc-team-two/altspace/pull/69)   |
|    〃    |           Gemini 활용 리뷰 요약 XSS 보안 이슈 발생 및 성능 저하            |                                                                                                                          기존 코드에서는 API 응답(getResult)을 innerHTML로 통째로 삽입하고 있었음.(XSS 보안 이슈 발생)  innerHTML 대신 document.createElement()와 textContent를 사용해 각 줄마다 <p> 요소로 분리하여 HTML 해석 없이 텍스트로 렌더링 또한, appendChild를 활용하여 부분적 DOM 갱신만 수행하여 성능 이슈도 개선.                                                                                                                          |  [💬](https://github.com/mc-team-two/altspace/pull/196)  |
|    〃    |     client 리뷰 수정/삭제 시 동일한 이미지 파일명이 중복 업로드·삭제되는 문제 발생      |                                                                                                                                                                                 리뷰 이미지 업로드/수정/삭제 시 동일한 파일명이 겹칠 경우 발생하는 충돌 문제를 방지하고, 사용자가 선택한 이미지에만 정확하게 작업되도록 UUID 기반의 고유한 파일명 체계를 도입.                                                                                                                                                                                 |  [💬](https://github.com/mc-team-two/altspace/pull/150)  |
|   박정우   |                고객센터, 홈의 UI 요소 간 간격 불일치 문제                 | 고객센터 페이지에서 상담 요청 칸과 우측 사이드바 사이의 간격이 일정하지 않고, 헤더 영역에서는 현재 날씨 정보, 로그아웃 버튼, 다크모드 버튼이 상하좌우로 어색하게 배열되어 사용자 경험을 저해하는 UI 불균형이 발생하였습니다. 또한, 푸터 영역에서도 콘텐츠 사이의 간격 및 정렬이 다소 어색하게 보이는 문제가 확인되었습니다. 그래서 HTML 내부의 <style> 태그를 활용하여 각 섹션의 마진과 정렬 기준을 명확히 설정하였습니다. 헤더 영역에는 display: flex와 gap 속성으로 아이템 간의 정렬을 통일하고, font-size: clamp()를 통해 반응형 폰트 크기를 적용하였습니다. FAQ 영역에서는 이미지 및 텍스트 요소에 margin-top/bottom을 적용하여 시각적 흐름을 개선하였습니다. 푸터 영역에는 컬럼 간 margin-top과 콘텐츠 간 margin-bottom을 설정하였습니다. |  [💬](https://github.com/mc-team-two/altspace/pull/215)  |
|    〃    |                부트스트랩 템플릿 커스터마이징 시 레이아웃 문제                 |                                                                                                          템플릿에서 불필요한 요소 제거 및 수정 후 레이아웃이 무너졌거나 의도치 않은 여백이 발생했습니다. 삭제한 요소가 기존 템플릿의 레이아웃 구조(container → row → col)에 포함되어 있었던 것을 확인하고, DOM 구조 분석을 통해 해당 요소의 제거가 전체 레이아웃에 미치는 영향을 파악하였습니다. 이를 기반으로 레이아웃이 무너지지 않도록 필요한 컨테이너 구조를 유지하거나 재구성하여 시각적으로 어색하지 않도록 조정하였습니다.                                                                                                           | [💬](https://github.com/mc-team-two/altspace/issues/126) |


---

## 🔗 프로젝트 관리

- [GitHub 프로젝트](https://github.com/orgs/mc-team-two/projects/9)
- [이슈 트래커](https://github.com/mc-team-two/altspace/issues)
- [Google Drive](https://drive.google.com/drive/folders/13tLna9244HiX4T5478tl90hapI7bvmfs)
- [Discord 채널](https://discord.gg/BvPUVb4k)


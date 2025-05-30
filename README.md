# Alt Space 🕹🏠
![readme_0530](https://github.com/user-attachments/assets/c8a69501-7861-4aa0-9c67-9ad75c8a6f4a)


# 1. 개요
## 1.1 프로젝트 기간
2025.03.26. ~ 2025.05.26.

## 1.2 프로젝트 참여 인원
|<a href="https://github.com/kungfugay">이예진|<a href="https://github.com/linea89kr">이황수|<a href="https://github.com/kimbugeon">김부건|<a href="https://github.com/imyukyung">임유경|<a href="https://github.com/jwpark-99">박정우|
|:---:|:---:|:---:|:---:|:---:|
|<img src="https://avatars.githubusercontent.com/u/121864128?v=4" width="100">|<img src="https://avatars.githubusercontent.com/u/34230941?v=4" width="100">|<img src="https://avatars.githubusercontent.com/u/55525567?v=4" width="100">|<img src="https://avatars.githubusercontent.com/u/202033529?s=130&v=4" width="100">|<img src="https://avatars.githubusercontent.com/u/192863504?v=4" width="100">|
|Dev (PM)|Dev (PL)|Dev|Dev|Dev|

## 1.3 프로젝트 주제
비정형적 공간을 대상으로 한 웹 기반 공간 대여 플랫폼

## 1.4 기획의도 및 차별점
본 프로젝트는 기존의 공간 대여 플랫폼과 유사한 기능을 기반으로 하되, **호스트와 클라이언트(사용자)를 명확히 분리한 이중 구조의 시스템**을 통해 **사용성과 데이터 기반 경험을 극대화**하는 것을 목표로 기획되었습니다.  

### **기획 의도**  
- 호스트와 클라이언트 간의 역할 구분을 명확히 하여, 양쪽 사용자 모두에게 최적화된 인터페이스와 기능을 제공함으로써 플랫폼 사용의 효율성과 만족도를 높이고자 했습니다.
- 단순 예약 시스템을 넘어서 개인의 여행 스타일과 성향을 파악할 수 있도록 하여, **반복 방문을 유도하고 개인화된 여행 경험을 제공**하는 것을 핵심 방향으로 설정했습니다.
  
### **차별점**  
**1. 호스트 전용 페이지 제공**  
   - 숙박시설 업로드, 관리, 수정 등의 기능을 통합적으로 제공하고,  
   - 조회수, 예약 수, 선호도 등의 통계 데이터를 시각화하여 제공함으로써, 호스트가 자신만의 마케팅 전략을 수립할 수 있도록 지원합니다.

**2. 사용자 맞춤형 '마이 페이지' 시스템**  
   - **내가 작성한 리뷰, 예약 내역, 찜 목록을 기반으로 AI가 여행 취향을 분석하고 시각적으로 보여줍니다.**  
   - 이를 통해 사용자 스스로도 자신의 여행 스타일을 인지할 수 있으며, 추천 숙소, 테마 여행 등에 자연스럽게 연결되도록 유도합니다.

**3. 사용자 경험 중심의 구조 설계**  
   - 단순 숙소 검색 / 예약이 아닌, 데이터 기반의 취향 분석과 호스트 운영 통계 제공이라는 양방향 가치 제공을 통해 기존 플랫폼과 차별화된 심화 경험을 제공합니다.  

## 1.5 프로젝트 관리 템플릿
- [깃허브 프로젝트](https://github.com/orgs/mc-team-two/projects/9)
- [깃허브 이슈](https://github.com/mc-team-two/altspace/issues)
- [Discord](https://discord.gg/BvPUVb4k)
- [Google Drive](https://drive.google.com/drive/folders/13tLna9244HiX4T5478tl90hapI7bvmfs)
  
<br><br>

# 2. 설계
## 2.1 시스템 구성도
![diagram](https://github.com/user-attachments/assets/bae440a7-839a-41a1-bc1e-6e1f01caa394)

## 2.2 화면 흐름도
<div align="center">
  <img width="60%" src="https://github.com/user-attachments/assets/a40bf190-1302-4796-988d-642b1e3c59dd"/>
  <img width="90%" src="https://github.com/user-attachments/assets/ac02cc95-2208-4af3-9329-1ba09bcb4e8e"/>
</div>
<br><br>

## 2.3 서비스 흐름도
<div align="center">
  <img width="60%" src="https://github.com/user-attachments/assets/9c2b7f28-db66-49d5-9fb0-e1dd4e6ed7b2"/>
</div>
<br><br>

## 2.3 DB 설계 (ERD)
<img width="100%" src="https://github.com/user-attachments/assets/22f70e1f-817f-4bdc-a3ff-9cff406ebe9e"/>
<br><br>

# 3. 구현

## 3.1 개발 환경 및 수행 도구

| 분류       | 기술 스택 |
| ---------- | ---------- |
| **개발 언어** | ![Java](https://img.shields.io/badge/Java-007396?style=flat&logo=oracle&logoColor=white) ![HTML](https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=html5&logoColor=white) ![CSS](https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=css3&logoColor=white) ![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=javascript&logoColor=black) |
| **프레임워크 & 라이브러리** | ![Spring Boot](https://img.shields.io/badge/Spring%20Boot-6DB33F?style=flat&logo=springboot&logoColor=white) ![MyBatis](https://img.shields.io/badge/MyBatis-BB1A1A?style=flat&logo=MyBatis&logoColor=white) ![JSP](https://img.shields.io/badge/JSP-007396?style=flat&logo=java&logoColor=white) ![Bootstrap](https://img.shields.io/badge/Bootstrap-7952B3?style=flat&logo=bootstrap&logoColor=white) |
| **IDE** | ![IntelliJ IDEA](https://img.shields.io/badge/IntelliJ-000000?style=flat&logo=intellijidea&logoColor=white) |
| **협업 도구** | ![Discord](https://img.shields.io/badge/Discord-5865F2?style=flat&logo=discord&logoColor=white) ![Zoom](https://img.shields.io/badge/Zoom-2D8CFF?style=flat&logo=zoom&logoColor=white) ![Google Drive](https://img.shields.io/badge/Google%20Drive-4285F4?style=flat&logo=googledrive&logoColor=white) |
| **DB** | ![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white) |
| **API** | ![Gemini AI](https://img.shields.io/badge/Gemini%20AI-FF6F61?style=flat) |
| **서버 배포** | ![NCP](https://img.shields.io/badge/Naver%20Cloud-03C75A?style=flat&logo=naver&logoColor=white) |


## 3.2 팀원별 역할 분장
~~ 주요 업무( 구현한 페이지 및 기능, api 등) ~~

<br><br>

## 3.3 프로젝트 핵심 기능
### 게스트(client) 페이지
~여기에 스크린샷~

### 호스트(admin) 페이지
~여기에 스크린샷~
<br><br>

## 3.4 프로젝트 일반 기능
### 게스트(clinet) 페이지
~여기에 스크린샷~
### 호스트(admin) 페이지
~여기에 스크린샷~
<br><br>

# 4. 트러블슈팅
| name | Issues | Problem Solving | Linked Issue |
|:---:|:---:|:---:|:---:|
| 이예진 | ... | ...|[💬](https://github.com/mc-team-two/altspace/issues/155)|
| 이황수 | ... | ...|...|
| 임유경 | ... | ...|...|
| 김부건 | ... | ...|...|
| 박정우 | ... | ...|...|

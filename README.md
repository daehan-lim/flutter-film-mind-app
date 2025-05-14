# FilmMind - 영화 정보 앱

## 📌 프로젝트 소개

이 프로젝트는 Flutter 기반의 영화 정보 애플리케이션입니다. 클린 아키텍처 패턴을 적용하여 TMDB API에서 다양한 카테고리의 영화 정보를 가져와 사용자에게 제공합니다. Hero 위젯을 활용한 애니메이션 효과와 함께 사용자가 쉽게 영화 정보를 탐색할 수 있는 경험을 제공합니다.

## 📱 시연 영상

[![시연 영상 보기](https://img.youtube.com/vi/OKqoMnWGQ5o/hqdefault.jpg)](https://www.youtube.com/shorts/OKqoMnWGQ5o)

## 🎯 주요 기능

- **영화 목록 표시**: 현재 상영중, 인기순, 평점 높은순, 개봉예정 영화를 각각 리스트로 표시합니다.
- **영화 상세 정보**: 영화 포스터, 제목, 개봉일, 런타임, 장르, 시놉시스 등 상세 정보를 제공합니다.
- **Hero 애니메이션**: 영화 목록에서 상세 페이지로 이동할 때 부드러운 전환 애니메이션을 제공합니다.
- **영화 검색**: 구글과 네이버에서 선택한 영화를 검색할 수 있는 기능을 제공합니다.
- **흥행 정보 분석**: 평점, 투표수, 인기점수, 예산, 수익 등 영화의 흥행 정보를 제공합니다.

## ✨ 추가 기능

### 1. 향상된 UI/UX
- **로딩 Shimmer 인디케이터**: Shimmer 효과를 활용하여 데이터 로딩 중에 사용자 경험을 개선했습니다.
- **이미지 캐싱**: cached_network_image를 이용한 네트워크 이미지 효율적 로딩 및 캐싱
- **다크 모드**: 기본 다크 모드를 적용하여 눈의 피로를 줄이고 영화 포스터를 더 돋보이게 했습니다.

### 2. 검색 연동 기능
- **외부 검색 엔진 연결**: 구글과 네이버에서 영화를 검색할 수 있는 기능을 제공합니다.
- **URL 런처**: `url_launcher` 패키지를 활용하여 외부 웹사이트 연결을 구현했습니다.

### 3. 클린 아키텍처
- **레이어 분리**: Data, Domain, Presentation 레이어를 명확히 분리하여 코드의 유지보수성을 높였습니다.
- **의존성 주입**: Riverpod를 활용한 의존성 주입으로 테스트 용이성을 높였습니다.
- **UseCase 패턴**: 각 기능별로 UseCase를 구현하여 비즈니스 로직을 캡슐화했습니다.

### 4. CI/CD
- **Github Actions**: 자동화된 빌드, 분석 및 테스트를 위한 CI/CD 파이프라인을 구축했습니다.
- **환경 변수 관리**: Github Secrets을 활용하여 TMDB API 토큰을 안전하게 관리합니다.
- **자동 APK 빌드**: PR과 master 브랜치 푸시 시 자동으로 릴리스 APK를 빌드하고 아티팩트로 저장합니다.

### 5. 테스트 자동화
- **단위 테스트**: 각 레이어별(DTO, DataSource, Repository, UseCase, ViewModel) 테스트 코드 구현
- **Mocking**: Mocktail 라이브러리를 활용하여 의존성을 효과적으로 모킹하고 격리된 테스트 환경 구성
- **CI 통합**: Github Actions를 통해 모든 PR과 푸시에서 테스트가 자동으로 실행됩니다.

## 📋 프로젝트 구조

```
lib/  
├── app/                               # 앱 전체에서 설정 및 공통 상수, 테마 등  
│   ├── constants/                     # 앱 상수 정의  
│   │   ├── app_colors.dart            # 색상 정의  
│   │   ├── app_constants.dart         # 상수 값 정의  
│   │   └── app_styles.dart            # 스타일 정의  
│   └── theme.dart                     # 앱 테마 설정  

├── core/                              # 앱 전체에서 사용되는 핵심 기능 및 유틸리티  
│   ├── exceptions/                    # 앱 전체에서 사용되는 예외 클래스  
│   │   └── data_exceptions.dart       # 데이터 관련 예외 클래스  
│   ├── extensions/                    # 확장 메서드 정의  
│   │   ├── date_extensions.dart       # 날짜 관련 확장 메서드  
│   │   └── number_extensions.dart     # 숫자 관련 확장 메서드  
│   ├── providers/                     # 공통 프로바이더  
│   │   └── repository_providers.dart  # 리포지토리 프로바이더  
│   └── utils/                         # 유틸리티 함수  
│       ├── navigation_util.dart       # 네비게이션 관련 유틸리티  
│       ├── snackbar_util.dart         # 스낵바 관련 유틸리티  
│       └── dialogue_util.dart         # 다이얼로그 관련 유틸리티  

├── data/                              # 데이터 관련 클래스 및 데이터 액세스 계층  
│   ├── data_source/                   # 데이터 소스 클래스 
│   ├── dto/                           # 데이터 전송 객체 
│   └── repository/                    # 리포지토리 구현체 

├── domain/                            # 비즈니스 로직 및 엔티티 정의  
│   ├── entity/                        # 도메인 엔티티 
│   ├── repository/                    # 리포지토리 인터페이스
│   └── usecase/                       # 유스케이스 

├── presentation/                      # UI 관련 코드  
│   ├── pages/                         # 앱 화면  
│   │   ├── home/                      # 홈 화면  
│   │   │   ├── home_page.dart         # 홈 페이지 위젯  
│   │   │   ├── home_view_model.dart   # 홈 화면 뷰모델  
│   │   │   └── widgets/               # 홈 화면 관련 위젯 
│   │   └── detail/                    # 상세 화면 
│   └── widgets/                       # 공통 위젯 

└── main.dart                          # 앱 진입점  
```

## 📦 의존성 패키지

프로젝트에서 사용된 주요 패키지:

- **flutter_riverpod**: 상태 관리 및 의존성 주입
- **dio**: HTTP 클라이언트
- **flutter_dotenv**: 환경 변수 관리
- **url_launcher**: 외부 URL 실행 지원
- **shimmer**: 로딩 상태 시각화
- **flutter_svg**: SVG 이미지 렌더링
- **intl**: 날짜 및 숫자 포맷팅
- **cached_network_image**: 네트워크 이미지 캐싱
- **mocktail**: 테스트를 위한 모킹 라이브러리

## 🔑 환경 설정

프로젝트 루트에 `.env` 파일을 생성하고 다음과 같이 TMDB API 접근을 위한 Bearer 토큰을 설정합니다:

```
# TMDB API 접근을 위한 Bearer 토큰
TMDB_BEARER_TOKEN=YOUR-TOKEN-HERE
```

CI/CD 파이프라인에서는 Github Secrets에 등록된 `TMDB_BEARER_TOKEN` 값을 자동으로 사용합니다.

## 📄 라이센스

이 프로젝트는 MIT 라이센스 하에 제공됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.
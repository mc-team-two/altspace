document.addEventListener('DOMContentLoaded', () => {
    const themeToggleCheckboxes = document.querySelectorAll('.theme-toggle');
    const htmlElement = document.documentElement;

    // 모든 토글 버튼에 대한 정보 저장
    const toggleDetails = Array.from(themeToggleCheckboxes).map(checkbox => ({
        checkbox: checkbox,
        moonIcon: checkbox.nextElementSibling?.querySelector('.moon-icon'),
        sunIcon: checkbox.nextElementSibling?.querySelector('.sun-icon'),
    }));

    // 저장된 테마 불러오기
    const savedTheme = localStorage.getItem('theme');

    // 브라우저 선호 테마 감지
    const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    const defaultTheme = prefersDark ? 'dark' : 'light';

    // 초기 테마 설정 및 모든 토글 버튼 상태 업데이트
    const initialTheme = savedTheme || defaultTheme;
    htmlElement.setAttribute('data-theme', initialTheme);
    htmlElement.style.setProperty('--theme', initialTheme); // CSS 변수 설정

    toggleDetails.forEach(({ checkbox, moonIcon, sunIcon }) => {
        checkbox.checked = initialTheme === 'dark';
        updateIconVisibility(moonIcon, sunIcon, initialTheme === 'dark');
        updateAriaChecked(checkbox, initialTheme === 'dark'); // ARIA 속성 설정
    });

    // 로컬 스토리지에 초기 테마 저장 (처음 방문 시)
    if (!savedTheme) {
        localStorage.setItem('theme', initialTheme);
    }

    // 아이콘 업데이트 함수
    function updateIconVisibility(moonIcon, sunIcon, isDark) {
        if (moonIcon && sunIcon) {
            moonIcon.style.opacity = isDark ? 0 : 1;
            sunIcon.style.opacity = isDark ? 1 : 0;
        }
    }

    // ARIA 속성 업데이트 함수
    function updateAriaChecked(element, isChecked) {
        element.setAttribute('aria-checked', isChecked.toString());
    }

    // 테마 전환 기능 (각 체크박스의 change 이벤트 활용)
    themeToggleCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const newTheme = this.checked ? 'dark' : 'light';
            htmlElement.setAttribute('data-theme', newTheme);
            htmlElement.style.setProperty('--theme', newTheme); // CSS 변수 업데이트
            localStorage.setItem('theme', newTheme);

            // 다른 모든 토글 버튼의 상태와 아이콘, ARIA 속성 동기화
            toggleDetails.forEach(({ checkbox: otherCheckbox, moonIcon, sunIcon }) => {
                if (otherCheckbox !== this) {
                    otherCheckbox.checked = this.checked;
                    updateAriaChecked(otherCheckbox, this.checked);
                }
                updateIconVisibility(moonIcon, sunIcon, this.checked);
            });
        });
    });
});
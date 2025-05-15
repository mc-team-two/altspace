document.addEventListener('DOMContentLoaded', () => {
    const themeToggleCheckboxes = document.querySelectorAll('.theme-toggle input[type="checkbox"]');
    const htmlElement = document.documentElement;

    // 저장된 테마 불러오기
    const savedTheme = localStorage.getItem('theme');

    // 브라우저 선호 테마 감지
    const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    const defaultTheme = prefersDark ? 'dark' : 'light';

    // 초기 테마 설정 및 모든 토글 버튼 상태 업데이트
    const initialTheme = savedTheme || defaultTheme;
    htmlElement.setAttribute('data-theme', initialTheme);

    // 모든 토글 버튼 초기화
    themeToggleCheckboxes.forEach(checkbox => {
        checkbox.checked = initialTheme === 'dark';
        checkbox.setAttribute('aria-checked', (initialTheme === 'dark').toString());
    });

    // 로컬 스토리지에 초기 테마 저장 (처음 방문 시)
    if (!savedTheme) {
        localStorage.setItem('theme', initialTheme);
    }

    // 테마 전환 기능 (각 체크박스의 change 이벤트 활용)
    themeToggleCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const newTheme = this.checked ? 'dark' : 'light';
            htmlElement.setAttribute('data-theme', newTheme);
            localStorage.setItem('theme', newTheme);

            // 다른 모든 토글 버튼의 상태와 ARIA 속성 동기화
            themeToggleCheckboxes.forEach(otherCheckbox => {
                if (otherCheckbox !== this) {
                    otherCheckbox.checked = this.checked;
                    otherCheckbox.setAttribute('aria-checked', this.checked.toString());
                }
            });
        });
    });
    // if (initialTheme === 'dark') {
    //     const mainNav = document.querySelector('.main_nav');
    //     if (mainNav) {
    //         mainNav.style.setProperty('background-color', 'rgba(54, 19, 84, 0.6)', 'important');
    //     }
    // }
});
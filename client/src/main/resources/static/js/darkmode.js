document.addEventListener('DOMContentLoaded', function() {
    // 두 토글 버튼 모두 찾기
    const toggleGuest = document.getElementById('theme-toggle-guest');
    const toggleUser = document.getElementById('theme-toggle-user');
    const toggleButtons = [toggleGuest, toggleUser].filter(el => el !== null);

    // 현재 테마 가져오기
    const currentTheme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', currentTheme);

    // 모든 토글 버튼 상태 설정
    toggleButtons.forEach(toggle => {
        toggle.checked = currentTheme === 'dark';

        toggle.addEventListener('change', function() {
            const theme = this.checked ? 'dark' : 'light';
            document.documentElement.setAttribute('data-theme', theme);
            localStorage.setItem('theme', theme);

            // 모든 버튼 동기화
            toggleButtons.forEach(btn => {
                btn.checked = this.checked;
            });
        });
    });
});
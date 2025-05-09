$(document).ready(function() {
    function initPoppers() {
        const popperTriggers = document.querySelectorAll('[data-popper-content]'); // data-popper-content 속성을 가진 모든 요소 선택

        popperTriggers.forEach(trigger => {
            const popperContent = trigger.dataset.popperContent;
            const popperElement = document.createElement('div');
            popperElement.classList.add('popper-tooltip'); // 공통 스타일 클래스
            popperElement.textContent = popperContent;
            document.body.appendChild(popperElement);

            const popperInstance = new Popper(trigger, popperElement, {
                placement: 'top', // 기본 위치
                modifiers: [
                    {
                        name: 'offset',
                        options: {
                            offset: [0, 8],
                        },
                    },
                    {
                        name: 'arrow',
                        options: {
                            element: '.popper-arrow', // 공통 화살표 클래스 (선택 사항)
                        },
                    },
                ],
            });

            const showEvents = ['mouseenter', 'focus'];
            const hideEvents = ['mouseleave', 'blur'];

            showEvents.forEach(event => {
                trigger.addEventListener(event, () => {
                    popperElement.classList.add('active');
                    popperInstance.update();
                });
            });

            hideEvents.forEach(event => {
                trigger.addEventListener(event, () => {
                    popperElement.classList.remove('active');
                });
            });
        });
    }

    initPoppers(); // 페이지 로드 시 모든 popper 기능 초기화
});
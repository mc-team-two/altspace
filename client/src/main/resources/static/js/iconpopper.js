// popper 1.12.5 버전에 맞춰 작성

document.addEventListener('DOMContentLoaded', () => {
    const tooltipTriggers = document.querySelectorAll('.offers_icons_item');

    tooltipTriggers.forEach(trigger => {
        const tooltip = document.createElement('div');
        tooltip.classList.add('popper-tooltip');
        tooltip.textContent = trigger.dataset.popperContent;

        // 1.x 버전의 Popper 사용
        const popperInstance = new Popper(trigger, tooltip, {
            placement: 'top',
            modifiers: {
                offset: {
                    offset: '0, 8',
                },
                arrow: {
                    element: '.popper-arrow',
                },
            },
        });

        trigger.addEventListener('mouseenter', () => {
            tooltip.classList.add('active');
        });

        trigger.addEventListener('mouseleave', () => {
            tooltip.classList.remove('active');
        });

        document.body.appendChild(tooltip);

        trigger.addEventListener('beforeunload', () => {
            popperInstance.destroy();
        });
    });
});
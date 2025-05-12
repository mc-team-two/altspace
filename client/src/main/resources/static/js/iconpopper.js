$(document).ready(function() {
    function initPoppers() {
        const popperTriggers = document.querySelectorAll('[data-popper-content]');

        popperTriggers.forEach(trigger => {
            const popperContent = trigger.dataset.popperContent;
            const popperElement = document.createElement('div');
            popperElement.classList.add('popper-tooltip');
            popperElement.textContent = popperContent;
            document.body.appendChild(popperElement);

            const popperInstance = new Popper(trigger, popperElement, {
                placement: 'top',
                modifiers: [
                    {
                        name: 'keepTogether',
                    },
                    {
                        name: 'offset',
                        options: {
                            offset: [0, 8],
                        },
                    },
                    {
                        name: 'arrow',
                        options: {
                            element: '.popper-arrow',
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

    initPoppers();
});
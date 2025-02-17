document.addEventListener("DOMContentLoaded", function () {
    const menuToggle = document.querySelector(".menu-toggle");
    const sidebar = document.querySelector("#sidebar");
    const mainContent = document.querySelector(".main-content");

    function toggleMenu() {
        sidebar.classList.toggle("open");
        mainContent.classList.toggle("shift");
    }

    menuToggle.addEventListener("click", toggleMenu);
});

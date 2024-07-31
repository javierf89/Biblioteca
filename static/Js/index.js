document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.click').forEach(div => {
        div.addEventListener('click', function() {
            const url = this.getAttribute('data-url');
            window.location.href = url;
        });
    });
});

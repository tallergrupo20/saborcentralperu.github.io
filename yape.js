document.getElementById('confirm-button').addEventListener('click', function () {
    // Mostrar el modal
    document.getElementById('confirmation-modal').style.display = 'flex';
});

document.getElementById('choose-location-button').addEventListener('click', function () {
    // Redirigir a la página de elección de sede
    window.location.href = 'recogerentienda.html';
});

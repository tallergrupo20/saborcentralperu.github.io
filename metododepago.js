document.getElementById('payment-form').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevenir que el formulario se envíe de forma tradicional

    // Ocultar el formulario de pago y mostrar el mensaje de confirmación
    document.getElementById('payment-form').style.display = 'none';
    document.getElementById('confirmation-message').style.display = 'block';
});

// Botón para redirigir a la página de selección de sede
document.getElementById('go-to-sede-button').addEventListener('click', function() {
    window.location.href = 'recogerentienda.html'; // Redirigir a la página de pago finalizado
});

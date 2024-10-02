document.getElementById('confirm-button').addEventListener('click', function () {
    // Obtener el método de pago seleccionado
    const selectedPayment = document.querySelector('input[name="payment"]:checked');
    
    if (selectedPayment) {
        if (selectedPayment.value === 'cash') {
            // Redirigir a la página de pago finalizado si se selecciona "Efectivo"
            window.location.href = 'pagofinalizadoefectivo.html';
        } else if (selectedPayment.value === 'credit-card') {
            // Redirigir a la página de método de pago si se selecciona "Tarjeta de Crédito"
            window.location.href = 'metododepago.html';
        } else if (selectedPayment.value === 'paypal') {
            // Redirigir a la página de Yape si se selecciona "PayPal"
            window.location.href = 'yape.html';
        } else {
            // Mensaje para otros métodos de pago
            alert('Método de pago no soportado aún.');
        }
    } else {
        // Mostrar alerta si no se ha seleccionado un método de pago
        alert('Por favor, seleccione un método de pago.');
    }
});
document.getElementById('confirm-button').addEventListener('click', function() {
    const selectedPayment = document.querySelector('input[name="payment"]:checked');
    if (selectedPayment) {
        const paymentId = selectedPayment.value;
        
        // Enviar el paymentId al servidor
        fetch('procesar_pago.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `paymentId=${paymentId}`
        })
        .then(response => response.text())
        .then(data => {
            alert('Pedido confirmado');
            // Manejar la respuesta del servidor
        })
        .catch(error => {
            console.error('Error:', error);
        });
    } else {
        alert('Por favor, seleccione un método de pago.');
    }
});

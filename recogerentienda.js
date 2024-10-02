document.addEventListener('DOMContentLoaded', () => {
    const storeOptions = document.querySelectorAll('input[name="store"]');
    const confirmButton = document.getElementById('confirm-store-button');
    const confirmButtonContainer = document.getElementById('confirm-store-button-container');
    const pickupModal = document.getElementById('pickup-modal');
    const pedidoConfirmadoButton = document.getElementById('pedido-confirmado-button');
    const closeModal = pickupModal.querySelector('.close');

    // Mostrar el botón de confirmar cuando se selecciona una tienda
    storeOptions.forEach(option => {
        option.addEventListener('change', () => {
            confirmButtonContainer.style.display = 'block';
        });
    });

    // Confirmar la sede seleccionada
    confirmButton.addEventListener('click', () => {
        const selectedStore = document.querySelector('input[name="store"]:checked');
        if (selectedStore) {
            const storeId = selectedStore.value;

            // Aquí podrías enviar storeId al servidor
            // Por ejemplo, usando fetch o XMLHttpRequest
            
            // Mostrar modal de confirmación
            pickupModal.style.display = 'block';
        } else {
            alert('Por favor, selecciona una tienda.');
        }
    });

    // Cerrar el modal
    closeModal.addEventListener('click', () => {
        pickupModal.style.display = 'none';
    });

    // Confirmar pedido
    pedidoConfirmadoButton.addEventListener('click', () => {
        pickupModal.style.display = 'none';
        alert('¡Pedido confirmado!');
        // Aquí puedes redirigir a otra página o realizar otra acción
    });
});

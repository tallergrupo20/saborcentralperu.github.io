// Seleccionar los elementos del DOM
const storeRadios = document.querySelectorAll('input[name="store"]');
const confirmStoreButtonContainer = document.getElementById('confirm-store-button-container');
const confirmStoreButton = document.getElementById('confirm-store-button');
const modal = document.getElementById('pickup-modal');
const closeModal = document.querySelector('.close');
const pedidoConfirmadoButton = document.getElementById('pedido-confirmado-button');

// Mostrar el botón de confirmar sede cuando se elige una tienda
storeRadios.forEach(radio => {
    radio.addEventListener('change', () => {
        confirmStoreButtonContainer.style.display = 'block';
    });
});

// Al hacer clic en el botón de Confirmar Sede
confirmStoreButton.addEventListener('click', () => {
    modal.style.display = 'block'; // Mostrar el modal
});

// Al hacer clic en la "X" del modal
closeModal.addEventListener('click', () => {
    modal.style.display = 'none'; // Cerrar el modal
});

// Cerrar el modal si se hace clic fuera del contenido del modal
window.addEventListener('click', (event) => {
    if (event.target === modal) {
        modal.style.display = 'none';
    }
});

// Al hacer clic en el botón de Pedido Confirmado
pedidoConfirmadoButton.addEventListener('click', () => {
    window.location.href = 'pedidos.html'; // Redirigir a la página de pedidos
});

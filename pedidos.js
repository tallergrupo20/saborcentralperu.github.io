const btnCart = document.querySelector('.container-icon')
const containerCartProducts = document.querySelector('.container-cart-products')

btnCart.addEventListener('click', () => {
    containerCartProducts.classList.toggle('hidden-cart')
})


const btnInicio = document.querySelector('#btn-inicio');
const confirmacion = document.querySelector('#confirmacion');
const btnSi = document.querySelector('#btn-si');
const btnNo = document.querySelector('#btn-no');

btnInicio.addEventListener('click', (event) => {
    event.preventDefault(); // Previene el comportamiento por defecto del enlace
    confirmacion.classList.remove('hidden'); // Muestra la ventana emergente
});

btnSi.addEventListener('click', () => {
    window.location.href = 'index.html'; // Redirige a index.html
});

btnNo.addEventListener('click', () => {
    confirmacion.classList.add('hidden'); // Oculta la ventana emergente
});


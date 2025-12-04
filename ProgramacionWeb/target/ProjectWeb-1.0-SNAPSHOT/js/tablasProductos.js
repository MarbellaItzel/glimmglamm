
function toggleMenu() {
    const menu = document.getElementById('menuHamburguesa');
    menu.classList.toggle('activo');
}

document.querySelectorAll('#menuHamburguesa a').forEach(link => {
    link.addEventListener('click', () => {
        document.getElementById('menuHamburguesa').classList.remove('activo');
    });
});

$(document).ready(function () {
    if (typeof mensaje !== "undefined" && mensaje.trim() !== "") {
        Swal.fire({
            icon: 'success',
            title: '¡Acción completada!',
            html: `
                <div class="mensaje-exito">
                    <strong>${mensaje}</strong><br>
                    Gracias por mantener tu catálogo actualizado 💄✨
                </div>
            `,
            background: '#fff0f7',
            confirmButtonColor: '#e08ebf',
            confirmButtonText: '¡Perfecto!',
            customClass: {
                popup: 'sweet-popup',
                confirmButton: 'sweet-button'
            }
        });
    }
    
    $("form").on("submit", function (e) {
    let valid = true;
    const $form = $(this);
    const accion = $form.find("input[name='accion']").val();

    $form.find(".mensaje-error-campo").remove();

        if (accion === "alta") {
            $form.find("input[required], select, textarea").each(function () {
                if (!$(this).val().trim()) {
                    mostrarError($(this), "Este campo es obligatorio.");
                    valid = false;
                }
            });

            if (!validarCamposNumericos($form)) valid = false;
            validarLongitudes($form);
        }
        else if (accion === "modificar") {
        const id = $form.find("input[name='id']").val().trim();
        const precio = $form.find("input[name='precio']").val().trim();
        const stock = $form.find("input[name='stock']").val().trim();

        if (!id) {
            mostrarError($form.find("input[name='id']"), "El ID es obligatorio.");
            valid = false;
        } else if (!/^[1-9]\d*$/.test(id)) {
            mostrarError($form.find("input[name='id']"), "El ID debe ser un número entero positivo.");
            valid = false;
        }

        if (precio === "" && stock === "") {
            mostrarError($form.find("input[name='stock']"), "Ingresa al menos el precio o el stock para modificar.");
            valid = false;
        }

        if (precio && (isNaN(precio) || Number(precio) <= 0)) {
            mostrarError($form.find("input[name='precio']"), "El precio debe ser un número mayor que 0.");
            valid = false;
        }

        if (stock && !/^[1-9]\d*$/.test(stock)) {
            mostrarError($form.find("input[name='stock']"), "El stock debe ser un número entero positivo.");
            valid = false;
        }

    } else if (accion === "eliminar") {
        const id = $form.find("input[name='id']").val().trim();
        if (!id) {
            mostrarError($form.find("input[name='id']"), "El ID es obligatorio para eliminar un producto.");
            valid = false;
        } else if (!/^[1-9]\d*$/.test(id)) {
            mostrarError($form.find("input[name='id']"), "El ID debe ser un número entero positivo.");
            valid = false;
        }
    }

    if (!valid) e.preventDefault();
    });

    function mostrarError($campo, mensaje) {
        const $msg = $("<div>")
            .addClass("mensaje-error-campo")
            .text(mensaje)
            .hide();
        $campo.after($msg);
        $msg.fadeIn();
    }

    function validarCamposNumericos($form) {
    let valid = true; // <-- nuevo
    $form.find("input[type='text']").each(function () {
        const nombreCampo = $(this).attr("name");
        const valor = $(this).val().trim();

        if (["precio", "stock", "id"].includes(nombreCampo) && valor !== "") {
            if (nombreCampo === "precio" && (isNaN(valor) || Number(valor) <= 0)) {
                mostrarError($(this), "El precio debe ser un número mayor que 0.");
                valid = false;
            }
            if (nombreCampo === "stock" && !/^[1-9]\d*$/.test(valor)) {
                mostrarError($(this), "El stock debe ser un número entero positivo.");
                valid = false;
            }
            if (nombreCampo === "id" && !/^[1-9]\d*$/.test(valor)) {
                mostrarError($(this), "El ID debe ser un número entero positivo.");
                valid = false;
            }
        }
    });
    return valid;
    }


    function validarLongitudes($form) {
        const nombre = $form.find("input[name='nombre']");
        if (nombre.length && nombre.val().trim().length < 3) {
            mostrarError(nombre, " El nombre debe tener al menos 3 caracteres.");
        }

        const marca = $form.find("input[name='marca']");
        if (marca.length && marca.val().trim().length < 2) {
            mostrarError(marca, " La marca debe tener al menos 2 caracteres.");
        }
    }

    $(".form-seccion").hide(); 
    $("#alta").fadeIn(600); 
    $(".opciones-barra a").click(function (e) {
        e.preventDefault();
        const target = $(this).attr("href");
        $(".form-seccion").hide();
        $(target).fadeIn(600);
    });

    // Efecto hover 
    $(".form-seccion button, .form-seccion input[type='submit']").hover(
        function () {
            $(this).css({ backgroundColor: "#a56c57", color: "#fff", transition: "0.3s" });
        },
        function () {
            $(this).css({ backgroundColor: "", color: "" });
        }
    );

    $("input, select, textarea").on("focus", function () {
        $(this).css("box-shadow", "0 0 8px #a56c57");
    }).on("blur", function () {
        $(this).css("box-shadow", "none");
    });
    
    
});

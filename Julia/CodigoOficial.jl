function ingreso_al_sistema()
    println("=== Ingreso al sistema ===")
    println("Ingrese su nombre de usuario:")
    username = readline()
    println("Ingrese su contraseña:")
    password = readline()

    # Verificar las credenciales ingresadas
    if verificar_credenciales(username, password)
        println("¡Inicio de sesión exitoso!")
        menu_principal(username)
    else
        println("Credenciales incorrectas. Vuelva a intentarlo.")
    end
end

function verificar_credenciales(username, password)
    # Leer los usuarios registrados desde el archivo "usuarios.txt"
    usuarios = leer_usuarios_registrados()

    # Verificar si el usuario y contraseña coinciden con algún usuario registrado
    for usuario in usuarios
        if usuario[1] == username && usuario[2] == password
            return true
        end
    end

    return false
end

function leer_usuarios_registrados()
    usuarios = []
    archivo = open("usuarios.txt", "r")
    for linea in eachline(archivo)
        push!(usuarios, split(linea, ","))  # Suponiendo que cada línea contiene "usuario,contraseña"
    end
    close(archivo)
    return usuarios
end

function menu_principal(username)
    while true
        println("=====================")
        println("Menú principal")
        println("1. Registrar un texto")
        println("2. Buscar palabra / oración en un texto")
        println("3. Ver historial de búsquedas")
        println("4. Salir")
        println("=====================")
        opcion = readline()

        if opcion == "1"
            registrar_texto()
        elseif opcion == "2"
            buscar_palabra()
        elseif opcion == "3"
            ver_historial_busquedas(username)
        elseif opcion == "4"
            println("¡Hasta luego!")
            break
        else
            println("Opción inválida. Intente nuevamente.")
        end
    end
end

#busca si el archivo txt existe

function registrar_texto()
    println("=== registrar texto ===")
    println("Ingrese el nombre del texto:")    #nombre al azar para guardar el texto
    nombreTexto = readline()
    println("Ingrese la ruta del archivo de texto:")     #la ruta donde esta libro.txt: C:\Users\ERICK\Desktop\Prueba\libro.txt
    rutaArchivo = readline()

    if isfile(rutaArchivo)
        contenidoTexto = leer_contenido_archivo(rutaArchivo)
        if contenidoTexto != ""
            println("Texto registrado exitosamente.")
            guardar_texto(nombreTexto, contenidoTexto)
        else
            println("No se pudo leer el contenido del archivo.")
        end
    else
        println("El archivo no existe. No se pudo registrar el texto.")
    end
end

#lee todo el contenido de libro.txt

function leer_contenido_archivo(ruta_archivo)
    if isfile(ruta_archivo)
        try
            archivo = open(ruta_archivo, "r")
            contenido = read(archivo, String)
            close(archivo)
            return contenido
        catch error
            println("Error al leer el archivo de texto:", error)
            return ""
        end
    else
        return ""
    end
end

#guarda el texto en otra carpeta como registrado

function guardar_texto(ruta_destino, contenido)
    try
        archivo = open(ruta_destino, "w")
        write(archivo, contenido)
        close(archivo)
    catch error
        println("Error al guardar el texto:", error)
    end
end
ingreso_al_sistema()
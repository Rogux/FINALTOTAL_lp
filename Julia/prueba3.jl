function FuncionX()
    println("=== FuncionX ===")
    println("Ingrese el nombre del texto:")
    nombreTexto = readline()
    println("Ingrese la ruta del archivo de texto:")
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

function guardar_texto(ruta_destino, contenido)
    try
        archivo = open(ruta_destino, "w")
        write(archivo, contenido)
        close(archivo)
    catch error
        println("Error al guardar el texto:", error)
    end
end

# Llamada a la función FuncionX para registrar un texto


function buscar_palabra()
    println("=== Buscar palabra / oración en un texto ===")
    println("Textos registrados:")
    mostrar_textos_registrados()

    println("Seleccione el nombre del texto:")
    nombreTexto = readline()

    if texto_registrado(nombreTexto)
        println("Seleccione el algoritmo de búsqueda:")
        println("1. Fuerza Bruta")
        println("2. Knuth-Morris-Pratt")
        println("3. Boyer-Moore")
        algoritmoSeleccionado = readline()

        if algoritmoSeleccionado == "1"
            algoritmo = "Fuerza Bruta"
        elseif algoritmoSeleccionado == "2"
            algoritmo = "Knuth-Morris-Pratt"
        elseif algoritmoSeleccionado == "3"
            algoritmo = "Boyer-Moore"
        else
            println("Opción inválida. Operación cancelada.")
            return
        end

        println("Ingrese la palabra / oración a buscar:")
        consultaBusqueda = readline()  #Se guarda la palabra a buscar

        texto = obtener_contenido_texto(nombreTexto)   #Se guarda el texto completo

        ocurrencias = buscar_ocurrencias(algoritmoSeleccionado, texto, consultaBusqueda)

        if isempty(ocurrencias)
            println("No se encontraron ocurrencias de la palabra / oración buscada.")
        else
            mostrar_resultados_busqueda(ocurrencias)

            println("Seleccione una opción:")
            println("1. Mostrar cantidad de apariciones")
            println("2. Ver apariciones")
            opcion = readline()

            if opcion == "1"
                mostrar_cantidad_apariciones(ocurrencias)
            elseif opcion == "2"
                ver_apariciones(ocurrencias, texto, consultaBusqueda)
            else
                println("Opción inválida. Operación cancelada.")
            end
        end
    else
        println("El texto seleccionado no existe.")
    end
end

function mostrar_textos_registrados()
    rutaCarpeta = dirname(@__FILE__)
    archivos = readdir(rutaCarpeta)

    println("Archivos de texto registrados:")
    for archivo in archivos
        if isfile(joinpath(rutaCarpeta, archivo)) && endswith(archivo, ".txt")
            println(archivo)
        end
    end
end

function texto_registrado(nombreTexto)
    rutaCarpeta = dirname(@__FILE__)
    rutaArchivo = joinpath(rutaCarpeta, nombreTexto)

    if isfile(rutaArchivo)
        println("El archivo existe.")
        return true
    else
        println("El archivo no existe.")
        return false
    end
end

function obtener_contenido_texto(nombreTexto)
    rutaCarpeta = dirname(@__FILE__)
    rutaArchivo = joinpath(rutaCarpeta, nombreTexto)

    if isfile(rutaArchivo)
        try
            archivo = open(rutaArchivo, "r")
            contenido = read(archivo, String)
            close(archivo)
            return contenido
        catch error
            println("Error al leer el archivo de texto:", error)
            return ""
        end
    else
        println("El archivo no existe.")
        return ""
    end
end
function buscar_ocurrencias(algoritmoSeleccionado, texto, consultaBusqueda)
    ocurrencias = []
    
    if algoritmoSeleccionado == "1"
        ocurrencias = buscar_ocurrencias_fuerza_bruta(texto, consultaBusqueda)
    elseif algoritmoSeleccionado == "2"
        ocurrencias = buscar_ocurrencias_kmp(texto, consultaBusqueda)
    elseif algoritmoSeleccionado == "3"
        ocurrencias = buscar_ocurrencias_boyer_moore(texto, consultaBusqueda)
    else
        println("Algoritmo de búsqueda inválido.")
    end
    
    return ocurrencias
end

function buscar_ocurrencias_fuerza_bruta(texto, consultaBusqueda)
    ocurrencias = Int[]
    n = length(texto)
    m = length(consultaBusqueda)

    for i in 1:(n - m + 1)
        match = true
        for j in 1:m
            if texto[i + j - 1] != consultaBusqueda[j]
                match = false
                break
            end
        end

        if match
            push!(ocurrencias, i)
        end
    end

    return ocurrencias
end

function buscar_ocurrencias_kmp(texto, consultaBusqueda)
    ocurrencias = []
    n = length(texto)
    m = length(consultaBusqueda)

    # Construir tabla de prefijos para el patrón
    tablaPrefijos = construir_tabla_prefijos(consultaBusqueda)

    # Realizar búsqueda utilizando el algoritmo KMP
    i = 1
    j = 1
    while i <= n
        if texto[i] == consultaBusqueda[j]
            i += 1
            j += 1
        end

        if j > m
            push!(ocurrencias, i - m)
            j = tablaPrefijos[j]
        elseif i <= n && texto[i] != consultaBusqueda[j]
            j = tablaPrefijos[j]
            if j == 0
                i += 1
            end
        end
    end

    return ocurrencias
end

function construir_tabla_prefijos(patron)
    m = length(patron)
    tablaPrefijos = zeros(Int, m+1)

    i = 1
    j = 0
    tablaPrefijos[1] = 0

    while i < m
        if patron[i+1] == patron[j+1]
            tablaPrefijos[i+1] = tablaPrefijos[j+1]
            i += 1
            j += 1
        else
            tablaPrefijos[i+1] = j
            j = tablaPrefijos[j+1]
            while j > 0 && patron[i+1] != patron[j+1]
                j = tablaPrefijos[j+1]
            end
        end
    end

    tablaPrefijos[m+1] = j

    return tablaPrefijos
end

function buscar_ocurrencias_boyer_moore(texto, consultaBusqueda)
    ocurrencias = []
    n = length(texto)
    m = length(consultaBusqueda)

    # Construir tabla de saltos para el patrón
    tablaSaltos = construir_tabla_saltos(consultaBusqueda)

    i = m
    while i <= n
        j = m
        while j > 0 && texto[i] == consultaBusqueda[j]
            i -= 1
            j -= 1
        end

        if j == 0
            push!(ocurrencias, i+1)
            i += m + 1
        else
            salto1 = tablaSaltos[texto[i]]
            salto2 = m - j

            if salto1 > salto2
                i += salto1
            else
                i += salto2
            end
        end
    end

    return ocurrencias
end

function construir_tabla_saltos(patron)
    tablaSaltos = Dict{Char, Int}()
    m = length(patron)

    for i in 1:m-1
        tablaSaltos[patron[i]] = m - i
    end

    return tablaSaltos
end


buscar_palabra()
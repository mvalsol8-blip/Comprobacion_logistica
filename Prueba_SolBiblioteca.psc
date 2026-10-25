Algoritmo Biblioteca_Sun
    //- Definirs
    Definir cantidad_prestamos, cantidad_devoluciones, op_menu, i, inventario Como Entero
    Definir multas_generadas Como Real
    Definir prest_usuario Como Caracter
    Definir prest_codigo, prest_dias, prest_cant Como Entero
    Definir prest_devuelto Como Logico
	
    //- Dimensiones
    Dimension prest_usuario[100]
    Dimension prest_codigo[100], prest_dias[100], prest_cant[100]
    Dimension prest_devuelto[100]
	
    //- Contadores y variables
    cantidad_prestamos <- 0
    cantidad_devoluciones <- 0
    multas_generadas <- 0
    op_menu <- 0
    inventario <- 6   //- Inventario: total de libros disponibles en la biblioteca
	
    //- Comienzo en los arreglos
    Para i <- 1 Hasta 100 Hacer
        prest_usuario[i] <- ''
        prest_codigo[i] <- 0
        prest_dias[i] <- 0
        prest_cant[i] <- 0
        prest_devuelto[i] <- Falso
    FinPara
	
    //- Menu principal 
    Mientras op_menu <> 4 Hacer
        Limpiar Pantalla
        Escribir '.................................'
        Escribir '   Bienvenido a Biblioteca Sun'
        Escribir '.................................'
        Escribir '       MENU PRINCIPAL'
        Escribir 'Libros disponibles: ', inventario
        Escribir '1. Registrar prestamo'
        Escribir '2. Registrar devolucion'
        Escribir '3. Reportes'
        Escribir '4. Salir'
        op_menu <- leer_entero('Seleccione una opcion:')
		
        Segun op_menu Hacer
            1:
                RegistrarPrestamo(cantidad_prestamos, inventario, prest_usuario, prest_codigo, prest_dias, prest_cant, prest_devuelto)
            2:
                RegistrarDevolucion(cantidad_devoluciones, multas_generadas, cantidad_prestamos, inventario, prest_usuario, prest_codigo, prest_dias, prest_cant, prest_devuelto)
            3:
                GenerarReporte(cantidad_prestamos, cantidad_devoluciones, multas_generadas, inventario)
            4:
                Limpiar Pantalla
                Escribir '...........................'
                Escribir '      REPORTE FINAL'
                Escribir '...........................'
                Escribir 'Total de prestamos: ', cantidad_prestamos
                Escribir 'Total de devoluciones: ', cantidad_devoluciones
                Escribir 'Total de multas generadas: ', multas_generadas
                Escribir 'Libros disponibles: ', inventario
                Escribir 'Gracias por utilizar Biblioteca Sun.'
                Esperar Tecla
            De Otro Modo:
                Escribir 'Denegado: seleccione una opcion del 1 al 4.'
                Esperar Tecla
        FinSegun
    FinMientras
FinAlgoritmo

//- Funcion auxiliar: detecta si las cadenas empiezan en 0 o en 1
Funcion base <- BaseCadenas(muestra)
    Definir base Como Entero
    Si Subcadena(muestra, 0, 0) = 'a' Entonces
        base <- 0
    Sino
        base <- 1
    FinSi
FinFuncion

//- FUNCION 0: VALIDACION
//- Su funcion es: Verificar que el texto tenga solo letras y espacios
Funcion resultado <- EsSoloLetras(texto)
    Definir resultado Como Logico
    Definir permitidos, caracter Como Caracter
    Definir i, j, base, cant_letras Como Entero
    Definir es_valido Como Logico
	
    base <- BaseCadenas('abc')
	permitidos <- 'abcdefghijklmnopqrstuvwxyzáéíóúüñ'
    resultado <- Verdadero
    cant_letras <- 0
	
    Si Longitud(texto) = 0 Entonces
        resultado <- Falso
    Sino
        Para i <- base Hasta base + Longitud(texto) - 1 Hacer
            caracter <- Minusculas(Subcadena(texto, i, i))
			
            Si caracter <> ' ' Entonces
                es_valido <- Falso
				
				Para j <- base Hasta base + Longitud(permitidos) - 1 Hacer
                    Si Subcadena(permitidos, j, j) = caracter Entonces
                        es_valido <- Verdadero
                    FinSi
                FinPara
				
                Si es_valido Entonces
                    cant_letras <- cant_letras + 1
                Sino
                    resultado <- Falso
                FinSi
            FinSi
        FinPara
		
        //- Un nombre que no tenga letras no es valido
        Si cant_letras = 0 Entonces
            resultado <- Falso
        FinSi
    FinSi
FinFuncion

//-Funcion 1: Resultados de numeros enteros
//- Su funcion es: Verificar que el texto sea un numero entero
Funcion resultado <- es_entero(texto)
    Definir resultado Como Logico
    Definir digitos, caracter Como Caracter
    Definir i, j, base Como Entero
    Definir es_digito Como Logico
	
    base <- BaseCadenas('abc')
	digitos <- '0123456789'
    resultado <- Verdadero
	
    Si Longitud(texto) = 0 O Longitud(texto) > 9 Entonces
        resultado <- Falso
    Sino
        Para i <- base Hasta base + Longitud(texto) - 1 Hacer
            caracter <- Subcadena(texto, i, i)
            es_digito <- Falso
			
            Para j <- base Hasta base + 9 Hacer
                Si Subcadena(digitos, j, j) = caracter Entonces
                    es_digito <- Verdadero
                FinSi
            FinPara
			
            Si NO es_digito Entonces
                resultado <- Falso
            FinSi
        FinPara
    FinSi
FinFuncion

//-Funcion 2: Solicitud de nombre
//- Su funcion es: Pedir un nombre hasta que contenga solo letras
Funcion nombre <- leer_nombre(mensaje)
    Definir nombre Como Caracter
    Definir valido Como Logico
	
    Repetir
        Escribir mensaje
        Leer nombre
        valido <- EsSoloLetras(nombre)
        Si NO valido Entonces
            Escribir 'Denegado: el nombre solo puede tener letras (sin numeros ni simbolos).'
        FinSi
    Hasta Que valido
FinFuncion

//-Funcion 3: Numeros
//-Su funcion es: Pedir un numero entero hasta que se digite correctamente
Funcion numero <- leer_entero(mensaje)
    Definir numero Como Entero
    Definir oracion Como Caracter
    Definir valido Como Logico
	
    Repetir
        Escribir mensaje
        Leer oracion
        valido <- es_entero(oracion)
		
        Si NO valido Entonces
            Escribir 'Denegado: solo se permiten numeros enteros (sin letras ni simbolos).'
        FinSi
    Hasta Que valido
	
    numero <- ConvertirANumero(oracion)
FinFuncion

//-Funcion 4: Mayores
//-Su funcion es: Solicitar un entero mayor que cero
Funcion numero <- leer_positivo(mensaje)
    Definir numero Como Entero
	
    Repetir
        numero <- leer_entero(mensaje)
        Si numero <= 0 Entonces
            Escribir 'Denegado: debe ingresar un numero mayor que cero.'
        FinSi
    Hasta Que numero > 0
FinFuncion

//- Funcion 5: ValidarDias
//- Su funcion es: Pedir una cantidad de dias valida (entero mayor que cero)
Funcion dias <- ValidarDias(mensaje)
    Definir dias Como Entero
    dias <- leer_positivo(mensaje)
FinFuncion

//- Funcion 6: Preguntas
//- Su funcion es: Pregunta entre dos opciones
Funcion resultado <- escoger(opcion1, opcion2)
    Definir resultado Como Logico
    Definir opinion Como Entero
	
    Repetir
        Escribir '1. ', opcion1
        Escribir '2. ', opcion2
        opinion <- leer_entero('Seleccione una opcion:')
        Si opinion <> 1 Y opinion <> 2 Entonces
            Escribir 'Denegado: seleccione 1 o 2.'
        FinSi
    Hasta Que opinion = 1 O opinion = 2
	
    resultado <- (opinion = 1)
FinFuncion

//- Funcion 7: Multas por dias de atraso
//- Su funcion es: Calcular las multas
Funcion multa_calculada <- CalcularMulta(dias_atraso)
    Definir multa_calculada Como Real
    Definir tramo, tarifa Como Entero
	
    multa_calculada <- 0
    tramo <- 0
    tarifa <- 0
	
    Si dias_atraso > 0 Entonces
        Si dias_atraso <= 5 Entonces
            tramo <- 1
        Sino
            Si dias_atraso <= 10 Entonces
                tramo <- 2
            Sino
                tramo <- 3
            FinSi
        FinSi
		
        Segun tramo Hacer
            1:
                tarifa <- 500
            2:
                tarifa <- 750
            3:
                tarifa <- 1000
        FinSegun
		
        multa_calculada <- dias_atraso * tarifa
    FinSi
FinFuncion

//-Funcion 8_Lista de libros
//-Su funcion es: Luego de crear el usuario y escoger cuantos libros escoger lo mas gustan
Funcion nombre <- titulo_libro(numero)
    Definir nombre Como Caracter
    Segun numero Hacer
        1:
            nombre <- 'Harry Potter y las Reliquias de la muerte'
        2:
            nombre <- 'Los juegos del hambre'
        3:
            nombre <- 'Orgullo y Prejucio'
        4:
            nombre <- 'Alas de sangre'
        5:
            nombre <- 'La biblioteca de la media noche'
        6:
            nombre <- 'Dracula'
    FinSegun
FinFuncion

//- SubProceso 1: Registrar prestamo
SubProceso RegistrarPrestamo(cantidad_prestamos Por Referencia, inventario Por Referencia, prest_usuario Por Referencia, prest_codigo Por Referencia, prest_dias Por Referencia, prest_cant Por Referencia, prest_devuelto Por Referencia)
    Definir usuario, libros_seleccionados Como Caracter
    Definir codigo, dias, cantidad_libros, i, j, k, prestamos_usuario, libro_elegido Como Entero
    Definir valido Como Logico
    Definir elegido Como Logico
    Dimension elegido[6]
	
    Limpiar Pantalla
    Escribir '...... REGISTRAR PRESTAMO ......'
    Escribir '................................'
	
    //- Opcion de devolverse si se entro por error
    Si escoger('Continuar con el registro', 'Volver al menu principal') Entonces
		
        Si cantidad_prestamos >= 100 Entonces
            Escribir 'Denegado: Se llego al limite de prestamos.'
            Esperar Tecla
        Sino
            Si inventario <= 0 Entonces
                Escribir 'No tenemos libros disponibles en este momento.'
                Esperar Tecla
            Sino
                //- Nombre del usuario (solo letras)
                usuario <- leer_nombre('Ingrese el nombre del usuario:')
				
                //- Buscar si el usuario ya existe
                prestamos_usuario <- 0
                Para i <- 1 Hasta cantidad_prestamos Con Paso 1 Hacer
                    Si Minusculas(prest_usuario[i]) = Minusculas(usuario) Entonces
                        Si prestamos_usuario = 0 Entonces
                            usuario <- prest_usuario[i]
                        FinSi
                        prestamos_usuario <- prestamos_usuario + 1
                    FinSi
                FinPara
				
                Si prestamos_usuario > 0 Entonces
                    Escribir 'Usuario ya registrado: ', usuario, ' (historial de prestamos: ', prestamos_usuario, ').'
                Sino
                    Escribir 'Usuario nuevo: ', usuario
                FinSi
				
                //- Codigo y dias
                codigo <- leer_positivo('Ingrese el codigo del prestamo:')
                dias <- ValidarDias('Ingrese la cantidad de dias:')
				
                //- Cantidad de libros 
                Repetir
                    cantidad_libros <- leer_entero('Cantidad de libros (entre 1 y 3):')
                    Si cantidad_libros < 1 O cantidad_libros > 3 Entonces
                        Escribir 'Denegado: Debe escoger entre 1 y 3 libros.'
                    Sino
                        Si cantidad_libros > inventario Entonces
                            Escribir 'Denegado: Solo hay ', inventario, ' libro(s) disponible(s).'
                            cantidad_libros <- 0
                        FinSi
                    FinSi
                Hasta Que cantidad_libros >= 1 Y cantidad_libros <= 3
				
                //- Seleccion de los libros (ahora si ya se conoce cantidad_libros)
                Para k <- 1 Hasta 6 Con Paso 1 Hacer
                    elegido[k] <- Falso
                FinPara
				
                libros_seleccionados <- ''
                Para k <- 1 Hasta cantidad_libros Con Paso 1 Hacer
                    Repetir
                        Escribir ' '
                        Para j <- 1 Hasta 6 Con Paso 1 Hacer
                            Escribir j, '. ', titulo_libro(j)
                        FinPara
                        libro_elegido <- leer_entero('Libro numero ' + ConvertirATexto(k) + ':')
                        valido <- Verdadero
                        Si libro_elegido < 1 O libro_elegido > 6 Entonces
                            Escribir 'Denegado: elija del 1 al 6.'
                            valido <- Falso
                        Sino
                            Si elegido[libro_elegido] Entonces
                                Escribir 'Denegado: ese libro ya esta en este prestamo.'
                                valido <- Falso
                            FinSi
                        FinSi
                    Hasta Que valido
					
                    elegido[libro_elegido] <- Verdadero
					
                    Si k = 1 Entonces
                        libros_seleccionados <- titulo_libro(libro_elegido)
                    Sino
                        libros_seleccionados <- libros_seleccionados + ', ' + titulo_libro(libro_elegido)
                    FinSi
                FinPara
				
                //- Guardar datos
                cantidad_prestamos <- cantidad_prestamos + 1
                prest_usuario[cantidad_prestamos] <- usuario
                prest_codigo[cantidad_prestamos] <- codigo
                prest_dias[cantidad_prestamos] <- dias
                prest_cant[cantidad_prestamos] <- cantidad_libros
                prest_devuelto[cantidad_prestamos] <- Falso
				
                //- Descontar del inventario
                inventario <- inventario - cantidad_libros
				
                Escribir ' '
                Escribir 'Prestamo registrado correctamente.'
                Escribir 'Usuario: ', usuario
                Escribir 'Codigo del prestamo: ', codigo
                Escribir 'Dias del prestamo: ', dias
                Escribir 'Cantidad de libros: ', cantidad_libros
                Escribir 'Libros: ', libros_seleccionados
                Escribir 'Libros disponibles ahora: ', inventario
                Escribir 'Total de prestamos registrados: ', cantidad_prestamos
				MostrarUsuarios(cantidad_prestamos, prest_usuario, prest_codigo, prest_cant, prest_devuelto)
                Esperar Tecla
            FinSi
        FinSi
    FinSi
FinSubProceso

//- SubProceso auxiliar: lista de usuarios guardados
SubProceso MostrarUsuarios(cantidad_prestamos, prest_usuario Por Referencia, prest_codigo Por Referencia, prest_cant Por Referencia, prest_devuelto Por Referencia)
    Definir i Como Entero
	
    Escribir ' '
    Escribir '..... USUARIOS REGISTRADOS .....'
    Si cantidad_prestamos = 0 Entonces
        Escribir 'No hay usuarios registrados.'
    Sino
        Para i <- 1 Hasta cantidad_prestamos Con Paso 1 Hacer
            Si prest_devuelto[i] Entonces
                Escribir i, '. ', prest_usuario[i], ' | Codigo: ', prest_codigo[i], ' | Libros: ', prest_cant[i], ' | Devuelto'
            Sino
                Escribir i, '. ', prest_usuario[i], ' | Codigo: ', prest_codigo[i], ' | Libros: ', prest_cant[i], ' | Pendiente'
            FinSi
        FinPara
    FinSi
    Escribir '................................'
FinSubProceso

SubProceso RegistrarDevolucion(cantidad_devoluciones Por Referencia, multas_generadas Por Referencia, cantidad_prestamos Por Referencia, inventario Por Referencia, prest_usuario Por Referencia, prest_codigo Por Referencia, prest_dias Por Referencia, prest_cant Por Referencia, prest_devuelto Por Referencia)
    Definir usuario Como Caracter
    Definir codigo, posicion, dias_atraso, i, existentes, pendientes Como Entero
    Definir multa Como Real
    Definir cancelar, por_usuario Como Logico
	
    Limpiar Pantalla
    Escribir '...... REGISTRO DE DEVOLUCION ......'
    Escribir '....................................'
	
    //- Opcion de devolverse si se entro por error
    Si escoger('Continuar con la devolucion', 'Volver al menu principal') Entonces
		
        //- Verificacion de prestamos pendientes
        Si cantidad_devoluciones >= cantidad_prestamos Entonces
            Escribir 'No hay prestamos pendientes.'
            Esperar Tecla
        Sino
            //- Se muestran los usuarios guardados
            MostrarUsuarios(cantidad_prestamos, prest_usuario, prest_codigo, prest_cant, prest_devuelto)
			
            cancelar <- Falso
            posicion <- 0
			
            Repetir
                Escribir 'Buscar el prestamo por:'
                por_usuario <- escoger('Nombre de usuario', 'Codigo del prestamo')
                posicion <- 0
				
                Si por_usuario Entonces
                    //- Busqueda por nombre
                    usuario <- leer_nombre('Ingrese el nombre del usuario:')
                    existentes <- 0
                    pendientes <- 0
                    Para i <- 1 Hasta cantidad_prestamos Con Paso 1 Hacer
                        Si Minusculas(prest_usuario[i]) = Minusculas(usuario) Entonces
                            existentes <- existentes + 1
                            Si prest_devuelto[i] = Falso Entonces
                                pendientes <- pendientes + 1
                                Si posicion = 0 Entonces
                                    posicion <- i
                                FinSi
                            FinSi
                        FinSi
                    FinPara
					
                    Si existentes = 0 Entonces
                        Escribir 'DENEGADO: el usuario no existe.'
                    Sino
                        Si pendientes = 0 Entonces
                            Escribir 'DENEGADO: el usuario existe, pero no tiene prestamos pendientes.'
                        Sino
                            Si pendientes > 1 Entonces
                                //- Varios pendientes: se pide el codigo para elegir cual
                                Escribir 'El usuario tiene ', pendientes, ' prestamos pendientes.'
                                codigo <- leer_positivo('Digite el codigo del prestamo que desea devolver:')
                                posicion <- 0
                                Para i <- 1 Hasta cantidad_prestamos Con Paso 1 Hacer
                                    Si prest_codigo[i] = codigo Y prest_devuelto[i] = Falso Y Minusculas(prest_usuario[i]) = Minusculas(usuario) Y posicion = 0 Entonces
                                        posicion <- i
                                    FinSi
                                FinPara
                                Si posicion = 0 Entonces
                                    Escribir 'DENEGADO: ese codigo no corresponde a un prestamo pendiente de este usuario.'
                                FinSi
                            FinSi
                        FinSi
                    FinSi
                Sino
                    //- Busqueda por codigo
                    codigo <- leer_positivo('Digite el codigo del prestamo:')
                    existentes <- 0
                    Para i <- 1 Hasta cantidad_prestamos Con Paso 1 Hacer
                        Si prest_codigo[i] = codigo Entonces
                            existentes <- existentes + 1
                            Si prest_devuelto[i] = Falso Y posicion = 0 Entonces
                                posicion <- i
                            FinSi
                        FinSi
                    FinPara
					
                    Si existentes = 0 Entonces
                        Escribir 'DENEGADO: no existe un prestamo con ese codigo.'
                    Sino
                        Si posicion = 0 Entonces
                            Escribir 'DENEGADO: ese prestamo ya fue devuelto.'
                        FinSi
                    FinSi
                FinSi
				
                Si posicion = 0 Entonces
                    Si NO escoger('Intentar de nuevo', 'Volver al menu principal') Entonces
                        cancelar <- Verdadero
                    FinSi
                FinSi
            Hasta Que posicion > 0 O cancelar
			
            Si NO cancelar Entonces
                //- Se muestra lo registrado anteriormente
                Escribir ' '
                Escribir '..... Prestamo encontrado .....'
                Escribir 'Usuario: ', prest_usuario[posicion]
                Escribir 'Codigo del prestamo: ', prest_codigo[posicion]
                Escribir 'Cantidad de libros: ', prest_cant[posicion]
                Escribir 'Dias del prestamo: ', prest_dias[posicion]
                Escribir '................................'
				
                //- Consulta sobre los dias de atraso
                Escribir 'Cuenta el usuario con dias de atraso?'
                Si escoger('Si', 'No') Entonces
                    dias_atraso <- ValidarDias('Ingrese los dias de atraso:')
                Sino
                    dias_atraso <- 0
                FinSi
				
                //- Calculo y acumulacion de la multa
                multa <- CalcularMulta(dias_atraso)
                multas_generadas <- multas_generadas + multa
				
                //- Actualizacion de la devolucion y del inventario
                cantidad_devoluciones <- cantidad_devoluciones + 1
                prest_devuelto[posicion] <- Verdadero
                inventario <- inventario + prest_cant[posicion]
				
                //- Comprobante
                Escribir '....................................'
                Escribir 'Devolucion registrada correctamente.'
                Escribir 'Dias de atraso: ', dias_atraso
                Si multa > 0 Entonces
                    Escribir 'Multa de esta devolucion: ', multa
                Sino
                    Escribir 'Devolucion a tiempo, no tiene multa.'
                FinSi
                Escribir 'Total acumulado de multas: ', multas_generadas
                Escribir 'Total de devoluciones: ', cantidad_devoluciones
                Escribir 'Libros disponibles ahora: ', inventario
                Esperar Tecla
            FinSi
        FinSi
    FinSi
FinSubProceso


//- SubProceso 3: Reportes
SubProceso GenerarReporte(cantidad_prestamos, cantidad_devoluciones, multas_generadas, inventario)
    Definir op_reporte Como Entero
    Definir promedio_multas Como Real
	
    Repetir
        Limpiar Pantalla
        Escribir '......... GENERAR REPORTES .........'
        Escribir '1. Cantidad de prestamos'
        Escribir '2. Cantidad de devoluciones'
        Escribir '3. Total de multas'
        Escribir '4. Reporte general'
        Escribir '5. Volver al menu principal'
        op_reporte <- leer_entero('Seleccione una opcion:')
		
        Segun op_reporte Hacer
            1:
                Escribir 'Total de prestamos: ', cantidad_prestamos
                Esperar Tecla
            2:
                Escribir 'Total de devoluciones: ', cantidad_devoluciones
                Esperar Tecla
            3:
                Escribir 'Total acumulado de multas: ', multas_generadas
                Esperar Tecla
            4:
                Escribir '......... REPORTE GENERAL .........'
                Escribir 'Total de prestamos: ', cantidad_prestamos
                Escribir 'Total de devoluciones: ', cantidad_devoluciones
                Escribir 'Total acumulado de multas: ', multas_generadas
                Escribir 'Libros disponibles: ', inventario
				
                Si cantidad_devoluciones > 0 Entonces
                    promedio_multas <- multas_generadas / cantidad_devoluciones
                    Escribir 'Promedio de multa por devolucion: ', promedio_multas
                Sino
                    Escribir 'Promedio de multa: No disponible'
                    Escribir 'No se han registrado devoluciones.'
                FinSi
				
                Esperar Tecla
            5:
                Escribir 'Regresando al menu principal.'
            De Otro Modo:
                Escribir 'Denegado: seleccione una opcion del 1 al 5.'
                Esperar Tecla
        FinSegun
    Hasta Que op_reporte = 5
FinSubProceso

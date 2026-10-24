Algoritmo Biblioteca_Sun 
	//-Definiciones del algoritmo
	Definir cantidad_prestamos, cantidad_devoluciones, cantidad_usuarios, op_menu, i, j Como Entero
	Definir multas_generadas Como Real
	
	//-Contadores y acumuladores
	cantidad_prestamos <- 0
	cantidad_devoluciones <- 0
	multas_generadas <- 0
	op_menu <- 0	
	
	//-Configuracion en registro
	Definir usuarios, prest_usuario, prest_libros Como Caracter
	Definir prest_codigo, prest_dias, prest_cant, libro Como Entero
	Definir prest_devuelto Como Logico
	Dimension usuarios[101]
	Dimension prest_codigo[101], prest_usuario[101], prest_dias[101], prest_cant[101], prest_libros[101], prest_devuelto[101]
	Dimension libro[101, 3]
	
	//-Contadores y acumuladores x2
	cantidad_prestamos <- 0
	cantidad_devoluciones <- 0
	cantidad_usuarios <- 0
	multas_generadas <- 0
	op_menu <- 0
	
	//-Usuario en el inicio
	Para i <- 1 Hasta 101 Hacer
		usuarios[i] <- ''
		prest_usuario[i] <- ''
		prest_libros[i] <- ''
		prest_codigo[i] <- 0
		prest_dias[i] <- 0
		prest_cant[i] <- 0
		prest_devuelto[i] <- Falso
		Para j <- 1 Hasta 3 Hacer
			libro[i, j] <- 0
		Fin Para
	Fin Para
	
	//-Pantalla de bienvenida, ciclo y ejecucion
	Mientras op_menu <> 4 Hacer
		Limpiar Pantalla
		Escribir '.................................'
		Escribir '   Bienvenido a Biblioteca Sun   '
		Escribir '.................................'
		Escribir '   MENÚ PRINCIPAL:     '
		Escribir '1. Registrar prestamo'
		Escribir '2. Registrar devolucion'
		Escribir '3. Reportes'
		Escribir '4. Salir'
		op_menu <- leer_entero('Seleccione una opcion: ')
		
		Segun op_menu Hacer
			1:
				registrar_prestamo(cantidad_prestamos, cantidad_usuarios, usuarios, prest_codigo, prest_usuario, prest_dias, prest_cant, prest_libros, libros, prest_devuelto)
			2:
				registrar_devolucion(cantidad_devoluciones, multas_generadas, cantidad_prestamos, prest_codigo, prest_usuario, prest_dias, prest_cant, prest_libros, libros, prest_devuelto)
			3:
				generar_reporte(cantidad_prestamos, cantidad_devoluciones, multas_generadas)
			4:
				Limpiar Pantalla
				Escribir '...........................'
				Escribir '...... REPORTE FINAL ......'
				Escribir 'Total de prestamos: ', cantidad_prestamos
				Escribir 'Total de devoluciones: ', cantidad_devoluciones
				Escribir 'Total de multas generadas: ', multas_generadas
				Escribir 'Gracias por utilizar Biblioteca Sun.'
				Esperar Tecla
			De Otro Modo:
				Escribir 'Denegado: Seleccione una opcion del 1 al 4'
				Esperar Tecla
		FinSegun
	FinMientras
FinAlgoritmo	

//-Inicio de funciones

//-Funcion 1: Inicio numerico
//-Su funcion: Leer el dato como texto y lo convierta
Funcion punto_num <- leer_entero(mensaje)
	Definir punto_num Como Entero
	Definir entrada Como Caracter
	Definir entrada_correcta Como Logico
	
	Repetir
		Escribir mensaje
		Leer entrada
		entrada_correcta <- es_num(entrada)
		Si entrada_correcta Entonces
            Si Longitud(entrada) > 9 Entonces
                entrada_correcta <- Falso
                Escribir 'Denegado: El numero es demasiado grande'
            FinSi
        SiNo
            Escribir 'Denegado: Digite solamente numeros completos'
        FinSi
		
        Si entrada_correcta Entonces
            punto_num <- ConvertirANumero(entrada)
        FinSi
		
    Hasta Que entrada_correcta
	
Fin Funcion

//Funcion 2: Comprobar el inicio numerico
//Su funcion: Devolver el Verdadero si los digitos son del 0 al 9
Funcion resultado <- es_num (texto)
	Definir resultado, encontrado Como Logico
	Definir digitos, letras Como Caracter
	Definir i, j Como Entero
	digitos <- '0123456789'
	resultado <- Verdadero
	
	Si Longitud(texto) = 0 Entonces
		resultado <- Falso
	SiNo
		Para i <- 0 Hasta Longitud(texto) - 1 Hacer
			letras <- Subcadena(texto, i, i)
			encontrado <- Falso
			
			Para j <- 0 Hasta 9 Hacer
				Si letras = Subcadena(digitos, j, j) Entonces
					encontrado <- Verdadero
				FinSi
				
			Fin Para
			
			Si encontrado = Falso Entonces
				resultado <- Falso
			Fin Si
		Fin Para
		
	Fin Si
	
Fin Funcion

//-Funcion 3: Validar los dias del prestamo
//Su funcion: Valida la cantidad de dias, verifica que sea mayor que 0 y devuelve los dias validos

Funcion dias_validos <- validar_dias(mensaje)
	Definir dias_validos Como Entero
	dias_validos <- leer_entero(mensaje)
Fin Funcion

//-Funcion 4: Calcular multa
//-Su funcion es: Calcular la multa de los dias atrasados
Funcion multa_calculada <- calcular_multa(dias)
	Definir multa_calculada, pago Como Real
	Definir trayecto Como Entero
	Si dias <= 0 Entonces
        multa_calculada <- 0
    SiNo
        Si dias <= 5 Entonces
            trayecto <- 1
        SiNo
            Si dias <= 10 Entonces
                trayecto <- 2
            SiNo
                trayecto <- 3
            FinSi
        FinSi
		
        Segun trayecto Hacer
            1:
                pago <- 500
            2:
                pago <- 750
            3:
                pago <- 1000
        FinSegun
		
        multa_calculada <- dias * pago
    FinSi
Fin Funcion

//-Funcion 5: Texto en el programa
//-Su funicion es: Comprueba, lee, busca,cuenta, posiciona, revisa, da titulo, al usuario, prestamo y libro

//-Funcion: Comprobar que el nombre sea texto (solo letras y espacios)
Funcion resultado <- es_nombre(texto)
	Definir resultado, encontrado, hay_letra Como Logico
	Definir permitidos, caracter, minuscula Como Caracter
	Definir i, j Como Entero
	permitidos <- 'abcdefghijklmnñopqrstuvwxyzáéíóúü'
	minuscula <- Minusculas(texto)
	resultado <- Verdadero
	hay_letra <- Falso
	
	Si Longitud(texto) = 0 Entonces
		resultado <- Falso
	SiNo
		Para i <- 0 Hasta Longitud(minuscula) - 1 Hacer
			caracter <- Subcadena(minuscula, i, i)
			Si caracter <> ' ' Entonces
				encontrado <- Falso
				Para j <- 0 Hasta Longitud(permitidos) - 1 Hacer
					Si caracter = Subcadena(permitidos, j, j) Entonces
						encontrado <- Verdadero
					FinSi
				Fin Para
				Si encontrado Entonces
					hay_letra <- Verdadero
				SiNo
					resultado <- Falso
				FinSi
			FinSi
		Fin Para
		Si hay_letra = Falso Entonces
			resultado <- Falso
		FinSi
	Fin Si
Fin Funcion

//-Funcion: Leer el nombre del usuario (solo letras). Devuelve '0' si quiere volver
Funcion nombre <- leer_nombre(mensaje)
	Definir nombre Como Caracter
	Definir valido Como Logico
	
	Repetir
		Escribir mensaje, ' (0 para volver al menu)'
		Leer nombre
		Si nombre = '0' Entonces
			valido <- Verdadero
		SiNo
			valido <- es_nombre(nombre)
			Si valido = Falso Entonces
				Escribir 'Denegado: El nombre solo puede llevar letras (sin numeros ni simbolos)'
			FinSi
		FinSi
	Hasta Que valido
Fin Funcion

//-Funcion: Buscar un usuario por nombre (devuelve la posicion o 0 si no existe)
Funcion pos <- buscar_usuario(nombre, lista_usuarios, total_usuarios)
	Definir pos, i Como Entero
	pos <- 0
	Para i <- 1 Hasta total_usuarios Hacer
		Si Minusculas(lista_usuarios[i]) = Minusculas(nombre) Entonces
			pos <- i
		FinSi
	Fin Para
Fin Funcion

//-Funcion: Buscar un prestamo por codigo (devuelve la posicion o 0)
Funcion pos <- buscar_prestamo(codigo, codigos_prestamos, total_prestamos)
	Definir pos, i Como Entero
	pos <- 0
	Para i <- 1 Hasta total_prestamos Hacer
		Si codigos_prestamos[i] = codigo Entonces
			pos <- i
		FinSi
	Fin Para
Fin Funcion

//-Funcion: Cuenta los prestamos sin devolver de un usuario
Funcion total <- contar_pendientes(nombre, nombres_prestatarios, estados_devolucion, total_prestamos)
	Definir total, i Como Entero
	total <- 0
	Para i <- 1 Hasta total_prestamos Hacer
		Si Minusculas(nombres_prestatarios[i]) = Minusculas(nombre) Y estados_devolucion[i] = Falso Entonces
			total <- total + 1
		FinSi
	Fin Para
Fin Funcion

//-Funcion: Posicion de un prestamo sin devolver de un usuario
Funcion pos <- buscar_pendiente(nombre, nombres_prestatarios, estados_devolucion, total_prestamos)
	Definir pos, i Como Entero
	pos <- 0
	Para i <- 1 Hasta total_prestamos Hacer
		Si Minusculas(nombres_prestatarios[i]) = Minusculas(nombre) Y estados_devolucion[i] = Falso Entonces
			pos <- i
		FinSi
	Fin Para
Fin Funcion

//-Funcion: Revisa si el usuario ya tiene prestado ese libro sin devolver
//-Devuelve la posicion del prestamo donde lo tiene, o 0 si no lo tiene
Funcion pos <- prestamo_con_libro(nombre, libro, nombres_prestatarios, libros_prestados, cantidades_libros, estados_devolucion, total_prestamos)
	Definir pos, i, k Como Entero
	pos <- 0
	Para i <- 1 Hasta total_prestamos Hacer
		Si Minusculas(nombres_prestatarios[i]) = Minusculas(nombre) Y estados_devolucion[i] = Falso Entonces
			Para k <- 1 Hasta cantidades_libros[i] Hacer
				Si libros_prestados[i, k] = libro Entonces
					pos <- i
				FinSi
			Fin Para
		FinSi
	Fin Para
Fin Funcion

//-Funcion: Titulo del libro segun su numero
Funcion titulo <- titulo_libro(numero)
	Definir titulo Como Caracter
	Segun numero Hacer
		1:
			titulo <- 'La hipotesis del amor'
		2:
			titulo <- 'Enola Holmes y el carruaje negro'
		3:
			titulo <- 'Crimen y castigo'
		4:
			titulo <- 'Orgullo y prejuicio'
		5:
			titulo <- 'Harry Potter y el prisionero de Azkaban'
		6:
			titulo <- 'Los juegos del hambre'
	Fin Segun
Fin Funcion


//- Subproceso 1: Registra prestamo
SubProceso registrar_prestamo(cantidad_prestamos Por referencia)
	//- Defino las variables 
	Definir nombre_usuario, nombre_libro, libros_seleccionados Como Caracter
	Definir codigo_prestamo, dias_prestamo, cantidad_libros, libro_elegido, i Como Entero
	
	Limpiar Pantalla
	Escribir '...... Registrar prestamo ......'
	Escribir '................................'
	
	//-Verificando nombre
	Repetir
		Escribir 'Ingrese el nombre del usuario: '
		Leer nombre_usuario
		
		Si nombre_usuario = '' Entonces
			Escribir 'Denegado: El nombre debe llevar letras o elementos validos'
		Fin Si
		
	Hasta Que nombre_usuario <> ''
	
	//-Verificando codigo
	Repetir
		codigo_prestamo <- leer_entero ('Ingrese el codigo del prestamo: ')
		
		Si codigo_prestamo <= 0 Entonces
			Escribir 'Denegado: El codigo debe ser mayor que cero'
		Fin Si
		
	Hasta Que codigo_prestamo > 0
	
	//-Verificando dias
	dias_prestamo <- validar_dias
	
	//-Verificando cantidad de libros
	Repetir
		cantidad_libros <- leer_entero('Cantidad de libros que desea llevar (1 a 3): ')
		
		Si cantidad_libros < 1 O cantidad_libros > 3 Entonces
			Escribir 'Denegado: Solo puedes escoger de 1 a 3 libros'
		Fin Si
		
	Hasta Que cantidad_libros >= 1 Y cantidad_libros <= 3
	
	//-Comenzar lista de libros
	libros_seleccionados <- ''
	
	//-Elegir libros
	Para i <- 1 Hasta cantidad_libros Hacer
		Limpiar Pantalla
		Escribir 'Libro ', i, ' de ', cantidad_libros
		Escribir '1. La hipotesis del amor '
		Escribir '2. Enola Holmes y el carruaje negro'
		Escribir '3. Crimen y castigo'
		Escribir '4. Orgullo y prejuicio'
		Escribir '5. Harry Potter y el prisionero de Azkaban'
		Escribir '6. Los juegos del hambre'
		
		//-Verificando seleccion
		Repetir
			libro_elegido <- leer_entero('Digita el numero del libro: ')
			Si libro_elegido < 1 O libro_elegido > 6 Entonces
				Escribir 'Denegado: Seleccione un libro del 1 al 6: '
			Fin Si
		Hasta Que libro_elegido >= 1 Y libro_elegido <= 6
		
		//-Definiendo titulo
		Segun libro_elegido Hacer
			1:
                nombre_libro <- 'La hipotesis del amor'
				
            2:
                nombre_libro <- 'Enola Holmes y el carruaje negro'
				
            3:
                nombre_libro <- 'Crimen y castigo'
				
            4:
                nombre_libro <- 'Orgullo y prejuicio'
				
            5:
                nombre_libro <- 'Harry Potter y el prisionero de Azkaban'
				
            6:
                nombre_libro <- 'Los juegos del hambre'
		Fin Segun
		
		//-Añadiendo titulo
		Si i = 1 Entonces
			libros_seleccionados <- nombre_libro
		SiNo
			libros_seleccionados <- libros_seleccionados + ', ' + nombre_libro
		Fin Si
		
	Fin Para
	
	//Actualizando contador
	cantidad_prestamos <- cantidad_prestamos + 1
	
	//Enseñar comprobante
	Limpiar Pantalla
	Escribir '...... PRESTAMO REGISTRADO ......'
	Escribir '.................................'
	Escribir 'Usuario: ', nombre_usuario
	Escribir 'Codigo del prestamo: ', codigo_prestamo
	Escribir 'Dias del prestamo: ', dias_prestamo
	Escribir 'Cantidad de libros: ', cantidad_libros
	Escribir 'Libros escogidos: '
	Escribir libros_seleccionados
	Escribir 'Total de prestamos registrados: ', cantidad_prestamos
	Escribir '.................................'
	Escribir 'Escoje una tecla para continuar'
	Esperar Tecla
FinSubProceso

//-Subproceso 2: Registrar devolucion
SubProceso registrar_devolucion(cantidad_devoluciones Por Referencia, multas_generadas Por Referencia)
	//Diseñando definirs	
	Definir nombre_usuario Como Caracter
	Definir multa Como Real
	Definir codigo_prestamo, op_atraso, dias_atraso Como Entero
	Limpiar Pantalla
	Escribir '...... REGISTRO DE DEVOLUCION ......'
	Escribir '....................................'
	
	//Verificando
	Repetir
		Escribir 'Digite el nombre del usuario: '
		Leer nombre_usuario
		Si nombre_usuario = '' Entonces
			Escribir 'Denegado: El nombre debe llevar letras o elementos validos'
		Fin Si
	Hasta Que nombre_usuario <> ''
	
	//-Verificando codigo
	Repetir
		codigo_prestamo <- leer_entero('Digite el codigo del prestamo: ')
		Si codigo_prestamo <= 0 Entonces
			Escribir 'Denegado: el codigo debe ser mayor que cero'
		Fin Si
	Hasta Que codigo_prestamo > 0
	
	//-Consultar sobre atrasos
	Repetir
		Escribir '¿La devolucion tiene dias de atraso?'
		Escribir '1. Si'
		Escribir '2. No'
		op_atraso <- leer_entero('Escoja una opcion: ')
		
		Si op_atraso <> 1 Y op_atraso <> 2 Entonces
			Escribir 'Denegado: Seleccione 1 o 2'
		Fin Si
		
	Hasta Que op_atraso = 1 O op_atraso = 2
	
	//-Verificar dias de atraso
	Si op_atraso = 1 Entonces
		dias_atraso <- validar_dias
	SiNo
		dias_atraso <- 0
	Fin Si
	
	//-Verificar multa
	multa <- calcular_multa(dias_atraso)
	//-Acumular multas
	multas_generadas <- multas_generadas + multa
	//-Actualizar devoluciones
	cantidad_devoluciones <- cantidad_devoluciones + 1
	
	//Mostrar comprobante
	Limpiar Pantalla
	Escribir '...... REGISTRO DE DEVOLUCION ......'
	Escribir '....................................'
	Escribir 'Usuario: ', nombre_usuario
	Escribir 'Codigo del prestamo: ', codigo_prestamo
	Escribir 'Dias de atraso: ', dias_atraso
	
	Si multa > 0 Entonces
		Escribir 'Multa de esta devolucion: ', multa
	SiNo
		Escribir 'Devolucion a tiempo, no tiene multa'
	Fin Si
	Escribir 'Total acumulado de multas: ', multas_generadas
	Escribir 'Total de devoluciones: ', cantidad_devoluciones
	Escribir '....................................'
	Escribir 'Escoja una tecla para continuar'
	Esperar Tecla
FinSubProceso

//-SubProceso 3: Generando reportes
SubProceso generar_reporte(cantidad_prestamos, cantidad_devoluciones, multas_generadas)
	Definir op_reporte	Como Entero
	Definir promedio_multas Como Real	
	
	Repetir
		Limpiar Pantalla
		Escribir '......... GENERAR REPORTES .........'
		Escribir '....................................'
		Escribir '1. Cantidad de prestamos'
		Escribir '2. Cantidad de devoluciones'
		Escribir '3. Total de multas'
		Escribir '4. Reporte general'
		Escribir '5. Volver al menu principal'
		Escribir '....................................'
		op_reporte <- leer_entero('Seleccione una opcion:')
		
		Segun op_reporte Hacer
			1:
				Escribir 'Total de prestamos: ', cantidad_prestamos
				Esperar Tecla
			2:
				Escribir 'Total de devoluciones: ', cantidad_devoluciones
				Esperar Tecla
			3:
				Si multas_generadas = 0 Entonces
					Escribir 'No se han generado multas'
				SiNo
					Escribir 'Total acumulado de multas: ', multas_generadas
				Fin Si
				Esperar Tecla
			4:
				Limpiar Pantalla
				Escribir '......... REPORTE  GENERAL .........'
				Escribir '....................................'
				Escribir 'Total de prestamos: ', cantidad_prestamos
				Escribir 'Total de devoluciones: ', cantidad_devoluciones
				Escribir 'Total acumulado de multas: ', multas_generadas
				
				Si cantidad_devoluciones > 0 Entonces
					promedio_multas <- multas_generadas / cantidad_devoluciones
					Escribir 'Calculo de multa por devolucion: ', promedio_multas
				SiNo
					Escribir 'Calculo de multa: No disponible'
					Escribir 'No se han detectado registro de devoluciones'
				Fin Si
				Esperar Tecla
			5:
				Escribir 'Regresando al menu principal'
				
			De Otro Modo:
				Escribir 'Denegado: seleccione una opcion del 1 al 5.'
				Esperar Tecla
		Fin Segun
		
	Hasta Que op_reporte = 5
	
FinSubProceso